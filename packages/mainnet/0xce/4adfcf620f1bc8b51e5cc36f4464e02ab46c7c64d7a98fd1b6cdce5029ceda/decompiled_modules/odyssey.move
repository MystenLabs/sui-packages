module 0xce4adfcf620f1bc8b51e5cc36f4464e02ab46c7c64d7a98fd1b6cdce5029ceda::odyssey {
    struct ODYSSEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ODYSSEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ODYSSEY>(arg0, 6, b"ODYSSEY", b"SUI ODYSSEY", b"LETS FIGHT MEME SUI OCEAN WITH $ODYSSEY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3935_b430ad0cea.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ODYSSEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ODYSSEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

