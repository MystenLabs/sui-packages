module 0x7b888393d6a552819bb0a7f878183abaf04550bfb9546b20ea586d338210826f::moon {
    struct MOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOON>(arg0, 6, b"MOON", b"Moonbag", x"497420646f65736e277420676574206d7563682073696d706c6572207468616e20746869732e0a0a477261622061206d6f6f6e62616720616e6420686f646c2069742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih7pl4sccgj22drcjfpuposdhxvsjvsi3us3rrdctoohabeaytzk4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

