module 0x98b37fd5a78b83ca2821fa528ea0bcdac125ac8584f869c436714ad7f691b42a::airdrop {
    struct AIRDROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIRDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIRDROP>(arg0, 6, b"AIRDROP", b"AIRDROP Daily", b"Get AIRDROP every Activity in Your Daily Income", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ezgif_com_avif_to_jpg_converter_a4534fb373.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIRDROP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIRDROP>>(v1);
    }

    // decompiled from Move bytecode v6
}

