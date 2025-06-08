module 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::momentum_adapter {
    struct NoAssetProof has store {
        dummy_field: bool,
    }

    struct MomentumProtocolOpenPositionRequest {
        dummy_field: bool,
    }

    struct MomentumProtocolClosePositionRequest {
        dummy_field: bool,
    }

    struct MomentumProtocolSwapRequest {
        dummy_field: bool,
    }

    struct MomentumProtocolAddLiquidityRequest {
        dummy_field: bool,
    }

    struct MomentumProtocolRemoveLiquidityRequest {
        dummy_field: bool,
    }

    struct MomentumProtocolClaimRequest {
        dummy_field: bool,
    }

    struct MomentumProtocolOpenPositionReceipt {
        dummy_field: bool,
    }

    struct MomentumProtocolClosePositionReceipt {
        dummy_field: bool,
    }

    struct MomentumProtocolSwapReceipt {
        dummy_field: bool,
    }

    struct MomentumProtocolAddLiquidityReceipt {
        dummy_field: bool,
    }

    struct MomentumProtocolRemoveLiquidityReceipt {
        dummy_field: bool,
    }

    struct MomentumProtocolClaimReceipt {
        dummy_field: bool,
    }

    public fun swap<T0, T1>(arg0: &mut 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Collector, arg1: MomentumProtocolSwapRequest, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: bool, arg4: bool, arg5: u128, arg6: &0x2::clock::Clock, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &mut 0x2::tx_context::TxContext) : (0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Collector, MomentumProtocolSwapReceipt) {
        let v0 = 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::vault_id(arg0);
        let v1 = extract_balance<MomentumProtocolSwapRequest, T0>(arg0, &arg1, false);
        let v2 = extract_balance<MomentumProtocolSwapRequest, T1>(arg0, &arg1, true);
        drop_swap_request(arg1);
        let v3 = if (arg3) {
            0x2::balance::value<T0>(&v1)
        } else {
            0x2::balance::value<T1>(&v2)
        };
        let (v4, v5, v6) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg2, arg3, arg4, v3, arg5, arg6, arg7, arg8);
        let v7 = v6;
        let (v8, v9) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v7);
        let v10 = if (arg3) {
            v8
        } else {
            v9
        };
        let (v11, v12) = if (arg3) {
            (0x2::balance::split<T0>(&mut v1, v10), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v2, v10))
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg2, v7, v11, v12, arg7, arg8);
        0x2::balance::join<T0>(&mut v1, v4);
        0x2::balance::join<T1>(&mut v2, v5);
        let v13 = 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::new(v0);
        let v14 = new_swap_receipt();
        0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::collect_asset<0x2::balance::Balance<T0>, MomentumProtocolSwapReceipt>(&mut v13, &v14, v1, arg8);
        0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::collect_asset<0x2::balance::Balance<T1>, MomentumProtocolSwapReceipt>(&mut v13, &v14, v2, arg8);
        (v13, v14)
    }

    public fun add_liquidity<T0, T1>(arg0: &mut 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Collector, arg1: MomentumProtocolAddLiquidityRequest, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &mut 0x2::tx_context::TxContext) : (0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Collector, MomentumProtocolAddLiquidityReceipt) {
        let v0 = 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::vault_id(arg0);
        let v1 = extract_position<MomentumProtocolAddLiquidityRequest>(arg0, &arg1, false);
        let v2 = extract_balance<MomentumProtocolAddLiquidityRequest, T0>(arg0, &arg1, false);
        drop_add_liquidity_request(arg1);
        let (v3, v4) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::add_liquidity<T0, T1>(arg2, &mut v1, 0x2::coin::from_balance<T0>(v2, arg7), 0x2::coin::from_balance<T1>(extract_balance<MomentumProtocolAddLiquidityRequest, T1>(arg0, &arg1, true), arg7), arg3, arg4, arg5, arg6, arg7);
        let v5 = 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::new(v0);
        let v6 = new_add_liquidity_receipt();
        0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::collect_asset<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, MomentumProtocolAddLiquidityReceipt>(&mut v5, &v6, v1, arg7);
        0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::collect_asset<0x2::balance::Balance<T0>, MomentumProtocolAddLiquidityReceipt>(&mut v5, &v6, 0x2::coin::into_balance<T0>(v3), arg7);
        0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::collect_asset<0x2::balance::Balance<T1>, MomentumProtocolAddLiquidityReceipt>(&mut v5, &v6, 0x2::coin::into_balance<T1>(v4), arg7);
        (v5, v6)
    }

    public fun close_position(arg0: &mut 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Collector, arg1: MomentumProtocolClosePositionRequest, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x2::tx_context::TxContext) : (0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Collector, MomentumProtocolClosePositionReceipt) {
        let v0 = 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::vault_id(arg0);
        drop_close_position_request(arg1);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::close_position(extract_position<MomentumProtocolClosePositionRequest>(arg0, &arg1, true), arg2, arg3);
        let v1 = 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::new(v0);
        let v2 = new_close_position_receipt();
        0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::collect_asset<NoAssetProof, MomentumProtocolClosePositionReceipt>(&mut v1, &v2, new_no_asset_proof(), arg3);
        (v1, v2)
    }

    public fun open_position<T0, T1>(arg0: &mut 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Collector, arg1: MomentumProtocolOpenPositionRequest, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, arg4: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x2::tx_context::TxContext) : (0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Collector, MomentumProtocolOpenPositionReceipt) {
        let v0 = 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::vault_id(arg0);
        drop_empty<MomentumProtocolOpenPositionRequest>(arg0, &arg1, true);
        drop_open_position_request(arg1);
        let v1 = 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::new(v0);
        let v2 = new_open_position_receipt();
        0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::collect_asset<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, MomentumProtocolOpenPositionReceipt>(&mut v1, &v2, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::open_position<T0, T1>(arg2, arg3, arg4, arg5, arg6), arg6);
        (v1, v2)
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Collector, arg1: MomentumProtocolRemoveLiquidityRequest, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: u128, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &mut 0x2::tx_context::TxContext) : (0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Collector, MomentumProtocolRemoveLiquidityReceipt) {
        let v0 = 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::vault_id(arg0);
        let v1 = extract_position<MomentumProtocolRemoveLiquidityRequest>(arg0, &arg1, true);
        drop_remove_liquidity_request(arg1);
        let (v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::remove_liquidity<T0, T1>(arg2, &mut v1, arg3, arg4, arg5, arg6, arg7, arg8);
        let v4 = 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::new(v0);
        let v5 = new_remove_liquidity_receipt();
        0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::collect_asset<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, MomentumProtocolRemoveLiquidityReceipt>(&mut v4, &v5, v1, arg8);
        0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::collect_asset<0x2::balance::Balance<T0>, MomentumProtocolRemoveLiquidityReceipt>(&mut v4, &v5, 0x2::coin::into_balance<T0>(v2), arg8);
        0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::collect_asset<0x2::balance::Balance<T1>, MomentumProtocolRemoveLiquidityReceipt>(&mut v4, &v5, 0x2::coin::into_balance<T1>(v3), arg8);
        (v4, v5)
    }

    public fun claim_rewards<T0, T1, T2>(arg0: &mut 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Collector, arg1: MomentumProtocolClaimRequest, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x2::tx_context::TxContext) : (0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Collector, MomentumProtocolClaimReceipt) {
        let v0 = 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::vault_id(arg0);
        let v1 = extract_position<MomentumProtocolClaimRequest>(arg0, &arg1, true);
        drop_claim_request(arg1);
        let v2 = 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::new(v0);
        let v3 = new_claim_receipt();
        0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::collect_asset<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, MomentumProtocolClaimReceipt>(&mut v2, &v3, v1, arg5);
        0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::collect_asset<0x2::balance::Balance<T2>, MomentumProtocolClaimReceipt>(&mut v2, &v3, 0x2::coin::into_balance<T2>(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T2>(arg2, &mut v1, arg3, arg4, arg5)), arg5);
        (v2, v3)
    }

    public(friend) fun drop_add_liquidity_receipt(arg0: MomentumProtocolAddLiquidityReceipt) {
        let MomentumProtocolAddLiquidityReceipt {  } = arg0;
    }

    public(friend) fun drop_add_liquidity_request(arg0: MomentumProtocolAddLiquidityRequest) {
        let MomentumProtocolAddLiquidityRequest {  } = arg0;
    }

    public(friend) fun drop_claim_receipt(arg0: MomentumProtocolClaimReceipt) {
        let MomentumProtocolClaimReceipt {  } = arg0;
    }

    public(friend) fun drop_claim_request(arg0: MomentumProtocolClaimRequest) {
        let MomentumProtocolClaimRequest {  } = arg0;
    }

    public(friend) fun drop_close_position_receipt(arg0: MomentumProtocolClosePositionReceipt) {
        let MomentumProtocolClosePositionReceipt {  } = arg0;
    }

    public(friend) fun drop_close_position_request(arg0: MomentumProtocolClosePositionRequest) {
        let MomentumProtocolClosePositionRequest {  } = arg0;
    }

    public(friend) fun drop_empty<T0>(arg0: &mut 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Collector, arg1: &T0, arg2: bool) {
        let v0 = 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::extract_asset_map_mut<T0>(arg0, arg1);
        let v1 = 0x1::type_name::get<0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Empty>();
        let (_, v3) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Item>(v0, &v1);
        0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::drop_empty_item(v3);
        if (arg2) {
            let v4 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Item>(v0);
            if (0x1::vector::length<0x1::type_name::TypeName>(&v4) > 0) {
                err_remaining_unused_asset();
            };
        };
    }

    public(friend) fun drop_no_asset_proof(arg0: NoAssetProof) {
        let NoAssetProof {  } = arg0;
    }

    public(friend) fun drop_open_position_receipt(arg0: MomentumProtocolOpenPositionReceipt) {
        let MomentumProtocolOpenPositionReceipt {  } = arg0;
    }

    public(friend) fun drop_open_position_request(arg0: MomentumProtocolOpenPositionRequest) {
        let MomentumProtocolOpenPositionRequest {  } = arg0;
    }

    public(friend) fun drop_remove_liquidity_receipt(arg0: MomentumProtocolRemoveLiquidityReceipt) {
        let MomentumProtocolRemoveLiquidityReceipt {  } = arg0;
    }

    public(friend) fun drop_remove_liquidity_request(arg0: MomentumProtocolRemoveLiquidityRequest) {
        let MomentumProtocolRemoveLiquidityRequest {  } = arg0;
    }

    public(friend) fun drop_swap_receipt(arg0: MomentumProtocolSwapReceipt) {
        let MomentumProtocolSwapReceipt {  } = arg0;
    }

    public(friend) fun drop_swap_request(arg0: MomentumProtocolSwapRequest) {
        let MomentumProtocolSwapRequest {  } = arg0;
    }

    fun err_remaining_unused_asset() {
        abort 1000
    }

    public(friend) fun extract_balance<T0, T1>(arg0: &mut 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Collector, arg1: &T0, arg2: bool) : 0x2::balance::Balance<T1> {
        let v0 = 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::extract_asset_map_mut<T0>(arg0, arg1);
        let v1 = 0x1::type_name::get<0x2::balance::Balance<T1>>();
        let (_, v3) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Item>(v0, &v1);
        if (arg2) {
            let v4 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Item>(v0);
            if (0x1::vector::length<0x1::type_name::TypeName>(&v4) > 0) {
                err_remaining_unused_asset();
            };
        };
        0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::extract_inner_asset<0x2::balance::Balance<T1>>(v3)
    }

    public(friend) fun extract_position<T0>(arg0: &mut 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Collector, arg1: &T0, arg2: bool) : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position {
        let v0 = 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::extract_asset_map_mut<T0>(arg0, arg1);
        let v1 = 0x1::type_name::get<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>();
        let (_, v3) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Item>(v0, &v1);
        if (arg2) {
            let v4 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Item>(v0);
            if (0x1::vector::length<0x1::type_name::TypeName>(&v4) > 0) {
                err_remaining_unused_asset();
            };
        };
        0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::extract_inner_asset<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(v3)
    }

    public(friend) fun new_add_liquidity_receipt() : MomentumProtocolAddLiquidityReceipt {
        MomentumProtocolAddLiquidityReceipt{dummy_field: false}
    }

    public(friend) fun new_add_liquidity_request() : MomentumProtocolAddLiquidityRequest {
        MomentumProtocolAddLiquidityRequest{dummy_field: false}
    }

    public(friend) fun new_claim_receipt() : MomentumProtocolClaimReceipt {
        MomentumProtocolClaimReceipt{dummy_field: false}
    }

    public(friend) fun new_claim_request() : MomentumProtocolClaimRequest {
        MomentumProtocolClaimRequest{dummy_field: false}
    }

    public(friend) fun new_close_position_receipt() : MomentumProtocolClosePositionReceipt {
        MomentumProtocolClosePositionReceipt{dummy_field: false}
    }

    public(friend) fun new_close_position_request() : MomentumProtocolClosePositionRequest {
        MomentumProtocolClosePositionRequest{dummy_field: false}
    }

    public(friend) fun new_no_asset_proof() : NoAssetProof {
        NoAssetProof{dummy_field: false}
    }

    public(friend) fun new_open_position_receipt() : MomentumProtocolOpenPositionReceipt {
        MomentumProtocolOpenPositionReceipt{dummy_field: false}
    }

    public(friend) fun new_open_position_request() : MomentumProtocolOpenPositionRequest {
        MomentumProtocolOpenPositionRequest{dummy_field: false}
    }

    public(friend) fun new_remove_liquidity_receipt() : MomentumProtocolRemoveLiquidityReceipt {
        MomentumProtocolRemoveLiquidityReceipt{dummy_field: false}
    }

    public(friend) fun new_remove_liquidity_request() : MomentumProtocolRemoveLiquidityRequest {
        MomentumProtocolRemoveLiquidityRequest{dummy_field: false}
    }

    public(friend) fun new_swap_receipt() : MomentumProtocolSwapReceipt {
        MomentumProtocolSwapReceipt{dummy_field: false}
    }

    public(friend) fun new_swap_request() : MomentumProtocolSwapRequest {
        MomentumProtocolSwapRequest{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

