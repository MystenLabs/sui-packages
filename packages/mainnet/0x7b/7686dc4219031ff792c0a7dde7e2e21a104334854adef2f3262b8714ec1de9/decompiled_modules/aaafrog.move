module 0x7b7686dc4219031ff792c0a7dde7e2e21a104334854adef2f3262b8714ec1de9::aaafrog {
    struct AAAFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAFROG>(arg0, 6, b"Aaafrog", b"AAAFROG", x"41616166726f67203f3f0a4c657473206265617420416161436174", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_2024_10_06_T124540_448_0fb0053d5c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

