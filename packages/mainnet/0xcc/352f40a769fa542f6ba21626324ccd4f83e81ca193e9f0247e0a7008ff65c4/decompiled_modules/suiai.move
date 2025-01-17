module 0xcc352f40a769fa542f6ba21626324ccd4f83e81ca193e9f0247e0a7008ff65c4::suiai {
    struct SuiFeeCollectedEvent has copy, drop {
        amount: u64,
        order_id: 0x1::string::String,
    }

    struct SuaiFeeCollectedEvent has copy, drop {
        amount: u64,
        order_id: 0x1::string::String,
    }

    public entry fun pay_fee_suai(arg0: &mut 0xcc352f40a769fa542f6ba21626324ccd4f83e81ca193e9f0247e0a7008ff65c4::fee::FeeObject, arg1: 0x2::coin::Coin<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>(&arg1) >= arg2, 2);
        0x2::balance::join<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>(0xcc352f40a769fa542f6ba21626324ccd4f83e81ca193e9f0247e0a7008ff65c4::fee::get_mut_balance_suiai(arg0), 0x2::coin::into_balance<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>(0x2::coin::split<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>(&mut arg1, arg2, arg4)));
        0xcc352f40a769fa542f6ba21626324ccd4f83e81ca193e9f0247e0a7008ff65c4::utils::send_coin<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>(arg1, 0x2::tx_context::sender(arg4));
        let v0 = SuaiFeeCollectedEvent{
            amount   : arg2,
            order_id : arg3,
        };
        0x2::event::emit<SuaiFeeCollectedEvent>(v0);
    }

    public entry fun pay_fee_sui(arg0: &mut 0xcc352f40a769fa542f6ba21626324ccd4f83e81ca193e9f0247e0a7008ff65c4::fee::FeeObject, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg2, 2);
        0x2::balance::join<0x2::sui::SUI>(0xcc352f40a769fa542f6ba21626324ccd4f83e81ca193e9f0247e0a7008ff65c4::fee::get_mut_balance_sui(arg0), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg2, arg4)));
        0xcc352f40a769fa542f6ba21626324ccd4f83e81ca193e9f0247e0a7008ff65c4::utils::send_coin<0x2::sui::SUI>(arg1, 0x2::tx_context::sender(arg4));
        let v0 = SuiFeeCollectedEvent{
            amount   : arg2,
            order_id : arg3,
        };
        0x2::event::emit<SuiFeeCollectedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

