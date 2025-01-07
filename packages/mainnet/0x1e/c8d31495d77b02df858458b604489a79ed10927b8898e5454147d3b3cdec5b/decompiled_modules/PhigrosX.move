module 0x1ec8d31495d77b02df858458b604489a79ed10927b8898e5454147d3b3cdec5b::PhigrosX {
    struct PHIGROSX has drop {
        dummy_field: bool,
    }

    public entry fun getSomeGme(arg0: &mut 0x2::coin::TreasuryCap<PHIGROSX>, arg1: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<PHIGROSX>(arg0, 0x2::token::transfer<PHIGROSX>(0x2::token::mint<PHIGROSX>(arg0, 20, arg1), 0x2::tx_context::sender(arg1), arg1), arg1);
    }

    fun init(arg0: PHIGROSX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHIGROSX>(arg0, 0, b"GME", b"game currency", b"in-game currency", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let (v3, v4) = 0x2::token::new_policy<PHIGROSX>(&mut v2, arg1);
        let v5 = v4;
        let v6 = v3;
        0x2::token::allow<PHIGROSX>(&mut v6, &v5, 0x2::token::spend_action(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<PHIGROSX>>(v2);
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<PHIGROSX>>(v5, 0x2::tx_context::sender(arg1));
        0x2::token::share_policy<PHIGROSX>(v6);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PHIGROSX>>(v1);
    }

    // decompiled from Move bytecode v6
}

