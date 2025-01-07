module 0x81bd0e55b4d3761acdbf0443bffe7e0fd8f4fde70cb5d256e67e877be7b0370c::jelly {
    struct JELLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JELLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JELLY>(arg0, 6, b"JELLY", b"Sui JellyFish", x"244a454c4c59200a54686520637574657374206d656d65636f696e207377696d6d696e67206f6e207468652053756920426c6f636b636861696e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jellyfish_pink_db89a19a65.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JELLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JELLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

