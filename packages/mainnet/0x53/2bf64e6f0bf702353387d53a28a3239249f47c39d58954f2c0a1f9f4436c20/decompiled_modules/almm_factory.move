module 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_factory {
    struct EventCreateFactory has copy, drop, store {
        factory_id: 0x2::object::ID,
    }

    struct EventPaused has copy, drop, store {
        paused: bool,
    }

    struct EventChangeUnstakedLiquidityFeeRate has copy, drop, store {
        old: u64,
        new: u64,
    }

    struct ALMM_FACTORY has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ProtocolFeeCap has store, key {
        id: 0x2::object::UID,
    }

    struct Preset has copy, drop, store {
        base_factor: u32,
        filter_period: u16,
        decay_period: u16,
        reduction_factor: u16,
        variable_fee_control: u32,
        protocol_share: u16,
        max_volatility_accumulator: u32,
    }

    struct BaseFeeBinStep has copy, drop, store {
        base_fee: u64,
        bin_step: u16,
    }

    struct Factory has store, key {
        id: 0x2::object::UID,
        pairs: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        pairs_iter: vector<0x2::object::ID>,
        allowed_admin: 0x2::vec_set::VecSet<0x2::object::ID>,
        allowed_protocol_fee_cap: 0x2::vec_set::VecSet<0x2::object::ID>,
        presets: 0x2::table::Table<u64, 0x2::table::Table<u16, Preset>>,
        opened_bin_steps: 0x2::vec_map::VecMap<u64, 0x2::vec_set::VecSet<u16>>,
        available_bin_steps: 0x2::table::Table<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, 0x2::vec_set::VecSet<BaseFeeBinStep>>>,
        unstaked_liquidity_fee_rate: u64,
        default_partner: 0x1::option::Option<0x2::object::ID>,
        enable_composition: bool,
        max_bins_in_position: u64,
        version: u64,
        paused: bool,
    }

    struct EventGrantAdmin has copy, drop, store {
        who: address,
        cap: 0x2::object::ID,
    }

    struct EventRevokeAdmin has copy, drop, store {
        cap: 0x2::object::ID,
    }

    struct EventMaxBinsInPosition has copy, drop, store {
        old: u64,
        new: u64,
    }

    struct EventGrantProtocolFeeCap has copy, drop, store {
        who: address,
        cap: 0x2::object::ID,
    }

    struct EventRevokeProtocolFeeCap has copy, drop, store {
        cap: 0x2::object::ID,
    }

    struct EventOpenBinStepPreset has copy, drop, store {
        base_fee: u64,
        bin_step: u16,
        opened: bool,
    }

    struct EventAddPreset has copy, drop, store {
        base_fee: u64,
        bin_step: u16,
        preset: Preset,
    }

    struct EventRemovePreset has copy, drop, store {
        base_fee: u64,
        bin_step: u16,
        preset: Preset,
    }

    struct EventUpdatePreset has copy, drop, store {
        base_fee: u64,
        bin_step: u16,
        old: Preset,
        new: Preset,
    }

    struct EventEnableComposition has copy, drop, store {
        enabled: bool,
    }

    public(friend) fun abort_if_paused(arg0: &Factory) {
        assert!(!arg0.paused, 11);
    }

    public(friend) fun add_available_bin_step(arg0: &mut Factory, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u16, arg5: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, 0x2::vec_set::VecSet<BaseFeeBinStep>>>(&arg0.available_bin_steps, arg1)) {
            0x2::table::add<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, 0x2::vec_set::VecSet<BaseFeeBinStep>>>(&mut arg0.available_bin_steps, arg1, 0x2::table::new<0x1::type_name::TypeName, 0x2::vec_set::VecSet<BaseFeeBinStep>>(arg5));
        };
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, 0x2::vec_set::VecSet<BaseFeeBinStep>>>(&mut arg0.available_bin_steps, arg1);
        if (!0x2::table::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<BaseFeeBinStep>>(v0, arg2)) {
            0x2::table::add<0x1::type_name::TypeName, 0x2::vec_set::VecSet<BaseFeeBinStep>>(v0, arg2, 0x2::vec_set::empty<BaseFeeBinStep>());
        };
        let v1 = BaseFeeBinStep{
            base_fee : arg3,
            bin_step : arg4,
        };
        0x2::vec_set::insert<BaseFeeBinStep>(0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::vec_set::VecSet<BaseFeeBinStep>>(v0, arg2), v1);
    }

    public(friend) fun add_pair(arg0: &mut Factory, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.pairs, arg1, arg2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.pairs_iter, arg2);
    }

    public fun add_preset(arg0: &mut Factory, arg1: &AdminCap, arg2: u64, arg3: u16, arg4: u32, arg5: u16, arg6: u16, arg7: u16, arg8: u32, arg9: u16, arg10: u32, arg11: &mut 0x2::tx_context::TxContext) {
        version_only(arg0);
        check_admin(arg0, arg1);
        assert!(arg3 >= 1 && arg3 <= 1000, 8);
        assert!(!0x2::table::contains<u64, 0x2::table::Table<u16, Preset>>(&arg0.presets, arg2) || !0x2::table::contains<u16, Preset>(0x2::table::borrow<u64, 0x2::table::Table<u16, Preset>>(&arg0.presets, arg2), arg3), 5);
        assert!(arg9 <= 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_constants::max_protocol_share(), 12);
        let v0 = Preset{
            base_factor                : arg4,
            filter_period              : arg5,
            decay_period               : arg6,
            reduction_factor           : arg7,
            variable_fee_control       : arg8,
            protocol_share             : arg9,
            max_volatility_accumulator : arg10,
        };
        if (!0x2::table::contains<u64, 0x2::table::Table<u16, Preset>>(&arg0.presets, arg2)) {
            0x2::table::add<u64, 0x2::table::Table<u16, Preset>>(&mut arg0.presets, arg2, 0x2::table::new<u16, Preset>(arg11));
        };
        0x2::table::add<u16, Preset>(0x2::table::borrow_mut<u64, 0x2::table::Table<u16, Preset>>(&mut arg0.presets, arg2), arg3, v0);
        let v1 = EventAddPreset{
            base_fee : arg2,
            bin_step : arg3,
            preset   : v0,
        };
        0x2::event::emit<EventAddPreset>(v1);
    }

    public fun base_factor(arg0: &Preset) : u32 {
        arg0.base_factor
    }

    public(friend) fun check_admin(arg0: &Factory, arg1: &AdminCap) {
        let v0 = 0x2::object::id<AdminCap>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_admin, &v0), 2);
    }

    public(friend) fun check_protocol_fee_cap(arg0: &Factory, arg1: &ProtocolFeeCap) {
        let v0 = 0x2::object::id<ProtocolFeeCap>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_protocol_fee_cap, &v0), 6);
    }

    public fun close_bin_step_preset(arg0: &mut Factory, arg1: &AdminCap, arg2: u64, arg3: u16) {
        version_only(arg0);
        check_admin(arg0, arg1);
        assert!(0x2::vec_map::contains<u64, 0x2::vec_set::VecSet<u16>>(&arg0.opened_bin_steps, &arg2) && 0x2::vec_set::contains<u16>(0x2::vec_map::get<u64, 0x2::vec_set::VecSet<u16>>(&arg0.opened_bin_steps, &arg2), &arg3), 13906835711941672959);
        0x2::vec_set::remove<u16>(0x2::vec_map::get_mut<u64, 0x2::vec_set::VecSet<u16>>(&mut arg0.opened_bin_steps, &arg2), &arg3);
        let v0 = EventOpenBinStepPreset{
            base_fee : arg2,
            bin_step : arg3,
            opened   : false,
        };
        0x2::event::emit<EventOpenBinStepPreset>(v0);
    }

    public fun composition_enabled(arg0: &Factory) : bool {
        arg0.enable_composition
    }

    public fun decay_period(arg0: &Preset) : u16 {
        arg0.decay_period
    }

    public fun default_partner(arg0: &Factory) : 0x2::object::ID {
        *0x1::option::borrow<0x2::object::ID>(&arg0.default_partner)
    }

    public fun default_unstaked_liquidity_fee_rate() : u64 {
        72057594037927935
    }

    public fun filter_period(arg0: &Preset) : u16 {
        arg0.filter_period
    }

    public fun get_all_pairs(arg0: &Factory) : &vector<0x2::object::ID> {
        &arg0.pairs_iter
    }

    public fun get_all_pairs_count(arg0: &Factory) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.pairs_iter)
    }

    public fun get_bin_step_preset(arg0: &Factory, arg1: u64, arg2: u16) : Preset {
        assert!(0x2::vec_map::contains<u64, 0x2::vec_set::VecSet<u16>>(&arg0.opened_bin_steps, &arg1) && 0x2::vec_set::contains<u16>(0x2::vec_map::get<u64, 0x2::vec_set::VecSet<u16>>(&arg0.opened_bin_steps, &arg1), &arg2), 3);
        assert!(0x2::table::contains<u64, 0x2::table::Table<u16, Preset>>(&arg0.presets, arg1) && 0x2::table::contains<u16, Preset>(0x2::table::borrow<u64, 0x2::table::Table<u16, Preset>>(&arg0.presets, arg1), arg2), 4);
        *0x2::table::borrow<u16, Preset>(0x2::table::borrow<u64, 0x2::table::Table<u16, Preset>>(&arg0.presets, arg1), arg2)
    }

    public fun get_opened_bin_steps(arg0: &Factory, arg1: u64) : vector<u16> {
        *0x2::vec_set::keys<u16>(0x2::vec_map::get<u64, 0x2::vec_set::VecSet<u16>>(&arg0.opened_bin_steps, &arg1))
    }

    public fun get_pair_id(arg0: &Factory, arg1: 0x2::object::ID) : 0x2::object::ID {
        assert!(0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.pairs, arg1), 1);
        *0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.pairs, arg1)
    }

    public fun grant_admin(arg0: &mut Factory, arg1: &0x2::package::Publisher, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        version_only(arg0);
        assert!(0x2::package::from_package<Factory>(arg1), 13906835192250630143);
        let v0 = AdminCap{id: 0x2::object::new(arg3)};
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allowed_admin, 0x2::object::id<AdminCap>(&v0));
        let v1 = EventGrantAdmin{
            who : arg2,
            cap : 0x2::object::id<AdminCap>(&v0),
        };
        0x2::event::emit<EventGrantAdmin>(v1);
        0x2::transfer::transfer<AdminCap>(v0, arg2);
    }

    public fun grant_protocol_fee_cap(arg0: &mut Factory, arg1: &0x2::package::Publisher, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        version_only(arg0);
        assert!(0x2::package::from_package<Factory>(arg1), 13906835432768798719);
        let v0 = ProtocolFeeCap{id: 0x2::object::new(arg3)};
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allowed_protocol_fee_cap, 0x2::object::id<ProtocolFeeCap>(&v0));
        let v1 = EventGrantProtocolFeeCap{
            who : arg2,
            cap : 0x2::object::id<ProtocolFeeCap>(&v0),
        };
        0x2::event::emit<EventGrantProtocolFeeCap>(v1);
        0x2::transfer::transfer<ProtocolFeeCap>(v0, arg2);
    }

    public fun has_default_partner(arg0: &Factory) : bool {
        0x1::option::is_some<0x2::object::ID>(&arg0.default_partner)
    }

    fun init(arg0: ALMM_FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ALMM_FACTORY>(arg0, arg1);
        let v1 = Factory{
            id                          : 0x2::object::new(arg1),
            pairs                       : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg1),
            pairs_iter                  : 0x1::vector::empty<0x2::object::ID>(),
            allowed_admin               : 0x2::vec_set::empty<0x2::object::ID>(),
            allowed_protocol_fee_cap    : 0x2::vec_set::empty<0x2::object::ID>(),
            presets                     : 0x2::table::new<u64, 0x2::table::Table<u16, Preset>>(arg1),
            opened_bin_steps            : 0x2::vec_map::empty<u64, 0x2::vec_set::VecSet<u16>>(),
            available_bin_steps         : 0x2::table::new<0x1::type_name::TypeName, 0x2::table::Table<0x1::type_name::TypeName, 0x2::vec_set::VecSet<BaseFeeBinStep>>>(arg1),
            unstaked_liquidity_fee_rate : 0,
            default_partner             : 0x1::option::none<0x2::object::ID>(),
            enable_composition          : true,
            max_bins_in_position        : 81,
            version                     : 0,
            paused                      : false,
        };
        let v2 = &mut v1;
        let v3 = 0x2::tx_context::sender(arg1);
        grant_admin(v2, &v0, v3, arg1);
        0x2::transfer::share_object<Factory>(v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v4 = EventCreateFactory{factory_id: 0x2::object::id<Factory>(&v1)};
        0x2::event::emit<EventCreateFactory>(v4);
    }

    public fun is_bin_step_preset_open(arg0: &Factory, arg1: u64, arg2: u16) : bool {
        0x2::vec_map::contains<u64, 0x2::vec_set::VecSet<u16>>(&arg0.opened_bin_steps, &arg1) && 0x2::vec_set::contains<u16>(0x2::vec_map::get<u64, 0x2::vec_set::VecSet<u16>>(&arg0.opened_bin_steps, &arg1), &arg2)
    }

    public fun is_token_pair_sequence_valid<T0, T1>() : bool {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::ascii::as_bytes(&v0);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v3 = 0x1::ascii::as_bytes(&v2);
        if (v1 == v3) {
            return false
        };
        let v4 = 0;
        let v5 = false;
        let v6 = v5;
        while (v4 < 0x1::vector::length<u8>(v3)) {
            let v7 = 0x1::vector::borrow<u8>(v3, v4);
            if (!v5 && v4 < 0x1::vector::length<u8>(v1)) {
                let v8 = 0x1::vector::borrow<u8>(v1, v4);
                if (*v8 < *v7) {
                    return false
                };
                if (*v8 > *v7) {
                    v6 = true;
                    break
                };
            };
            v4 = v4 + 1;
        };
        if (!v6 && 0x1::vector::length<u8>(v1) > 0x1::vector::length<u8>(v3)) {
            return true
        };
        v6
    }

    public fun max_bins_in_position(arg0: &Factory) : u64 {
        arg0.max_bins_in_position
    }

    public fun max_volatility_accumulator(arg0: &Preset) : u32 {
        arg0.max_volatility_accumulator
    }

    public fun open_bin_step_preset(arg0: &mut Factory, arg1: &AdminCap, arg2: u64, arg3: u16) {
        version_only(arg0);
        check_admin(arg0, arg1);
        assert!(0x2::table::contains<u64, 0x2::table::Table<u16, Preset>>(&arg0.presets, arg2), 4);
        assert!(0x2::table::contains<u16, Preset>(0x2::table::borrow<u64, 0x2::table::Table<u16, Preset>>(&arg0.presets, arg2), arg3), 4);
        assert!(!0x2::vec_map::contains<u64, 0x2::vec_set::VecSet<u16>>(&arg0.opened_bin_steps, &arg2) || !0x2::vec_set::contains<u16>(0x2::vec_map::get<u64, 0x2::vec_set::VecSet<u16>>(&arg0.opened_bin_steps, &arg2), &arg3), 9);
        if (!0x2::vec_map::contains<u64, 0x2::vec_set::VecSet<u16>>(&arg0.opened_bin_steps, &arg2)) {
            0x2::vec_map::insert<u64, 0x2::vec_set::VecSet<u16>>(&mut arg0.opened_bin_steps, arg2, 0x2::vec_set::empty<u16>());
        };
        0x2::vec_set::insert<u16>(0x2::vec_map::get_mut<u64, 0x2::vec_set::VecSet<u16>>(&mut arg0.opened_bin_steps, &arg2), arg3);
        let v0 = EventOpenBinStepPreset{
            base_fee : arg2,
            bin_step : arg3,
            opened   : true,
        };
        0x2::event::emit<EventOpenBinStepPreset>(v0);
    }

    public fun pair_exist(arg0: &Factory, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.pairs, arg1)
    }

    public fun pair_uniq<T0, T1>(arg0: u16) : 0x2::object::ID {
        assert!(is_token_pair_sequence_valid<T0, T1>(), 7);
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v2 = 0x1::ascii::as_bytes(&v1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(v2)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(v2, v3));
            v3 = v3 + 1;
        };
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u16>(&arg0));
        0x2::object::id_from_bytes(0x2::hash::blake2b256(&v0))
    }

    public fun protocol_share(arg0: &Preset) : u16 {
        arg0.protocol_share
    }

    public fun reduction_factor(arg0: &Preset) : u16 {
        arg0.reduction_factor
    }

    public fun remove_preset(arg0: &mut Factory, arg1: &AdminCap, arg2: u64, arg3: u16) {
        version_only(arg0);
        check_admin(arg0, arg1);
        assert!(0x2::table::contains<u64, 0x2::table::Table<u16, Preset>>(&arg0.presets, arg2) && 0x2::table::contains<u16, Preset>(0x2::table::borrow<u64, 0x2::table::Table<u16, Preset>>(&arg0.presets, arg2), arg3), 1);
        if (0x2::vec_map::contains<u64, 0x2::vec_set::VecSet<u16>>(&arg0.opened_bin_steps, &arg2) && 0x2::vec_set::contains<u16>(0x2::vec_map::get<u64, 0x2::vec_set::VecSet<u16>>(&arg0.opened_bin_steps, &arg2), &arg3)) {
            0x2::vec_set::remove<u16>(0x2::vec_map::get_mut<u64, 0x2::vec_set::VecSet<u16>>(&mut arg0.opened_bin_steps, &arg2), &arg3);
            let v0 = EventOpenBinStepPreset{
                base_fee : arg2,
                bin_step : arg3,
                opened   : false,
            };
            0x2::event::emit<EventOpenBinStepPreset>(v0);
        };
        let v1 = EventRemovePreset{
            base_fee : arg2,
            bin_step : arg3,
            preset   : 0x2::table::remove<u16, Preset>(0x2::table::borrow_mut<u64, 0x2::table::Table<u16, Preset>>(&mut arg0.presets, arg2), arg3),
        };
        0x2::event::emit<EventRemovePreset>(v1);
    }

    public fun revoke_admin(arg0: &mut Factory, arg1: &0x2::package::Publisher, arg2: 0x2::object::ID) {
        version_only(arg0);
        assert!(0x2::package::from_module<Factory>(arg1), 13906835252380172287);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_admin, &arg2), 13906835256675139583);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.allowed_admin, &arg2);
        let v0 = EventRevokeAdmin{cap: arg2};
        0x2::event::emit<EventRevokeAdmin>(v0);
    }

    public fun revoke_protocol_fee_cap(arg0: &mut Factory, arg1: &0x2::package::Publisher, arg2: 0x2::object::ID) {
        version_only(arg0);
        assert!(0x2::package::from_module<Factory>(arg1), 13906835492898340863);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_protocol_fee_cap, &arg2), 13906835497193308159);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.allowed_protocol_fee_cap, &arg2);
        let v0 = EventRevokeProtocolFeeCap{cap: arg2};
        0x2::event::emit<EventRevokeProtocolFeeCap>(v0);
    }

    public fun set_composition_enabled(arg0: &mut Factory, arg1: &AdminCap, arg2: bool) {
        version_only(arg0);
        check_admin(arg0, arg1);
        arg0.enable_composition = arg2;
        let v0 = EventEnableComposition{enabled: arg2};
        0x2::event::emit<EventEnableComposition>(v0);
    }

    public fun set_default_partner(arg0: &mut Factory, arg1: &0x2::package::Publisher, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::partner::Partner) {
        version_only(arg0);
        assert!(0x2::package::from_package<Factory>(arg1), 13906835303919779839);
        if (0x1::option::is_some<0x2::object::ID>(&arg0.default_partner)) {
            0x1::option::extract<0x2::object::ID>(&mut arg0.default_partner);
        };
        0x1::option::fill<0x2::object::ID>(&mut arg0.default_partner, 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::partner::Partner>(arg2));
    }

    public fun set_max_bins_in_position(arg0: &mut Factory, arg1: &AdminCap, arg2: u64) {
        version_only(arg0);
        check_admin(arg0, arg1);
        let v0 = arg0.max_bins_in_position;
        assert!(v0 != arg2, 13906835381229191167);
        arg0.max_bins_in_position = arg2;
        let v1 = EventMaxBinsInPosition{
            old : v0,
            new : arg2,
        };
        0x2::event::emit<EventMaxBinsInPosition>(v1);
    }

    public fun set_paused(arg0: &mut Factory, arg1: &AdminCap, arg2: bool) {
        version_only(arg0);
        check_admin(arg0, arg1);
        assert!(arg0.paused != arg2, 13906834921667690495);
        arg0.paused = arg2;
        let v0 = EventPaused{paused: arg0.paused};
        0x2::event::emit<EventPaused>(v0);
    }

    public fun set_unstaked_liquidity_fee_rate(arg0: &mut Factory, arg1: &AdminCap, arg2: u64) {
        version_only(arg0);
        check_admin(arg0, arg1);
        assert!(arg0.unstaked_liquidity_fee_rate != arg2, 13906834956027428863);
        arg0.unstaked_liquidity_fee_rate = arg2;
        let v0 = EventChangeUnstakedLiquidityFeeRate{
            old : arg0.unstaked_liquidity_fee_rate,
            new : arg2,
        };
        0x2::event::emit<EventChangeUnstakedLiquidityFeeRate>(v0);
    }

    public fun set_version(arg0: &mut Factory, arg1: &AdminCap, arg2: u64) {
        check_admin(arg0, arg1);
        assert!(arg0.version < arg2, 13906834883012984831);
        arg0.version = arg2;
    }

    public fun unstaked_liquidity_fee_rate(arg0: &Factory) : u64 {
        arg0.unstaked_liquidity_fee_rate
    }

    public fun update_preset(arg0: &mut Factory, arg1: &AdminCap, arg2: u64, arg3: u16, arg4: Preset) {
        version_only(arg0);
        check_admin(arg0, arg1);
        assert!(0x2::table::contains<u64, 0x2::table::Table<u16, Preset>>(&arg0.presets, arg2) && 0x2::table::contains<u16, Preset>(0x2::table::borrow<u64, 0x2::table::Table<u16, Preset>>(&arg0.presets, arg2), arg3), 4);
        assert!(arg4.protocol_share <= 0x532bf64e6f0bf702353387d53a28a3239249f47c39d58954f2c0a1f9f4436c20::almm_constants::max_protocol_share(), 12);
        0x2::table::add<u16, Preset>(0x2::table::borrow_mut<u64, 0x2::table::Table<u16, Preset>>(&mut arg0.presets, arg2), arg3, arg4);
        let v0 = EventUpdatePreset{
            base_fee : arg2,
            bin_step : arg3,
            old      : 0x2::table::remove<u16, Preset>(0x2::table::borrow_mut<u64, 0x2::table::Table<u16, Preset>>(&mut arg0.presets, arg2), arg3),
            new      : arg4,
        };
        0x2::event::emit<EventUpdatePreset>(v0);
    }

    public fun variable_fee_control(arg0: &Preset) : u32 {
        arg0.variable_fee_control
    }

    public(friend) fun version_only(arg0: &Factory) {
        assert!(arg0.version == 0, 10);
    }

    // decompiled from Move bytecode v6
}

