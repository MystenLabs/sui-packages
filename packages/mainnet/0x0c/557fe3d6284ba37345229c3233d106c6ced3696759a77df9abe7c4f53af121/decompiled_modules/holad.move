module 0xc557fe3d6284ba37345229c3233d106c6ced3696759a77df9abe7c4f53af121::holad {
    struct HOLAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLAD>(arg0, 6, b"HOLAD", b"asdasdq", b"sdqweqwe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sisi_2ce36530c0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOLAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

