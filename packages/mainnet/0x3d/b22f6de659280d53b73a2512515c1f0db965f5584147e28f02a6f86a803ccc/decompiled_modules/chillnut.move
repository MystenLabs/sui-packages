module 0x3db22f6de659280d53b73a2512515c1f0db965f5584147e28f02a6f86a803ccc::chillnut {
    struct CHILLNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLNUT>(arg0, 6, b"CHILLNUT", b"CHILLNUT on Sui", b"Whether youre here to chill, hustle, or both, $CHILLNUT offers a space where creativity and community thrive.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4167_dc6e944caf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

