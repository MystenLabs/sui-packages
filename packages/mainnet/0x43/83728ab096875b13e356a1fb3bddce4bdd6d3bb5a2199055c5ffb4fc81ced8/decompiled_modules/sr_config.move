module 0x4383728ab096875b13e356a1fb3bddce4bdd6d3bb5a2199055c5ffb4fc81ced8::sr_config {
    struct SRConfig has store, key {
        id: 0x2::object::UID,
        min_stake: u64,
        max_stake: u64,
    }

    public fun admin_change_max_stake(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut SRConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg3);
        arg1.max_stake = arg2;
    }

    public fun admin_change_min_stake(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut SRConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg3);
        arg1.min_stake = arg2;
    }

    public fun get_max_stake(arg0: &SRConfig) : u64 {
        arg0.max_stake
    }

    public fun get_min_stake(arg0: &SRConfig) : u64 {
        arg0.min_stake
    }

    public fun get_sr_config_id(arg0: &SRConfig) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SRConfig{
            id        : 0x2::object::new(arg0),
            min_stake : 100000000,
            max_stake : 1000000000,
        };
        0x2::transfer::public_share_object<SRConfig>(v0);
    }

    // decompiled from Move bytecode v6
}

