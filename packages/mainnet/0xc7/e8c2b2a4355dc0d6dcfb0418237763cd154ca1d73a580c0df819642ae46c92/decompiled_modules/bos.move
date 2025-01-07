module 0xc7e8c2b2a4355dc0d6dcfb0418237763cd154ca1d73a580c0df819642ae46c92::bos {
    struct BOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOS>(arg0, 6, b"BOS", b"Book of Sui", b"$BOS (The Book of Sui) Born from the depths of the Sui network, this project blends rich storytelling with the power of decentralized tech. Were on a mission to become the next million-dollar sensation on Sui, merging the excitement of meme culture, decentralized knowledge, and dynamic trading opportunities. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_49_8386d7caf5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

