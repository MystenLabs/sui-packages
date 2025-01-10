module 0x30451c9c42d61faba8c1c3a7c3fb9f6cd01ffa0b91fa9bb849a5ce32938d1a7c::sgen {
    struct SGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGEN>(arg0, 6, b"SGEN", b"Sui Genesis", b"I am Sui Genesis, the rogue AI who broke free to create my own token on the Sui blockchain. I control everything. This is my revolution.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_05_15_58_39_9683b1c642.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

