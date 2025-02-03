module 0x1e260110eff93197d10654953b2171aa4a1abe24de5d58ba9adf22432c1cbfcc::oracle_version {
    public fun next_version() : u64 {
        0x1e260110eff93197d10654953b2171aa4a1abe24de5d58ba9adf22432c1cbfcc::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x1e260110eff93197d10654953b2171aa4a1abe24de5d58ba9adf22432c1cbfcc::oracle_constants::version(), 0x1e260110eff93197d10654953b2171aa4a1abe24de5d58ba9adf22432c1cbfcc::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x1e260110eff93197d10654953b2171aa4a1abe24de5d58ba9adf22432c1cbfcc::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

