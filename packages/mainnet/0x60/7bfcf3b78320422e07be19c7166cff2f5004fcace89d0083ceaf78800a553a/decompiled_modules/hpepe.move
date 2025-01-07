module 0x607bfcf3b78320422e07be19c7166cff2f5004fcace89d0083ceaf78800a553a::hpepe {
    struct HPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HPEPE>(arg0, 6, b"HPEPE", b"Hippie Pepe", b"Hey there!  I'm a free-spirited hippie cruising the Sui blockchain, spreading good vibes and decentralized love.  Here to connect, explore, and share the journey in this groovy Web3 space. Peace, love, and crypto! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_13_19_57_39_7b3e51aed0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

