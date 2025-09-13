module 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::oapp_uln_config {
    struct OAppUlnConfig has copy, drop, store {
        use_default_confirmations: bool,
        use_default_required_dvns: bool,
        use_default_optional_dvns: bool,
        uln_config: 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_config::UlnConfig,
    }

    public fun new() : OAppUlnConfig {
        OAppUlnConfig{
            use_default_confirmations : true,
            use_default_required_dvns : true,
            use_default_optional_dvns : true,
            uln_config                : 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_config::new(),
        }
    }

    public fun assert_oapp_config(arg0: &OAppUlnConfig) {
        if (arg0.use_default_confirmations) {
            assert!(0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_config::confirmations(uln_config(arg0)) == 0, 1);
        };
        if (arg0.use_default_required_dvns) {
            assert!(0x1::vector::is_empty<address>(0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_config::required_dvns(uln_config(arg0))), 2);
        } else {
            0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_config::assert_required_dvns(uln_config(arg0));
        };
        if (arg0.use_default_optional_dvns) {
            assert!(0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_config::optional_dvn_threshold(uln_config(arg0)) == 0 && 0x1::vector::is_empty<address>(0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_config::optional_dvns(uln_config(arg0))), 3);
        } else {
            0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_config::assert_optional_dvns(uln_config(arg0));
        };
    }

    public fun create(arg0: bool, arg1: bool, arg2: bool, arg3: 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_config::UlnConfig) : OAppUlnConfig {
        OAppUlnConfig{
            use_default_confirmations : arg0,
            use_default_required_dvns : arg1,
            use_default_optional_dvns : arg2,
            uln_config                : arg3,
        }
    }

    public fun uln_config(arg0: &OAppUlnConfig) : &0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_config::UlnConfig {
        &arg0.uln_config
    }

    public fun deserialize(arg0: vector<u8>) : OAppUlnConfig {
        let v0 = 0x2::bcs::new(arg0);
        OAppUlnConfig{
            use_default_confirmations : 0x2::bcs::peel_bool(&mut v0),
            use_default_required_dvns : 0x2::bcs::peel_bool(&mut v0),
            use_default_optional_dvns : 0x2::bcs::peel_bool(&mut v0),
            uln_config                : 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_config::deserialize(0x2::bcs::into_remainder_bytes(v0)),
        }
    }

    public fun get_effective_config(arg0: &OAppUlnConfig, arg1: &0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_config::UlnConfig) : 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_config::UlnConfig {
        let v0 = if (arg0.use_default_confirmations) {
            0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_config::confirmations(arg1)
        } else {
            0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_config::confirmations(uln_config(arg0))
        };
        let v1 = if (arg0.use_default_required_dvns) {
            *0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_config::required_dvns(arg1)
        } else {
            *0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_config::required_dvns(uln_config(arg0))
        };
        let (v2, v3) = if (arg0.use_default_optional_dvns) {
            (*0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_config::optional_dvns(arg1), 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_config::optional_dvn_threshold(arg1))
        } else {
            (*0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_config::optional_dvns(uln_config(arg0)), 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_config::optional_dvn_threshold(uln_config(arg0)))
        };
        let v4 = 0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_config::create(v0, v1, v2, v3);
        0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_config::assert_at_least_one_dvn(&v4);
        v4
    }

    public fun use_default_confirmations(arg0: &OAppUlnConfig) : bool {
        arg0.use_default_confirmations
    }

    public fun use_default_optional_dvns(arg0: &OAppUlnConfig) : bool {
        arg0.use_default_optional_dvns
    }

    public fun use_default_required_dvns(arg0: &OAppUlnConfig) : bool {
        arg0.use_default_required_dvns
    }

    // decompiled from Move bytecode v6
}

