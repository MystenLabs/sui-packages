module 0x9856d3346d223c6b927de48b7eb0c47c668d433e9a8b96423a36145bb20cf2c1::shuffle {
    struct SHUFFLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUFFLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUFFLE>(arg0, 6, b"Shuffle", b"Trump Shuffle on SUI", b"Let's make the biggest meme coin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/NI_Axps_5bsqgjotn_e6a5f9e999.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUFFLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHUFFLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

