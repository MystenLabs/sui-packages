module 0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::settlement {
    public fun release_funds(arg0: &mut 0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::funding_pool::FundingPool, arg1: &mut 0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::campaign::Campaign, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::campaign::creator(arg1) == arg2, 50);
        assert!(0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::campaign::status(arg1) == 1, 51);
        let v0 = 0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::funding_pool::get_balance(arg0);
        assert!(v0 > 0, 52);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::funding_pool::extract_all_funds(arg0, arg3), arg2);
        0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::events::emit_fund_released(0x2::object::id<0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::campaign::Campaign>(arg1), v0, arg2);
    }

    public fun release_milestone_funds(arg0: &mut 0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::funding_pool::FundingPool, arg1: &0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::milestone::Milestone, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::milestone::is_completed(arg1), 53);
        let v0 = 0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::milestone::get_amount(arg1);
        assert!(0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::funding_pool::get_balance(arg0) >= v0, 54);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::funding_pool::extract_funds(arg0, v0, arg3), arg2);
        0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::events::emit_fund_released(0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::milestone::get_campaign_id(arg1), v0, arg2);
    }

    public fun settle_campaign(arg0: &mut 0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::funding_pool::FundingPool, arg1: &mut 0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::campaign::Campaign, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::campaign::creator(arg1);
        if (0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::campaign::status(arg1) == 1) {
            release_funds(arg0, arg1, v0, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

