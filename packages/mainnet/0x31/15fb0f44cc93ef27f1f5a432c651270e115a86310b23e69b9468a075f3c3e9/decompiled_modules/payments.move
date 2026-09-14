module 0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::payments {
    struct ChatToppedUp has copy, drop {
        account: address,
        amount: u64,
    }

    struct BoostPaid has copy, drop {
        payer: address,
        curve_id: 0x2::object::ID,
        kind: u8,
        amount: u64,
    }

    public fun pay_boost(arg0: &0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::Config, arg1: &mut 0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::Treasury, arg2: 0x2::object::ID, arg3: u8, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::tx_context::TxContext) {
        0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::assert_version(arg0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        assert!(v0 >= 10000000, 600);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg4);
        0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::deposit_season(arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v1, v0 * 2000 / 10000));
        0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::deposit_platform(arg1, v1);
        let v2 = BoostPaid{
            payer    : 0x2::tx_context::sender(arg5),
            curve_id : arg2,
            kind     : arg3,
            amount   : v0,
        };
        0x2::event::emit<BoostPaid>(v2);
    }

    public fun top_up_chat(arg0: &0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::Config, arg1: &mut 0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::Treasury, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::tx_context::TxContext) {
        0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::assert_version(arg0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 >= 10000000, 600);
        0x3115fb0f44cc93ef27f1f5a432c651270e115a86310b23e69b9468a075f3c3e9::config::deposit_season(arg1, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v1 = ChatToppedUp{
            account : 0x2::tx_context::sender(arg3),
            amount  : v0,
        };
        0x2::event::emit<ChatToppedUp>(v1);
    }

    // decompiled from Move bytecode v7
}

