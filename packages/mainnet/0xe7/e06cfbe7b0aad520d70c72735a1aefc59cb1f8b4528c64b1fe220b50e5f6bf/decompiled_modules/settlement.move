module 0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::settlement {
    public fun release_funds(arg0: &mut 0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::funding_pool::FundingPool, arg1: &mut 0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::campaign::Campaign, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::campaign::creator(arg1) == arg2, 1);
        assert!(0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::campaign::status(arg1) == 1, 2);
        let v0 = 0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::funding_pool::get_balance(arg0);
        assert!(v0 > 0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::funding_pool::extract_all_funds(arg0, arg3), arg2);
        0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::events::emit_fund_released(0x2::object::id<0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::campaign::Campaign>(arg1), v0, arg2);
    }

    public fun release_milestone_funds(arg0: &mut 0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::funding_pool::FundingPool, arg1: &0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::milestone::Milestone, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::milestone::is_completed(arg1), 4);
        let v0 = 0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::milestone::get_amount(arg1);
        assert!(0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::funding_pool::get_balance(arg0) >= v0, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::funding_pool::extract_funds(arg0, v0, arg3), arg2);
        0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::events::emit_fund_released(0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::milestone::get_campaign_id(arg1), v0, arg2);
    }

    public fun settle_campaign(arg0: &mut 0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::funding_pool::FundingPool, arg1: &mut 0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::campaign::Campaign, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::campaign::creator(arg1);
        if (0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::campaign::status(arg1) == 1) {
            release_funds(arg0, arg1, v0, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

