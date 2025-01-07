module 0xdb3e9524c744b6923793b4b5b1a5561d0ae535314d08d6e5271991ecb691969c::nigger {
    struct NIGGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGGER>(arg0, 6, b"NIGGER", b"N Word Pass", b"A notional pass giving permission for a nonblack person to say the words nigga or nigger without being perceived as racist.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_01_59_40_2f48966228.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIGGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

