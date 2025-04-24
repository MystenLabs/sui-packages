module 0x772443e0cce4342f6a993efdb15fb0878e17e6437f2a9920c0085cdb7f5e1a64::don {
    struct DON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DON>(arg0, 6, b"Don", b"Donie", b"Born from dreams, stitched with giggles  your snuggly guide through Suiverse.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_a_a_a_a_a_a_a_a_2025_04_24_202556_417678bd83.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DON>>(v1);
    }

    // decompiled from Move bytecode v6
}

