module 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::g_bucks {
    struct G_BUCKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: G_BUCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<G_BUCKS>(arg0, 1, b"GBUCK", b"G-Bucks", b"The one and only universal currency across all of Gamisodes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gamisodes-blockchain-assets.s3.us-west-1.amazonaws.com/1725887082450G-Buck.png")), arg1);
        let v2 = v0;
        let (v3, v4) = 0x2::token::new_policy<G_BUCKS>(&v2, arg1);
        let v5 = v4;
        let v6 = v3;
        0x2::token::allow<G_BUCKS>(&mut v6, &v5, 0x2::token::spend_action(), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<G_BUCKS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<G_BUCKS>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<G_BUCKS>>(v5, 0x2::tx_context::sender(arg1));
        0x2::token::share_policy<G_BUCKS>(v6);
    }

    public fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<G_BUCKS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<G_BUCKS>(arg0, 0x2::token::transfer<G_BUCKS>(0x2::token::mint<G_BUCKS>(arg0, arg1, arg3), arg2, arg3), arg3);
    }

    // decompiled from Move bytecode v6
}

