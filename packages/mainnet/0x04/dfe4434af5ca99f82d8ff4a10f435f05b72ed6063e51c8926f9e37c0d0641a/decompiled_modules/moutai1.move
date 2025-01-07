module 0x4dfe4434af5ca99f82d8ff4a10f435f05b72ed6063e51c8926f9e37c0d0641a::moutai1 {
    struct MOUTAI1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOUTAI1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOUTAI1>(arg0, 6, b"MOUTAI1", b"MOUTAI", b"111", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_b42fe0f62e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOUTAI1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOUTAI1>>(v1);
    }

    // decompiled from Move bytecode v6
}

