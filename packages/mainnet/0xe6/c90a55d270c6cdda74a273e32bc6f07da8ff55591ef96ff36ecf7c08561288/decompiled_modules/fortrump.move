module 0xe6c90a55d270c6cdda74a273e32bc6f07da8ff55591ef96ff36ecf7c08561288::fortrump {
    struct FORTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORTRUMP>(arg0, 6, b"ForTrump", b"Trump", b"Trump win", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6109_887a0bfe03.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FORTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

