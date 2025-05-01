module 0xee9b51e206427db6500a7e9efc1ebd44d44aedd791c74533614ebb10225f506b::lol {
    struct LOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOL>(arg0, 6, b"LOL", b"LOL Token", b"LOL Fake", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid36uhwrftnvsbllqxmk6ucvrt7styzuqlymaqtxj5w5l4tibz2z4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

