module 0x5636fa6b3794c9971cdd196053edfa98334c5831849a2efb4568f51fcfd0ee5b::libre_receipt_token {
    struct LIBRE_RECEIPT_TOKEN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<LIBRE_RECEIPT_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<LIBRE_RECEIPT_TOKEN>(arg0, 0x2::token::transfer<LIBRE_RECEIPT_TOKEN>(0x2::token::mint<LIBRE_RECEIPT_TOKEN>(arg0, arg1, arg3), arg2, arg3), arg3);
    }

    public fun burn(arg0: &mut 0x2::token::TokenPolicy<LIBRE_RECEIPT_TOKEN>, arg1: 0x2::token::Token<LIBRE_RECEIPT_TOKEN>, arg2: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0x2::token::confirm_request_mut<LIBRE_RECEIPT_TOKEN>(arg0, 0x2::token::spend<LIBRE_RECEIPT_TOKEN>(arg1, arg2), arg2);
    }

    fun init(arg0: LIBRE_RECEIPT_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIBRE_RECEIPT_TOKEN>(arg0, 0x5636fa6b3794c9971cdd196053edfa98334c5831849a2efb4568f51fcfd0ee5b::config::decimals(), 0x5636fa6b3794c9971cdd196053edfa98334c5831849a2efb4568f51fcfd0ee5b::config::symbol(), 0x5636fa6b3794c9971cdd196053edfa98334c5831849a2efb4568f51fcfd0ee5b::config::name(), 0x5636fa6b3794c9971cdd196053edfa98334c5831849a2efb4568f51fcfd0ee5b::config::description(), 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let (v3, v4) = 0x2::token::new_policy<LIBRE_RECEIPT_TOKEN>(&v2, arg1);
        let v5 = v4;
        let v6 = v3;
        0x2::token::allow<LIBRE_RECEIPT_TOKEN>(&mut v6, &v5, 0x2::token::spend_action(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIBRE_RECEIPT_TOKEN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<LIBRE_RECEIPT_TOKEN>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIBRE_RECEIPT_TOKEN>>(v1);
        0x2::token::share_policy<LIBRE_RECEIPT_TOKEN>(v6);
    }

    // decompiled from Move bytecode v6
}

