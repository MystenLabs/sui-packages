module 0x3b6866030ce35c648e4255b0274ca519b2c18ca742a7dcd920301b5b9380ea99::mjsui3 {
    struct MJSUI3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MJSUI3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MJSUI3>(arg0, 9, b"MJSUI3", b"mjSUI3", b"Creating MJSUI3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/image.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MJSUI3>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MJSUI3>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

