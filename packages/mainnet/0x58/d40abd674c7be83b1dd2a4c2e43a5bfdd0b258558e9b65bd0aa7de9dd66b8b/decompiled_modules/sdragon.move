module 0x58d40abd674c7be83b1dd2a4c2e43a5bfdd0b258558e9b65bd0aa7de9dd66b8b::sdragon {
    struct SDRAGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDRAGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDRAGON>(arg0, 6, b"Sdragon", b"sdragon", b"the first small sui dragon on the chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020507_5654779bc4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDRAGON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDRAGON>>(v1);
    }

    // decompiled from Move bytecode v6
}

