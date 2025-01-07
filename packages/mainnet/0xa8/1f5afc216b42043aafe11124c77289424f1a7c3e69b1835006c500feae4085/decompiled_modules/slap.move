module 0xa81f5afc216b42043aafe11124c77289424f1a7c3e69b1835006c500feae4085::slap {
    struct SLAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLAP>(arg0, 6, b"Slap", b"SlapSui", b"The slap heard around the crypto world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_16_070357208_9380ec3b8c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

