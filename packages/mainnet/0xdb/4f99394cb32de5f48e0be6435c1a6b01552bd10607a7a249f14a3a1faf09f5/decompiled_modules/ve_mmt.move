module 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::ve_mmt {
    struct VE_MMT has drop {
        dummy_field: bool,
    }

    struct VeMMT has key {
        id: 0x2::object::UID,
        acl: 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::acl::Acl,
        version: 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::version::Version,
        ep_config: 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::epoch::EpochConfig,
        vp_config: 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::vote_power::VotePowerConfig,
        is_paused: bool,
    }

    public fun acl(arg0: &VeMMT) : &0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::acl::Acl {
        &arg0.acl
    }

    fun create(arg0: &mut 0x2::tx_context::TxContext) : (VeMMT, 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::acl::AdminCap, 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::version::VersionCap) {
        let (v0, v1) = 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::acl::create(arg0);
        let (v2, v3) = 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::version::create(arg0);
        let v4 = VeMMT{
            id        : 0x2::object::new(arg0),
            acl       : v1,
            version   : v2,
            ep_config : 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::epoch::create(604800000, arg0),
            vp_config : 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::vote_power::create(209, arg0),
            is_paused : false,
        };
        (v4, v0, v3)
    }

    public(friend) fun acl_mut(arg0: &mut VeMMT) : &mut 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::acl::Acl {
        &mut arg0.acl
    }

    public fun assert_supported_version(arg0: &VeMMT) {
        0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::version::assert_supported_version(&arg0.version);
    }

    public(friend) fun config_fields(arg0: &VeMMT) : (&0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::vote_power::VotePowerConfig, &0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::epoch::EpochConfig) {
        (&arg0.vp_config, &arg0.ep_config)
    }

    public fun version(arg0: &VeMMT) : &0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::version::Version {
        &arg0.version
    }

    public fun ep_config(arg0: &VeMMT) : &0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::epoch::EpochConfig {
        &arg0.ep_config
    }

    fun init(arg0: VE_MMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = create(arg1);
        0x2::transfer::share_object<VeMMT>(v0);
        0x2::transfer::public_transfer<0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::acl::AdminCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::version::VersionCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun is_paused(arg0: &VeMMT) : bool {
        arg0.is_paused
    }

    public(friend) fun set_paused(arg0: &mut VeMMT, arg1: bool) {
        arg0.is_paused = arg1;
    }

    public fun version_mul(arg0: &mut VeMMT) : &mut 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::version::Version {
        &mut arg0.version
    }

    public fun vp_config(arg0: &VeMMT) : &0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::vote_power::VotePowerConfig {
        &arg0.vp_config
    }

    // decompiled from Move bytecode v6
}

