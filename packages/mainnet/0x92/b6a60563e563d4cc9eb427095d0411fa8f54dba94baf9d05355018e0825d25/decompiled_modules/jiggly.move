module 0x92b6a60563e563d4cc9eb427095d0411fa8f54dba94baf9d05355018e0825d25::jiggly {
    struct JIGGLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIGGLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIGGLY>(arg0, 6, b"Jiggly", b"Moon Jiggly", x"4d6f6f6e204a6967676c792054686520556e6f6666696369616c20506f6bc3a96d6f6e20466f72204d6f6f6e62616773", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihfipe5tlivstbyqbkigot7k45a2mwmoeywgeqlsozyjce4ratktu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIGGLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JIGGLY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

