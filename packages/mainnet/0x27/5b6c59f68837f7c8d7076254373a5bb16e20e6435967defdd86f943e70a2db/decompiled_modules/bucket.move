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

    struct FlashReceipt<phantom T0> {
        amount: u64,
        fee: u64,
    }

    public(friend) fun new<T0>(arg0: u64, arg1: u64, arg2: u8, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) : Bucket<T0> {
        Bucket<T0>{
            id                      : 0x2::object::new(arg4),
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

    public fun bottle_exists<T0>(arg0: &Bucket<T0>, arg1: address) : bool {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::bottle_exists(&arg0.bottle_table, arg1)
    }

    public fun get_bottle_info<T0>(arg0: &Bucket<T0>, arg1: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle) : (u64, u64) {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::get_bottle_info(&arg0.bottle_table, arg1)
    }

    public fun get_bottle_info_by_debtor<T0>(arg0: &Bucket<T0>, arg1: address) : (u64, u64) {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::get_bottle_info_by_debtor(&arg0.bottle_table, arg1)
    }

    public fun get_lowest_cr_debtor<T0>(arg0: &Bucket<T0>) : 0x1::option::Option<address> {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::get_lowest_cr_debtor(&arg0.bottle_table)
    }

    public(friend) fun update_snapshot<T0>(arg0: &mut Bucket<T0>) {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::update_snapshot(&mut arg0.bottle_table, get_collateral_vault_balance<T0>(arg0));
    }

    public fun borrow_bottle_table<T0>(arg0: &Bucket<T0>) : &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::BottleTable {
        &arg0.bottle_table
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

    public fun get_bottle_icr<T0>(arg0: &Bucket<T0>, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock, arg3: address) : u64 {
        let (v0, v1) = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::get_price<T0>(arg1, arg2);
        let (v2, v3) = get_bottle_info_by_debtor<T0>(arg0, arg3);
        if (v3 > 0) {
            0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(compute_collateral_value_to_buck(v2, arg0.collateral_decimal, v0, v1), 100, v3)
        } else {
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::max_u64()
        }
    }

    public fun get_bottle_table_length<T0>(arg0: &Bucket<T0>) : u64 {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::get_table_length(&arg0.bottle_table)
    }

    public fun get_bucket_size<T0>(arg0: &Bucket<T0>) : u64 {
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::get_table_length(&arg0.bottle_table)
    }

    public fun get_bucket_tcr<T0>(arg0: &Bucket<T0>, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock) : u64 {
        let v0 = arg0.minted_buck_amount;
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

    public(friend) fun handle_borrow<T0>(arg0: &mut Bucket<T0>, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: 0x1::option::Option<address>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = &mut arg5;
        check_insertion_place<T0>(arg0, v0, v1);
        assert!(is_not_locked<T0>(arg0), 0);
        let v2 = false;
        let v3 = 0x2::balance::value<T0>(&arg3);
        let v4 = v3;
        let v5 = if (bottle_exists<T0>(arg0, v0)) {
            let (_, _) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::get_bottle_info_after_update(&mut arg0.bottle_table, v0);
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::remove_bottle(&mut arg0.bottle_table, v0)
        } else if (0x2::table::contains<address, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle>(&arg0.surplus_bottle_table, v0)) {
            v4 = v3 + 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::destroy_surplus_bottle(0x2::table::remove<address, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle>(&mut arg0.surplus_bottle_table, v0));
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::new(borrow_bottle_table<T0>(arg0), arg7)
        } else {
            v2 = true;
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::new(borrow_bottle_table<T0>(arg0), arg7)
        };
        let v8 = v5;
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::record_borrow(&mut v8, v4, arg4, arg6);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::update_stake_and_total_stake(&mut arg0.bottle_table, &mut v8);
        if (v2) {
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket_events::emit_bottle_created<T0>(v0, &v8);
        } else {
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket_events::emit_bottle_updated<T0>(v0, &v8);
        };
        arg0.minted_buck_amount = arg0.minted_buck_amount + arg4;
        0x2::balance::join<T0>(&mut arg0.collateral_vault, arg3);
        assert!(is_healthy_bottle<T0>(arg0, arg1, arg2, &v8), 4);
        if (0x1::option::is_some<u64>(&arg0.max_mint_amount)) {
            assert!(arg0.minted_buck_amount <= *0x1::option::borrow<u64>(&arg0.max_mint_amount), 5);
        };
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::insert(&mut arg0.bottle_table, v0, v8, arg5);
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
            let (_, v5) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::get_bottle_info_after_update(&mut arg0.bottle_table, 0x1::option::destroy_some<address>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::get_lowest_cr_debtor(&arg0.bottle_table)));
            let (v6, v7) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::pop_front(&mut arg0.bottle_table);
            let v8 = v7;
            if (v3 >= v5) {
                let v9 = compute_buck_value_to_collateral(v5, arg0.collateral_decimal, v0, v1);
                0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::record_redeem(&mut v8, v9, v5);
                0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket_events::emit_bottle_destroyed<T0>(v6, &v8);
                0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket_events::emit_surplus_bottle_generated<T0>(v6, &v8);
                0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::update_stake_and_total_stake(&mut arg0.bottle_table, &mut v8);
                0x2::balance::join<T0>(&mut v2, 0x2::balance::split<T0>(&mut arg0.collateral_vault, v9));
                0x2::table::add<address, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle>(&mut arg0.surplus_bottle_table, v6, v8);
                v3 = v3 - v5;
            } else {
                let v10 = compute_buck_value_to_collateral(v3, arg0.collateral_decimal, v0, v1);
                0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::record_redeem(&mut v8, v10, v3);
                0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket_events::emit_bottle_updated<T0>(v6, &v8);
                0x2::balance::join<T0>(&mut v2, 0x2::balance::split<T0>(&mut arg0.collateral_vault, v10));
                0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::insert(&mut arg0.bottle_table, v6, v8, arg4);
                v3 = 0;
                0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::update_stake_and_total_stake_by_debtor(&mut arg0.bottle_table, v6);
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
        let v2 = 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(v0, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::liquidation_rebate(), 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::constants::fee_precision());
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::remove_bottle_stake(&mut arg0.bottle_table, arg1);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::record_redistribution(&mut arg0.bottle_table, v0 - v2 * 2, v1, arg1);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket_events::emit_bottle_destroyed<T0>(arg1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::borrow_bottle(borrow_bottle_table<T0>(arg0), arg1));
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::destroy_bottle(&mut arg0.bottle_table, arg1);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket_events::emit_redistribution<T0>();
        (0x2::balance::split<T0>(&mut arg0.collateral_vault, v2), 0x2::balance::split<T0>(&mut arg0.collateral_vault, v2))
    }

    public(friend) fun handle_repay<T0>(arg0: &mut Bucket<T0>, arg1: address, arg2: u64, arg3: u64, arg4: bool) : 0x2::balance::Balance<T0> {
        let (_, v1) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::get_bottle_info_after_update(&mut arg0.bottle_table, arg1);
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
        } else {
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::re_insert(&mut arg0.bottle_table, arg1);
        };
        arg0.minted_buck_amount = arg0.minted_buck_amount - arg2;
        0x2::balance::split<T0>(&mut arg0.collateral_vault, v4)
    }

    public(friend) fun handle_repay_capped<T0>(arg0: &mut Bucket<T0>, arg1: address, arg2: u64, arg3: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let (_, v1) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::get_bottle_info_after_update(&mut arg0.bottle_table, arg1);
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

    public(friend) fun handle_top_up<T0>(arg0: &mut Bucket<T0>, arg1: 0x2::balance::Balance<T0>, arg2: address, arg3: 0x1::option::Option<address>) {
        let v0 = &mut arg3;
        check_insertion_place<T0>(arg0, arg2, v0);
        let (_, _) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::get_bottle_info_after_update(&mut arg0.bottle_table, arg2);
        let v3 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::remove_bottle(&mut arg0.bottle_table, arg2);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::record_top_up(&mut v3, 0x2::balance::value<T0>(&arg1));
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::update_stake_and_total_stake(&mut arg0.bottle_table, &mut v3);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket_events::emit_bottle_updated<T0>(arg2, &v3);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::insert(&mut arg0.bottle_table, arg2, v3, arg3);
        0x2::balance::join<T0>(&mut arg0.collateral_vault, arg1);
    }

    public(friend) fun handle_withdraw<T0>(arg0: &mut Bucket<T0>, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock, arg3: u64, arg4: 0x1::option::Option<address>, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = &mut arg4;
        check_insertion_place<T0>(arg0, v0, v1);
        let (_, _) = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::get_bottle_info_after_update(&mut arg0.bottle_table, v0);
        let v4 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::remove_bottle(&mut arg0.bottle_table, v0);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::record_withdraw(&mut v4, arg3);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::update_stake_and_total_stake(&mut arg0.bottle_table, &mut v4);
        assert!(is_healthy_bottle<T0>(arg0, arg1, arg2, &v4), 4);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket_events::emit_bottle_updated<T0>(v0, &v4);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::insert(&mut arg0.bottle_table, v0, v4, arg4);
        0x2::balance::split<T0>(&mut arg0.collateral_vault, arg3)
    }

    public fun has_liquidatable_bottle<T0>(arg0: &Bucket<T0>, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock) : bool {
        let v0 = get_lowest_cr_debtor<T0>(arg0);
        if (0x1::option::is_none<address>(&v0)) {
            0x1::option::destroy_none<address>(v0);
            return false
        };
        is_liquidatable<T0>(arg0, arg1, arg2, 0x1::option::destroy_some<address>(v0))
    }

    public fun is_healthy_bottle<T0>(arg0: &Bucket<T0>, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock, arg3: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle) : bool {
        let v0 = if (is_in_recovery_mode<T0>(arg0, arg1, arg2)) {
            arg0.recovery_mode_threshold
        } else {
            arg0.min_collateral_ratio
        };
        let (v1, v2) = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::get_price<T0>(arg1, arg2);
        let (v3, v4) = get_bottle_info<T0>(arg0, arg3);
        compute_collateral_value_to_buck(v3, arg0.collateral_decimal, v1, v2) >= 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(v4, v0, 100)
    }

    public fun is_in_recovery_mode<T0>(arg0: &Bucket<T0>, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock) : bool {
        let (v0, v1) = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::get_price<T0>(arg1, arg2);
        compute_collateral_value_to_buck(0x2::balance::value<T0>(&arg0.collateral_vault) + arg0.total_flash_loan_amount, arg0.collateral_decimal, v0, v1) <= 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::math::mul_factor(arg0.minted_buck_amount, arg0.recovery_mode_threshold, 100)
    }

    public fun is_liquidatable<T0>(arg0: &Bucket<T0>, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock, arg3: address) : bool {
        !is_healthy_bottle<T0>(arg0, arg1, arg2, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::borrow_bottle(&arg0.bottle_table, arg3))
    }

    public fun is_not_locked<T0>(arg0: &Bucket<T0>) : bool {
        arg0.total_flash_loan_amount == 0
    }

    public(friend) fun update_base_rate_fee<T0>(arg0: &mut Bucket<T0>, arg1: u64, arg2: u64) {
        arg0.base_fee_rate = arg1;
        arg0.latest_redemption_time = arg2;
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket_events::emit_fee_rate_changed<T0>(arg1);
    }

    public(friend) fun update_max_mint_amount<T0>(arg0: &mut Bucket<T0>, arg1: 0x1::option::Option<u64>) {
        arg0.max_mint_amount = arg1;
    }

    public(friend) fun withdraw_surplus_collateral<T0>(arg0: &mut Bucket<T0>, arg1: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle>(&arg0.surplus_bottle_table, v0), 6);
        let v1 = 0x2::table::remove<address, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::Bottle>(&mut arg0.surplus_bottle_table, v0);
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bucket_events::emit_surplus_bottle_withdrawal<T0>(v0, &v1);
        0x2::balance::split<T0>(&mut arg0.collateral_vault, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::bottle::destroy_surplus_bottle(v1))
    }

    // decompiled from Move bytecode v6
}

