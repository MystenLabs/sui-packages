module 0xffd17b737ec3d39285f1fbde9289162dcdad29a7fa66ac8a2e8006bec4013a32::liquidity_pool {
    struct LiquidityPool has key {
        id: 0x2::object::UID,
        usdt_reserve: 0x2::balance::Balance<0xffd17b737ec3d39285f1fbde9289162dcdad29a7fa66ac8a2e8006bec4013a32::tether_usdt_sui::TETHER_USDT_SUI>,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        lp_token_supply: u64,
        fee_rate: u64,
        price_usdt_usd: u64,
    }

    struct LPToken has store, key {
        id: 0x2::object::UID,
        pool_id: address,
        amount: u64,
    }

    struct PoolAdminCap has key {
        id: 0x2::object::UID,
    }

    struct PoolCreated has copy, drop {
        pool_id: address,
        usdt_amount: u64,
        sui_amount: u64,
        creator: address,
    }

    struct LiquidityAdded has copy, drop {
        pool_id: address,
        usdt_amount: u64,
        sui_amount: u64,
        lp_tokens: u64,
        provider: address,
    }

    struct LiquidityRemoved has copy, drop {
        pool_id: address,
        usdt_amount: u64,
        sui_amount: u64,
        lp_tokens: u64,
        provider: address,
    }

    struct SwapExecuted has copy, drop {
        pool_id: address,
        token_in: vector<u8>,
        token_out: vector<u8>,
        amount_in: u64,
        amount_out: u64,
        trader: address,
    }

    struct PriceUpdated has copy, drop {
        pool_id: address,
        old_price: u64,
        new_price: u64,
        updater: address,
    }

    public entry fun add_liquidity(arg0: &mut LiquidityPool, arg1: 0x2::coin::Coin<0xffd17b737ec3d39285f1fbde9289162dcdad29a7fa66ac8a2e8006bec4013a32::tether_usdt_sui::TETHER_USDT_SUI>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xffd17b737ec3d39285f1fbde9289162dcdad29a7fa66ac8a2e8006bec4013a32::tether_usdt_sui::TETHER_USDT_SUI>(&arg1);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 4);
        assert!(v1 > 0, 4);
        let v2 = if (arg0.lp_token_supply == 0) {
            0x2::math::sqrt(v0 * v1)
        } else {
            let v3 = v0 * arg0.lp_token_supply / 0x2::balance::value<0xffd17b737ec3d39285f1fbde9289162dcdad29a7fa66ac8a2e8006bec4013a32::tether_usdt_sui::TETHER_USDT_SUI>(&arg0.usdt_reserve);
            let v4 = v1 * arg0.lp_token_supply / 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve);
            if (v3 < v4) {
                v3
            } else {
                v4
            }
        };
        0x2::balance::join<0xffd17b737ec3d39285f1fbde9289162dcdad29a7fa66ac8a2e8006bec4013a32::tether_usdt_sui::TETHER_USDT_SUI>(&mut arg0.usdt_reserve, 0x2::coin::into_balance<0xffd17b737ec3d39285f1fbde9289162dcdad29a7fa66ac8a2e8006bec4013a32::tether_usdt_sui::TETHER_USDT_SUI>(arg1));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        arg0.lp_token_supply = arg0.lp_token_supply + v2;
        let v5 = LPToken{
            id      : 0x2::object::new(arg3),
            pool_id : 0x2::object::uid_to_address(&arg0.id),
            amount  : v2,
        };
        let v6 = LiquidityAdded{
            pool_id     : 0x2::object::uid_to_address(&arg0.id),
            usdt_amount : v0,
            sui_amount  : v1,
            lp_tokens   : v2,
            provider    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<LiquidityAdded>(v6);
        0x2::transfer::transfer<LPToken>(v5, 0x2::tx_context::sender(arg3));
    }

    public fun calculate_swap_output(arg0: &LiquidityPool, arg1: u64, arg2: bool) : u64 {
        let (v0, v1) = get_reserves(arg0);
        if (arg2) {
            let v3 = arg1 * (10000 - arg0.fee_rate) / 10000;
            v0 * v3 / (v1 + v3)
        } else {
            let v4 = arg1 * (10000 - arg0.fee_rate) / 10000;
            v1 * v4 / (v0 + v4)
        }
    }

    public entry fun create_pool(arg0: 0x2::coin::Coin<0xffd17b737ec3d39285f1fbde9289162dcdad29a7fa66ac8a2e8006bec4013a32::tether_usdt_sui::TETHER_USDT_SUI>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xffd17b737ec3d39285f1fbde9289162dcdad29a7fa66ac8a2e8006bec4013a32::tether_usdt_sui::TETHER_USDT_SUI>(&arg0);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 4);
        assert!(v1 > 0, 4);
        let v2 = 0x2::object::new(arg2);
        let v3 = 0x2::object::uid_to_address(&v2);
        let v4 = LiquidityPool{
            id              : v2,
            usdt_reserve    : 0x2::coin::into_balance<0xffd17b737ec3d39285f1fbde9289162dcdad29a7fa66ac8a2e8006bec4013a32::tether_usdt_sui::TETHER_USDT_SUI>(arg0),
            sui_reserve     : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            lp_token_supply : 0x2::math::sqrt(v0 * v1),
            fee_rate        : 30,
            price_usdt_usd  : 100,
        };
        let v5 = LPToken{
            id      : 0x2::object::new(arg2),
            pool_id : v3,
            amount  : v4.lp_token_supply,
        };
        let v6 = PoolAdminCap{id: 0x2::object::new(arg2)};
        let v7 = PoolCreated{
            pool_id     : v3,
            usdt_amount : v0,
            sui_amount  : v1,
            creator     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<PoolCreated>(v7);
        0x2::transfer::transfer<LPToken>(v5, 0x2::tx_context::sender(arg2));
        0x2::transfer::transfer<PoolAdminCap>(v6, 0x2::tx_context::sender(arg2));
        0x2::transfer::share_object<LiquidityPool>(v4);
    }

    public fun get_exchange_rate(arg0: &LiquidityPool) : u64 {
        let (v0, v1) = get_reserves(arg0);
        if (v1 == 0) {
            0
        } else {
            v0 * 1000000 / v1
        }
    }

    public fun get_reserves(arg0: &LiquidityPool) : (u64, u64) {
        (0x2::balance::value<0xffd17b737ec3d39285f1fbde9289162dcdad29a7fa66ac8a2e8006bec4013a32::tether_usdt_sui::TETHER_USDT_SUI>(&arg0.usdt_reserve), 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve))
    }

    public fun get_usdt_price(arg0: &LiquidityPool) : u64 {
        arg0.price_usdt_usd
    }

    public entry fun remove_liquidity(arg0: &mut LiquidityPool, arg1: LPToken, arg2: &mut 0x2::tx_context::TxContext) {
        let LPToken {
            id      : v0,
            pool_id : _,
            amount  : v2,
        } = arg1;
        0x2::object::delete(v0);
        let v3 = v2 * 0x2::balance::value<0xffd17b737ec3d39285f1fbde9289162dcdad29a7fa66ac8a2e8006bec4013a32::tether_usdt_sui::TETHER_USDT_SUI>(&arg0.usdt_reserve) / arg0.lp_token_supply;
        let v4 = v2 * 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) / arg0.lp_token_supply;
        arg0.lp_token_supply = arg0.lp_token_supply - v2;
        let v5 = LiquidityRemoved{
            pool_id     : 0x2::object::uid_to_address(&arg0.id),
            usdt_amount : v3,
            sui_amount  : v4,
            lp_tokens   : v2,
            provider    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<LiquidityRemoved>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xffd17b737ec3d39285f1fbde9289162dcdad29a7fa66ac8a2e8006bec4013a32::tether_usdt_sui::TETHER_USDT_SUI>>(0x2::coin::take<0xffd17b737ec3d39285f1fbde9289162dcdad29a7fa66ac8a2e8006bec4013a32::tether_usdt_sui::TETHER_USDT_SUI>(&mut arg0.usdt_reserve, v3, arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_reserve, v4, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_sui_for_usdt(arg0: &mut LiquidityPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 4);
        let v1 = 0x2::balance::value<0xffd17b737ec3d39285f1fbde9289162dcdad29a7fa66ac8a2e8006bec4013a32::tether_usdt_sui::TETHER_USDT_SUI>(&arg0.usdt_reserve);
        let v2 = v0 * (10000 - arg0.fee_rate) / 10000;
        let v3 = v1 * v2 / (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) + v2);
        assert!(v3 >= arg2, 2);
        assert!(v3 < v1, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v4 = SwapExecuted{
            pool_id    : 0x2::object::uid_to_address(&arg0.id),
            token_in   : b"SUI",
            token_out  : b"USDT",
            amount_in  : v0,
            amount_out : v3,
            trader     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SwapExecuted>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xffd17b737ec3d39285f1fbde9289162dcdad29a7fa66ac8a2e8006bec4013a32::tether_usdt_sui::TETHER_USDT_SUI>>(0x2::coin::take<0xffd17b737ec3d39285f1fbde9289162dcdad29a7fa66ac8a2e8006bec4013a32::tether_usdt_sui::TETHER_USDT_SUI>(&mut arg0.usdt_reserve, v3, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_usdt_for_sui(arg0: &mut LiquidityPool, arg1: 0x2::coin::Coin<0xffd17b737ec3d39285f1fbde9289162dcdad29a7fa66ac8a2e8006bec4013a32::tether_usdt_sui::TETHER_USDT_SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xffd17b737ec3d39285f1fbde9289162dcdad29a7fa66ac8a2e8006bec4013a32::tether_usdt_sui::TETHER_USDT_SUI>(&arg1);
        assert!(v0 > 0, 4);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve);
        let v2 = v0 * (10000 - arg0.fee_rate) / 10000;
        let v3 = v1 * v2 / (0x2::balance::value<0xffd17b737ec3d39285f1fbde9289162dcdad29a7fa66ac8a2e8006bec4013a32::tether_usdt_sui::TETHER_USDT_SUI>(&arg0.usdt_reserve) + v2);
        assert!(v3 >= arg2, 2);
        assert!(v3 < v1, 1);
        0x2::balance::join<0xffd17b737ec3d39285f1fbde9289162dcdad29a7fa66ac8a2e8006bec4013a32::tether_usdt_sui::TETHER_USDT_SUI>(&mut arg0.usdt_reserve, 0x2::coin::into_balance<0xffd17b737ec3d39285f1fbde9289162dcdad29a7fa66ac8a2e8006bec4013a32::tether_usdt_sui::TETHER_USDT_SUI>(arg1));
        let v4 = SwapExecuted{
            pool_id    : 0x2::object::uid_to_address(&arg0.id),
            token_in   : b"USDT",
            token_out  : b"SUI",
            amount_in  : v0,
            amount_out : v3,
            trader     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SwapExecuted>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_reserve, v3, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun update_usdt_price(arg0: &PoolAdminCap, arg1: &mut LiquidityPool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.price_usdt_usd = arg2;
        let v0 = PriceUpdated{
            pool_id   : 0x2::object::uid_to_address(&arg1.id),
            old_price : arg1.price_usdt_usd,
            new_price : arg2,
            updater   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<PriceUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

