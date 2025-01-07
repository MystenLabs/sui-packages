module 0xad2523522674efe0995a0b4c38989336601dfbd0581b240cc3496795bc1c3000::froggang {
    struct FROGGANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGGANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGGANG>(arg0, 6, b"Froggang", b"Frog gang", b"Splashing into sui then the moon. Tap in .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016817_171a0cc5d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGGANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGGANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

