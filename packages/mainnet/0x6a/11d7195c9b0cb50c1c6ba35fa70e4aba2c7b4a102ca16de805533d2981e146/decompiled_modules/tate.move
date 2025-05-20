module 0x6a11d7195c9b0cb50c1c6ba35fa70e4aba2c7b4a102ca16de805533d2981e146::tate {
    struct TATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TATE>(arg0, 6, b"Tate", b"Andrew Suitate", b"Andrew Suitate (TATE) is a pure meme coin on the Sui blockchain, inspired by the bald legend Andrew Tate", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigh2hxtbzwzdl5nteuu7useeswf5ciaxmvy4mema32x22e6xget2u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TATE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

