module 0x8cd477da1ebc560d04d32ae8039c0676992a8c59f4dbd555a25f2cc8f394ffc9::srl {
    struct SRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRL>(arg0, 6, b"SRL", b"Suirrel", b"Charged with meme power, Suirrel rules the Sui scene", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rell_79db753fd1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

