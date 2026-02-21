module 0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::refund {
    public fun refund_all_backers(arg0: &mut 0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::funding_pool::FundingPool, arg1: &mut 0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::campaign::Campaign, arg2: &mut 0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::funding_pool::ContributorTable, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::campaign::status(arg1) == 2, 2);
        let v0 = 0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::funding_pool::get_contributor_count(arg2);
        refund_all_backers_recursive(arg0, 0x2::object::id<0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::campaign::Campaign>(arg1), arg2, arg3, 0, v0);
    }

    fun refund_all_backers_recursive(arg0: &mut 0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::funding_pool::FundingPool, arg1: 0x2::object::ID, arg2: &mut 0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::funding_pool::ContributorTable, arg3: &mut 0x2::tx_context::TxContext, arg4: u64, arg5: u64) {
        if (arg4 >= arg5) {
            return
        };
        let (v0, v1) = 0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::funding_pool::get_contributor(arg2, arg4);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::funding_pool::extract_funds(arg0, v1, arg3), v0);
            0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::events::emit_refunded(arg1, v1, v0);
        };
        refund_all_backers_recursive(arg0, arg1, arg2, arg3, arg4 + 1, arg5);
    }

    public fun refund_contributor(arg0: &mut 0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::funding_pool::FundingPool, arg1: &mut 0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::funding_pool::ContributorTable, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::funding_pool::borrow_contributor_mut(arg1, arg2);
        let v1 = 0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::funding_pool::get_contributor_amount(v0);
        assert!(v1 > 0, 1);
        let v2 = 0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::funding_pool::get_contributor_address(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::funding_pool::extract_funds(arg0, v1, arg3), v2);
        0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::funding_pool::set_contributor_amount(v0, 0);
        0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::events::emit_refunded(0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::funding_pool::campaign_id(arg0), v1, v2);
    }

    // decompiled from Move bytecode v6
}

