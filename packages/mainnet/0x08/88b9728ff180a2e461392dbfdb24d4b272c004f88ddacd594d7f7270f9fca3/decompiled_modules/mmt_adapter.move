module 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::mmt_adapter {
    struct MmtPosition<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        farm_id: u64,
        settlement_route: u8,
        mmt_position: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position,
    }

    struct PositionOpened has copy, drop {
        farm_id: u64,
        mmt_position_id: 0x2::object::ID,
        max_amount_x: u64,
        max_amount_y: u64,
    }

    struct PositionClosed has copy, drop {
        farm_id: u64,
        principal_x: u64,
        principal_y: u64,
        fee_x: u64,
        fee_y: u64,
    }

    struct NativeRewardClaimed has copy, drop {
        farm_id: u64,
        reward_amount: u64,
        operations_fee: u64,
        protocol_fee: u64,
    }

    public entry fun add_liquidity<T0, T1>(arg0: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::Router, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut MmtPosition<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::assert_active_farm_pool(arg0, arg3.farm_id, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg1));
        assert!(0x2::coin::value<T0>(&arg4) > 0 && 0x2::coin::value<T1>(&arg5) > 0, 1);
        let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::add_liquidity<T0, T1>(arg1, &mut arg3.mmt_position, arg4, arg5, arg6, arg7, arg8, arg2, arg9);
        let v2 = 0x2::tx_context::sender(arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, v2);
    }

    public entry fun claim_native_reward<T0, T1, T2>(arg0: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::Router, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut MmtPosition<T0, T1>, arg4: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::RevenueVault<T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::assert_active_farm_pool(arg0, arg3.farm_id, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg1));
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T2>(arg1, &mut arg3.mmt_position, arg5, arg2, arg6);
        let v1 = 0x2::coin::value<T2>(&v0);
        let (v2, v3) = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::native_reward_fees(v1);
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit_coin<T2>(arg4, 0x2::coin::split<T2>(&mut v0, v3, arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, 0x2::tx_context::sender(arg6));
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::split<T2>(&mut v0, v2, arg6), 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::operations_wallet(arg0));
        } else {
            0x2::coin::destroy_zero<T2>(0x2::coin::split<T2>(&mut v0, v2, arg6));
        };
        let v4 = NativeRewardClaimed{
            farm_id        : arg3.farm_id,
            reward_amount  : v1,
            operations_fee : v2,
            protocol_fee   : v3,
        };
        0x2::event::emit<NativeRewardClaimed>(v4);
    }

    public entry fun close_native<T0, T1>(arg0: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::Router, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: MmtPosition<T0, T1>, arg4: u64, arg5: u64, arg6: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::RevenueVault<T0>, arg7: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::RevenueVault<T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let MmtPosition {
            id               : v0,
            farm_id          : v1,
            settlement_route : _,
            mmt_position     : v3,
        } = arg3;
        let v4 = v3;
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::assert_active_farm_pool(arg0, v1, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg1));
        let (v5, v6) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::remove_liquidity<T0, T1>(arg1, &mut v4, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(&v4), arg4, arg5, arg8, arg2, arg9);
        let v7 = v6;
        let v8 = v5;
        let (v9, v10) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::fee<T0, T1>(arg1, &mut v4, arg8, arg2, arg9);
        let v11 = v10;
        let v12 = v9;
        let v13 = &mut v12;
        let (v14, v15) = split_native_fees<T0>(v13, arg9);
        let v16 = v14;
        let v17 = &mut v11;
        let (v18, v19) = split_native_fees<T1>(v17, arg9);
        let v20 = v18;
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit_coin<T0>(arg6, v15);
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit_coin<T1>(arg7, v19);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::close_position(v4, arg2, arg9);
        0x2::object::delete(v0);
        let v21 = 0x2::tx_context::sender(arg9);
        let v22 = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::operations_wallet(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, v21);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v7, v21);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v12, v21);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v11, v21);
        if (0x2::coin::value<T0>(&v16) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v16, v22);
        } else {
            0x2::coin::destroy_zero<T0>(v16);
        };
        if (0x2::coin::value<T1>(&v20) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v20, v22);
        } else {
            0x2::coin::destroy_zero<T1>(v20);
        };
        let v23 = PositionClosed{
            farm_id     : v1,
            principal_x : 0x2::coin::value<T0>(&v8),
            principal_y : 0x2::coin::value<T1>(&v7),
            fee_x       : 0x2::coin::value<T0>(&v12),
            fee_y       : 0x2::coin::value<T1>(&v11),
        };
        0x2::event::emit<PositionClosed>(v23);
    }

    public entry fun open_position_native<T0, T1>(arg0: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::Router, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: u64, arg4: u8, arg5: u32, arg6: bool, arg7: u32, arg8: bool, arg9: 0x2::coin::Coin<T0>, arg10: 0x2::coin::Coin<T1>, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::assert_active_farm_pool(arg0, arg3, 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg1));
        assert!(arg4 == 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::route_native(), 2);
        let v0 = 0x2::coin::value<T0>(&arg9);
        let v1 = 0x2::coin::value<T1>(&arg10);
        assert!(v0 > 0 && v1 > 0, 1);
        let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::open_position<T0, T1>(arg1, signed_tick(arg5, arg6), signed_tick(arg7, arg8), arg2, arg14);
        let (v3, v4) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::add_liquidity<T0, T1>(arg1, &mut v2, arg9, arg10, arg11, arg12, arg13, arg2, arg14);
        let v5 = 0x2::tx_context::sender(arg14);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, v5);
        let v6 = MmtPosition<T0, T1>{
            id               : 0x2::object::new(arg14),
            farm_id          : arg3,
            settlement_route : arg4,
            mmt_position     : v2,
        };
        0x2::transfer::public_transfer<MmtPosition<T0, T1>>(v6, v5);
        let v7 = PositionOpened{
            farm_id         : arg3,
            mmt_position_id : 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&v2),
            max_amount_x    : v0,
            max_amount_y    : v1,
        };
        0x2::event::emit<PositionOpened>(v7);
    }

    fun signed_tick(arg0: u32, arg1: bool) : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32 {
        if (arg1) {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::neg_from(arg0)
        } else {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(arg0)
        }
    }

    fun split_native_fees<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        let (v0, v1) = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::native_reward_fees(0x2::coin::value<T0>(arg0));
        (0x2::coin::split<T0>(arg0, v0, arg1), 0x2::coin::split<T0>(arg0, v1, arg1))
    }

    // decompiled from Move bytecode v7
}

