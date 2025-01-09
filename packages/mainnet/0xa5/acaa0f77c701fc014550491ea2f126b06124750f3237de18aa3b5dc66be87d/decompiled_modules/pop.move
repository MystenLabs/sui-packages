module 0xa5acaa0f77c701fc014550491ea2f126b06124750f3237de18aa3b5dc66be87d::pop {
    struct POP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POP>(arg0, 6, b"POP", b"PopIsland", b"First E-Commerce On Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/immagine_3_67b7728860.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POP>>(v1);
    }

    // decompiled from Move bytecode v6
}

