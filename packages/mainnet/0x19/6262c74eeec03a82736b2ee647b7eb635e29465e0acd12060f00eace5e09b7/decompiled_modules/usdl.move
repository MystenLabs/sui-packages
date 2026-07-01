module 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::usdl {
    struct USDL has drop {
        dummy_field: bool,
    }

    struct LoafProtocol has key {
        id: 0x2::object::UID,
        version: u64,
        usdl_treasury_cap: 0x2::coin::TreasuryCap<USDL>,
        min_bottle_size: u64,
    }

    struct BucketType<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct WellType<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct TankType<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FlashMintConfig has store, key {
        id: 0x2::object::UID,
        fee_rate: u64,
        max_amount: u64,
        total_amount: u64,
    }

    struct FlashMintReceipt {
        config_id: 0x2::object::ID,
        mint_amount: u64,
        fee_amount: u64,
    }

    struct ReservoirType<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct SUsdlRateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SUsdlEmission has store, key {
        id: 0x2::object::UID,
        latest_time: u64,
        rate: 0x3e7e178c0ec6e24dd5a05346ed3cc0331670675ccf22d1ed4d61a6b1e8a5f97a::float::Float,
    }

    struct USDLET_PROTOCOL has drop {
        dummy_field: bool,
    }

    public fun borrow<T0>(arg0: &mut LoafProtocol, arg1: &0x9da1faddc97fd38448b688e5a064f1b4b3af9e43d7dab3cc07b681ec44ccff5a::loaf_oracle::LoafOracle, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: 0x1::option::Option<address>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<USDL> {
        assert_valid_package_version(arg0);
        let v0 = arg0.min_bottle_size;
        let v1 = borrow_bucket_mut<T0>(arg0);
        let v2 = 0x69f56ddcf0afd984804b0a17f11539a575854cb6fac16b887328abcf8f966bc2::math::mul_factor(arg4, compute_base_rate_fee<T0>(v1, arg2), 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::constants::fee_precision());
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::usdl_events::emit_collateral_increased<T0>(0x2::balance::value<T0>(&arg3));
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::handle_borrow<T0>(v1, arg1, 0x2::tx_context::sender(arg6), arg2, arg3, arg4 + v2, arg5, v0, arg6);
        let v3 = mint_usdl<T0>(arg0, v2);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well_events::emit_collect_fee_from<USDL>(&v3, b"borrow");
        let v4 = borrow_well_mut<USDL>(arg0);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well::collect_fee<USDL>(v4, v3);
        mint_usdl<T0>(arg0, arg4)
    }

    public fun add_interest_table_to_bucket<T0>(arg0: &AdminCap, arg1: &mut LoafProtocol, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::add_interest_table_to_bucket<T0>(borrow_bucket_mut<T0>(arg1), arg2, arg3);
    }

    public fun add_pending_record_to_bucket<T0>(arg0: &AdminCap, arg1: &mut LoafProtocol, arg2: &mut 0x2::tx_context::TxContext) {
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::add_pending_record_to_bucket<T0>(borrow_bucket_mut<T0>(arg1), arg2);
    }

    public fun adjust_pending_record<T0>(arg0: &AdminCap, arg1: &mut LoafProtocol) {
        let v0 = 0;
        let v1 = 0;
        let v2 = borrow_bucket_mut<T0>(arg1);
        let v3 = 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::borrow_bottle_table<T0>(v2);
        let v4 = *0x69f56ddcf0afd984804b0a17f11539a575854cb6fac16b887328abcf8f966bc2::linked_table::front<address, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bottle::Bottle>(0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bottle::borrow_table(v3));
        while (0x1::option::is_some<address>(&v4)) {
            let v5 = 0x1::option::destroy_some<address>(v4);
            let v6 = 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bottle::borrow_bottle(v3, v5);
            v0 = v0 + 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bottle::get_pending_coll(v6, v3);
            v1 = v1 + 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bottle::get_pending_debt(v6, v3);
            v4 = *0x69f56ddcf0afd984804b0a17f11539a575854cb6fac16b887328abcf8f966bc2::linked_table::next<address, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bottle::Bottle>(0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bottle::borrow_table(v3), v5);
        };
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::adjust_pending_record<T0>(v2, v0, v1);
    }

    public fun get_bottle_info_by_debtor<T0>(arg0: &LoafProtocol, arg1: address) : (u64, u64) {
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::get_bottle_info_by_debtor<T0>(borrow_bucket<T0>(arg0), arg1)
    }

    public fun get_bottle_info_with_interest_by_debtor<T0>(arg0: &LoafProtocol, arg1: address, arg2: &0x2::clock::Clock) : (u64, u64) {
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::get_bottle_info_with_interest_by_debtor<T0>(borrow_bucket<T0>(arg0), arg1, arg2)
    }

    public fun input<T0, T1: drop>(arg0: &mut LoafProtocol, arg1: 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::pipe::InputCarrier<T0, T1>) {
        assert!(!is_usdl<T0>(), 17);
        let v0 = borrow_pipe_mut<T0, T1>(arg0);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::input<T0>(borrow_bucket_mut<T0>(arg0), 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::pipe::destroy_input_carrier<T0, T1>(v0, arg1));
    }

    public fun is_liquidatable<T0>(arg0: &LoafProtocol, arg1: &0x9da1faddc97fd38448b688e5a064f1b4b3af9e43d7dab3cc07b681ec44ccff5a::loaf_oracle::LoafOracle, arg2: &0x2::clock::Clock, arg3: address) : bool {
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::is_liquidatable<T0>(borrow_bucket<T0>(arg0), arg1, arg2, arg3)
    }

    public fun output<T0, T1: drop>(arg0: &mut LoafProtocol, arg1: u64) : 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::pipe::OutputCarrier<T0, T1> {
        assert!(!is_usdl<T0>(), 17);
        let v0 = borrow_bucket_mut<T0>(arg0);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::pipe::output<T0, T1>(borrow_pipe_mut<T0, T1>(arg0), 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::output<T0>(v0, arg1))
    }

    public fun update_liquidation_config<T0>(arg0: &AdminCap, arg1: &mut LoafProtocol, arg2: &0x9da1faddc97fd38448b688e5a064f1b4b3af9e43d7dab3cc07b681ec44ccff5a::loaf_oracle::LoafOracle, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64) {
        let v0 = borrow_bucket_mut<T0>(arg1);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::update_liquidation_config<T0>(v0, arg4, arg5);
        assert!(!0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::has_liquidatable_bottle<T0>(v0, arg2, arg3), 18);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::usdl_events::emit_param_updated<T0>(b"min_collateral_ratio", arg4);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::usdl_events::emit_param_updated<T0>(b"recovery_mode_threshold", arg5);
    }

    public entry fun update_max_mint_amount<T0>(arg0: &AdminCap, arg1: &mut LoafProtocol, arg2: 0x1::option::Option<u64>) {
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::update_max_mint_amount<T0>(borrow_bucket_mut<T0>(arg1), arg2);
        let v0 = if (0x1::option::is_some<u64>(&arg2)) {
            0x1::option::destroy_some<u64>(arg2)
        } else {
            0
        };
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::usdl_events::emit_param_updated<LoafProtocol>(b"max_mint_amount", v0);
    }

    public fun withdraw_surplus_collateral<T0>(arg0: &mut LoafProtocol, arg1: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert_valid_package_version(arg0);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::withdraw_surplus_collateral<T0>(borrow_bucket_mut<T0>(arg0), 0x2::tx_context::sender(arg1))
    }

    public fun collect_interests<T0>(arg0: &mut LoafProtocol) {
        assert_valid_package_version(arg0);
        let v0 = borrow_bucket_mut<T0>(arg0);
        let v1 = mint_usdl<T0>(arg0, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::interest::collect_interests(0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::borrow_interest_table_mut<T0>(v0)));
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well_events::emit_collect_fee_from<USDL>(&v1, b"interest");
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well::collect_fee<USDL>(borrow_well_mut<USDL>(arg0), v1);
    }

    public fun set_interest_rate<T0>(arg0: &AdminCap, arg1: &mut LoafProtocol, arg2: u256, arg3: &0x2::clock::Clock) {
        assert!(arg2 <= 10000, 16);
        let v0 = borrow_bucket_mut<T0>(arg1);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::interest::set_interest_rate(0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::borrow_interest_table_mut<T0>(v0), 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::math::mul_factor_u256(arg2, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::constants::interest_precision(), 10000 * 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::constants::ms_in_year()), 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::get_minted_usdl_amount<T0>(v0) - 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::get_bucket_pending_debt<T0>(v0), arg3);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::usdl_events::emit_param_updated<0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::Bucket<T0>>(b"interest_rate", (arg2 as u64));
    }

    public fun destroy_pipe<T0, T1: drop>(arg0: &AdminCap, arg1: &mut LoafProtocol) {
        if (is_usdl<T0>()) {
            0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::pipe::destroy_usdl_pipe<T0, T1>(0x2::dynamic_object_field::remove<0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::pipe::PipeType<T0, T1>, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::pipe::Pipe<T0, T1>>(&mut arg1.id, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::pipe::new_type<T0, T1>()));
        } else {
            0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::pipe::destroy_pipe<T0, T1>(0x2::dynamic_object_field::remove<0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::pipe::PipeType<T0, T1>, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::pipe::Pipe<T0, T1>>(&mut arg1.id, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::pipe::new_type<T0, T1>()));
        };
    }

    public fun withdraw<T0>(arg0: &mut LoafProtocol, arg1: &0x9da1faddc97fd38448b688e5a064f1b4b3af9e43d7dab3cc07b681ec44ccff5a::loaf_oracle::LoafOracle, arg2: &0x2::clock::Clock, arg3: u64, arg4: 0x1::option::Option<address>, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = borrow_bucket_mut<T0>(arg0);
        assert!(0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::is_not_locked<T0>(v0), 14);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::usdl_events::emit_collateral_decreased<T0>(arg3);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::handle_withdraw<T0>(v0, arg1, 0x2::tx_context::sender(arg5), arg2, arg3, arg4)
    }

    fun assert_valid_package_version(arg0: &LoafProtocol) {
        assert!(package_version() == arg0.version, 99);
    }

    public fun borrow_bucket<T0>(arg0: &LoafProtocol) : &0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::Bucket<T0> {
        assert_valid_package_version(arg0);
        let v0 = BucketType<T0>{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_with_type<BucketType<T0>, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::Bucket<T0>>(&arg0.id, v0), 5);
        0x2::dynamic_object_field::borrow<BucketType<T0>, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::Bucket<T0>>(&arg0.id, v0)
    }

    fun borrow_bucket_mut<T0>(arg0: &mut LoafProtocol) : &mut 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::Bucket<T0> {
        assert_valid_package_version(arg0);
        let v0 = BucketType<T0>{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_with_type<BucketType<T0>, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::Bucket<T0>>(&arg0.id, v0), 5);
        let v1 = BucketType<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<BucketType<T0>, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::Bucket<T0>>(&mut arg0.id, v1)
    }

    public fun borrow_pipe<T0, T1: drop>(arg0: &LoafProtocol) : &0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::pipe::Pipe<T0, T1> {
        assert_valid_package_version(arg0);
        let v0 = 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::pipe::new_type<T0, T1>();
        assert!(0x2::dynamic_object_field::exists_with_type<0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::pipe::PipeType<T0, T1>, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::pipe::Pipe<T0, T1>>(&arg0.id, v0), 5);
        0x2::dynamic_object_field::borrow<0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::pipe::PipeType<T0, T1>, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::pipe::Pipe<T0, T1>>(&arg0.id, v0)
    }

    fun borrow_pipe_mut<T0, T1: drop>(arg0: &mut LoafProtocol) : &mut 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::pipe::Pipe<T0, T1> {
        assert_valid_package_version(arg0);
        let v0 = 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::pipe::new_type<T0, T1>();
        assert!(0x2::dynamic_object_field::exists_with_type<0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::pipe::PipeType<T0, T1>, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::pipe::Pipe<T0, T1>>(&arg0.id, v0), 5);
        0x2::dynamic_object_field::borrow_mut<0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::pipe::PipeType<T0, T1>, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::pipe::Pipe<T0, T1>>(&mut arg0.id, v0)
    }

    public fun borrow_reservoir<T0>(arg0: &LoafProtocol) : &0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::reservoir::Reservoir<T0> {
        assert_valid_package_version(arg0);
        let v0 = ReservoirType<T0>{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_with_type<ReservoirType<T0>, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::reservoir::Reservoir<T0>>(&arg0.id, v0), 5);
        0x2::dynamic_object_field::borrow<ReservoirType<T0>, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::reservoir::Reservoir<T0>>(&arg0.id, v0)
    }

    fun borrow_reservoir_mut<T0>(arg0: &mut LoafProtocol) : &mut 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::reservoir::Reservoir<T0> {
        assert_valid_package_version(arg0);
        let v0 = ReservoirType<T0>{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_with_type<ReservoirType<T0>, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::reservoir::Reservoir<T0>>(&arg0.id, v0), 5);
        0x2::dynamic_object_field::borrow_mut<ReservoirType<T0>, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::reservoir::Reservoir<T0>>(&mut arg0.id, v0)
    }

    public fun borrow_tank<T0>(arg0: &LoafProtocol) : &0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::tank::Tank<USDL, T0> {
        assert_valid_package_version(arg0);
        let v0 = TankType<T0>{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_with_type<TankType<T0>, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::tank::Tank<USDL, T0>>(&arg0.id, v0), 5);
        let v1 = TankType<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow<TankType<T0>, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::tank::Tank<USDL, T0>>(&arg0.id, v1)
    }

    public fun borrow_tank_mut<T0>(arg0: &mut LoafProtocol) : &mut 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::tank::Tank<USDL, T0> {
        assert_valid_package_version(arg0);
        let v0 = TankType<T0>{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_with_type<TankType<T0>, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::tank::Tank<USDL, T0>>(&arg0.id, v0), 5);
        let v1 = TankType<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<TankType<T0>, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::tank::Tank<USDL, T0>>(&mut arg0.id, v1)
    }

    public fun borrow_well<T0>(arg0: &LoafProtocol) : &0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well::Well<T0> {
        assert_valid_package_version(arg0);
        let v0 = WellType<T0>{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_with_type<WellType<T0>, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well::Well<T0>>(&arg0.id, v0), 5);
        let v1 = WellType<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow<WellType<T0>, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well::Well<T0>>(&arg0.id, v1)
    }

    public fun borrow_well_mut<T0>(arg0: &mut LoafProtocol) : &mut 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well::Well<T0> {
        assert_valid_package_version(arg0);
        let v0 = WellType<T0>{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_with_type<WellType<T0>, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well::Well<T0>>(&arg0.id, v0), 5);
        let v1 = WellType<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<WellType<T0>, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well::Well<T0>>(&mut arg0.id, v1)
    }

    public fun borrow_with_strap<T0>(arg0: &mut LoafProtocol, arg1: &0x9da1faddc97fd38448b688e5a064f1b4b3af9e43d7dab3cc07b681ec44ccff5a::loaf_oracle::LoafOracle, arg2: &0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::strap::BottleStrap<T0>, arg3: &0x2::clock::Clock, arg4: 0x2::balance::Balance<T0>, arg5: u64, arg6: 0x1::option::Option<address>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<USDL> {
        assert_valid_package_version(arg0);
        let v0 = arg0.min_bottle_size;
        let v1 = borrow_bucket_mut<T0>(arg0);
        let v2 = 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::strap::fee_rate<T0>(arg2);
        let v3 = if (0x1::option::is_none<u64>(&v2)) {
            compute_base_rate_fee<T0>(v1, arg3)
        } else {
            0x1::option::destroy_some<u64>(v2)
        };
        let v4 = 0x69f56ddcf0afd984804b0a17f11539a575854cb6fac16b887328abcf8f966bc2::math::mul_factor(arg5, v3, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::constants::fee_precision());
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::usdl_events::emit_collateral_increased<T0>(0x2::balance::value<T0>(&arg4));
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::handle_borrow<T0>(v1, arg1, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::strap::get_address<T0>(arg2), arg3, arg4, arg5 + v4, arg6, v0, arg7);
        if (v4 > 0) {
            let v5 = mint_usdl<T0>(arg0, v4);
            0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well_events::emit_collect_fee_from<USDL>(&v5, b"borrow");
            let v6 = borrow_well_mut<USDL>(arg0);
            0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well::collect_fee<USDL>(v6, v5);
        };
        mint_usdl<T0>(arg0, arg5)
    }

    public fun burn_susdl(arg0: &mut LoafProtocol, arg1: &mut 0x3e7e178c0ec6e24dd5a05346ed3cc0331670675ccf22d1ed4d61a6b1e8a5f97a::susdl::Flask<USDL>, arg2: 0x2::coin::Coin<0x3e7e178c0ec6e24dd5a05346ed3cc0331670675ccf22d1ed4d61a6b1e8a5f97a::susdl::SUSDL>) : 0x2::balance::Balance<USDL> {
        abort 404
    }

    fun burn_usdl<T0>(arg0: &mut LoafProtocol, arg1: 0x2::balance::Balance<USDL>) {
        assert_valid_package_version(arg0);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::usdl_events::emit_usdl_burnt<T0>(0x2::balance::value<USDL>(&arg1));
        0x2::balance::decrease_supply<USDL>(0x2::coin::supply_mut<USDL>(&mut arg0.usdl_treasury_cap), arg1);
    }

    public fun charge_reservoir<T0>(arg0: &mut LoafProtocol, arg1: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<USDL> {
        let v0 = 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::reservoir::charge_fee_rate<T0>(borrow_reservoir<T0>(arg0));
        charge_reservoir_internal<T0>(arg0, arg1, v0)
    }

    public fun charge_reservoir_by_partner<T0, T1: drop>(arg0: &mut LoafProtocol, arg1: 0x2::balance::Balance<T0>, arg2: T1) : 0x2::balance::Balance<USDL> {
        let v0 = 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::reservoir::charge_fee_rate_for_partner<T0, T1>(borrow_reservoir<T0>(arg0));
        charge_reservoir_internal<T0>(arg0, arg1, v0)
    }

    fun charge_reservoir_internal<T0>(arg0: &mut LoafProtocol, arg1: 0x2::balance::Balance<T0>, arg2: u64) : 0x2::balance::Balance<USDL> {
        let v0 = borrow_reservoir_mut<T0>(arg0);
        let v1 = 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::reservoir::handle_charge<T0>(v0, arg1);
        let v2 = mint_usdl<T0>(arg0, v1);
        let v3 = 0x2::balance::split<USDL>(&mut v2, 0x69f56ddcf0afd984804b0a17f11539a575854cb6fac16b887328abcf8f966bc2::math::mul_factor(v1, arg2, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::constants::fee_precision()));
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well_events::emit_collect_fee_from<USDL>(&v3, b"charge");
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well::collect_fee<USDL>(borrow_well_mut<USDL>(arg0), v3);
        v2
    }

    fun collect_interest(arg0: &mut LoafProtocol, arg1: &mut 0x3e7e178c0ec6e24dd5a05346ed3cc0331670675ccf22d1ed4d61a6b1e8a5f97a::susdl::Flask<USDL>, arg2: &0x2::clock::Clock) {
        let v0 = interest_amount(arg0, arg1, arg2);
        let v1 = mint_usdl<0x3e7e178c0ec6e24dd5a05346ed3cc0331670675ccf22d1ed4d61a6b1e8a5f97a::susdl::SUSDL>(arg0, v0);
        emission_mut(arg0).latest_time = 0x2::clock::timestamp_ms(arg2);
        0x3e7e178c0ec6e24dd5a05346ed3cc0331670675ccf22d1ed4d61a6b1e8a5f97a::susdl::collect_rewards<USDL>(arg1, v1);
    }

    public fun collect_interests_to_flask<T0>(arg0: &mut LoafProtocol, arg1: &mut 0x3e7e178c0ec6e24dd5a05346ed3cc0331670675ccf22d1ed4d61a6b1e8a5f97a::susdl::Flask<USDL>) {
        abort 404
    }

    public fun compute_base_rate_fee<T0>(arg0: &0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::Bucket<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::compute_base_rate<T0>(arg0, 0x2::clock::timestamp_ms(arg1));
        let v1 = v0;
        if (v0 > 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::constants::max_fee()) {
            v1 = 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::constants::max_fee();
        };
        if (v1 < 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::constants::min_fee()) {
            v1 = 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::constants::min_fee();
        };
        v1
    }

    public entry fun create_bucket<T0>(arg0: &AdminCap, arg1: &mut LoafProtocol, arg2: u64, arg3: u64, arg4: u8, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = BucketType<T0>{dummy_field: false};
        assert!(!0x2::dynamic_object_field::exists_with_type<BucketType<T0>, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::Bucket<T0>>(&arg1.id, v0), 2);
        0x2::dynamic_object_field::add<BucketType<T0>, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::Bucket<T0>>(&mut arg1.id, v0, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::new<T0>(arg2, arg3, arg4, arg5, arg6));
        let v1 = WellType<T0>{dummy_field: false};
        0x2::dynamic_object_field::add<WellType<T0>, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well::Well<T0>>(&mut arg1.id, v1, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well::new<T0>(arg6));
        let v2 = TankType<T0>{dummy_field: false};
        0x2::dynamic_object_field::add<TankType<T0>, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::tank::Tank<USDL, T0>>(&mut arg1.id, v2, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::tank::new<USDL, T0>(arg6));
    }

    public fun create_bucket_with_interest_table<T0>(arg0: &AdminCap, arg1: &mut LoafProtocol, arg2: u64, arg3: u64, arg4: u8, arg5: 0x1::option::Option<u64>, arg6: &0x2::clock::Clock, arg7: u256, arg8: &mut 0x2::tx_context::TxContext) {
        create_bucket<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg8);
        add_pending_record_to_bucket<T0>(arg0, arg1, arg8);
        add_interest_table_to_bucket<T0>(arg0, arg1, arg6, arg8);
        set_interest_rate<T0>(arg0, arg1, arg7, arg6);
    }

    public fun create_flash_mint_config_to(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = FlashMintConfig{
            id           : 0x2::object::new(arg4),
            fee_rate     : arg1,
            max_amount   : arg2,
            total_amount : 0,
        };
        0x2::transfer::transfer<FlashMintConfig>(v0, arg3);
    }

    public fun create_pipe<T0, T1: drop>(arg0: &AdminCap, arg1: &mut LoafProtocol, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::dynamic_object_field::add<0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::pipe::PipeType<T0, T1>, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::pipe::Pipe<T0, T1>>(&mut arg1.id, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::pipe::new_type<T0, T1>(), 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::pipe::new_pipe<T0, T1>(arg2));
    }

    public fun create_reservoir<T0>(arg0: &AdminCap, arg1: &mut LoafProtocol, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert_valid_package_version(arg1);
        let v0 = ReservoirType<T0>{dummy_field: false};
        0x2::dynamic_object_field::add<ReservoirType<T0>, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::reservoir::Reservoir<T0>>(&mut arg1.id, v0, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::reservoir::new<T0>(arg2, arg3, arg4, arg5));
        let v1 = WellType<T0>{dummy_field: false};
        if (!0x2::dynamic_object_field::exists_with_type<WellType<T0>, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well::Well<T0>>(&arg1.id, v1)) {
            0x2::dynamic_object_field::add<WellType<T0>, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well::Well<T0>>(&mut arg1.id, v1, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well::new<T0>(arg5));
        };
    }

    public fun deposit_surplus_with_strap<T0>(arg0: &mut LoafProtocol, arg1: 0x2::balance::Balance<T0>, arg2: &0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::strap::BottleStrap<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::handle_deposit_surplus<T0>(borrow_bucket_mut<T0>(arg0), 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::strap::get_address<T0>(arg2), arg1, arg3);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::usdl_events::emit_collateral_increased<T0>(0x2::balance::value<T0>(&arg1));
    }

    public fun discharge_reservoir<T0>(arg0: &mut LoafProtocol, arg1: 0x2::balance::Balance<USDL>) : 0x2::balance::Balance<T0> {
        let v0 = 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::reservoir::discharge_fee_rate<T0>(borrow_reservoir<T0>(arg0));
        discharge_reservoir_internal<T0>(arg0, arg1, v0)
    }

    public fun discharge_reservoir_by_partner<T0, T1: drop>(arg0: &mut LoafProtocol, arg1: 0x2::balance::Balance<USDL>, arg2: T1) : 0x2::balance::Balance<T0> {
        let v0 = 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::reservoir::discharge_fee_rate_for_partner<T0, T1>(borrow_reservoir<T0>(arg0));
        discharge_reservoir_internal<T0>(arg0, arg1, v0)
    }

    fun discharge_reservoir_internal<T0>(arg0: &mut LoafProtocol, arg1: 0x2::balance::Balance<USDL>, arg2: u64) : 0x2::balance::Balance<T0> {
        burn_usdl<T0>(arg0, arg1);
        let v0 = borrow_reservoir_mut<T0>(arg0);
        let v1 = 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::reservoir::handle_discharge<T0>(v0, 0x2::balance::value<USDL>(&arg1));
        let v2 = 0x2::balance::split<T0>(&mut v1, 0x69f56ddcf0afd984804b0a17f11539a575854cb6fac16b887328abcf8f966bc2::math::mul_factor(0x2::balance::value<T0>(&v1), arg2, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::constants::fee_precision()));
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well_events::emit_collect_fee_from<T0>(&v2, b"discharge");
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well::collect_fee<T0>(borrow_well_mut<T0>(arg0), v2);
        v1
    }

    fun emission(arg0: &LoafProtocol) : &SUsdlEmission {
        let v0 = SUsdlRateKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<SUsdlRateKey, SUsdlEmission>(&arg0.id, v0)
    }

    fun emission_mut(arg0: &mut LoafProtocol) : &mut SUsdlEmission {
        let v0 = SUsdlRateKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<SUsdlRateKey, SUsdlEmission>(&mut arg0.id, v0)
    }

    public fun flash_borrow<T0>(arg0: &mut LoafProtocol, arg1: u64) : (0x2::balance::Balance<T0>, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::FlashReceipt<T0>) {
        assert_valid_package_version(arg0);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::usdl_events::emit_flash_loan<T0>(arg1);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::handle_flash_borrow<T0>(borrow_bucket_mut<T0>(arg0), arg1)
    }

    public fun flash_borrow_usdl<T0>(arg0: &mut LoafProtocol, arg1: u64) : (0x2::balance::Balance<USDL>, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::tank::FlashReceipt<USDL, T0>) {
        assert_valid_package_version(arg0);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::usdl_events::emit_flash_loan<USDL>(arg1);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::tank::handle_flash_borrow<USDL, T0>(borrow_tank_mut<T0>(arg0), arg1)
    }

    public fun flash_burn(arg0: &mut LoafProtocol, arg1: &mut FlashMintConfig, arg2: 0x2::balance::Balance<USDL>, arg3: FlashMintReceipt) {
        let FlashMintReceipt {
            config_id   : v0,
            mint_amount : v1,
            fee_amount  : v2,
        } = arg3;
        assert!(0x2::balance::value<USDL>(&arg2) >= v1 + v2, 12);
        assert!(v0 == 0x2::object::id<FlashMintConfig>(arg1), 13);
        arg1.total_amount = arg1.total_amount - v1;
        let v3 = 0x2::balance::split<USDL>(&mut arg2, v2);
        burn_usdl<USDL>(arg0, arg2);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well_events::emit_collect_fee_from<USDL>(&v3, b"flashmint");
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well::collect_fee<USDL>(borrow_well_mut<USDL>(arg0), v3);
    }

    public fun flash_mint(arg0: &mut LoafProtocol, arg1: &mut FlashMintConfig, arg2: u64) : (0x2::balance::Balance<USDL>, FlashMintReceipt) {
        arg1.total_amount = arg1.total_amount + arg2;
        assert!(arg1.total_amount <= arg1.max_amount, 11);
        let v0 = 0x2::object::id<FlashMintConfig>(arg1);
        let v1 = 0x69f56ddcf0afd984804b0a17f11539a575854cb6fac16b887328abcf8f966bc2::math::mul_factor(arg2, arg1.fee_rate, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::constants::fee_precision());
        let v2 = FlashMintReceipt{
            config_id   : v0,
            mint_amount : arg2,
            fee_amount  : v1,
        };
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::usdl_events::emit_flash_mint(v0, arg2, v1);
        (mint_usdl<USDL>(arg0, arg2), v2)
    }

    public fun flash_repay<T0>(arg0: &mut LoafProtocol, arg1: 0x2::balance::Balance<T0>, arg2: 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::FlashReceipt<T0>) {
        assert_valid_package_version(arg0);
        let v0 = borrow_bucket_mut<T0>(arg0);
        let v1 = 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::handle_flash_repay<T0>(v0, arg1, arg2);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well_events::emit_collect_fee_from<T0>(&v1, b"flashloan");
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well::collect_fee<T0>(borrow_well_mut<T0>(arg0), v1);
    }

    public fun flash_repay_usdl<T0>(arg0: &mut LoafProtocol, arg1: 0x2::balance::Balance<USDL>, arg2: 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::tank::FlashReceipt<USDL, T0>) {
        assert_valid_package_version(arg0);
        let v0 = borrow_tank_mut<T0>(arg0);
        let v1 = 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::tank::handle_flash_repay<USDL, T0>(v0, arg1, arg2);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well_events::emit_collect_fee_from<USDL>(&v1, b"flashloan");
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well::collect_fee<USDL>(borrow_well_mut<USDL>(arg0), v1);
    }

    public fun get_min_bottle_size(arg0: &LoafProtocol) : u64 {
        assert_valid_package_version(arg0);
        arg0.min_bottle_size
    }

    fun has_emission(arg0: &LoafProtocol) : bool {
        let v0 = SUsdlRateKey{dummy_field: false};
        0x2::dynamic_object_field::exists_with_type<SUsdlRateKey, SUsdlEmission>(&arg0.id, v0)
    }

    fun init(arg0: USDL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new_protocol(arg0, arg1);
        0x2::transfer::share_object<LoafProtocol>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun init_bottle_current_interest_index<T0>(arg0: &AdminCap, arg1: &mut LoafProtocol, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_bucket_mut<T0>(arg1);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::add_interest_index_to_bottle_by_debtor<T0>(v0, arg2, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::interest::get_active_interest_index(0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::borrow_interest_table<T0>(v0)), arg3);
    }

    public fun init_bottle_interest_index<T0>(arg0: &AdminCap, arg1: &mut LoafProtocol, arg2: address, arg3: u256, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_bucket_mut<T0>(arg1);
        assert!(arg3 >= 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::interest::get_active_interest_index(0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::borrow_interest_table_mut<T0>(v0)), 15);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::add_interest_index_to_bottle_by_debtor<T0>(v0, arg2, arg3, arg4);
    }

    public fun input_usdl<T0: drop>(arg0: &mut LoafProtocol, arg1: 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::pipe::InputCarrier<USDL, T0>) {
        let v0 = borrow_pipe_mut<USDL, T0>(arg0);
        burn_usdl<T0>(arg0, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::pipe::destroy_input_carrier<USDL, T0>(v0, arg1));
    }

    public fun interest_amount(arg0: &LoafProtocol, arg1: &0x3e7e178c0ec6e24dd5a05346ed3cc0331670675ccf22d1ed4d61a6b1e8a5f97a::susdl::Flask<USDL>, arg2: &0x2::clock::Clock) : u64 {
        if (has_emission(arg0)) {
            let v1 = emission(arg0);
            0x3e7e178c0ec6e24dd5a05346ed3cc0331670675ccf22d1ed4d61a6b1e8a5f97a::float::floor(0x3e7e178c0ec6e24dd5a05346ed3cc0331670675ccf22d1ed4d61a6b1e8a5f97a::float::mul(0x3e7e178c0ec6e24dd5a05346ed3cc0331670675ccf22d1ed4d61a6b1e8a5f97a::float::from(0x3e7e178c0ec6e24dd5a05346ed3cc0331670675ccf22d1ed4d61a6b1e8a5f97a::susdl::reserves<USDL>(arg1)), 0x3e7e178c0ec6e24dd5a05346ed3cc0331670675ccf22d1ed4d61a6b1e8a5f97a::float::mul(v1.rate, 0x3e7e178c0ec6e24dd5a05346ed3cc0331670675ccf22d1ed4d61a6b1e8a5f97a::float::from_fraction(0x2::clock::timestamp_ms(arg2) - v1.latest_time, (0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::constants::ms_in_year() as u64)))))
        } else {
            0
        }
    }

    public fun is_usdl<T0>() : bool {
        0x1::type_name::get<T0>() == 0x1::type_name::get<USDL>()
    }

    public fun liquidate_under_normal_mode<T0>(arg0: &mut LoafProtocol, arg1: &0x9da1faddc97fd38448b688e5a064f1b4b3af9e43d7dab3cc07b681ec44ccff5a::loaf_oracle::LoafOracle, arg2: &0x2::clock::Clock, arg3: address) : 0x2::balance::Balance<T0> {
        assert_valid_package_version(arg0);
        let v0 = borrow_bucket<T0>(arg0);
        assert!(!0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::is_in_recovery_mode<T0>(v0, arg1, arg2), 7);
        assert!(0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::is_not_locked<T0>(v0), 14);
        normally_liquidate<T0>(arg0, arg1, arg2, arg3, 0x1::option::none<u64>())
    }

    public fun liquidate_under_recovery_mode<T0>(arg0: &mut LoafProtocol, arg1: &0x9da1faddc97fd38448b688e5a064f1b4b3af9e43d7dab3cc07b681ec44ccff5a::loaf_oracle::LoafOracle, arg2: &0x2::clock::Clock, arg3: address) : 0x2::balance::Balance<T0> {
        assert_valid_package_version(arg0);
        assert!(is_liquidatable<T0>(arg0, arg1, arg2, arg3), 1);
        assert!(0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::tank::is_not_locked<USDL, T0>(borrow_tank<T0>(arg0)), 4);
        let v0 = 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::tank::get_reserve_balance<USDL, T0>(borrow_tank<T0>(arg0));
        let v1 = borrow_bucket_mut<T0>(arg0);
        assert!(0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::is_in_recovery_mode<T0>(v1, arg1, arg2), 6);
        assert!(0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::is_not_locked<T0>(v1), 14);
        let v2 = if (0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::is_interest_table_exists<T0>(v1)) {
            0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::accrue_interests_by_debtor<T0>(v1, arg3, arg2);
            let (v3, v4) = 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::get_bottle_info_with_interest_by_debtor<T0>(v1, arg3, arg2);
            let _ = v3;
            v4
        } else {
            let (v6, v7) = 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::get_bottle_info_by_debtor<T0>(v1, arg3);
            let _ = v6;
            v7
        };
        let v8 = 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::get_bottle_icr<T0>(v1, arg1, arg2, arg3);
        let v9 = 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::get_bucket_tcr<T0>(v1, arg1, arg2);
        let v10 = 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::get_minimum_collateral_ratio<T0>(v1) * 100;
        let (v11, v12) = if (v8 < v10) {
            let v13 = normally_liquidate<T0>(arg0, arg1, arg2, arg3, 0x1::option::some<u64>(v9));
            (0x2::balance::zero<T0>(), v13)
        } else {
            assert!(v8 >= v10 && v8 < v9, 1);
            assert!(v0 > 0, 9);
            let v14 = if (v2 <= v0) {
                v2
            } else {
                v0
            };
            let v15 = borrow_bucket_mut<T0>(arg0);
            let v16 = 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::handle_repay_capped<T0>(v15, arg3, v14, arg1, arg2);
            let v17 = 0x2::balance::value<T0>(&v16);
            if (v2 == v14) {
                assert!(0x2::table::contains<address, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bottle::Bottle>(0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::borrow_surplus_bottle_table<T0>(borrow_bucket<T0>(arg0)), arg3), 10);
            };
            let v18 = borrow_tank_mut<T0>(arg0);
            burn_usdl<T0>(arg0, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::tank::absorb<USDL, T0>(v18, v16, v14));
            let v19 = borrow_bucket_mut<T0>(arg0);
            0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::update_snapshot<T0>(v19);
            0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::usdl_events::emit_collateral_decreased<T0>(v17);
            let (v20, v21) = 0x9da1faddc97fd38448b688e5a064f1b4b3af9e43d7dab3cc07b681ec44ccff5a::loaf_oracle::get_price<T0>(arg1, arg2);
            0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::usdl_events::emit_liquidation<T0>(v20, v21, v17, v14, 0x1::option::some<u64>(v9), arg3);
            (0x2::balance::split<T0>(&mut v16, 0x69f56ddcf0afd984804b0a17f11539a575854cb6fac16b887328abcf8f966bc2::math::mul_factor(0x2::balance::value<T0>(&v16), 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::constants::liquidation_fee(), 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::constants::fee_precision())), 0x2::balance::split<T0>(&mut v16, 0x69f56ddcf0afd984804b0a17f11539a575854cb6fac16b887328abcf8f966bc2::math::mul_factor(0x2::balance::value<T0>(&v16), 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::constants::liquidation_rebate(), 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::constants::fee_precision())))
        };
        let v22 = v11;
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well_events::emit_collect_fee_from<T0>(&v22, b"liquidate");
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well::collect_fee<T0>(borrow_well_mut<T0>(arg0), v22);
        v12
    }

    public fun mint_susdl(arg0: &mut LoafProtocol, arg1: &mut 0x3e7e178c0ec6e24dd5a05346ed3cc0331670675ccf22d1ed4d61a6b1e8a5f97a::susdl::Flask<USDL>, arg2: 0x2::coin::Coin<USDL>) : 0x2::balance::Balance<0x3e7e178c0ec6e24dd5a05346ed3cc0331670675ccf22d1ed4d61a6b1e8a5f97a::susdl::SUSDL> {
        abort 404
    }

    fun mint_usdl<T0>(arg0: &mut LoafProtocol, arg1: u64) : 0x2::balance::Balance<USDL> {
        assert_valid_package_version(arg0);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::usdl_events::emit_usdl_minted<T0>(arg1);
        0x2::coin::mint_balance<USDL>(&mut arg0.usdl_treasury_cap, arg1)
    }

    fun new_protocol(arg0: USDL, arg1: &mut 0x2::tx_context::TxContext) : (LoafProtocol, AdminCap) {
        let (v0, v1) = 0x2::coin::create_currency<USDL>(arg0, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::constants::usdl_decimal(), b"USDL", b"Loaf USD", b"the stablecoin minted through loafprotocol.io", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYH4seo7K9CiFqHGDmhbZmzewHEapAhN9aqLRA7af2vMW")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDL>>(v1);
        let v2 = 0x2::object::new(arg1);
        let v3 = WellType<USDL>{dummy_field: false};
        0x2::dynamic_object_field::add<WellType<USDL>, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well::Well<USDL>>(&mut v2, v3, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well::new<USDL>(arg1));
        let v4 = LoafProtocol{
            id                : v2,
            version           : 7,
            usdl_treasury_cap : v0,
            min_bottle_size   : 10000000000,
        };
        let v5 = AdminCap{id: 0x2::object::new(arg1)};
        let v6 = &mut v4;
        create_bucket<0x2::sui::SUI>(&v5, v6, 110, 150, 9, 0x1::option::none<u64>(), arg1);
        (v4, v5)
    }

    fun normally_liquidate<T0>(arg0: &mut LoafProtocol, arg1: &0x9da1faddc97fd38448b688e5a064f1b4b3af9e43d7dab3cc07b681ec44ccff5a::loaf_oracle::LoafOracle, arg2: &0x2::clock::Clock, arg3: address, arg4: 0x1::option::Option<u64>) : 0x2::balance::Balance<T0> {
        assert_valid_package_version(arg0);
        let v0 = arg0.min_bottle_size;
        assert!(is_liquidatable<T0>(arg0, arg1, arg2, arg3), 1);
        assert!(0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::tank::is_not_locked<USDL, T0>(borrow_tank<T0>(arg0)), 4);
        let v1 = 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::tank::get_reserve_balance<USDL, T0>(borrow_tank<T0>(arg0));
        let v2 = borrow_bucket_mut<T0>(arg0);
        let v3 = if (0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::is_interest_table_exists<T0>(v2)) {
            0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::accrue_interests_by_debtor<T0>(v2, arg3, arg2);
            let (v4, v5) = 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::get_bottle_info_with_interest_by_debtor<T0>(v2, arg3, arg2);
            let _ = v4;
            v5
        } else {
            let (v7, v8) = 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::get_bottle_info_by_debtor<T0>(v2, arg3);
            let _ = v7;
            v8
        };
        let (v9, v10) = if (v3 <= v1) {
            (false, v3)
        } else {
            (true, v1)
        };
        let v11 = 0x2::balance::zero<T0>();
        let v12 = 0x2::balance::zero<T0>();
        let v13 = 0;
        if (v1 > 0) {
            let v14 = 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::handle_repay<T0>(v2, arg3, v10, v0, false, arg2);
            v13 = 0x2::balance::value<T0>(&v14);
            0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::usdl_events::emit_collateral_decreased<T0>(0x2::balance::value<T0>(&v14));
            0x2::balance::join<T0>(&mut v11, 0x2::balance::split<T0>(&mut v14, 0x69f56ddcf0afd984804b0a17f11539a575854cb6fac16b887328abcf8f966bc2::math::mul_factor(0x2::balance::value<T0>(&v14), 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::constants::liquidation_rebate(), 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::constants::fee_precision())));
            0x2::balance::join<T0>(&mut v12, 0x2::balance::split<T0>(&mut v14, 0x69f56ddcf0afd984804b0a17f11539a575854cb6fac16b887328abcf8f966bc2::math::mul_factor(0x2::balance::value<T0>(&v14), 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::constants::liquidation_fee(), 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::constants::fee_precision())));
            let v15 = borrow_tank_mut<T0>(arg0);
            burn_usdl<T0>(arg0, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::tank::absorb<USDL, T0>(v15, v14, v10));
        };
        let v16 = borrow_bucket_mut<T0>(arg0);
        if (v9) {
            let (v17, v18) = 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::handle_redistribution<T0>(v16, arg3);
            0x2::balance::join<T0>(&mut v12, v17);
            0x2::balance::join<T0>(&mut v11, v18);
        };
        let v19 = borrow_bucket_mut<T0>(arg0);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::update_snapshot<T0>(v19);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well_events::emit_collect_fee_from<T0>(&v12, b"liquidate");
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well::collect_fee<T0>(borrow_well_mut<T0>(arg0), v12);
        let (v20, v21) = 0x9da1faddc97fd38448b688e5a064f1b4b3af9e43d7dab3cc07b681ec44ccff5a::loaf_oracle::get_price<T0>(arg1, arg2);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::usdl_events::emit_liquidation<T0>(v20, v21, v13, v10, arg4, arg3);
        v11
    }

    public fun output_usdl<T0: drop>(arg0: &mut LoafProtocol, arg1: u64) : 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::pipe::OutputCarrier<USDL, T0> {
        let v0 = mint_usdl<T0>(arg0, arg1);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::pipe::output<USDL, T0>(borrow_pipe_mut<USDL, T0>(arg0), v0)
    }

    public fun package_version() : u64 {
        7
    }

    public fun redeem<T0>(arg0: &mut LoafProtocol, arg1: &0x9da1faddc97fd38448b688e5a064f1b4b3af9e43d7dab3cc07b681ec44ccff5a::loaf_oracle::LoafOracle, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<USDL>, arg4: 0x1::option::Option<address>) : 0x2::balance::Balance<T0> {
        assert_valid_package_version(arg0);
        let v0 = 0x2::balance::value<USDL>(&arg3);
        let v1 = borrow_bucket_mut<T0>(arg0);
        assert!(0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::is_not_locked<T0>(v1), 14);
        let v2 = 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::handle_redeem<T0>(v1, arg1, arg2, v0, arg4);
        let v3 = compute_base_rate_fee<T0>(v1, arg2) + 0x69f56ddcf0afd984804b0a17f11539a575854cb6fac16b887328abcf8f966bc2::math::mul_factor(0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::constants::fee_precision(), v0, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::get_minted_usdl_amount<T0>(v1)) / 2;
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::update_base_rate_fee<T0>(v1, v3, 0x2::clock::timestamp_ms(arg2));
        let v4 = 0x2::balance::split<T0>(&mut v2, 0x69f56ddcf0afd984804b0a17f11539a575854cb6fac16b887328abcf8f966bc2::math::mul_factor(0x2::balance::value<T0>(&v2), v3, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::constants::fee_precision()));
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well_events::emit_collect_fee_from<T0>(&v4, b"redeem");
        let v5 = borrow_well_mut<T0>(arg0);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::well::collect_fee<T0>(v5, v4);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::usdl_events::emit_collateral_decreased<T0>(0x2::balance::value<T0>(&v2));
        burn_usdl<T0>(arg0, arg3);
        v2
    }

    public entry fun release_yeast<T0>(arg0: &AdminCap, arg1: &mut LoafProtocol, arg2: &mut 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::yeast::BktTreasury, arg3: u64) {
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::tank::collect_yeast<USDL, T0>(borrow_tank_mut<T0>(arg1), 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::yeast::release_yeast(arg2, arg3));
    }

    public fun repay<T0>(arg0: &mut LoafProtocol, arg1: 0x2::balance::Balance<USDL>, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        abort 404
    }

    public fun repay_debt<T0>(arg0: &mut LoafProtocol, arg1: 0x2::balance::Balance<USDL>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert_valid_package_version(arg0);
        let v0 = arg0.min_bottle_size;
        burn_usdl<T0>(arg0, arg1);
        let v1 = borrow_bucket_mut<T0>(arg0);
        assert!(0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::is_not_locked<T0>(v1), 14);
        let v2 = 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::handle_repay<T0>(v1, 0x2::tx_context::sender(arg3), 0x2::balance::value<USDL>(&arg1), v0, true, arg2);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::usdl_events::emit_collateral_decreased<T0>(0x2::balance::value<T0>(&v2));
        v2
    }

    public fun repay_with_strap<T0>(arg0: &mut LoafProtocol, arg1: &0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::strap::BottleStrap<T0>, arg2: 0x2::balance::Balance<USDL>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        assert_valid_package_version(arg0);
        let v0 = arg0.min_bottle_size;
        burn_usdl<T0>(arg0, arg2);
        let v1 = borrow_bucket_mut<T0>(arg0);
        assert!(0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::is_not_locked<T0>(v1), 14);
        let v2 = 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::handle_repay<T0>(v1, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::strap::get_address<T0>(arg1), 0x2::balance::value<USDL>(&arg2), v0, true, arg3);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::usdl_events::emit_collateral_decreased<T0>(0x2::balance::value<T0>(&v2));
        v2
    }

    public fun set_reservoir_partner<T0, T1: drop>(arg0: &AdminCap, arg1: &mut LoafProtocol, arg2: u64, arg3: u64) {
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::reservoir::set_fee_config<T0, T1>(borrow_reservoir_mut<T0>(arg1), arg2, arg3);
    }

    public fun set_susdl_rate(arg0: &AdminCap, arg1: &mut LoafProtocol, arg2: &mut 0x3e7e178c0ec6e24dd5a05346ed3cc0331670675ccf22d1ed4d61a6b1e8a5f97a::susdl::Flask<USDL>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert_valid_package_version(arg1);
        if (has_emission(arg1)) {
            collect_interest(arg1, arg2, arg3);
            let v0 = emission_mut(arg1);
            v0.latest_time = 0x2::clock::timestamp_ms(arg3);
            v0.rate = 0x3e7e178c0ec6e24dd5a05346ed3cc0331670675ccf22d1ed4d61a6b1e8a5f97a::float::from_bps(arg4);
        } else {
            let v1 = SUsdlRateKey{dummy_field: false};
            let v2 = SUsdlEmission{
                id          : 0x2::object::new(arg5),
                latest_time : 0x2::clock::timestamp_ms(arg3),
                rate        : 0x3e7e178c0ec6e24dd5a05346ed3cc0331670675ccf22d1ed4d61a6b1e8a5f97a::float::from_bps(arg4),
            };
            0x2::dynamic_object_field::add<SUsdlRateKey, SUsdlEmission>(&mut arg1.id, v1, v2);
        };
    }

    public fun share_flash_mint_config(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = FlashMintConfig{
            id           : 0x2::object::new(arg3),
            fee_rate     : arg1,
            max_amount   : arg2,
            total_amount : 0,
        };
        0x2::transfer::share_object<FlashMintConfig>(v0);
    }

    public fun susdl_to_usdl(arg0: &mut LoafProtocol, arg1: &mut 0x3e7e178c0ec6e24dd5a05346ed3cc0331670675ccf22d1ed4d61a6b1e8a5f97a::susdl::Flask<USDL>, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<0x3e7e178c0ec6e24dd5a05346ed3cc0331670675ccf22d1ed4d61a6b1e8a5f97a::susdl::SUSDL>) : 0x2::balance::Balance<USDL> {
        assert_valid_package_version(arg0);
        collect_interest(arg0, arg1, arg2);
        let v0 = USDLET_PROTOCOL{dummy_field: false};
        0x3e7e178c0ec6e24dd5a05346ed3cc0331670675ccf22d1ed4d61a6b1e8a5f97a::susdl::withdraw_by_protocol<USDL, USDLET_PROTOCOL>(arg1, v0, arg3)
    }

    public fun tank_withdraw<T0>(arg0: &mut LoafProtocol, arg1: &0x9da1faddc97fd38448b688e5a064f1b4b3af9e43d7dab3cc07b681ec44ccff5a::loaf_oracle::LoafOracle, arg2: &0x2::clock::Clock, arg3: &mut 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::yeast::BktTreasury, arg4: 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::tank::ContributorToken<USDL, T0>, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<USDL>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::yeast::YEAST>) {
        assert_valid_package_version(arg0);
        assert!(!0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::has_liquidatable_bottle<T0>(borrow_bucket<T0>(arg0), arg1, arg2), 8);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::tank::withdraw<USDL, T0>(borrow_tank_mut<T0>(arg0), arg3, arg4, arg5)
    }

    public fun top_up<T0>(arg0: &mut LoafProtocol, arg1: 0x2::balance::Balance<T0>, arg2: address, arg3: 0x1::option::Option<address>) {
        abort 404
    }

    public fun top_up_coll<T0>(arg0: &mut LoafProtocol, arg1: 0x2::balance::Balance<T0>, arg2: address, arg3: 0x1::option::Option<address>, arg4: &0x2::clock::Clock) {
        assert_valid_package_version(arg0);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::usdl_events::emit_collateral_increased<T0>(0x2::balance::value<T0>(&arg1));
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::handle_top_up<T0>(borrow_bucket_mut<T0>(arg0), arg1, arg2, arg3, arg4);
    }

    public fun transfer_bottle<T0>(arg0: &mut LoafProtocol, arg1: &0x2::clock::Clock, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::handle_transfer<T0>(borrow_bucket_mut<T0>(arg0), 0x2::tx_context::sender(arg3), arg2, arg1);
    }

    public fun update_flash_mint_config(arg0: &AdminCap, arg1: &mut FlashMintConfig, arg2: u64, arg3: u64) {
        arg1.fee_rate = arg2;
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::usdl_events::emit_param_updated<FlashMintConfig>(b"fee_rate", arg2);
        arg1.max_amount = arg3;
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::usdl_events::emit_param_updated<FlashMintConfig>(b"max_amount", arg3);
    }

    public entry fun update_min_bottle_size(arg0: &AdminCap, arg1: &mut LoafProtocol, arg2: u64) {
        arg1.min_bottle_size = arg2;
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::usdl_events::emit_param_updated<LoafProtocol>(b"min_bottle_size", arg2);
    }

    public entry fun update_protocol_version(arg0: &AdminCap, arg1: &mut LoafProtocol, arg2: u64) {
        arg1.version = arg2;
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::usdl_events::emit_param_updated<LoafProtocol>(b"version", arg2);
    }

    public fun update_reservoir_fee_rate<T0>(arg0: &AdminCap, arg1: &mut LoafProtocol, arg2: u64, arg3: u64) {
        assert_valid_package_version(arg1);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::reservoir::update_fee_rate<T0>(borrow_reservoir_mut<T0>(arg1), arg2, arg3);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::usdl_events::emit_param_updated<0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::reservoir::Reservoir<T0>>(b"charge_fee_rate", arg2);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::usdl_events::emit_param_updated<0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::reservoir::Reservoir<T0>>(b"discharge_fee_rate", arg3);
    }

    public fun usdl_to_susdl(arg0: &mut LoafProtocol, arg1: &mut 0x3e7e178c0ec6e24dd5a05346ed3cc0331670675ccf22d1ed4d61a6b1e8a5f97a::susdl::Flask<USDL>, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<USDL>) : 0x2::balance::Balance<0x3e7e178c0ec6e24dd5a05346ed3cc0331670675ccf22d1ed4d61a6b1e8a5f97a::susdl::SUSDL> {
        assert_valid_package_version(arg0);
        collect_interest(arg0, arg1, arg2);
        let v0 = USDLET_PROTOCOL{dummy_field: false};
        0x3e7e178c0ec6e24dd5a05346ed3cc0331670675ccf22d1ed4d61a6b1e8a5f97a::susdl::deposit_by_protocol<USDL, USDLET_PROTOCOL>(arg1, v0, arg3)
    }

    public fun withdraw_surplus_with_strap<T0>(arg0: &mut LoafProtocol, arg1: &0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::strap::BottleStrap<T0>) : 0x2::balance::Balance<T0> {
        assert_valid_package_version(arg0);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::withdraw_surplus_collateral<T0>(borrow_bucket_mut<T0>(arg0), 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::strap::get_address<T0>(arg1))
    }

    public fun withdraw_with_strap<T0>(arg0: &mut LoafProtocol, arg1: &0x9da1faddc97fd38448b688e5a064f1b4b3af9e43d7dab3cc07b681ec44ccff5a::loaf_oracle::LoafOracle, arg2: &0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::strap::BottleStrap<T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: 0x1::option::Option<address>) : 0x2::balance::Balance<T0> {
        let v0 = borrow_bucket_mut<T0>(arg0);
        assert!(0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::is_not_locked<T0>(v0), 14);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::usdl_events::emit_collateral_decreased<T0>(arg4);
        0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::bucket::handle_withdraw<T0>(v0, arg1, 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::strap::get_address<T0>(arg2), arg3, arg4, arg5)
    }

    // decompiled from Move bytecode v7
}

