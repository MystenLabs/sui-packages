module 0xc7aa0f7ab9cbba21de35edd6100f19a47876d78a14574e02042e6c0b724cc6fb::binky {
    struct BINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BINKY>(arg0, 6, b"BINKY", b"BUY BINKY", b"BUY BINKY!!!!!! RETARDER!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sticker_218c899eec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BINKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BINKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

