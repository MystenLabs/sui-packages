module 0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::refund {
    public fun refund_all_backers(arg0: &mut 0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::funding_pool::FundingPool, arg1: &mut 0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::campaign::Campaign, arg2: &mut 0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::funding_pool::ContributorTable, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::campaign::status(arg1) == 2, 41);
        let v0 = 0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::funding_pool::get_contributor_count(arg2);
        refund_all_recursive(arg0, 0x2::object::id<0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::campaign::Campaign>(arg1), arg2, arg3, 0, v0);
    }

    fun refund_all_recursive(arg0: &mut 0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::funding_pool::FundingPool, arg1: 0x2::object::ID, arg2: &mut 0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::funding_pool::ContributorTable, arg3: &mut 0x2::tx_context::TxContext, arg4: u64, arg5: u64) {
        if (arg4 >= arg5) {
            return
        };
        let (v0, v1) = 0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::funding_pool::get_contributor(arg2, arg4);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::funding_pool::extract_funds(arg0, v1, arg3), v0);
            0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::events::emit_refunded(arg1, v1, v0);
        };
        refund_all_recursive(arg0, arg1, arg2, arg3, arg4 + 1, arg5);
    }

    public fun refund_contributor(arg0: &mut 0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::funding_pool::FundingPool, arg1: &mut 0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::funding_pool::ContributorTable, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::funding_pool::borrow_contributor_mut(arg1, arg2);
        let v1 = 0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::funding_pool::get_contributor_amount(v0);
        assert!(v1 > 0, 40);
        let v2 = 0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::funding_pool::get_contributor_address(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::funding_pool::extract_funds(arg0, v1, arg3), v2);
        0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::funding_pool::set_contributor_amount(v0, 0);
        0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::events::emit_refunded(0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::funding_pool::campaign_id(arg0), v1, v2);
    }

    // decompiled from Move bytecode v6
}

