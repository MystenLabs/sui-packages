module 0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::admin {
    struct SetVersionEvent has copy, drop, store {
        major: u64,
        minor: u64,
    }

    struct SetGaugeAdminEvent has copy, drop, store {
        previous: 0x1::option::Option<address>,
        after: address,
    }

    struct SetGaugeOperatorEvent has copy, drop, store {
        previous: 0x1::option::Option<address>,
        after: address,
    }

    struct CreateGaugeEvent<phantom T0, phantom T1> has copy, drop, store {
        pool_id: address,
        gauge_id: address,
        epoch_id: u64,
    }

    struct SetGaugePausedEvent has copy, drop, store {
        gauge_id: address,
        paused: bool,
    }

    struct SetGlobalPausedEvent has copy, drop, store {
        paused: bool,
    }

    struct AddIncentiveWhitelistEvent<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct RemoveIncentiveWhitelistEvent<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct AddWhitelistVoterEvent has copy, drop, store {
        voter: address,
    }

    struct SetEpochPrologueMsEvent has copy, drop, store {
        value: u64,
    }

    struct SetEpochFinaleMsEvent has copy, drop, store {
        value: u64,
    }

    public fun set_gauge_admin(arg0: &mut 0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::VeMMT, arg1: &0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::acl::AdminCap, arg2: address) {
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::assert_supported_version(arg0);
        let v0 = SetGaugeAdminEvent{
            previous : 0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::acl::set_gauge_admin(0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::acl_mut(arg0), arg1, arg2),
            after    : arg2,
        };
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::event::emit<SetGaugeAdminEvent>(v0);
    }

    public fun set_gauge_operator(arg0: &mut 0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::VeMMT, arg1: &0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::acl::AdminCap, arg2: address) {
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::assert_supported_version(arg0);
        let v0 = SetGaugeOperatorEvent{
            previous : 0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::acl::set_gauge_operator(0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::acl_mut(arg0), arg1, arg2),
            after    : arg2,
        };
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::event::emit<SetGaugeOperatorEvent>(v0);
    }

    public fun add_clmm_ve_cap(arg0: &mut 0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::VeMMT, arg1: 0x731710adc6979ec0acfa6e969b3ce4740e961854c5c851d132abb0b2831c4d28::app::VeCap) {
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::assert_supported_version(arg0);
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::add_clmm_ve_cap(arg0, arg1);
    }

    public fun add_incentive_whitelist<T0>(arg0: &mut 0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::VeMMT, arg1: &0x2::tx_context::TxContext) {
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::assert_supported_version(arg0);
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::assert_gauge_admin(arg0, arg1);
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::gauge_globals::add_incentive_whitelist<T0>(0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::gauge_globals_mut(arg0));
        let v0 = AddIncentiveWhitelistEvent<T0>{dummy_field: false};
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::event::emit<AddIncentiveWhitelistEvent<T0>>(v0);
    }

    public fun add_whitelist_voter(arg0: &mut 0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::VeMMT, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::assert_supported_version(arg0);
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::assert_gauge_admin(arg0, arg2);
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::gauge_globals::add_whitelisted_voter(0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::gauge_globals_mut(arg0), arg1);
        let v0 = AddWhitelistVoterEvent{voter: arg1};
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::event::emit<AddWhitelistVoterEvent>(v0);
    }

    public fun create_gauge<T0, T1>(arg0: &mut 0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::VeMMT, arg1: &0x731710adc6979ec0acfa6e969b3ce4740e961854c5c851d132abb0b2831c4d28::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::assert_supported_version(arg0);
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::assert_gauge_admin(arg0, arg3);
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::gauge_globals::assert_not_paused(0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::gauge_globals(arg0));
        let v0 = 0x731710adc6979ec0acfa6e969b3ce4740e961854c5c851d132abb0b2831c4d28::pool::pool_id<T0, T1>(arg1);
        let v1 = 0x2::object::id_to_address(&v0);
        let v2 = 0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::epoch::epoch_id(0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::ep_config(arg0), 0x2::clock::timestamp_ms(arg2));
        let v3 = 0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::gauge::create<T0, T1>(v1, v2, arg3);
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::gauge_globals::add_gauge(0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::gauge_globals_mut(arg0), v3);
        let v4 = CreateGaugeEvent<T0, T1>{
            pool_id  : v1,
            gauge_id : 0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::gauge::gauge_id(&v3),
            epoch_id : v2,
        };
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::event::emit<CreateGaugeEvent<T0, T1>>(v4);
    }

    public fun remove_incentive_whitelist<T0>(arg0: &mut 0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::VeMMT, arg1: &0x2::tx_context::TxContext) {
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::assert_supported_version(arg0);
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::assert_gauge_admin(arg0, arg1);
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::gauge_globals::remove_incentive_whitelist<T0>(0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::gauge_globals_mut(arg0));
        let v0 = RemoveIncentiveWhitelistEvent<T0>{dummy_field: false};
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::event::emit<RemoveIncentiveWhitelistEvent<T0>>(v0);
    }

    public fun set_epoch_finale_ms(arg0: &mut 0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::VeMMT, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::assert_supported_version(arg0);
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::assert_gauge_admin(arg0, arg2);
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::epoch::set_finale_ms(0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::ep_config_mut(arg0), arg1);
        let v0 = SetEpochFinaleMsEvent{value: arg1};
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::event::emit<SetEpochFinaleMsEvent>(v0);
    }

    public fun set_epoch_prologue_ms(arg0: &mut 0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::VeMMT, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::assert_supported_version(arg0);
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::assert_gauge_admin(arg0, arg2);
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::epoch::set_prologue_ms(0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::ep_config_mut(arg0), arg1);
        let v0 = SetEpochPrologueMsEvent{value: arg1};
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::event::emit<SetEpochPrologueMsEvent>(v0);
    }

    public fun set_gauge_paused(arg0: &mut 0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::VeMMT, arg1: address, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::assert_supported_version(arg0);
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::assert_gauge_admin(arg0, arg3);
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::gauge::set_paused(0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::gauge_globals::get_gauge_not_paused(0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::gauge_globals_mut(arg0), &arg1), arg2);
        let v0 = SetGaugePausedEvent{
            gauge_id : arg1,
            paused   : arg2,
        };
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::event::emit<SetGaugePausedEvent>(v0);
    }

    public fun set_global_paused(arg0: &mut 0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::VeMMT, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::assert_supported_version(arg0);
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::assert_gauge_admin(arg0, arg2);
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::gauge_globals::set_paused(0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::gauge_globals_mut(arg0), arg1);
        let v0 = SetGlobalPausedEvent{paused: arg1};
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::event::emit<SetGlobalPausedEvent>(v0);
    }

    public fun set_version(arg0: &mut 0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::VeMMT, arg1: &0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::version::VersionCap, arg2: u64, arg3: u64) {
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::version::set_version(0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::ve_mmt::version_mut(arg0), arg1, arg2, arg3);
        let v0 = SetVersionEvent{
            major : arg2,
            minor : arg3,
        };
        0x8ce9c6f9f0206ffb7940e52d712965ad3f1a0b27572c9aab1ad065e218ef6c35::event::emit<SetVersionEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

