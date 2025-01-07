module 0x39bd21398f83286276005b1c6361c3692e5a869ddd2cd648d3d6bd6e6f17c0d8::vestor {
    struct VESTOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: VESTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VESTOR>(arg0, 6, b"VESTOR", b"The Vector", b"VECTOR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_18_26_00_c1c73e3882.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VESTOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VESTOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

