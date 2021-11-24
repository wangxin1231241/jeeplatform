package org.muses.jeeplatform.oauth.config;


import org.muses.jeeplatform.oauth.filter.SimpleCORSFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.MessageDigestPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.context.SecurityContextPersistenceFilter;


import javax.annotation.Resource;

/**
 * <pre>
 *
 * </pre>
 *
 * <pre>
 * @author mazq
 * 修改记录
 *    修改后版本:     修改人：  修改日期: 2020/04/30 15:58  修改内容:
 * </pre>
 */
@Configuration
@EnableWebSecurity
@Order(1)
//@EnableGlobalMethodSecurity(prePostEnabled = true)
//@EnableAutoConfiguration(exclude = {
//        org.springframework.boot.autoconfigure.security.SecurityAutoConfiguration.class })
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {
    @Autowired
    private SimpleCORSFilter simpleCORSFilter;

    @Resource(name = "userService")
    private UserDetailsService userDetailsService;

    private static final String SECRET_CHAR_SEQUENCE = "secret";

    @Bean
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }


    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {    //auth.inMemoryAuthentication()
        auth.inMemoryAuthentication()
                .withUser("nicky")
                .password(passwordEncoder().encode("123"))
                .roles("admin");
//        auth.userDetailsService(userDetailsService)
//                .passwordEncoder(bCryptPasswordEncoder());
//        auth.parentAuthenticationManager(authenticationManagerBean());
    }

    @Override
    public void configure(WebSecurity web) throws Exception {
        //解决静态资源被拦截的问题
        //web.ignoring().antMatchers("/static/login.html");
        //web.ignoring().antMatchers("/i18n/**");
        web.ignoring().antMatchers("/asserts/**");
        web.ignoring().antMatchers("/favicon.ico");

    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.requestMatchers()
                .antMatchers("/index")
                .antMatchers("/login")
                .antMatchers("/oauth/authorize")
                .and()
                .authorizeRequests()
                .anyRequest().authenticated() //所有请求都需要通过认证
                .and()
                //.httpBasic() //Basic登录
                //.and()
                .formLogin()
                .loginPage("/login")
                //.loginProcessingUrl("/login")
                .permitAll()
                .and()
                .csrf().disable(); //关闭跨域保护;
        http.addFilterBefore(simpleCORSFilter, SecurityContextPersistenceFilter.class);
    }



    @Bean
    public PasswordEncoder passwordEncoder() {
        return new MessageDigestPasswordEncoder("MD5");
    }
}
