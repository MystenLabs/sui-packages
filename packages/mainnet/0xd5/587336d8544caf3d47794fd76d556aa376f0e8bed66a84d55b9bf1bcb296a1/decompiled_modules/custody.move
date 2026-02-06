module 0xd5587336d8544caf3d47794fd76d556aa376f0e8bed66a84d55b9bf1bcb296a1::custody {
    struct CustodyAccount has store, key {
        id: 0x2::object::UID,
        owner: address,
        agents: vector<address>,
        position: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>,
    }

    public entry fun agent_claim_and_exit<T0, T1>(arg0: &mut CustodyAccount, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x1::vector::contains<address>(&arg0.agents, &v0) || v0 == arg0.owner, 1);
        assert!(0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position), 3);
        let v1 = 0x1::option::extract<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.position);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v1) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), 4);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, &mut v1, true);
        let v4 = v3;
        let v5 = v2;
        let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg1, arg2, &mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v1), arg3);
        0x2::balance::join<T0>(&mut v5, v6);
        0x2::balance::join<T1>(&mut v4, v7);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg1, arg2, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg4), arg0.owner);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg4), arg0.owner);
    }

    public entry fun agent_reposition<T0, T1>(arg0: &mut CustodyAccount, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u32, arg4: u32, arg5: u128, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(0x1::vector::contains<address>(&arg0.agents, &v0), 1);
        assert!(0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position), 3);
        let v1 = 0x1::option::extract<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.position);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v1) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2), 4);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, &mut v1, true);
        let v4 = v3;
        let v5 = v2;
        let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg1, arg2, &mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v1), arg8);
        0x2::balance::join<T0>(&mut v5, v6);
        0x2::balance::join<T1>(&mut v4, v7);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg1, arg2, v1);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg1, arg2, arg3, arg4, arg9);
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg1, arg2, &mut v8, arg5, arg8);
        let (v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v9);
        assert!(v10 <= arg6 && v11 <= arg7, 5);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut v5, v10), 0x2::balance::split<T1>(&mut v4, v11), v9);
        0x1::option::fill<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.position, v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg9), arg0.owner);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg9), arg0.owner);
    }

    public entry fun authorize_agent(arg0: &mut CustodyAccount, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        0x1::vector::push_back<address>(&mut arg0.agents, arg1);
    }

    public entry fun create_account(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CustodyAccount{
            id       : 0x2::object::new(arg0),
            owner    : 0x2::tx_context::sender(arg0),
            agents   : 0x1::vector::empty<address>(),
            position : 0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(),
        };
        0x2::transfer::share_object<CustodyAccount>(v0);
    }

    public entry fun deposit_position(arg0: &mut CustodyAccount, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        assert!(0x1::option::is_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position), 2);
        0x1::option::fill<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.position, arg1);
    }

    // decompiled from Move bytecode v6
}

