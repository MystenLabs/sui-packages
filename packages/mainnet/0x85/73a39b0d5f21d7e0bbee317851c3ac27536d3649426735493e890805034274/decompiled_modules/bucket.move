module 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket {
    struct Bucket<phantom T0> has store, key {
        id: 0x2::object::UID,
        min_collateral_ratio: u64,
        recovery_mode_threshold: u64,
        collateral_decimal: u8,
        max_mint_amount: 0x1::option::Option<u64>,
        collateral_vault: 0x2::balance::Balance<T0>,
        bottle_table: 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::BottleTable,
        surplus_bottle_table: 0x2::table::Table<address, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle>,
        minted_buck_amount: u64,
        base_fee_rate: u64,
        latest_redemption_time: u64,
        total_flash_loan_amount: u64,
    }

    struct PendingRecord has store, key {
        id: 0x2::object::UID,
        bucket_pending_debt: u64,
        bucket_pending_collateral: u64,
    }

    struct FlashReceipt<phantom T0> {
        amount: u64,
        fee: u64,
    }

    public(friend) fun new<T0>(arg0: u64, arg1: u64, arg2: u8, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) : Bucket<T0> {
        let v0 = 0x2::object::new(arg4);
        let v1 = new_pending_record(arg4);
        0x2::dynamic_object_field::add<vector<u8>, PendingRecord>(&mut v0, b"pending_record", v1);
        Bucket<T0>{
            id                      : v0,
            min_collateral_ratio    : arg0,
            recovery_mode_threshold : arg1,
            collateral_decimal      : arg2,
            max_mint_amount         : arg3,
            collateral_vault        : 0x2::balance::zero<T0>(),
            bottle_table            : 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::new_table(arg4),
            surplus_bottle_table    : 0x2::table::new<address, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle>(arg4),
            minted_buck_amount      : 0,
            base_fee_rate           : 0,
            latest_redemption_time  : 0,
            total_flash_loan_amount : 0,
        }
    }

    public(friend) fun add_interest_index_to_bottle(arg0: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::add_interest_index_to_bottle(arg0, arg1, arg2);
    }

    public fun bottle_exists<T0>(arg0: &Bucket<T0>, arg1: address) : bool {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::bottle_exists(&arg0.bottle_table, arg1)
    }

    public fun get_bottle_info<T0>(arg0: &Bucket<T0>, arg1: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle) : (u64, u64) {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::get_bottle_info(&arg0.bottle_table, arg1)
    }

    public fun get_bottle_info_by_debtor<T0>(arg0: &Bucket<T0>, arg1: address) : (u64, u64) {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::get_bottle_info_by_debtor(&arg0.bottle_table, arg1)
    }

    public fun get_bottle_info_with_interest<T0>(arg0: &Bucket<T0>, arg1: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle, arg2: &0x2::clock::Clock) : (u64, u64) {
        if (0x2::dynamic_object_field::exists_with_type<vector<u8>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::interest::InterestTable>(&arg0.id, b"interest_table")) {
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::get_bottle_info_with_interest(borrow_bottle_table<T0>(arg0), arg1, borrow_interest_table<T0>(arg0), arg2)
        } else {
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::get_bottle_info(borrow_bottle_table<T0>(arg0), arg1)
        }
    }

    public fun get_bottle_info_with_interest_by_debtor<T0>(arg0: &Bucket<T0>, arg1: address, arg2: &0x2::clock::Clock) : (u64, u64) {
        if (0x2::dynamic_object_field::exists_with_type<vector<u8>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::interest::InterestTable>(&arg0.id, b"interest_table")) {
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::get_bottle_info_with_interest_by_debtor(borrow_bottle_table<T0>(arg0), arg1, borrow_interest_table<T0>(arg0), arg2)
        } else {
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::get_bottle_info_by_debtor(borrow_bottle_table<T0>(arg0), arg1)
        }
    }

    public fun get_lowest_cr_debtor<T0>(arg0: &Bucket<T0>) : 0x1::option::Option<address> {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::get_lowest_cr_debtor(&arg0.bottle_table)
    }

    public(friend) fun update_snapshot<T0>(arg0: &mut Bucket<T0>) {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::update_snapshot(&mut arg0.bottle_table, get_collateral_vault_balance<T0>(arg0));
    }

    public(friend) fun accrue_interests_by_debtor<T0>(arg0: &mut Bucket<T0>, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        let v0 = arg0.minted_buck_amount;
        let v1 = borrow_pending_record<T0>(arg0).bucket_pending_debt;
        let (_, v3) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::get_bottle_raw_info_by_debator(&arg0.bottle_table, arg1);
        let v4 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::borrow_bottle(&arg0.bottle_table, arg1);
        if (0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::is_interest_index_exists(v4)) {
            let v6 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::interest::get_bottle_interest_index(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::borrow_interest_index(v4));
            let v7 = borrow_interest_table_mut<T0>(arg0);
            let (v8, v9) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::interest::accrue_active_interests(v7, v0 - v1, arg2);
            if (v6 < v8) {
                let v10 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::math::mul_factor_u256((v3 as u256), v8, v6);
                assert!(v10 <= (0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::max_u64() as u256), 8);
                0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::update_bottle_debt_and_interest_index(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::borrow_bottle_mut(&mut arg0.bottle_table, arg1), (v10 as u64), 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::interest::get_active_interest_index(v7));
            };
            assert!(v9 <= (0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::max_u64() as u256), 8);
            arg0.minted_buck_amount = arg0.minted_buck_amount + (v9 as u64);
            (v9 as u64)
        } else {
            0
        }
    }

    public(friend) fun add_interest_index_to_bottle_by_debtor<T0>(arg0: &mut Bucket<T0>, arg1: address, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::add_interest_index_to_bottle(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::borrow_bottle_mut(&mut arg0.bottle_table, arg1), arg2, arg3);
    }

    public(friend) fun add_interest_table_to_bucket<T0>(arg0: &mut Bucket<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::dynamic_object_field::add<vector<u8>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::interest::InterestTable>(&mut arg0.id, b"interest_table", 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::interest::new_interest_table(arg1, arg2));
    }

    public(friend) fun add_pending_record_to_bucket<T0>(arg0: &mut Bucket<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"pending_record";
        if (!0x2::dynamic_object_field::exists_with_type<vector<u8>, PendingRecord>(&arg0.id, v0)) {
            0x2::dynamic_object_field::add<vector<u8>, PendingRecord>(&mut arg0.id, v0, new_pending_record(arg1));
        };
    }

    public(friend) fun adjust_pending_record<T0>(arg0: &mut Bucket<T0>, arg1: u64, arg2: u64) {
        let v0 = borrow_pending_record_mut<T0>(arg0);
        v0.bucket_pending_collateral = arg1;
        v0.bucket_pending_debt = arg2;
    }

    fun apply_pending<T0>(arg0: &mut Bucket<T0>, arg1: address) : (u64, u64) {
        if (0x2::dynamic_object_field::exists_with_type<vector<u8>, PendingRecord>(&arg0.id, b"pending_record")) {
            let v0 = borrow_bottle_table<T0>(arg0);
            let v1 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::borrow_bottle(v0, arg1);
            let v2 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::get_pending_coll(v1, v0);
            let v3 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::get_pending_debt(v1, v0);
            let v4 = borrow_pending_record_mut<T0>(arg0);
            v4.bucket_pending_collateral = v4.bucket_pending_collateral - v2;
            v4.bucket_pending_debt = v4.bucket_pending_debt - v3;
        };
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::get_bottle_info_after_update(&mut arg0.bottle_table, arg1)
    }

    public fun borrow_bottle_table<T0>(arg0: &Bucket<T0>) : &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::BottleTable {
        &arg0.bottle_table
    }

    public fun borrow_interest_table<T0>(arg0: &Bucket<T0>) : &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::interest::InterestTable {
        assert!(is_interest_table_exists<T0>(arg0), 7);
        0x2::dynamic_object_field::borrow<vector<u8>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::interest::InterestTable>(&arg0.id, b"interest_table")
    }

    public(friend) fun borrow_interest_table_mut<T0>(arg0: &mut Bucket<T0>) : &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::interest::InterestTable {
        assert!(is_interest_table_exists<T0>(arg0), 7);
        0x2::dynamic_object_field::borrow_mut<vector<u8>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::interest::InterestTable>(&mut arg0.id, b"interest_table")
    }

    public fun borrow_pending_record<T0>(arg0: &Bucket<T0>) : &PendingRecord {
        0x2::dynamic_object_field::borrow<vector<u8>, PendingRecord>(&arg0.id, b"pending_record")
    }

    public(friend) fun borrow_pending_record_mut<T0>(arg0: &mut Bucket<T0>) : &mut PendingRecord {
        0x2::dynamic_object_field::borrow_mut<vector<u8>, PendingRecord>(&mut arg0.id, b"pending_record")
    }

    public fun borrow_surplus_bottle_table<T0>(arg0: &Bucket<T0>) : &0x2::table::Table<address, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle> {
        &arg0.surplus_bottle_table
    }

    fun check_insertion_place<T0>(arg0: &Bucket<T0>, arg1: address, arg2: &mut 0x1::option::Option<address>) {
        if (0x1::option::is_some<address>(arg2) && *0x1::option::borrow<address>(arg2) == arg1) {
            let v0 = *0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table::prev<address, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::borrow_table(&arg0.bottle_table), arg1);
            if (0x1::option::is_none<address>(&v0)) {
                0x1::option::extract<address>(arg2);
            } else {
                0x1::option::swap<address>(arg2, 0x1::option::destroy_some<address>(v0));
            };
        };
    }

    public fun compute_base_rate<T0>(arg0: &Bucket<T0>, arg1: u64) : u64 {
        let v0 = (arg1 - arg0.latest_redemption_time) / 60000;
        let v1 = v0;
        if (v0 > 525600000) {
            v1 = 525600000;
        };
        if (v1 == 0) {
            return arg0.base_fee_rate
        };
        let v2 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::decay_factor_precision();
        let v3 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::minute_decay_factor();
        let v4 = v1;
        while (v4 > 1) {
            if (v4 % 2 == 0) {
                v3 = 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(v3, v3, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::decay_factor_precision());
                v4 = v4 >> 1;
                continue
            };
            v2 = 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(v3, v2, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::decay_factor_precision());
            v3 = 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(v3, v3, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::decay_factor_precision());
            let v5 = v4 - 1;
            v4 = v5 / 2;
        };
        0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg0.base_fee_rate, 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(v3, v2, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::decay_factor_precision()), 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::decay_factor_precision())
    }

    fun compute_buck_value_to_collateral(arg0: u64, arg1: u8, arg2: u64, arg3: u64) : u64 {
        if (0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::buck_decimal() >= arg1) {
            0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg0, arg3, arg2) / 0x2::math::pow(10, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::buck_decimal() - arg1)
        } else {
            0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg0, arg3, arg2) * 0x2::math::pow(10, arg1 - 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::buck_decimal())
        }
    }

    fun compute_collateral_value_to_buck(arg0: u64, arg1: u8, arg2: u64, arg3: u64) : u64 {
        if (0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::buck_decimal() >= arg1) {
            0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg0, arg2, arg3) * 0x2::math::pow(10, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::buck_decimal() - arg1)
        } else {
            0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg0, arg2, arg3) / 0x2::math::pow(10, arg1 - 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::buck_decimal())
        }
    }

    public fun destroy_empty_strap<T0>(arg0: &Bucket<T0>, arg1: 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::BottleStrap<T0>) {
        let v0 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::get_address<T0>(&arg1);
        assert!(!bottle_exists<T0>(arg0, v0) && !0x2::table::contains<address, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle>(&arg0.surplus_bottle_table, v0), 8);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::destroy<T0>(arg1);
    }

    public fun get_bottle_icr<T0>(arg0: &Bucket<T0>, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock, arg3: address) : u64 {
        let (v0, v1) = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::get_price<T0>(arg1, arg2);
        let (v2, v3) = if (is_interest_table_exists<T0>(arg0)) {
            get_bottle_info_with_interest_by_debtor<T0>(arg0, arg3, arg2)
        } else {
            get_bottle_info_by_debtor<T0>(arg0, arg3)
        };
        if (v3 > 0) {
            0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(compute_collateral_value_to_buck(v2, arg0.collateral_decimal, v0, v1), 100, v3)
        } else {
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::max_u64()
        }
    }

    public fun get_bottle_table_length<T0>(arg0: &Bucket<T0>) : u64 {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::get_table_length(&arg0.bottle_table)
    }

    public fun get_bucket_debt<T0>(arg0: &Bucket<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = arg0.minted_buck_amount;
        let v1 = v0;
        if (is_interest_table_exists<T0>(arg0)) {
            let (_, v3) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::interest::calculate_interest_index(borrow_interest_table<T0>(arg0), arg1);
            if (v3 > 0) {
                let v4 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::math::mul_factor_u256((v0 as u256), v3, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::interest_precision());
                assert!(v4 <= (0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::max_u64() as u256), 8);
                v1 = v0 + (v4 as u64);
            };
        };
        v1
    }

    public fun get_bucket_pending_collateral<T0>(arg0: &Bucket<T0>) : u64 {
        borrow_pending_record<T0>(arg0).bucket_pending_collateral
    }

    public fun get_bucket_pending_debt<T0>(arg0: &Bucket<T0>) : u64 {
        borrow_pending_record<T0>(arg0).bucket_pending_debt
    }

    public fun get_bucket_size<T0>(arg0: &Bucket<T0>) : u64 {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::get_table_length(&arg0.bottle_table)
    }

    public fun get_bucket_tcr<T0>(arg0: &Bucket<T0>, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock) : u64 {
        let v0 = get_bucket_debt<T0>(arg0, arg2);
        if (v0 == 0) {
            return 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::max_u64()
        };
        let (v1, v2) = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::get_price<T0>(arg1, arg2);
        0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(compute_collateral_value_to_buck(0x2::balance::value<T0>(&arg0.collateral_vault) + arg0.total_flash_loan_amount, arg0.collateral_decimal, v1, v2), 100, v0)
    }

    public fun get_collateral_vault_balance<T0>(arg0: &Bucket<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.collateral_vault)
    }

    public fun get_max_mint_amount<T0>(arg0: &Bucket<T0>) : 0x1::option::Option<u64> {
        arg0.max_mint_amount
    }

    public fun get_minimum_collateral_ratio<T0>(arg0: &Bucket<T0>) : u64 {
        arg0.min_collateral_ratio
    }

    public fun get_minted_buck_amount<T0>(arg0: &Bucket<T0>) : u64 {
        arg0.minted_buck_amount
    }

    public fun get_receipt_info<T0>(arg0: &FlashReceipt<T0>) : (u64, u64) {
        (arg0.amount, arg0.fee)
    }

    public fun get_surplus_bottle_info_by_debtor<T0>(arg0: &Bucket<T0>, arg1: address) : (u64, u64) {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::get_bottle_raw_info(0x2::table::borrow<address, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle>(&arg0.surplus_bottle_table, arg1))
    }

    public fun get_surplus_bottle_table_size<T0>(arg0: &Bucket<T0>) : u64 {
        0x2::table::length<address, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle>(borrow_surplus_bottle_table<T0>(arg0))
    }

    public fun get_surplus_collateral_amount<T0>(arg0: &Bucket<T0>, arg1: address) : u64 {
        let (v0, _) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::get_bottle_raw_info(0x2::table::borrow<address, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle>(&arg0.surplus_bottle_table, arg1));
        v0
    }

    public fun get_total_flash_loan_amount<T0>(arg0: &Bucket<T0>) : u64 {
        arg0.total_flash_loan_amount
    }

    public(friend) fun handle_borrow<T0>(arg0: &mut Bucket<T0>, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: address, arg3: &0x2::clock::Clock, arg4: 0x2::balance::Balance<T0>, arg5: u64, arg6: 0x1::option::Option<address>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg6;
        check_insertion_place<T0>(arg0, arg2, v0);
        assert!(is_not_locked<T0>(arg0), 0);
        let v1 = false;
        let v2 = 0x2::balance::value<T0>(&arg4);
        let v3 = v2;
        let v4 = if (bottle_exists<T0>(arg0, arg2)) {
            if (is_interest_table_exists<T0>(arg0)) {
                accrue_interests_by_debtor<T0>(arg0, arg2, arg3);
            };
            let (_, _) = apply_pending<T0>(arg0, arg2);
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::remove_bottle(&mut arg0.bottle_table, arg2)
        } else if (0x2::table::contains<address, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle>(&arg0.surplus_bottle_table, arg2)) {
            v3 = v2 + 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::destroy_surplus_bottle(0x2::table::remove<address, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle>(&mut arg0.surplus_bottle_table, arg2));
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::new(borrow_bottle_table<T0>(arg0), arg8)
        } else {
            v1 = true;
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::new(borrow_bottle_table<T0>(arg0), arg8)
        };
        let v7 = v4;
        if (is_interest_table_exists<T0>(arg0) && !bottle_exists<T0>(arg0, arg2)) {
            let v8 = &mut v7;
            add_interest_index_to_bottle(v8, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::interest::get_active_interest_index(borrow_interest_table<T0>(arg0)), arg8);
        };
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::record_borrow(&mut v7, v3, arg5, arg7);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::update_stake_and_total_stake(&mut arg0.bottle_table, &mut v7);
        if (v1) {
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket_events::emit_bottle_created<T0>(arg2, &v7);
        } else {
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket_events::emit_bottle_updated<T0>(arg2, &v7);
        };
        arg0.minted_buck_amount = arg0.minted_buck_amount + arg5;
        0x2::balance::join<T0>(&mut arg0.collateral_vault, arg4);
        assert!(is_healthy_bottle<T0>(arg0, arg1, arg3, &v7), 4);
        if (0x1::option::is_some<u64>(&arg0.max_mint_amount)) {
            assert!(arg0.minted_buck_amount <= *0x1::option::borrow<u64>(&arg0.max_mint_amount), 5);
        };
        if (is_interest_table_exists<T0>(arg0)) {
            let v9 = 0x2::dynamic_object_field::remove<vector<u8>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::interest::InterestTable>(&mut arg0.id, b"interest_table");
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::insert_bottle(&mut arg0.bottle_table, &v9, arg2, v7, arg6, arg3);
            0x2::dynamic_object_field::add<vector<u8>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::interest::InterestTable>(&mut arg0.id, b"interest_table", v9);
        } else {
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::insert(&mut arg0.bottle_table, arg2, v7, arg6);
        };
    }

    public(friend) fun handle_flash_borrow<T0>(arg0: &mut Bucket<T0>, arg1: u64) : (0x2::balance::Balance<T0>, FlashReceipt<T0>) {
        arg0.total_flash_loan_amount = arg0.total_flash_loan_amount + arg1;
        let v0 = 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::flash_loan_fee(), 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::fee_precision());
        let v1 = v0;
        if (v0 == 0) {
            v1 = 1;
        };
        let v2 = FlashReceipt<T0>{
            amount : arg1,
            fee    : v1,
        };
        (0x2::balance::split<T0>(&mut arg0.collateral_vault, arg1), v2)
    }

    public(friend) fun handle_flash_repay<T0>(arg0: &mut Bucket<T0>, arg1: 0x2::balance::Balance<T0>, arg2: FlashReceipt<T0>) : 0x2::balance::Balance<T0> {
        let FlashReceipt {
            amount : v0,
            fee    : v1,
        } = arg2;
        arg0.total_flash_loan_amount = arg0.total_flash_loan_amount - v0;
        assert!(0x2::balance::value<T0>(&arg1) >= v0 + v1, 2);
        0x2::balance::join<T0>(&mut arg0.collateral_vault, 0x2::balance::split<T0>(&mut arg1, v0));
        arg1
    }

    public(friend) fun handle_redeem<T0>(arg0: &mut Bucket<T0>, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock, arg3: u64, arg4: 0x1::option::Option<address>) : 0x2::balance::Balance<T0> {
        let (v0, v1) = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::get_price<T0>(arg1, arg2);
        let v2 = 0x2::balance::zero<T0>();
        let v3 = arg3;
        while (v3 > 0 && 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::get_table_length(&arg0.bottle_table) > 0) {
            let v4 = 0x1::option::destroy_some<address>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::get_lowest_cr_debtor(&arg0.bottle_table));
            if (is_interest_table_exists<T0>(arg0)) {
                accrue_interests_by_debtor<T0>(arg0, v4, arg2);
            };
            let (_, v6) = apply_pending<T0>(arg0, v4);
            let (v7, v8) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::pop_front(&mut arg0.bottle_table);
            let v9 = v8;
            if (v3 >= v6) {
                let v10 = compute_buck_value_to_collateral(v6, arg0.collateral_decimal, v0, v1);
                0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::record_redeem(&mut v9, v10, v6);
                0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket_events::emit_bottle_destroyed<T0>(v7, &v9);
                0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket_events::emit_surplus_bottle_generated<T0>(v7, &v9);
                0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::update_stake_and_total_stake(&mut arg0.bottle_table, &mut v9);
                0x2::balance::join<T0>(&mut v2, 0x2::balance::split<T0>(&mut arg0.collateral_vault, v10));
                0x2::table::add<address, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle>(&mut arg0.surplus_bottle_table, v7, v9);
                v3 = v3 - v6;
            } else {
                let v11 = compute_buck_value_to_collateral(v3, arg0.collateral_decimal, v0, v1);
                0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::record_redeem(&mut v9, v11, v3);
                0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket_events::emit_bottle_updated<T0>(v7, &v9);
                0x2::balance::join<T0>(&mut v2, 0x2::balance::split<T0>(&mut arg0.collateral_vault, v11));
                if (is_interest_table_exists<T0>(arg0)) {
                    let v12 = 0x2::dynamic_object_field::remove<vector<u8>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::interest::InterestTable>(&mut arg0.id, b"interest_table");
                    0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::insert_bottle(&mut arg0.bottle_table, &v12, v7, v9, arg4, arg2);
                    0x2::dynamic_object_field::add<vector<u8>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::interest::InterestTable>(&mut arg0.id, b"interest_table", v12);
                } else {
                    0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::insert(&mut arg0.bottle_table, v7, v9, arg4);
                };
                v3 = 0;
                0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::update_stake_and_total_stake_by_debtor(&mut arg0.bottle_table, v7);
                break
            };
        };
        assert!(v3 == 0, 3);
        arg0.minted_buck_amount = arg0.minted_buck_amount - arg3;
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket_events::emit_redeem<T0>(arg3, 0x2::balance::value<T0>(&v2));
        v2
    }

    public(friend) fun handle_redistribution<T0>(arg0: &mut Bucket<T0>, arg1: address) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>) {
        let (v0, v1) = get_bottle_info_by_debtor<T0>(arg0, arg1);
        if (0x2::dynamic_object_field::exists_with_type<vector<u8>, PendingRecord>(&arg0.id, b"pending_record")) {
            let v2 = borrow_pending_record_mut<T0>(arg0);
            v2.bucket_pending_collateral = v2.bucket_pending_collateral + v0;
            v2.bucket_pending_debt = v2.bucket_pending_debt + v1;
        };
        let v3 = 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(v0, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::liquidation_rebate(), 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::fee_precision());
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::remove_bottle_stake(&mut arg0.bottle_table, arg1);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::record_redistribution(&mut arg0.bottle_table, v0 - v3 * 2, v1, arg1);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket_events::emit_bottle_destroyed<T0>(arg1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::borrow_bottle(borrow_bottle_table<T0>(arg0), arg1));
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::destroy_bottle(&mut arg0.bottle_table, arg1);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket_events::emit_redistribution<T0>();
        (0x2::balance::split<T0>(&mut arg0.collateral_vault, v3), 0x2::balance::split<T0>(&mut arg0.collateral_vault, v3))
    }

    public(friend) fun handle_repay<T0>(arg0: &mut Bucket<T0>, arg1: address, arg2: u64, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        if (is_interest_table_exists<T0>(arg0)) {
            accrue_interests_by_debtor<T0>(arg0, arg1, arg5);
        };
        let (_, v1) = apply_pending<T0>(arg0, arg1);
        assert!(v1 >= arg2, 1);
        let v2 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::borrow_bottle_mut(&mut arg0.bottle_table, arg1);
        let (v3, v4) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::record_repay(v2, arg2, arg3, arg4);
        if (v3) {
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket_events::emit_bottle_destroyed<T0>(arg1, v2);
        } else {
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket_events::emit_bottle_updated<T0>(arg1, v2);
        };
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::update_stake_and_total_stake_by_debtor(&mut arg0.bottle_table, arg1);
        if (v3) {
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::destroy_bottle(&mut arg0.bottle_table, arg1);
        } else if (is_interest_table_exists<T0>(arg0)) {
            let v5 = 0x2::dynamic_object_field::remove<vector<u8>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::interest::InterestTable>(&mut arg0.id, b"interest_table");
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::re_insert_bottle(&mut arg0.bottle_table, &v5, arg1, arg5);
            0x2::dynamic_object_field::add<vector<u8>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::interest::InterestTable>(&mut arg0.id, b"interest_table", v5);
        } else {
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::re_insert(&mut arg0.bottle_table, arg1);
        };
        arg0.minted_buck_amount = arg0.minted_buck_amount - arg2;
        0x2::balance::split<T0>(&mut arg0.collateral_vault, v4)
    }

    public(friend) fun handle_repay_capped<T0>(arg0: &mut Bucket<T0>, arg1: address, arg2: u64, arg3: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        if (is_interest_table_exists<T0>(arg0)) {
            accrue_interests_by_debtor<T0>(arg0, arg1, arg4);
        };
        let (_, v1) = apply_pending<T0>(arg0, arg1);
        assert!(v1 >= arg2, 1);
        let v2 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::borrow_bottle_mut(&mut arg0.bottle_table, arg1);
        let (v3, v4) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::record_repay_capped<T0>(v2, arg2, arg3, arg4, get_minimum_collateral_ratio<T0>(arg0), arg0.collateral_decimal);
        if (v3) {
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket_events::emit_bottle_destroyed<T0>(arg1, v2);
        };
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::update_stake_and_total_stake_by_debtor(&mut arg0.bottle_table, arg1);
        let (v5, _) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::get_bottle_info_by_debtor(&arg0.bottle_table, arg1);
        if (v3) {
            if (v5 == 0) {
                0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::destroy_bottle(&mut arg0.bottle_table, arg1);
            } else {
                let v7 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::remove_bottle(&mut arg0.bottle_table, arg1);
                0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket_events::emit_surplus_bottle_generated<T0>(arg1, &v7);
                0x2::table::add<address, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle>(&mut arg0.surplus_bottle_table, arg1, v7);
            };
        };
        arg0.minted_buck_amount = arg0.minted_buck_amount - arg2;
        0x2::balance::split<T0>(&mut arg0.collateral_vault, v4)
    }

    public(friend) fun handle_top_up<T0>(arg0: &mut Bucket<T0>, arg1: 0x2::balance::Balance<T0>, arg2: address, arg3: 0x1::option::Option<address>, arg4: &0x2::clock::Clock) {
        let v0 = &mut arg3;
        check_insertion_place<T0>(arg0, arg2, v0);
        let (_, _) = apply_pending<T0>(arg0, arg2);
        let v3 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::remove_bottle(&mut arg0.bottle_table, arg2);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::record_top_up(&mut v3, 0x2::balance::value<T0>(&arg1));
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::update_stake_and_total_stake(&mut arg0.bottle_table, &mut v3);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket_events::emit_bottle_updated<T0>(arg2, &v3);
        if (is_interest_table_exists<T0>(arg0)) {
            let v4 = 0x2::dynamic_object_field::remove<vector<u8>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::interest::InterestTable>(&mut arg0.id, b"interest_table");
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::insert_bottle(&mut arg0.bottle_table, &v4, arg2, v3, arg3, arg4);
            0x2::dynamic_object_field::add<vector<u8>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::interest::InterestTable>(&mut arg0.id, b"interest_table", v4);
        } else {
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::insert(&mut arg0.bottle_table, arg2, v3, arg3);
        };
        0x2::balance::join<T0>(&mut arg0.collateral_vault, arg1);
    }

    public(friend) fun handle_withdraw<T0>(arg0: &mut Bucket<T0>, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: address, arg3: &0x2::clock::Clock, arg4: u64, arg5: 0x1::option::Option<address>) : 0x2::balance::Balance<T0> {
        if (is_interest_table_exists<T0>(arg0)) {
            accrue_interests_by_debtor<T0>(arg0, arg2, arg3);
        };
        let v0 = &mut arg5;
        check_insertion_place<T0>(arg0, arg2, v0);
        let (_, _) = apply_pending<T0>(arg0, arg2);
        let v3 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::remove_bottle(&mut arg0.bottle_table, arg2);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::record_withdraw(&mut v3, arg4);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::update_stake_and_total_stake(&mut arg0.bottle_table, &mut v3);
        assert!(is_healthy_bottle<T0>(arg0, arg1, arg3, &v3), 4);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket_events::emit_bottle_updated<T0>(arg2, &v3);
        if (is_interest_table_exists<T0>(arg0)) {
            let v4 = 0x2::dynamic_object_field::remove<vector<u8>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::interest::InterestTable>(&mut arg0.id, b"interest_table");
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::insert_bottle(&mut arg0.bottle_table, &v4, arg2, v3, arg5, arg3);
            0x2::dynamic_object_field::add<vector<u8>, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::interest::InterestTable>(&mut arg0.id, b"interest_table", v4);
        } else {
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::insert(&mut arg0.bottle_table, arg2, v3, arg5);
        };
        0x2::balance::split<T0>(&mut arg0.collateral_vault, arg4)
    }

    public fun has_liquidatable_bottle<T0>(arg0: &Bucket<T0>, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock) : bool {
        let v0 = get_lowest_cr_debtor<T0>(arg0);
        if (0x1::option::is_none<address>(&v0)) {
            0x1::option::destroy_none<address>(v0);
            return false
        };
        is_liquidatable<T0>(arg0, arg1, arg2, 0x1::option::destroy_some<address>(v0))
    }

    public(friend) fun input<T0>(arg0: &mut Bucket<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.collateral_vault, arg1);
    }

    public fun is_healthy_bottle<T0>(arg0: &Bucket<T0>, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock, arg3: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle) : bool {
        let v0 = if (is_in_recovery_mode<T0>(arg0, arg1, arg2)) {
            arg0.recovery_mode_threshold
        } else {
            arg0.min_collateral_ratio
        };
        let (v1, v2) = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::get_price<T0>(arg1, arg2);
        let (v3, v4) = if (is_interest_table_exists<T0>(arg0)) {
            get_bottle_info_with_interest<T0>(arg0, arg3, arg2)
        } else {
            get_bottle_info<T0>(arg0, arg3)
        };
        compute_collateral_value_to_buck(v3, arg0.collateral_decimal, v1, v2) >= 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(v4, v0, 100)
    }

    public fun is_healthy_bottle_by_debtor<T0>(arg0: &Bucket<T0>, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock, arg3: address) : bool {
        let v0 = if (is_in_recovery_mode<T0>(arg0, arg1, arg2)) {
            arg0.recovery_mode_threshold
        } else {
            arg0.min_collateral_ratio
        };
        let (v1, v2) = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::get_price<T0>(arg1, arg2);
        let (v3, v4) = if (is_interest_table_exists<T0>(arg0)) {
            get_bottle_info_with_interest_by_debtor<T0>(arg0, arg3, arg2)
        } else {
            get_bottle_info_by_debtor<T0>(arg0, arg3)
        };
        compute_collateral_value_to_buck(v3, arg0.collateral_decimal, v1, v2) >= 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(v4, v0, 100)
    }

    public fun is_in_recovery_mode<T0>(arg0: &Bucket<T0>, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock) : bool {
        let (v0, v1) = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::get_price<T0>(arg1, arg2);
        compute_collateral_value_to_buck(0x2::balance::value<T0>(&arg0.collateral_vault) + arg0.total_flash_loan_amount, arg0.collateral_decimal, v0, v1) <= 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(get_bucket_debt<T0>(arg0, arg2), arg0.recovery_mode_threshold, 100)
    }

    public fun is_interest_table_exists<T0>(arg0: &Bucket<T0>) : bool {
        0x2::dynamic_object_field::exists_<vector<u8>>(&arg0.id, b"interest_table")
    }

    public fun is_liquidatable<T0>(arg0: &Bucket<T0>, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock, arg3: address) : bool {
        !is_healthy_bottle_by_debtor<T0>(arg0, arg1, arg2, arg3)
    }

    public fun is_not_locked<T0>(arg0: &Bucket<T0>) : bool {
        arg0.total_flash_loan_amount == 0
    }

    public(friend) fun new_pending_record(arg0: &mut 0x2::tx_context::TxContext) : PendingRecord {
        PendingRecord{
            id                        : 0x2::object::new(arg0),
            bucket_pending_debt       : 0,
            bucket_pending_collateral : 0,
        }
    }

    public fun next_debtor<T0>(arg0: &Bucket<T0>, arg1: address) : &0x1::option::Option<address> {
        0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table::next<address, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::borrow_table(&arg0.bottle_table), arg1)
    }

    public(friend) fun output<T0>(arg0: &mut Bucket<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.collateral_vault, arg1)
    }

    public fun prev_debtor<T0>(arg0: &Bucket<T0>, arg1: address) : &0x1::option::Option<address> {
        0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table::prev<address, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::borrow_table(&arg0.bottle_table), arg1)
    }

    public(friend) fun update_base_rate_fee<T0>(arg0: &mut Bucket<T0>, arg1: u64, arg2: u64) {
        arg0.base_fee_rate = arg1;
        arg0.latest_redemption_time = arg2;
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket_events::emit_fee_rate_changed<T0>(arg1);
    }

    public(friend) fun update_max_mint_amount<T0>(arg0: &mut Bucket<T0>, arg1: 0x1::option::Option<u64>) {
        arg0.max_mint_amount = arg1;
    }

    public(friend) fun withdraw_surplus_collateral<T0>(arg0: &mut Bucket<T0>, arg1: address) : 0x2::balance::Balance<T0> {
        assert!(0x2::table::contains<address, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle>(&arg0.surplus_bottle_table, arg1), 6);
        let v0 = 0x2::table::remove<address, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle>(&mut arg0.surplus_bottle_table, arg1);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket_events::emit_surplus_bottle_withdrawal<T0>(arg1, &v0);
        0x2::balance::split<T0>(&mut arg0.collateral_vault, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::destroy_surplus_bottle(v0))
    }

    // decompiled from Move bytecode v6
}

