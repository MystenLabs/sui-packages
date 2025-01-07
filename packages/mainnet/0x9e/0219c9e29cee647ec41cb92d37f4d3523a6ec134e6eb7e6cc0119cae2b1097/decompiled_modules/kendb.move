module 0x9e0219c9e29cee647ec41cb92d37f4d3523a6ec134e6eb7e6cc0119cae2b1097::kendb {
    struct KENDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: KENDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KENDB>(arg0, 9, b"KENDB", b"jebdb", b"hdbe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fb10c8ed-ceb1-4b2a-b564-b3c99dffab43.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KENDB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KENDB>>(v1);
    }

    // decompiled from Move bytecode v6
}

