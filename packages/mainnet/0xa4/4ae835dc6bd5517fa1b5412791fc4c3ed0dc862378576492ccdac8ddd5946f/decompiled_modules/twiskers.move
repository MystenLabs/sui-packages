module 0xa44ae835dc6bd5517fa1b5412791fc4c3ed0dc862378576492ccdac8ddd5946f::twiskers {
    struct TWISKERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWISKERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWISKERS>(arg0, 6, b"TWISKERS", b"First Twiskers on Sui", b"The Fiercerst Meme Token on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/flag_7623672a22.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWISKERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWISKERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

