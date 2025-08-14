module 0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::ve_mmt {
    struct VE_MMT has drop {
        dummy_field: bool,
    }

    struct VeMMT has key {
        id: 0x2::object::UID,
        acl: 0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::acl::Acl,
        vp_config: 0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::vote_power::VotePowerConfig,
        ep_config: 0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::epoch::EpochConfig,
        gauge_globals: 0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::gauge_globals::GaugeGlobals,
        version: 0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::version::Version,
    }

    struct VeCapKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun acl(arg0: &VeMMT) : &0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::acl::Acl {
        &arg0.acl
    }

    public fun assert_gauge_admin(arg0: &VeMMT, arg1: &0x2::tx_context::TxContext) {
        0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::acl::assert_gauge_admin(&arg0.acl, arg1);
    }

    public fun assert_gauge_operator(arg0: &VeMMT, arg1: &0x2::tx_context::TxContext) {
        0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::acl::assert_gauge_operator(&arg0.acl, arg1);
    }

    fun create(arg0: &mut 0x2::tx_context::TxContext) : (VeMMT, 0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::acl::AdminCap, 0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::version::VersionCap) {
        let (v0, v1) = 0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::acl::create(arg0);
        let (v2, v3) = 0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::version::create(arg0);
        let v4 = VeMMT{
            id            : 0x2::object::new(arg0),
            acl           : v1,
            vp_config     : 0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::vote_power::create(209, 200000, arg0),
            ep_config     : 0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::epoch::create(604800000, 3600000, 3600000, arg0),
            gauge_globals : 0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::gauge_globals::create(arg0),
            version       : v2,
        };
        (v4, v0, v3)
    }

    public fun gauge_globals(arg0: &VeMMT) : &0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::gauge_globals::GaugeGlobals {
        &arg0.gauge_globals
    }

    public(friend) fun acl_mut(arg0: &mut VeMMT) : &mut 0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::acl::Acl {
        &mut arg0.acl
    }

    public(friend) fun add_clmm_ve_cap(arg0: &mut VeMMT, arg1: 0x1e90b0d9a2550f817baecce1ecf6e8b6cb1504c13dc85e57ee39f510b2fe92d4::app::VeCap) {
        let v0 = VeCapKey{dummy_field: false};
        0x2::dynamic_field::add<VeCapKey, 0x1e90b0d9a2550f817baecce1ecf6e8b6cb1504c13dc85e57ee39f510b2fe92d4::app::VeCap>(&mut arg0.id, v0, arg1);
    }

    public fun assert_supported_version(arg0: &VeMMT) {
        0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::version::assert_supported_version(&arg0.version);
    }

    public fun version(arg0: &VeMMT) : &0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::version::Version {
        &arg0.version
    }

    public fun ep_config(arg0: &VeMMT) : &0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::epoch::EpochConfig {
        &arg0.ep_config
    }

    public(friend) fun ep_config_mut(arg0: &mut VeMMT) : &mut 0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::epoch::EpochConfig {
        &mut arg0.ep_config
    }

    public(friend) fun gauge_fields(arg0: &mut VeMMT) : (&0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::vote_power::VotePowerConfig, &0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::epoch::EpochConfig, &mut 0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::gauge_globals::GaugeGlobals, &0x1e90b0d9a2550f817baecce1ecf6e8b6cb1504c13dc85e57ee39f510b2fe92d4::app::VeCap) {
        let v0 = VeCapKey{dummy_field: false};
        (&arg0.vp_config, &arg0.ep_config, &mut arg0.gauge_globals, 0x2::dynamic_field::borrow<VeCapKey, 0x1e90b0d9a2550f817baecce1ecf6e8b6cb1504c13dc85e57ee39f510b2fe92d4::app::VeCap>(&arg0.id, v0))
    }

    public(friend) fun gauge_globals_mut(arg0: &mut VeMMT) : &mut 0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::gauge_globals::GaugeGlobals {
        &mut arg0.gauge_globals
    }

    fun init(arg0: VE_MMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = create(arg1);
        0x2::transfer::share_object<VeMMT>(v0);
        0x2::transfer::public_transfer<0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::acl::AdminCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::version::VersionCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun version_mut(arg0: &mut VeMMT) : &mut 0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::version::Version {
        &mut arg0.version
    }

    public fun vp_config(arg0: &VeMMT) : &0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::vote_power::VotePowerConfig {
        &arg0.vp_config
    }

    public(friend) fun vp_config_mut(arg0: &mut VeMMT) : &mut 0xf7d32f7be73abbfe78a906945e9df03e758212d85fefc6e3727ea470e3b0345c::vote_power::VotePowerConfig {
        &mut arg0.vp_config
    }

    // decompiled from Move bytecode v6
}

