module 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck {
    struct BUCK has drop {
        dummy_field: bool,
    }

    struct BucketProtocol has key {
        id: 0x2::object::UID,
        version: u64,
        buck_treasury_cap: 0x2::coin::TreasuryCap<BUCK>,
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

    public fun borrow<T0>(arg0: &mut BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: 0x1::option::Option<address>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<BUCK> {
        assert!(arg0.version == 1, 99);
        let v0 = arg0.min_bottle_size;
        let v1 = borrow_bucket_mut<T0>(arg0);
        let v2 = 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg4, compute_base_rate_fee<T0>(v1, arg2), 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::fee_precision());
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck_events::emit_collateral_increased<T0>(0x2::balance::value<T0>(&arg3));
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::handle_borrow<T0>(v1, arg1, arg2, arg3, arg4 + v2, arg5, v0, arg6);
        let v3 = mint_buck<T0>(arg0, v2);
        let v4 = borrow_well_mut<BUCK>(arg0);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::collect_fee<BUCK>(v4, v3);
        mint_buck<T0>(arg0, arg4)
    }

    public entry fun release_bkt<T0>(arg0: &AdminCap, arg1: &mut BucketProtocol, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BktTreasury, arg3: u64) {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::collect_bkt<BUCK, T0>(borrow_tank_mut<T0>(arg1), 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::release_bkt(arg2, arg3));
    }

    public fun borrow_bucket<T0>(arg0: &BucketProtocol) : &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::Bucket<T0> {
        assert!(arg0.version == 1, 99);
        let v0 = BucketType<T0>{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_with_type<BucketType<T0>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::Bucket<T0>>(&arg0.id, v0), 5);
        0x2::dynamic_object_field::borrow<BucketType<T0>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::Bucket<T0>>(&arg0.id, v0)
    }

    fun borrow_bucket_mut<T0>(arg0: &mut BucketProtocol) : &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::Bucket<T0> {
        assert!(arg0.version == 1, 99);
        let v0 = BucketType<T0>{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_with_type<BucketType<T0>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::Bucket<T0>>(&arg0.id, v0), 5);
        let v1 = BucketType<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<BucketType<T0>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::Bucket<T0>>(&mut arg0.id, v1)
    }

    public fun borrow_tank<T0>(arg0: &BucketProtocol) : &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::Tank<BUCK, T0> {
        assert!(arg0.version == 1, 99);
        let v0 = TankType<T0>{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_with_type<TankType<T0>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::Tank<BUCK, T0>>(&arg0.id, v0), 5);
        let v1 = TankType<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow<TankType<T0>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::Tank<BUCK, T0>>(&arg0.id, v1)
    }

    public fun borrow_tank_mut<T0>(arg0: &mut BucketProtocol) : &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::Tank<BUCK, T0> {
        assert!(arg0.version == 1, 99);
        let v0 = TankType<T0>{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_with_type<TankType<T0>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::Tank<BUCK, T0>>(&arg0.id, v0), 5);
        let v1 = TankType<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<TankType<T0>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::Tank<BUCK, T0>>(&mut arg0.id, v1)
    }

    public fun borrow_well<T0>(arg0: &BucketProtocol) : &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::Well<T0> {
        assert!(arg0.version == 1, 99);
        let v0 = WellType<T0>{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_with_type<WellType<T0>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::Well<T0>>(&arg0.id, v0), 5);
        let v1 = WellType<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow<WellType<T0>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::Well<T0>>(&arg0.id, v1)
    }

    public fun borrow_well_mut<T0>(arg0: &mut BucketProtocol) : &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::Well<T0> {
        assert!(arg0.version == 1, 99);
        let v0 = WellType<T0>{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_with_type<WellType<T0>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::Well<T0>>(&arg0.id, v0), 5);
        let v1 = WellType<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<WellType<T0>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::Well<T0>>(&mut arg0.id, v1)
    }

    fun burn_buck<T0>(arg0: &mut BucketProtocol, arg1: 0x2::balance::Balance<BUCK>) {
        assert!(arg0.version == 1, 99);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck_events::emit_buck_burnt<T0>(0x2::balance::value<BUCK>(&arg1));
        0x2::balance::decrease_supply<BUCK>(0x2::coin::supply_mut<BUCK>(&mut arg0.buck_treasury_cap), arg1);
    }

    public fun compute_base_rate_fee<T0>(arg0: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::Bucket<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::compute_base_rate<T0>(arg0, 0x2::clock::timestamp_ms(arg1));
        let v1 = v0;
        if (v0 > 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::max_fee()) {
            v1 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::max_fee();
        };
        if (v1 < 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::min_fee()) {
            v1 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::min_fee();
        };
        v1
    }

    public entry fun create_bucket<T0>(arg0: &AdminCap, arg1: &mut BucketProtocol, arg2: u64, arg3: u64, arg4: u8, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = BucketType<T0>{dummy_field: false};
        assert!(!0x2::dynamic_object_field::exists_with_type<BucketType<T0>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::Bucket<T0>>(&arg1.id, v0), 2);
        0x2::dynamic_object_field::add<BucketType<T0>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::Bucket<T0>>(&mut arg1.id, v0, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::new<T0>(arg2, arg3, arg4, arg5, arg6));
        let v1 = WellType<T0>{dummy_field: false};
        0x2::dynamic_object_field::add<WellType<T0>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::Well<T0>>(&mut arg1.id, v1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::new<T0>(arg6));
        let v2 = TankType<T0>{dummy_field: false};
        0x2::dynamic_object_field::add<TankType<T0>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::Tank<BUCK, T0>>(&mut arg1.id, v2, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::new<BUCK, T0>(arg6));
    }

    public fun flash_borrow<T0>(arg0: &mut BucketProtocol, arg1: u64) : (0x2::balance::Balance<T0>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::FlashReceipt<T0>) {
        assert!(arg0.version == 1, 99);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck_events::emit_flash_loan<T0>(arg1);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::handle_flash_borrow<T0>(borrow_bucket_mut<T0>(arg0), arg1)
    }

    public fun flash_borrow_buck<T0>(arg0: &mut BucketProtocol, arg1: u64) : (0x2::balance::Balance<BUCK>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::FlashReceipt<BUCK, T0>) {
        assert!(arg0.version == 1, 99);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck_events::emit_flash_loan<BUCK>(arg1);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::handle_flash_borrow<BUCK, T0>(borrow_tank_mut<T0>(arg0), arg1)
    }

    public fun flash_repay<T0>(arg0: &mut BucketProtocol, arg1: 0x2::balance::Balance<T0>, arg2: 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::FlashReceipt<T0>) {
        assert!(arg0.version == 1, 99);
        let v0 = borrow_bucket_mut<T0>(arg0);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::collect_fee<T0>(borrow_well_mut<T0>(arg0), 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::handle_flash_repay<T0>(v0, arg1, arg2));
    }

    public fun flash_repay_buck<T0>(arg0: &mut BucketProtocol, arg1: 0x2::balance::Balance<BUCK>, arg2: 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::FlashReceipt<BUCK, T0>) {
        assert!(arg0.version == 1, 99);
        let v0 = borrow_tank_mut<T0>(arg0);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::collect_fee<BUCK>(borrow_well_mut<BUCK>(arg0), 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::handle_flash_repay<BUCK, T0>(v0, arg1, arg2));
    }

    public fun get_bottle_info_by_debtor<T0>(arg0: &BucketProtocol, arg1: address) : (u64, u64) {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_bottle_info_by_debtor<T0>(borrow_bucket<T0>(arg0), arg1)
    }

    public fun get_min_bottle_size(arg0: &BucketProtocol) : u64 {
        arg0.min_bottle_size
    }

    fun init(arg0: BUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new_protocol(arg0, arg1);
        0x2::transfer::share_object<BucketProtocol>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun is_liquidatable<T0>(arg0: &BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock, arg3: address) : bool {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::is_liquidatable<T0>(borrow_bucket<T0>(arg0), arg1, arg2, arg3)
    }

    public fun liquidate_under_normal_mode<T0>(arg0: &mut BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock, arg3: address) : 0x2::balance::Balance<T0> {
        assert!(arg0.version == 1, 99);
        assert!(!0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::is_in_recovery_mode<T0>(borrow_bucket<T0>(arg0), arg1, arg2), 7);
        normally_liquidate<T0>(arg0, arg1, arg2, arg3)
    }

    public fun liquidate_under_recovery_mode<T0>(arg0: &mut BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock, arg3: address) : 0x2::balance::Balance<T0> {
        assert!(arg0.version == 1, 99);
        assert!(is_liquidatable<T0>(arg0, arg1, arg2, arg3), 1);
        assert!(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::is_not_locked<BUCK, T0>(borrow_tank<T0>(arg0)), 4);
        let v0 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::get_reserve_balance<BUCK, T0>(borrow_tank<T0>(arg0));
        let v1 = borrow_bucket<T0>(arg0);
        assert!(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::is_in_recovery_mode<T0>(v1, arg1, arg2), 6);
        let (_, v3) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_bottle_info_by_debtor<T0>(v1, arg3);
        let v4 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_bottle_icr<T0>(v1, arg1, arg2, arg3);
        let (v5, v6) = if (v4 < 100) {
            let v7 = borrow_bucket_mut<T0>(arg0);
            let (v8, v9) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::handle_redistribution<T0>(v7, arg3);
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::update_snapshot<T0>(v7);
            (v8, v9)
        } else if (v4 >= 100 && v4 < 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_minimum_collateral_ratio<T0>(v1)) {
            let v10 = normally_liquidate<T0>(arg0, arg1, arg2, arg3);
            (0x2::balance::zero<T0>(), v10)
        } else if (v4 >= 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_minimum_collateral_ratio<T0>(v1) && v4 < 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_bucket_tcr<T0>(v1, arg1, arg2)) {
            assert!(v0 > 0, 9);
            let v11 = if (v3 <= v0) {
                v3
            } else {
                v0
            };
            let v12 = borrow_bucket_mut<T0>(arg0);
            let v13 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::handle_repay_capped<T0>(v12, arg3, v11, arg1, arg2);
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck_events::emit_collateral_decreased<T0>(0x2::balance::value<T0>(&v13));
            let v14 = 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(0x2::balance::value<T0>(&v13), 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::liquidation_rebate(), 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::fee_precision());
            let v15 = borrow_tank_mut<T0>(arg0);
            burn_buck<T0>(arg0, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::absorb<BUCK, T0>(v15, v13, v11));
            let v16 = borrow_bucket_mut<T0>(arg0);
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::update_snapshot<T0>(v16);
            (0x2::balance::split<T0>(&mut v13, v14), 0x2::balance::split<T0>(&mut v13, v14))
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T0>())
        };
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::collect_fee<T0>(borrow_well_mut<T0>(arg0), v5);
        v6
    }

    fun mint_buck<T0>(arg0: &mut BucketProtocol, arg1: u64) : 0x2::balance::Balance<BUCK> {
        assert!(arg0.version == 1, 99);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck_events::emit_buck_minted<T0>(arg1);
        0x2::coin::mint_balance<BUCK>(&mut arg0.buck_treasury_cap, arg1)
    }

    fun new_protocol(arg0: BUCK, arg1: &mut 0x2::tx_context::TxContext) : (BucketProtocol, AdminCap) {
        let (v0, v1) = 0x2::coin::create_currency<BUCK>(arg0, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::buck_decimal(), b"BUCK", b"Bucket USD", b"the stablecoin minted through bucketprotocol.io", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYH4seo7K9CiFqHGDmhbZmzewHEapAhN9aqLRA7af2vMW")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUCK>>(v1);
        let v2 = 0x2::object::new(arg1);
        let v3 = WellType<BUCK>{dummy_field: false};
        0x2::dynamic_object_field::add<WellType<BUCK>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::Well<BUCK>>(&mut v2, v3, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::new<BUCK>(arg1));
        let v4 = BucketProtocol{
            id                : v2,
            version           : 1,
            buck_treasury_cap : v0,
            min_bottle_size   : 10000000000,
        };
        let v5 = AdminCap{id: 0x2::object::new(arg1)};
        let v6 = &mut v4;
        create_bucket<0x2::sui::SUI>(&v5, v6, 110, 150, 9, 0x1::option::none<u64>(), arg1);
        (v4, v5)
    }

    fun normally_liquidate<T0>(arg0: &mut BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock, arg3: address) : 0x2::balance::Balance<T0> {
        assert!(arg0.version == 1, 99);
        let v0 = arg0.min_bottle_size;
        assert!(is_liquidatable<T0>(arg0, arg1, arg2, arg3), 1);
        assert!(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::is_not_locked<BUCK, T0>(borrow_tank<T0>(arg0)), 4);
        let v1 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::get_reserve_balance<BUCK, T0>(borrow_tank<T0>(arg0));
        let v2 = borrow_bucket_mut<T0>(arg0);
        let (_, v4) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_bottle_info_by_debtor<T0>(v2, arg3);
        let (v5, v6) = if (v4 <= v1) {
            (false, v4)
        } else {
            (true, v1)
        };
        let v7 = 0x2::balance::zero<T0>();
        let v8 = 0x2::balance::zero<T0>();
        if (v1 > 0) {
            let v9 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::handle_repay<T0>(v2, arg3, v6, v0, false);
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck_events::emit_collateral_decreased<T0>(0x2::balance::value<T0>(&v9));
            let v10 = 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(0x2::balance::value<T0>(&v9), 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::liquidation_rebate(), 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::fee_precision());
            0x2::balance::join<T0>(&mut v7, 0x2::balance::split<T0>(&mut v9, v10));
            0x2::balance::join<T0>(&mut v8, 0x2::balance::split<T0>(&mut v9, v10));
            let v11 = borrow_tank_mut<T0>(arg0);
            burn_buck<T0>(arg0, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::absorb<BUCK, T0>(v11, v9, v6));
        };
        let v12 = borrow_bucket_mut<T0>(arg0);
        if (v5) {
            let (v13, v14) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::handle_redistribution<T0>(v12, arg3);
            0x2::balance::join<T0>(&mut v8, v13);
            0x2::balance::join<T0>(&mut v7, v14);
        };
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::update_snapshot<T0>(v12);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::collect_fee<T0>(borrow_well_mut<T0>(arg0), v8);
        v7
    }

    public fun redeem<T0>(arg0: &mut BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<BUCK>, arg4: 0x1::option::Option<address>) : 0x2::balance::Balance<T0> {
        assert!(arg0.version == 1, 99);
        let v0 = 0x2::balance::value<BUCK>(&arg3);
        let v1 = borrow_bucket_mut<T0>(arg0);
        let v2 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::handle_redeem<T0>(v1, arg1, arg2, v0, arg4);
        let v3 = compute_base_rate_fee<T0>(v1, arg2) + 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::fee_precision(), v0, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::get_minted_buck_amount<T0>(v1)) / 2;
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::update_base_rate_fee<T0>(v1, v3, 0x2::clock::timestamp_ms(arg2));
        let v4 = borrow_well_mut<T0>(arg0);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::collect_fee<T0>(v4, 0x2::balance::split<T0>(&mut v2, 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(0x2::balance::value<T0>(&v2), v3, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::fee_precision())));
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck_events::emit_collateral_decreased<T0>(0x2::balance::value<T0>(&v2));
        burn_buck<T0>(arg0, arg3);
        v2
    }

    public fun repay<T0>(arg0: &mut BucketProtocol, arg1: 0x2::balance::Balance<BUCK>, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(arg0.version == 1, 99);
        let v0 = arg0.min_bottle_size;
        burn_buck<T0>(arg0, arg1);
        let v1 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::handle_repay<T0>(borrow_bucket_mut<T0>(arg0), 0x2::tx_context::sender(arg2), 0x2::balance::value<BUCK>(&arg1), v0, true);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck_events::emit_collateral_decreased<T0>(0x2::balance::value<T0>(&v1));
        v1
    }

    public fun tank_withdraw<T0>(arg0: &mut BucketProtocol, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock, arg3: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BktTreasury, arg4: 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::ContributorToken<BUCK, T0>, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<BUCK>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bkt::BKT>) {
        assert!(arg0.version == 1, 99);
        assert!(!0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::has_liquidatable_bottle<T0>(borrow_bucket<T0>(arg0), arg1, arg2), 8);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank::withdraw<BUCK, T0>(borrow_tank_mut<T0>(arg0), arg3, arg4, arg5)
    }

    public fun top_up<T0>(arg0: &mut BucketProtocol, arg1: 0x2::balance::Balance<T0>, arg2: address, arg3: 0x1::option::Option<address>) {
        assert!(arg0.version == 1, 99);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck_events::emit_collateral_increased<T0>(0x2::balance::value<T0>(&arg1));
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::handle_top_up<T0>(borrow_bucket_mut<T0>(arg0), arg1, arg2, arg3);
    }

    public entry fun update_max_mint_amount<T0>(arg0: &AdminCap, arg1: &mut BucketProtocol, arg2: 0x1::option::Option<u64>) {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::update_max_mint_amount<T0>(borrow_bucket_mut<T0>(arg1), arg2);
    }

    public entry fun update_min_bottle_size(arg0: &AdminCap, arg1: &mut BucketProtocol, arg2: u64) {
        arg1.min_bottle_size = arg2;
    }

    public entry fun update_protocol_version(arg0: &AdminCap, arg1: &mut BucketProtocol, arg2: u64) {
        arg1.version = arg2;
    }

    public fun withdraw_surplus_collateral<T0>(arg0: &mut BucketProtocol, arg1: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(arg0.version == 1, 99);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket::withdraw_surplus_collateral<T0>(borrow_bucket_mut<T0>(arg0), arg1)
    }

    // decompiled from Move bytecode v6
}

