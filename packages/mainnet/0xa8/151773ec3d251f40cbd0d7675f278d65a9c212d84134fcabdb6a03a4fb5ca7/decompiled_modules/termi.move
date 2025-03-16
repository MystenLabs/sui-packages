module 0xa8151773ec3d251f40cbd0d7675f278d65a9c212d84134fcabdb6a03a4fb5ca7::termi {
    struct TERMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TERMI>(arg0, 6, b"TERMI", b"TermiAi", b"Welcome to $TERMI, the most powerful and legendary meme coin circulating on the base chain! We are combining robots, memes, and Sui-powered energy into one truly powerful token. From TERMI to Robots, a vast ocean of boats  its all covered.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000072992_98e6615c24.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TERMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TERMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

