module 0x5e8d0c7d7e26e6a7c4ff8aad932f072143c94a86648e352b12eba1522b0fb97a::aaadodo {
    struct AAADODO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAADODO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAADODO>(arg0, 6, b"AAADODO", b"aaaDODO", b"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaDODO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_01_36_58_5a34087baa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAADODO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAADODO>>(v1);
    }

    // decompiled from Move bytecode v6
}

