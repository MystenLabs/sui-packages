module 0xb2ebf20dd86363915cffe752da772ab4e38163a174822021bea2b1120981ff3e::mr {
    struct MR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MR>(arg0, 6, b"MR", b"MoleRat", b"MoleRat is a community-driven meme coin inspired by the social nature of the humble mole rat. Operating on the cutting-edge Sui blockchain, MR combines meme culture's fun and viral potential. Join the underground movement and dig in with MoleRat!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731005136582.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

