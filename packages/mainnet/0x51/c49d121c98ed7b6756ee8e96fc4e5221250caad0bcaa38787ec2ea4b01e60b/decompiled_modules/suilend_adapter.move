module 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::suilend_adapter {
    public fun owner_redeem<T0, T1>(arg0: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::Treasury<T1>, arg1: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::OwnerCap<T1>, arg2: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::lending_market::LendingMarket<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::owner_take_receipt<T1, 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::lending_market::ObligationOwnerCap<T0>>(arg0, arg1, 0);
        0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::custody_receipt<T1, 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::lending_market::ObligationOwnerCap<T0>>(arg0, 0, v0);
        0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg2, arg3, arg5, 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::lending_market::withdraw_ctokens<T0, T1>(arg2, arg3, &v0, arg5, arg4, arg6), 0x1::option::none<0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::lending_market::RateLimiterExemption<T0, T1>>(), arg6)
    }

    public fun supply_and_custody<T0, T1>(arg0: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::Treasury<T1>, arg1: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::AgentCap<T1>, arg2: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::lending_market::LendingMarket<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::has_position<T1>(arg0, 0)) {
            0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg2, arg3, 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::borrow_receipt_mut<T1, 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::lending_market::ObligationOwnerCap<T0>>(arg0, 0), arg5, 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg2, arg3, arg5, 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::release_for_action<T1>(arg0, arg1, arg4, arg5, arg6), arg6), arg6);
        } else {
            let v0 = 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::lending_market::create_obligation<T0>(arg2, arg6);
            0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg2, arg3, &v0, arg5, 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg2, arg3, arg5, 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::release_for_action<T1>(arg0, arg1, arg4, arg5, arg6), arg6), arg6);
            0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::custody_receipt<T1, 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::lending_market::ObligationOwnerCap<T0>>(arg0, 0, v0);
        };
    }

    // decompiled from Move bytecode v7
}

