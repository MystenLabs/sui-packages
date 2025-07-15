module 0x5b01fddd2fbdc66fb032b40379a78b166df70ec0fc748542abfb958e552eef8b::gas_optimized_arbitrage {
    struct StorageRebateHelper has store, key {
        id: 0x2::object::UID,
        original_amount: u64,
        intermediate_amount: u64,
        final_amount: u64,
        gas_smash_count: u64,
        dex_a_type: u8,
        dex_b_type: u8,
    }

    struct GasSmashCoin has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct ArbitrageResult has drop {
        original_amount: u64,
        final_amount: u64,
        profit: u64,
        gas_savings_percentage: u64,
        storage_objects_deleted: u64,
    }

    public fun calculate_expected_dex_output(arg0: u64, arg1: u8, arg2: bool) : u64 {
        if (arg2) {
            (arg0 - arg0 * get_dex_fee_rate(arg1) / 1000000) * (1000000 - get_dex_price_impact(arg1, arg0)) / 1000000 + 500000
        } else {
            (arg0 - arg0 * get_dex_fee_rate(arg1) / 1000000) * (1000000 - get_dex_price_impact(arg1, arg0)) / 1000000 + 500000 + 1000000
        }
    }

    fun calculate_optimal_gas_smash_count(arg0: u64) : u64 {
        if (arg0 >= 10000000) {
            20
        } else if (arg0 >= 1000000) {
            10
        } else {
            5
        }
    }

    fun create_gas_smash_coins(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : vector<GasSmashCoin> {
        let v0 = 0x1::vector::empty<GasSmashCoin>();
        let v1 = calculate_optimal_gas_smash_count(arg0);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = GasSmashCoin{
                id    : 0x2::object::new(arg1),
                value : arg0 / v1,
            };
            0x1::vector::push_back<GasSmashCoin>(&mut v0, v3);
            v2 = v2 + 1;
        };
        v0
    }

    fun delete_gas_smash_coins(arg0: vector<GasSmashCoin>) {
        while (!0x1::vector::is_empty<GasSmashCoin>(&arg0)) {
            let GasSmashCoin {
                id    : v0,
                value : _,
            } = 0x1::vector::pop_back<GasSmashCoin>(&mut arg0);
            0x2::object::delete(v0);
        };
        0x1::vector::destroy_empty<GasSmashCoin>(arg0);
    }

    public fun estimate_gas_savings(arg0: u64, arg1: u64) : (u64, u64, u64) {
        let v0 = 15000000;
        let v1 = 2000000 * 99 / 100 + arg1 * 990000;
        let v2 = 8000000;
        let v3 = if (v1 >= v2) {
            v2 / 2
        } else {
            v2 - v1
        };
        (v0, v3, (v0 - v3) * 100 / v0)
    }

    public entry fun finalize_gas_optimized_arbitrage<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: StorageRebateHelper, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > arg1.original_amount, 2);
        let v1 = v0 - arg1.original_amount;
        assert!(v1 >= 500000, 2);
        let v2 = arg1.gas_smash_count + 1;
        let (_, _, v5) = estimate_gas_savings(arg1.original_amount, v2);
        ArbitrageResult{original_amount: arg1.original_amount, final_amount: v0, profit: v1, gas_savings_percentage: v5, storage_objects_deleted: v2};
        let StorageRebateHelper {
            id                  : v6,
            original_amount     : _,
            intermediate_amount : _,
            final_amount        : _,
            gas_smash_count     : _,
            dex_a_type          : _,
            dex_b_type          : _,
        } = arg1;
        0x2::object::delete(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
    }

    public fun get_dex_fee_rate(arg0: u8) : u64 {
        if (arg0 == 0) {
            3000
        } else if (arg0 == 1) {
            2500
        } else if (arg0 == 2) {
            3000
        } else if (arg0 == 3) {
            2500
        } else if (arg0 == 4) {
            3000
        } else {
            5000
        }
    }

    public fun get_dex_name(arg0: u8) : vector<u8> {
        if (arg0 == 0) {
            b"Cetus"
        } else if (arg0 == 1) {
            b"Aftermath"
        } else if (arg0 == 2) {
            b"Bluefin"
        } else if (arg0 == 3) {
            b"Turbos"
        } else if (arg0 == 4) {
            b"Kriya"
        } else {
            b"DeepBook"
        }
    }

    public fun get_dex_price_impact(arg0: u8, arg1: u64) : u64 {
        let v0 = if (arg0 == 0 || arg0 == 1) {
            1000
        } else {
            2000
        };
        let v1 = if (arg1 >= 10000000) {
            1500
        } else {
            500
        };
        v0 + v1
    }

    public fun optimize_ptb_structure(arg0: u64, arg1: vector<u8>) : (u64, u64, u64) {
        let v0 = 0x1::vector::length<u8>(&arg1) * 2;
        let v1 = calculate_optimal_gas_smash_count(arg0);
        let v2 = v0 + v1 + 2;
        assert!(v2 <= 1024, 3);
        (v0, v1, v2)
    }

    public entry fun setup_gas_optimized_arbitrage<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 == 10000000, 1);
        assert!(arg1 <= 5 && arg2 <= 5, 3);
        let v1 = StorageRebateHelper{
            id                  : 0x2::object::new(arg3),
            original_amount     : v0,
            intermediate_amount : 0,
            final_amount        : 0,
            gas_smash_count     : 0,
            dex_a_type          : arg1,
            dex_b_type          : arg2,
        };
        let v2 = create_gas_smash_coins(v0, arg3);
        v1.gas_smash_count = 0x1::vector::length<GasSmashCoin>(&v2);
        0x2::transfer::share_object<StorageRebateHelper>(v1);
        delete_gas_smash_coins(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
    }

    public fun validate_claude_compliance(arg0: u64, arg1: u64, arg2: u8, arg3: u8) : bool {
        if (arg0 != 10000000) {
            return false
        };
        if (arg1 <= arg0) {
            return false
        };
        if (arg2 > 5 || arg3 > 5) {
            return false
        };
        arg1 - arg0 >= 500000
    }

    // decompiled from Move bytecode v6
}

