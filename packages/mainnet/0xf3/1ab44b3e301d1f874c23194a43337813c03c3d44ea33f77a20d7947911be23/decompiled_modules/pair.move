module 0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::pair {
    struct Fees has copy, drop {
        team_fee: u256,
        locker_fee: u256,
        buyback_fee: u256,
        remaining_amount: u256,
    }

    struct LPCoin<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct Pair<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        balance0: 0x2::balance::Balance<T0>,
        balance1: 0x2::balance::Balance<T1>,
        reserve0: u256,
        reserve1: u256,
        block_timestamp_last: u64,
        price0_cumulative_last: u256,
        price1_cumulative_last: u256,
        total_supply: u256,
        team_1_address: address,
        team_2_address: address,
        dev_address: address,
        locker_address: address,
        buyback_address: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        lp_supply: 0x2::balance::Supply<LPCoin<T0, T1>>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct LPMint<phantom T0, phantom T1> has copy, drop {
        sender: address,
        lp_coin_id: 0x2::object::ID,
        token0_type: 0x1::type_name::TypeName,
        token1_type: 0x1::type_name::TypeName,
        amount0: u256,
        amount1: u256,
        liquidity: u256,
        total_supply: u256,
    }

    struct LPBurn<phantom T0, phantom T1> has copy, drop {
        sender: address,
        lp_coin_id: 0x2::object::ID,
        token0_type: 0x1::type_name::TypeName,
        token1_type: 0x1::type_name::TypeName,
        amount0: u256,
        amount1: u256,
        liquidity: u256,
        total_supply: u256,
    }

    struct Swap<phantom T0, phantom T1> has copy, drop {
        sender: address,
        amount0_in: u256,
        amount1_in: u256,
        amount0_out: u256,
        amount1_out: u256,
    }

    struct Sync<phantom T0, phantom T1> has copy, drop {
        reserve0: u256,
        reserve1: u256,
    }

    public(friend) fun swap<T0, T1>(arg0: &mut Pair<T0, T1>, arg1: 0x1::option::Option<0x2::coin::Coin<T0>>, arg2: 0x1::option::Option<0x2::coin::Coin<T1>>, arg3: u256, arg4: u256, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::coin::Coin<T0>>, 0x1::option::Option<0x2::coin::Coin<T1>>) {
        assert!(arg3 > 0 || arg4 > 0, 104);
        assert!(arg3 < arg0.reserve0 && arg4 < arg0.reserve1, 105);
        let v0 = arg0.reserve0;
        let v1 = arg0.reserve1;
        let v2 = if (0x1::option::is_some<0x2::coin::Coin<T0>>(&arg1)) {
            let v3 = 0x1::option::extract<0x2::coin::Coin<T0>>(&mut arg1);
            0x2::balance::join<T0>(&mut arg0.balance0, 0x2::coin::into_balance<T0>(v3));
            (0x2::coin::value<T0>(&v3) as u256)
        } else {
            0
        };
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg1);
        let v4 = if (0x1::option::is_some<0x2::coin::Coin<T1>>(&arg2)) {
            let v5 = 0x1::option::extract<0x2::coin::Coin<T1>>(&mut arg2);
            0x2::balance::join<T1>(&mut arg0.balance1, 0x2::coin::into_balance<T1>(v5));
            (0x2::coin::value<T1>(&v5) as u256)
        } else {
            0
        };
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg2);
        assert!(v2 > 0 || v4 > 0, 107);
        let v6 = if (arg3 > 0) {
            let v7 = &mut arg0.balance0;
            let v8 = safe_withdraw<T0>(v7, arg3, arg6);
            0x1::option::some<0x2::coin::Coin<T0>>(v8)
        } else {
            0x1::option::none<0x2::coin::Coin<T0>>()
        };
        let v9 = if (arg4 > 0) {
            let v10 = &mut arg0.balance1;
            let v11 = safe_withdraw<T1>(v10, arg4, arg6);
            0x1::option::some<0x2::coin::Coin<T1>>(v11)
        } else {
            0x1::option::none<0x2::coin::Coin<T1>>()
        };
        if (v2 > 0) {
            let v12 = calculate_fees(v2);
            transfer_fees<T0, T1>(arg0, true, v12, arg6);
        };
        if (v4 > 0) {
            let v13 = calculate_fees(v4);
            transfer_fees<T0, T1>(arg0, false, v13, arg6);
        };
        let v14 = (0x2::balance::value<T0>(&arg0.balance0) as u256);
        let v15 = (0x2::balance::value<T1>(&arg0.balance1) as u256);
        verify_k(v0, v1, v14, v15);
        assert!(v14 >= 1000, 105);
        assert!(v15 >= 1000, 105);
        update<T0, T1>(arg0, v14, v15, arg5, arg6);
        let v16 = Swap<T0, T1>{
            sender      : 0x2::tx_context::sender(arg6),
            amount0_in  : v2,
            amount1_in  : v4,
            amount0_out : arg3,
            amount1_out : arg4,
        };
        0x2::event::emit<Swap<T0, T1>>(v16);
        (v6, v9)
    }

    public(friend) fun new<T0, T1>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: address, arg3: address, arg4: address, arg5: address, arg6: address, arg7: &mut 0x2::tx_context::TxContext) : Pair<T0, T1> {
        let v0 = 0x1::string::utf8(b"Suitrump V2 ");
        0x1::string::append(&mut v0, arg0);
        0x1::string::append_utf8(&mut v0, b"/");
        0x1::string::append(&mut v0, arg1);
        let v1 = LPCoin<T0, T1>{dummy_field: false};
        Pair<T0, T1>{
            id                     : 0x2::object::new(arg7),
            balance0               : 0x2::balance::zero<T0>(),
            balance1               : 0x2::balance::zero<T1>(),
            reserve0               : 0,
            reserve1               : 0,
            block_timestamp_last   : 0,
            price0_cumulative_last : 0,
            price1_cumulative_last : 0,
            total_supply           : 0,
            team_1_address         : arg2,
            team_2_address         : arg3,
            dev_address            : arg4,
            locker_address         : arg5,
            buyback_address        : arg6,
            name                   : v0,
            symbol                 : 0x1::string::utf8(b"SUIT-V2"),
            lp_supply              : 0x2::balance::create_supply<LPCoin<T0, T1>>(v1),
        }
    }

    public(friend) fun burn<T0, T1>(arg0: &mut Pair<T0, T1>, arg1: 0x2::coin::Coin<LPCoin<T0, T1>>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = (0x2::coin::value<LPCoin<T0, T1>>(&arg1) as u256);
        let v1 = (0x2::balance::value<T0>(&arg0.balance0) as u256);
        let v2 = (0x2::balance::value<T1>(&arg0.balance1) as u256);
        assert!(v1 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v0, 109);
        assert!(v2 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v0, 109);
        let v3 = v1 * v0 / arg0.total_supply;
        let v4 = v2 * v0 / arg0.total_supply;
        assert!(v3 > 0 && v4 > 0, 103);
        0x2::balance::decrease_supply<LPCoin<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<LPCoin<T0, T1>>(arg1));
        assert!(arg0.total_supply >= v0, 103);
        arg0.total_supply = arg0.total_supply - v0;
        assert!(v1 >= v3, 103);
        assert!(v2 >= v4, 103);
        update<T0, T1>(arg0, v1 - v3, v2 - v4, arg2, arg3);
        let v5 = LPBurn<T0, T1>{
            sender       : 0x2::tx_context::sender(arg3),
            lp_coin_id   : 0x2::object::id<0x2::coin::Coin<LPCoin<T0, T1>>>(&arg1),
            token0_type  : 0x1::type_name::get<T0>(),
            token1_type  : 0x1::type_name::get<T1>(),
            amount0      : v3,
            amount1      : v4,
            liquidity    : v0,
            total_supply : arg0.total_supply,
        };
        0x2::event::emit<LPBurn<T0, T1>>(v5);
        let v6 = &mut arg0.balance0;
        let v7 = safe_withdraw<T0>(v6, v3, arg3);
        let v8 = &mut arg0.balance1;
        (v7, safe_withdraw<T1>(v8, v4, arg3))
    }

    fun calculate_fees(arg0: u256) : Fees {
        let v0 = arg0 * 30 / 10000;
        let v1 = v0 * 9 / 30;
        let v2 = v0 * 3 / 30;
        let v3 = v0 * 3 / 30;
        Fees{
            team_fee         : v1,
            locker_fee       : v2,
            buyback_fee      : v3,
            remaining_amount : arg0 - v1 - v2 - v3,
        }
    }

    public fun get_name<T0, T1>(arg0: &Pair<T0, T1>) : 0x1::string::String {
        arg0.name
    }

    public fun get_price_cumulative_last<T0, T1>(arg0: &Pair<T0, T1>) : (u256, u256) {
        (arg0.price0_cumulative_last, arg0.price1_cumulative_last)
    }

    public fun get_reserves<T0, T1>(arg0: &Pair<T0, T1>) : (u256, u256, u64) {
        (arg0.reserve0, arg0.reserve1, arg0.block_timestamp_last)
    }

    public fun get_symbol<T0, T1>(arg0: &Pair<T0, T1>) : 0x1::string::String {
        arg0.symbol
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun mint<T0, T1>(arg0: &mut Pair<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LPCoin<T0, T1>> {
        let v0 = (0x2::coin::value<T0>(&arg1) as u256);
        let v1 = (0x2::coin::value<T1>(&arg2) as u256);
        0x2::balance::join<T0>(&mut arg0.balance0, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.balance1, 0x2::coin::into_balance<T1>(arg2));
        let v2 = if (arg0.total_supply == 0) {
            let v3 = 0xf31ab44b3e301d1f874c23194a43337813c03c3d44ea33f77a20d7947911be23::math_utils::integer_sqrt(v0 * v1);
            assert!(v3 > 1000, 102);
            let v4 = &mut arg0.lp_supply;
            let v5 = safe_increase_supply<LPCoin<T0, T1>>(v4, 1000, arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<LPCoin<T0, T1>>>(v5, @0x0);
            v3 - 1000
        } else {
            assert!(v0 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg0.total_supply, 109);
            assert!(v1 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg0.total_supply, 109);
            let v6 = v0 * arg0.total_supply / arg0.reserve0;
            let v7 = v1 * arg0.total_supply / arg0.reserve1;
            assert!(v6 > 0, 112);
            assert!(v7 > 0, 112);
            if (v6 < v7) {
                v6
            } else {
                v7
            }
        };
        assert!(v2 > 0, 102);
        assert!(v2 <= 57896044618658097711785492504343953926634992332820282019728792003956564819967, 108);
        if (arg0.total_supply == 0) {
            arg0.total_supply = v2 + 1000;
        } else {
            assert!(arg0.total_supply <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 - v2, 109);
            arg0.total_supply = arg0.total_supply + v2;
        };
        assert!(arg0.reserve0 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 - v0, 109);
        assert!(arg0.reserve1 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 - v1, 109);
        let v8 = arg0.reserve0 + v0;
        let v9 = arg0.reserve1 + v1;
        update<T0, T1>(arg0, v8, v9, arg3, arg4);
        let v10 = &mut arg0.lp_supply;
        let v11 = safe_increase_supply<LPCoin<T0, T1>>(v10, v2, arg4);
        let v12 = LPMint<T0, T1>{
            sender       : 0x2::tx_context::sender(arg4),
            lp_coin_id   : 0x2::object::id<0x2::coin::Coin<LPCoin<T0, T1>>>(&v11),
            token0_type  : 0x1::type_name::get<T0>(),
            token1_type  : 0x1::type_name::get<T1>(),
            amount0      : v0,
            amount1      : v1,
            liquidity    : v2,
            total_supply : arg0.total_supply,
        };
        0x2::event::emit<LPMint<T0, T1>>(v12);
        v11
    }

    fun safe_increase_supply<T0>(arg0: &mut 0x2::balance::Supply<T0>, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (arg1 == 0) {
            return 0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg2)
        };
        let v0 = 18446744073709551615;
        if (arg1 <= (v0 as u256)) {
            return 0x2::coin::from_balance<T0>(0x2::balance::increase_supply<T0>(arg0, (arg1 as u64)), arg2)
        };
        let v1 = 0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg2);
        let v2 = (arg1 as u128);
        while (v2 > 0) {
            let v3 = if (v2 > v0) {
                (v0 as u64)
            } else {
                (v2 as u64)
            };
            0x2::coin::join<T0>(&mut v1, 0x2::coin::from_balance<T0>(0x2::balance::increase_supply<T0>(arg0, v3), arg2));
            v2 = v2 - (v3 as u128);
        };
        v1
    }

    fun safe_transfer<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u256, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg1 == 0) {
            return
        };
        let v0 = 18446744073709551615;
        let v1 = (arg1 as u128);
        while (v1 > 0) {
            let v2 = if (v1 > v0) {
                (v0 as u64)
            } else {
                (v1 as u64)
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(arg0, v2, arg3), arg2);
            v1 = v1 - (v2 as u128);
        };
    }

    fun safe_withdraw<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (arg1 == 0) {
            return 0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg2)
        };
        let v0 = 18446744073709551615;
        if (arg1 <= (v0 as u256)) {
            return 0x2::coin::take<T0>(arg0, (arg1 as u64), arg2)
        };
        let v1 = 0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg2);
        let v2 = (arg1 as u128);
        while (v2 > 0) {
            let v3 = if (v2 > v0) {
                (v0 as u64)
            } else {
                (v2 as u64)
            };
            0x2::coin::join<T0>(&mut v1, 0x2::coin::take<T0>(arg0, v3, arg2));
            v2 = v2 - (v3 as u128);
        };
        v1
    }

    public fun share_pair<T0, T1>(arg0: Pair<T0, T1>) {
        0x2::transfer::share_object<Pair<T0, T1>>(arg0);
    }

    public fun sync<T0, T1>(arg0: &mut Pair<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = (0x2::balance::value<T0>(&arg0.balance0) as u256);
        let v1 = (0x2::balance::value<T1>(&arg0.balance1) as u256);
        update<T0, T1>(arg0, v0, v1, arg1, arg2);
    }

    public fun total_supply<T0, T1>(arg0: &Pair<T0, T1>) : u256 {
        arg0.total_supply
    }

    fun transfer_fees<T0, T1>(arg0: &mut Pair<T0, T1>, arg1: bool, arg2: Fees, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg1) {
            if (arg2.team_fee > 0) {
                let v0 = arg2.team_fee * 4000 / 10000;
                let v1 = arg2.team_fee * 5000 / 10000;
                let v2 = arg2.team_fee - v0 - v1;
                if (v0 > 0) {
                    let v3 = &mut arg0.balance0;
                    safe_transfer<T0>(v3, v0, arg0.team_1_address, arg3);
                };
                if (v1 > 0) {
                    let v4 = &mut arg0.balance0;
                    safe_transfer<T0>(v4, v1, arg0.team_2_address, arg3);
                };
                if (v2 > 0) {
                    let v5 = &mut arg0.balance0;
                    safe_transfer<T0>(v5, v2, arg0.dev_address, arg3);
                };
            };
            if (arg2.locker_fee > 0) {
                let v6 = &mut arg0.balance0;
                safe_transfer<T0>(v6, arg2.locker_fee, arg0.locker_address, arg3);
            };
            if (arg2.buyback_fee > 0) {
                let v7 = &mut arg0.balance0;
                safe_transfer<T0>(v7, arg2.buyback_fee, arg0.buyback_address, arg3);
            };
        } else {
            if (arg2.team_fee > 0) {
                let v8 = arg2.team_fee * 4000 / 10000;
                let v9 = arg2.team_fee * 5000 / 10000;
                let v10 = arg2.team_fee - v8 - v9;
                if (v8 > 0) {
                    let v11 = &mut arg0.balance1;
                    safe_transfer<T1>(v11, v8, arg0.team_1_address, arg3);
                };
                if (v9 > 0) {
                    let v12 = &mut arg0.balance1;
                    safe_transfer<T1>(v12, v9, arg0.team_2_address, arg3);
                };
                if (v10 > 0) {
                    let v13 = &mut arg0.balance1;
                    safe_transfer<T1>(v13, v10, arg0.dev_address, arg3);
                };
            };
            if (arg2.locker_fee > 0) {
                let v14 = &mut arg0.balance1;
                safe_transfer<T1>(v14, arg2.locker_fee, arg0.locker_address, arg3);
            };
            if (arg2.buyback_fee > 0) {
                let v15 = &mut arg0.balance1;
                safe_transfer<T1>(v15, arg2.buyback_fee, arg0.buyback_address, arg3);
            };
        };
    }

    fun update<T0, T1>(arg0: &mut Pair<T0, T1>, arg1: u256, arg2: u256, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        update_price_accumulators<T0, T1>(arg0, v0);
        arg0.reserve0 = arg1;
        arg0.reserve1 = arg2;
        arg0.block_timestamp_last = v0;
        let v1 = Sync<T0, T1>{
            reserve0 : arg1,
            reserve1 : arg2,
        };
        0x2::event::emit<Sync<T0, T1>>(v1);
    }

    public(friend) fun update_fee_addresses<T0, T1>(arg0: &mut Pair<T0, T1>, arg1: address, arg2: address, arg3: address, arg4: address, arg5: address) {
        assert!(arg1 != @0x0, 113);
        assert!(arg2 != @0x0, 113);
        assert!(arg3 != @0x0, 113);
        assert!(arg4 != @0x0, 113);
        assert!(arg5 != @0x0, 113);
        arg0.team_1_address = arg1;
        arg0.team_2_address = arg2;
        arg0.dev_address = arg3;
        arg0.locker_address = arg4;
        arg0.buyback_address = arg5;
    }

    fun update_price_accumulators<T0, T1>(arg0: &mut Pair<T0, T1>, arg1: u64) {
        let v0 = if (arg0.block_timestamp_last != 0) {
            ((arg1 - arg0.block_timestamp_last) as u256)
        } else {
            0
        };
        let v1 = if (v0 > 0) {
            if (arg0.reserve0 > 0) {
                arg0.reserve1 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v1) {
            arg0.price0_cumulative_last = wrapping_add_u256(arg0.price0_cumulative_last, arg0.reserve1 * 5192296858534827628530496329220096 / arg0.reserve0 * v0);
            arg0.price1_cumulative_last = wrapping_add_u256(arg0.price1_cumulative_last, arg0.reserve0 * 5192296858534827628530496329220096 / arg0.reserve1 * v0);
        };
    }

    fun verify_k(arg0: u256, arg1: u256, arg2: u256, arg3: u256) {
        assert!(arg2 * arg3 >= arg0 * arg1, 106);
    }

    fun wrapping_add_u256(arg0: u256, arg1: u256) : u256 {
        if (arg0 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg1) {
            arg0 + arg1
        } else {
            arg1 - 115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg0 - 1
        }
    }

    // decompiled from Move bytecode v6
}

