module 0x37b1d09aae4486c6fae6e15d0e4bd8c12253f3b8b7231f265bef1ab27b40b02b::zorp {
    struct ZORP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZORP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZORP>(arg0, 6, b"ZORP", b"ZORP on Sui", b"The friendly alien for planet solana looking for a friends in Sui ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0854_bfd0a8a3ef.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZORP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZORP>>(v1);
    }

    // decompiled from Move bytecode v6
}

