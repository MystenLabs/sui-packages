module 0x143a6fde6f1c0e1076f564b2d6de63618a8386f89acef772356bc1a54effcef8::jiggly {
    struct JIGGLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIGGLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIGGLY>(arg0, 6, b"JIGGLY", b"MOON JIGGLY", x"4d6f6f6e204a6967676c790a54686520556e6f6666696369616c20506f6bc3a96d6f6e20466f72204d6f6f6e62616773", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihfipe5tlivstbyqbkigot7k45a2mwmoeywgeqlsozyjce4ratktu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIGGLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JIGGLY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

