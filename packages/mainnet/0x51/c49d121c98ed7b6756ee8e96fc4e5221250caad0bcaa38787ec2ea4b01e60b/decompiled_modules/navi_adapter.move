module 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::navi_adapter {
    public fun owner_redeem<T0>(arg0: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::Treasury<T0>, arg1: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::OwnerCap<T0>, arg2: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::oracle::PriceOracle, arg3: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::storage::Storage, arg4: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::pool::Pool<T0>, arg5: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::incentive_v2::Incentive, arg6: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::incentive_v3::Incentive, arg7: u8, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::owner_take_receipt<T0, 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::account::AccountCap>(arg0, arg1, 2);
        0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::custody_receipt<T0, 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::account::AccountCap>(arg0, 2, v0);
        0x2::coin::from_balance<T0>(0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::incentive_v3::withdraw_with_account_cap<T0>(arg9, arg2, arg3, arg4, arg7, arg8, arg5, arg6, &v0), arg10)
    }

    public fun supply_and_custody<T0>(arg0: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::Treasury<T0>, arg1: &0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::AgentCap<T0>, arg2: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::storage::Storage, arg3: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::pool::Pool<T0>, arg4: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::incentive_v2::Incentive, arg5: &mut 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::incentive_v3::Incentive, arg6: u8, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        if (0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::has_position<T0>(arg0, 2)) {
            0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::incentive_v3::deposit_with_account_cap<T0>(arg8, arg2, arg3, arg6, 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::release_for_action<T0>(arg0, arg1, arg7, arg8, arg9), arg4, arg5, 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::borrow_receipt_mut<T0, 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::account::AccountCap>(arg0, 2));
        } else {
            let v0 = 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::lending::create_account(arg9);
            0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::incentive_v3::deposit_with_account_cap<T0>(arg8, arg2, arg3, arg6, 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::release_for_action<T0>(arg0, arg1, arg7, arg8, arg9), arg4, arg5, &v0);
            0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::capability::custody_receipt<T0, 0x51c49d121c98ed7b6756ee8e96fc4e5221250caad0bcaa38787ec2ea4b01e60b::account::AccountCap>(arg0, 2, v0);
        };
    }

    // decompiled from Move bytecode v7
}

