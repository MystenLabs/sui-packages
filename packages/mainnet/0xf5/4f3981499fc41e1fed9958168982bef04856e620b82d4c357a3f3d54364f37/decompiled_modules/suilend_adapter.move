module 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::suilend_adapter {
    struct SuilendProtocolBorrowRequest {
        dummy_field: bool,
    }

    struct SuilendProtocolSupplyRequest {
        dummy_field: bool,
    }

    struct SuilendProtocolRepayRequest {
        dummy_field: bool,
    }

    struct SuilendProtocolWithdrawRequest {
        dummy_field: bool,
    }

    struct SuilendProtocolClaimRequest {
        dummy_field: bool,
    }

    struct SuilendProtocolCreateObligationRequest {
        dummy_field: bool,
    }

    struct SuilendProtocolBorrowReceipt {
        dummy_field: bool,
    }

    struct SuilendProtocolSupplyReceipt {
        dummy_field: bool,
    }

    struct SuilendProtocolRepayReceipt {
        dummy_field: bool,
    }

    struct SuilendProtocolWithdrawReceipt {
        dummy_field: bool,
    }

    struct SuilendProtocolClaimReceipt {
        dummy_field: bool,
    }

    struct SuilendProtocolCreateObligationReceipt {
        dummy_field: bool,
    }

    public fun borrow<T0, T1>(arg0: &mut 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Collector, arg1: SuilendProtocolBorrowRequest, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Collector, SuilendProtocolBorrowReceipt) {
        let v0 = 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::vault_id(arg0);
        let v1 = extract_obligation_owner_cap<T0, SuilendProtocolBorrowRequest>(arg0, &arg1, true);
        drop_borrow_request(arg1);
        let v2 = 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::new(v0);
        let v3 = new_borrow_receipt();
        0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::collect_asset<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendProtocolBorrowReceipt>(&mut v2, &v3, v1, arg6);
        0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::collect_asset<0x2::balance::Balance<T1>, SuilendProtocolBorrowReceipt>(&mut v2, &v3, 0x2::coin::into_balance<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, T1>(arg2, arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow_request<T0, T1>(arg2, arg3, &v1, arg4, arg5), arg6)), arg6);
        (v2, v3)
    }

    public fun claim<T0, T1>(arg0: &mut 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Collector, arg1: SuilendProtocolClaimRequest, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : (0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Collector, SuilendProtocolClaimReceipt) {
        let v0 = 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::vault_id(arg0);
        let v1 = extract_obligation_owner_cap<T0, SuilendProtocolClaimRequest>(arg0, &arg1, true);
        drop_claim_request(arg1);
        let v2 = 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::new(v0);
        let v3 = new_claim_receipt();
        0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::collect_asset<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendProtocolClaimReceipt>(&mut v2, &v3, v1, arg7);
        0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::collect_asset<0x2::balance::Balance<T1>, SuilendProtocolClaimReceipt>(&mut v2, &v3, 0x2::coin::into_balance<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<T0, T1>(arg2, &v1, arg3, arg4, arg5, arg6, arg7)), arg7);
        (v2, v3)
    }

    public fun create_obligation<T0>(arg0: &mut 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Collector, arg1: SuilendProtocolCreateObligationRequest, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0x2::tx_context::TxContext) : (0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Collector, SuilendProtocolCreateObligationReceipt) {
        let v0 = 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::vault_id(arg0);
        drop_empty<SuilendProtocolCreateObligationRequest>(arg0, &arg1, true);
        drop_create_obligation_request(arg1);
        let v1 = 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::new(v0);
        let v2 = new_create_obligation_receipt();
        0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::collect_asset<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendProtocolCreateObligationReceipt>(&mut v1, &v2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg2, arg3), arg3);
        (v1, v2)
    }

    public(friend) fun drop_borrow_receipt(arg0: SuilendProtocolBorrowReceipt) {
        let SuilendProtocolBorrowReceipt {  } = arg0;
    }

    public(friend) fun drop_borrow_request(arg0: SuilendProtocolBorrowRequest) {
        let SuilendProtocolBorrowRequest {  } = arg0;
    }

    public(friend) fun drop_claim_receipt(arg0: SuilendProtocolClaimReceipt) {
        let SuilendProtocolClaimReceipt {  } = arg0;
    }

    public(friend) fun drop_claim_request(arg0: SuilendProtocolClaimRequest) {
        let SuilendProtocolClaimRequest {  } = arg0;
    }

    public(friend) fun drop_create_obligation_receipt(arg0: SuilendProtocolCreateObligationReceipt) {
        let SuilendProtocolCreateObligationReceipt {  } = arg0;
    }

    public(friend) fun drop_create_obligation_request(arg0: SuilendProtocolCreateObligationRequest) {
        let SuilendProtocolCreateObligationRequest {  } = arg0;
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

    public(friend) fun drop_repay_receipt(arg0: SuilendProtocolRepayReceipt) {
        let SuilendProtocolRepayReceipt {  } = arg0;
    }

    public(friend) fun drop_repay_request(arg0: SuilendProtocolRepayRequest) {
        let SuilendProtocolRepayRequest {  } = arg0;
    }

    public(friend) fun drop_supply_receipt(arg0: SuilendProtocolSupplyReceipt) {
        let SuilendProtocolSupplyReceipt {  } = arg0;
    }

    public(friend) fun drop_supply_request(arg0: SuilendProtocolSupplyRequest) {
        let SuilendProtocolSupplyRequest {  } = arg0;
    }

    public(friend) fun drop_withdraw_receipt(arg0: SuilendProtocolWithdrawReceipt) {
        let SuilendProtocolWithdrawReceipt {  } = arg0;
    }

    public(friend) fun drop_withdraw_request(arg0: SuilendProtocolWithdrawRequest) {
        let SuilendProtocolWithdrawRequest {  } = arg0;
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

    public(friend) fun extract_obligation_owner_cap<T0, T1>(arg0: &mut 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Collector, arg1: &T1, arg2: bool) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0> {
        let v0 = 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::extract_asset_map_mut<T1>(arg0, arg1);
        let v1 = 0x1::type_name::get<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>();
        let (_, v3) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Item>(v0, &v1);
        if (arg2) {
            let v4 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Item>(v0);
            if (0x1::vector::length<0x1::type_name::TypeName>(&v4) > 0) {
                err_remaining_unused_asset();
            };
        };
        0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::extract_inner_asset<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(v3)
    }

    public(friend) fun new_borrow_receipt() : SuilendProtocolBorrowReceipt {
        SuilendProtocolBorrowReceipt{dummy_field: false}
    }

    public(friend) fun new_borrow_request() : SuilendProtocolBorrowRequest {
        SuilendProtocolBorrowRequest{dummy_field: false}
    }

    public(friend) fun new_claim_receipt() : SuilendProtocolClaimReceipt {
        SuilendProtocolClaimReceipt{dummy_field: false}
    }

    public(friend) fun new_claim_request() : SuilendProtocolClaimRequest {
        SuilendProtocolClaimRequest{dummy_field: false}
    }

    public(friend) fun new_create_obligation_receipt() : SuilendProtocolCreateObligationReceipt {
        SuilendProtocolCreateObligationReceipt{dummy_field: false}
    }

    public(friend) fun new_create_obligation_request() : SuilendProtocolCreateObligationRequest {
        SuilendProtocolCreateObligationRequest{dummy_field: false}
    }

    public(friend) fun new_repay_receipt() : SuilendProtocolRepayReceipt {
        SuilendProtocolRepayReceipt{dummy_field: false}
    }

    public(friend) fun new_repay_request() : SuilendProtocolRepayRequest {
        SuilendProtocolRepayRequest{dummy_field: false}
    }

    public(friend) fun new_supply_receipt() : SuilendProtocolSupplyReceipt {
        SuilendProtocolSupplyReceipt{dummy_field: false}
    }

    public(friend) fun new_supply_request() : SuilendProtocolSupplyRequest {
        SuilendProtocolSupplyRequest{dummy_field: false}
    }

    public(friend) fun new_withdraw_receipt() : SuilendProtocolWithdrawReceipt {
        SuilendProtocolWithdrawReceipt{dummy_field: false}
    }

    public(friend) fun new_withdraw_request() : SuilendProtocolWithdrawRequest {
        SuilendProtocolWithdrawRequest{dummy_field: false}
    }

    public fun repay<T0, T1>(arg0: &mut 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Collector, arg1: SuilendProtocolRepayRequest, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Collector, SuilendProtocolRepayReceipt) {
        let v0 = 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::vault_id(arg0);
        let v1 = extract_obligation_owner_cap<T0, SuilendProtocolRepayRequest>(arg0, &arg1, false);
        let v2 = 0x2::coin::from_balance<T1>(extract_balance<SuilendProtocolRepayRequest, T1>(arg0, &arg1, true), arg5);
        drop_repay_request(arg1);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::repay<T0, T1>(arg2, arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&v1), arg4, &mut v2, arg5);
        let v3 = 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::new(v0);
        let v4 = new_repay_receipt();
        0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::collect_asset<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendProtocolRepayReceipt>(&mut v3, &v4, v1, arg5);
        0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::collect_asset<0x2::balance::Balance<T1>, SuilendProtocolRepayReceipt>(&mut v3, &v4, 0x2::coin::into_balance<T1>(v2), arg5);
        (v3, v4)
    }

    public fun supply<T0, T1>(arg0: &mut 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Collector, arg1: SuilendProtocolSupplyRequest, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Collector, SuilendProtocolSupplyReceipt) {
        let v0 = 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::vault_id(arg0);
        let v1 = extract_obligation_owner_cap<T0, SuilendProtocolSupplyRequest>(arg0, &arg1, false);
        drop_supply_request(arg1);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg2, arg3, &v1, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg2, arg3, arg4, 0x2::coin::from_balance<T1>(extract_balance<SuilendProtocolSupplyRequest, T1>(arg0, &arg1, true), arg5), arg5), arg5);
        let v2 = 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::new(v0);
        let v3 = new_supply_receipt();
        0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::collect_asset<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendProtocolSupplyReceipt>(&mut v2, &v3, v1, arg5);
        (v2, v3)
    }

    public fun withdraw<T0, T1>(arg0: &mut 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Collector, arg1: SuilendProtocolWithdrawRequest, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>, arg7: &mut 0x2::tx_context::TxContext) : (0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::Collector, SuilendProtocolWithdrawReceipt) {
        let v0 = 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::vault_id(arg0);
        let v1 = extract_obligation_owner_cap<T0, SuilendProtocolWithdrawRequest>(arg0, &arg1, true);
        drop_withdraw_request(arg1);
        let v2 = 0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::new(v0);
        let v3 = new_withdraw_receipt();
        0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::collect_asset<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>, SuilendProtocolWithdrawReceipt>(&mut v2, &v3, v1, arg7);
        0xf54f3981499fc41e1fed9958168982bef04856e620b82d4c357a3f3d54364f37::collector::collect_asset<0x2::balance::Balance<T1>, SuilendProtocolWithdrawReceipt>(&mut v2, &v3, 0x2::coin::into_balance<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, T1>(arg2, arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, T1>(arg2, arg3, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg2, arg3, &v1, arg4, arg5, arg7), arg6, arg7), arg7)), arg7);
        (v2, v3)
    }

    // decompiled from Move bytecode v6
}

