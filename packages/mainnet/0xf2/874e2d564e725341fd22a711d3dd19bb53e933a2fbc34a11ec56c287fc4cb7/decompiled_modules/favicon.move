module 0xf2874e2d564e725341fd22a711d3dd19bb53e933a2fbc34a11ec56c287fc4cb7::favicon {
    struct FAVICON has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAVICON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FAVICON>(arg0, 3, b"FAVICON", b"FAVICON", b"FAVICON is a coin for the FAVICON project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://portomasonet.com/favicon.ico")), arg1);
        let v3 = v1;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAVICON>>(v2);
        0x2::coin::mint_and_transfer<FAVICON>(&mut v3, 900000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAVICON>>(v3, v0);
    }

    // decompiled from Move bytecode v6
}

