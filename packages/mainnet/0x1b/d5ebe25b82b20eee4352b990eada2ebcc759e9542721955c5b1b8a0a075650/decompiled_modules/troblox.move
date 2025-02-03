module 0x1bd5ebe25b82b20eee4352b990eada2ebcc759e9542721955c5b1b8a0a075650::troblox {
    struct TROBLOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROBLOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROBLOX>(arg0, 6, b"Troblox", b"Troblox AI", b"TROBLOX is designed to speed up the AI training process, allowing you to get results more quickly than with other models.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2369_72d879cf10.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROBLOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TROBLOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

