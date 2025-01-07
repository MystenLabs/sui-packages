module 0x8120491d565ceacf20000e75b0829591ed3c9d2eb1d29c53dbe44947e3b5ae87::fuki {
    struct FUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUKI>(arg0, 6, b"Fuki", b"Fuki Gang", b"Cold vibes on Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/main_character_77a924ecf8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

