module 0x78cbf06706e8417fb99c394b99266b4943addbb5f6b82912382752ef24dfb8de::mirtle {
    struct MIRTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIRTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIRTLE>(arg0, 6, b"Mirtle", b"Mirtle The Turtle", b"Mirtle the King of the sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241006_003826_673_b52a55ca2e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIRTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIRTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

