module 0x85c1cb565147240d94a9f1101902f1437c19c13af85e185f20e425cdb7456546::suispark_token {
    struct SUISPARK_TOKEN has drop {
        dummy_field: bool,
    }

    struct TreasuryCapHolder has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<SUISPARK_TOKEN>,
    }

    fun init(arg0: SUISPARK_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISPARK_TOKEN>(arg0, 0, b"SPARK", b"SPARK TOKEN", b"Description", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let (v3, v4) = 0x2::token::new_policy<SUISPARK_TOKEN>(&v2, arg1);
        let v5 = v4;
        let v6 = v3;
        0x2::token::allow<SUISPARK_TOKEN>(&mut v6, &v5, 0x2::token::spend_action(), arg1);
        0x2::token::allow<SUISPARK_TOKEN>(&mut v6, &v5, 0x2::token::transfer_action(), arg1);
        let v7 = TreasuryCapHolder{
            id           : 0x2::object::new(arg1),
            treasury_cap : v2,
        };
        0x2::token::share_policy<SUISPARK_TOKEN>(v6);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISPARK_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<SUISPARK_TOKEN>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<TreasuryCapHolder>(v7);
    }

    public(friend) fun reward_user(arg0: &mut TreasuryCapHolder, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<SUISPARK_TOKEN>(&mut arg0.treasury_cap, 0x2::token::transfer<SUISPARK_TOKEN>(0x2::token::mint<SUISPARK_TOKEN>(&mut arg0.treasury_cap, arg1, arg3), arg2, arg3), arg3);
    }

    public fun spend_token_for_ticket(arg0: &mut TreasuryCapHolder, arg1: 0x2::token::Token<SUISPARK_TOKEN>, arg2: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<SUISPARK_TOKEN>(&mut arg0.treasury_cap, 0x2::token::spend<SUISPARK_TOKEN>(arg1, arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

