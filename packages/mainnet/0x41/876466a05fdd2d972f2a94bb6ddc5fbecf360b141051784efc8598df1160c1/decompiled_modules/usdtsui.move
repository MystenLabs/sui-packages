module 0x41876466a05fdd2d972f2a94bb6ddc5fbecf360b141051784efc8598df1160c1::usdtsui {
    struct USDTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDTSUI>(arg0, 9, b"USDTSUI", b"Tether", b"sui now androip", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://allmylinks.com/upload/Link/cover/P/W/e/2Xh-LeXSljGWZCLO1wO5Vua_fWNyYhfm.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USDTSUI>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDTSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

