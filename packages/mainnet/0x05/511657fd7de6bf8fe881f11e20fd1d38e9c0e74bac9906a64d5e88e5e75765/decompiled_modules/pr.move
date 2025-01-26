module 0x5511657fd7de6bf8fe881f11e20fd1d38e9c0e74bac9906a64d5e88e5e75765::pr {
    struct PR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PR>(arg0, 6, b"PR", b"PUNK ROCK", b"a meme has to be a meme. trust your instinct or we will throw you a PUNK ROCK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Punk_Rock_8f2dcc5bba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PR>>(v1);
    }

    // decompiled from Move bytecode v6
}

