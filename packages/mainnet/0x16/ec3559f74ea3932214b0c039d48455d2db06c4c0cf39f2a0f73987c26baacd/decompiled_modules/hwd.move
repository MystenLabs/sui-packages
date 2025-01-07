module 0x16ec3559f74ea3932214b0c039d48455d2db06c4c0cf39f2a0f73987c26baacd::hwd {
    struct HWD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HWD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HWD>(arg0, 6, b"HWD", b"HALLOWDOG", b"On one Halloween night, a witch was carving a pumpkin. But as she cut, a piece of pumpkin magically transformed into a little dog!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kxg_XL_Qc6_400x400_17a99cbb58.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HWD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HWD>>(v1);
    }

    // decompiled from Move bytecode v6
}

