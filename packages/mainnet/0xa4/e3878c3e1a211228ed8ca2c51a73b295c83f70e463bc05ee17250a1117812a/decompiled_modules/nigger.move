module 0xa4e3878c3e1a211228ed8ca2c51a73b295c83f70e463bc05ee17250a1117812a::nigger {
    struct NIGGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGGER>(arg0, 6, b"NIGGER", b"NIGGERTARDIO", b"Stop being so sensitive my $NIGGER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4077_4a5caccad5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIGGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

