module 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt {
    struct VE_MMT has drop {
        dummy_field: bool,
    }

    struct VeMMT has key {
        id: 0x2::object::UID,
        acl: 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::acl::Acl,
        version: 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::version::Version,
        ep_config: 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::epoch::EpochConfig,
        vp_config: 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::vote_power::VotePowerConfig,
        is_paused: bool,
    }

    struct VeCapKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun acl(arg0: &VeMMT) : &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::acl::Acl {
        &arg0.acl
    }

    fun create(arg0: &mut 0x2::tx_context::TxContext) : (VeMMT, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::acl::AdminCap, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::version::VersionCap) {
        let (v0, v1) = 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::acl::create(arg0);
        let (v2, v3) = 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::version::create(arg0);
        let v4 = VeMMT{
            id        : 0x2::object::new(arg0),
            acl       : v1,
            version   : v2,
            ep_config : 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::epoch::create(604800000, arg0),
            vp_config : 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::vote_power::create(209, arg0),
            is_paused : false,
        };
        (v4, v0, v3)
    }

    public(friend) fun acl_mut(arg0: &mut VeMMT) : &mut 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::acl::Acl {
        &mut arg0.acl
    }

    public fun assert_supported_version(arg0: &VeMMT) {
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::version::assert_supported_version(&arg0.version);
    }

    public(friend) fun config_fields(arg0: &VeMMT) : (&0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::vote_power::VotePowerConfig, &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::epoch::EpochConfig) {
        (&arg0.vp_config, &arg0.ep_config)
    }

    public fun version(arg0: &VeMMT) : &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::version::Version {
        &arg0.version
    }

    public fun ep_config(arg0: &VeMMT) : &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::epoch::EpochConfig {
        &arg0.ep_config
    }

    fun init(arg0: VE_MMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = create(arg1);
        0x2::transfer::share_object<VeMMT>(v0);
        0x2::transfer::public_transfer<0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::acl::AdminCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::version::VersionCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun is_paused(arg0: &VeMMT) : bool {
        arg0.is_paused
    }

    public(friend) fun set_paused(arg0: &mut VeMMT, arg1: bool) {
        arg0.is_paused = arg1;
    }

    public fun vp_config(arg0: &VeMMT) : &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::vote_power::VotePowerConfig {
        &arg0.vp_config
    }

    // decompiled from Move bytecode v6
}

