module 0xfd50a11f91e1d54076e45c5acca1723504aba32372e1e8020d40c734a31825c8::WAIFU {
    struct WAIFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAIFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAIFU>(arg0, 6, b"Waifu me", b"WAIFU", b"let me be your waifu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w3s.link/ipfs/bafkreiec44z2d322ncgfp7pqv5o4pw7wvyfova4g3lx3i5gneccozxdlzq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAIFU>>(v0, @0xbdebc33436425c9a7ca66a3b35925621c8885d16b3c741b9ca39527620462511);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAIFU>>(v1);
    }

    // decompiled from Move bytecode v6
}

