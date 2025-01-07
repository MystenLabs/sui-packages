module 0x285ee2c1709a11beb716c3500b8a4e95f76e1fb360f18213a48755ad50e08590::effinrate {
    struct EFFINRATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EFFINRATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EFFINRATE>(arg0, 6, b"EFFINRATE", b"Effinrats", b"The Effinrats Token Presale offers an exciting chance for early hodlers to join a Meme Rats Saga decentralized finance project . ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/1727176159444_1e3dd67c1395d064f7f9ed7a05407853_a66e4a2a95.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EFFINRATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EFFINRATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

