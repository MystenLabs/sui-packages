module 0x1e08f30bbb8cfec5e17f135428fe237fa5b10a6d3785e28753b0a74268ee1ac6::spoofy {
    struct SPOOFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOOFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOOFY>(arg0, 6, b"Spoofy", b"Spotify the Chihuahua", b"Spoofy the scary chihuahua enters Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1891_d2e97dc25f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOOFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPOOFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

