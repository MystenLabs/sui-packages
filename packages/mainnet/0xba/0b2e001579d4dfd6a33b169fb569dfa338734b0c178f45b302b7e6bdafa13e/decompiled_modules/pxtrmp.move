module 0xba0b2e001579d4dfd6a33b169fb569dfa338734b0c178f45b302b7e6bdafa13e::pxtrmp {
    struct PXTRMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PXTRMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PXTRMP>(arg0, 6, b"PXTRMP", b"PixelTrump", b"Trump needs your support https://makepxtrmp.pxtrmp.xyz/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fy_Kex6mj_400x400_2cb4a03eff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PXTRMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PXTRMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

