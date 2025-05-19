module 0x86af7bfa3e50f47c70e737033b31c58715354202e049b4e80acca1da0a2a2ffd::socks {
    struct SOCKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOCKS>(arg0, 6, b"SOCKS", b"Life Really Socks", b"It started as just a fun idea to bring my quirky sock characters to life is now turning into something bigger. I have poured my heart and a lot of laughs into this, and I am excited to see where it goes. Would love your take on it or even a little shoutout. If you are down, lets make some noise.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidmddbdmmbmqy7qxem5sykfohfniroeblwoceml46ipjjzjrr4lgy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOCKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SOCKS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

