module 0x21e4229be70adef501c4c28be42f391d49cae2b1ee3f008a88d37e6f27a23ca5::nick {
    struct NICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NICK>(arg0, 9, b"NICK", b"NickToken", b"A token for Nick", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NICK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NICK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

