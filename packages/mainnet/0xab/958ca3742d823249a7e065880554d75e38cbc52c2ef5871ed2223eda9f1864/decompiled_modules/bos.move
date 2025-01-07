module 0xab958ca3742d823249a7e065880554d75e38cbc52c2ef5871ed2223eda9f1864::bos {
    struct BOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOS>(arg0, 6, b"BOS", b"Book of Sui", b"$BOS (The Book of Sui) Born from the depths of the Sui network, this project blends rich storytelling with the power of decentralized tech. Were on a mission to become the next million-dollar sensation on Sui, merging the excitement of meme culture, decentralized knowledge, and dynamic trading opportunities. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_49_825a11905b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

