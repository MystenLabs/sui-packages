module 0x683b0325e09f826dc8e5e79d7932194c0b6b81319f7a329aee107cf9cad0defb::zowie {
    struct ZOWIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOWIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOWIE>(arg0, 6, b"Zowie", b"Zowie on Sui", x"496e2074686520657468657265616c207265616c6d20776865726520696d6167696e6174696f6e2074616b657320666c696768742c20616d696473742074686520746f776572696e67207065616b73206f6620696379206d6f756e7461696e732cc2a05a4f5749452077617320626f726e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif4baqjhsk6jfzuna6bye6epkbhmengtfkulnxfa54h7c7iqjda2a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOWIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZOWIE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

