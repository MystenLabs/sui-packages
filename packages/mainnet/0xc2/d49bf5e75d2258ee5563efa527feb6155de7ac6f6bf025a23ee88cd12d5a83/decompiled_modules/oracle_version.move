module 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_version {
    public fun next_version() : u64 {
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_constants::version(), 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

