module 0xd4f705a7b8f32600255da97ff80e040486111435acb021e91b475d2dd19e6296::sbull {
    struct SBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBULL>(arg0, 6, b"SBULL", b"Sui Bull", x"5765206172652062756c6c697368206f6e20535549206e6574776f726b2c206c657427732070756d7020697420746f6765746865722c20706f757220616c6c20796f75722062756c6c6973686e6573732068657265210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bbull_cc65dd2c30_c8a22e0df6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

