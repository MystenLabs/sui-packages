module 0x926038960e9e8841158a7159075f2727624e18ebdf495ecc7cd23428188b7eb1::real_dex_arbitrage {
    struct RealDexConfig has store, key {
        id: 0x2::object::UID,
        enabled: bool,
        min_profit_bps: u64,
        max_slippage_bps: u64,
        owner: address,
    }

    struct RealArbitrageExecuted has copy, drop {
        executor: address,
        buy_dex: u8,
        sell_dex: u8,
        amount_in: u64,
        amount_out: u64,
        profit: u64,
        timestamp: u64,
        cetus_pool: address,
        turbos_contract: address,
    }

    public fun calculate_cetus_turbos_profit(arg0: u64) : u64 {
        let v0 = arg0 * 25 / 10000;
        let v1 = v0 + (arg0 - v0) * 30 / 10000;
        if (arg0 > v1) {
            arg0 - v1
        } else {
            0
        }
    }

    public fun calculate_deepbook_bluefin_profit(arg0: u64) : u64 {
        let v0 = arg0 * 10 / 10000;
        let v1 = v0 + (arg0 - v0) * 25 / 10000;
        if (arg0 > v1) {
            arg0 - v1
        } else {
            0
        }
    }

    public entry fun emergency_stop(arg0: &mut RealDexConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 105);
        arg0.enabled = false;
    }

    public entry fun execute_cetus_turbos_arbitrage(arg0: &RealDexConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 <= arg3, 104);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 > 0, 102);
        let v2 = v1 - v1 * 25 / 10000;
        let v3 = v2 - v2 * 30 / 10000;
        let v4 = if (v3 > v1) {
            v3 - v1
        } else {
            0
        };
        assert!(v4 >= arg2, 101);
        let v5 = RealArbitrageExecuted{
            executor        : 0x2::tx_context::sender(arg5),
            buy_dex         : 2,
            sell_dex        : 3,
            amount_in       : v1,
            amount_out      : v3,
            profit          : v4,
            timestamp       : v0,
            cetus_pool      : @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630,
            turbos_contract : @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1,
        };
        0x2::event::emit<RealArbitrageExecuted>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg5));
    }

    public entry fun execute_deepbook_bluefin_arbitrage(arg0: &RealDexConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 <= arg3, 104);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 > 0, 102);
        let v2 = v1 - v1 * 10 / 10000;
        let v3 = v2 - v2 * 25 / 10000;
        let v4 = if (v3 > v1) {
            v3 - v1
        } else {
            0
        };
        assert!(v4 >= arg2, 101);
        let v5 = RealArbitrageExecuted{
            executor        : 0x2::tx_context::sender(arg5),
            buy_dex         : 4,
            sell_dex        : 5,
            amount_in       : v1,
            amount_out      : v3,
            profit          : v4,
            timestamp       : v0,
            cetus_pool      : @0xaf16199a2dff736e9f07a845f23c5da6df6f756eddb631aed9d24a93efc4549d,
            turbos_contract : @0x40dc6a93bd4f26ea9507c70f19eb1a060fd5cb9c3718db372f4ae711ffbbb29,
        };
        0x2::event::emit<RealArbitrageExecuted>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg5));
    }

    public entry fun execute_three_way_arbitrage(arg0: &RealDexConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 <= arg3, 104);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 > 0, 102);
        let v2 = v1 - v1 * 25 / 10000;
        let v3 = v2 - v2 * 30 / 10000;
        let v4 = v3 - v3 * 10 / 10000;
        let v5 = if (v4 > v1) {
            v4 - v1
        } else {
            0
        };
        assert!(v5 >= arg2, 101);
        let v6 = RealArbitrageExecuted{
            executor        : 0x2::tx_context::sender(arg5),
            buy_dex         : 2,
            sell_dex        : 4,
            amount_in       : v1,
            amount_out      : v4,
            profit          : v5,
            timestamp       : v0,
            cetus_pool      : @0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630,
            turbos_contract : @0xaf16199a2dff736e9f07a845f23c5da6df6f756eddb631aed9d24a93efc4549d,
        };
        0x2::event::emit<RealArbitrageExecuted>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg5));
    }

    public fun get_config(arg0: &RealDexConfig) : (bool, u64, u64) {
        (arg0.enabled, arg0.min_profit_bps, arg0.max_slippage_bps)
    }

    public fun get_dex_addresses() : (address, address, address, address, address) {
        (@0xcf994611fd4c48e277ce3ffd4d4364c914af2c3cbb05f7bf6facd371de688630, @0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1, @0xcaf6ba059d539a97646d47f0b9ddf843e138d215e2a12ca1f4585d386f7aec3a, @0xaf16199a2dff736e9f07a845f23c5da6df6f756eddb631aed9d24a93efc4549d, @0x40dc6a93bd4f26ea9507c70f19eb1a060fd5cb9c3718db372f4ae711ffbbb29)
    }

    public entry fun initialize_real_config(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = RealDexConfig{
            id               : 0x2::object::new(arg2),
            enabled          : true,
            min_profit_bps   : arg0,
            max_slippage_bps : arg1,
            owner            : 0x2::tx_context::sender(arg2),
        };
        0x2::transfer::share_object<RealDexConfig>(v0);
    }

    public entry fun resume_operations(arg0: &mut RealDexConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 105);
        arg0.enabled = true;
    }

    // decompiled from Move bytecode v6
}

