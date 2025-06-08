module 0x5b6dd8f2b859d9af79133b828fb19539c80cde287b6850563309c9a95830ac5::justsui {
    struct JUSTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUSTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUSTSUI>(arg0, 6, b"JUSTSUI", b"JUST A SUI TOKEN", b"The only meme coin you will ever need on the Sui blockchain. Just A Sui Token brings pure meme chaos, lightning fast transactions, and low fees.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiamgpfxel3zoh3brbxzn7nupsm3rq57cf7kn5aek4ctvyura7wov4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUSTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JUSTSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

