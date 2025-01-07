module 0xf895071e6dbd610594f43a8430b3f24870dcbeb5379f0d815d903f2163c7c26d::smurf {
    struct SMURF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMURF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMURF>(arg0, 6, b"SMURF", b"SmurfsTurf", x"536d7572667320617265206865726520746f2072756e2074686520747572662e2045697468657220666164652075732c206f72206a6f696e2074686520746f776e20616e64207761746368206173207765206d656c742066616365732e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/531_76a848b228.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMURF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMURF>>(v1);
    }

    // decompiled from Move bytecode v6
}

