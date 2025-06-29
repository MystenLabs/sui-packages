module 0x9b734c10bfb7911d8e225486d208d22a2fc3e15691b200203bfc43999e5397d3::chan {
    struct CHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAN>(arg0, 6, b"CHAN", b"ChanCan", b"CHAN Vision is generate a thousand happiness through art music meme and game me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih73iauv2m6bx4uluppcohdniff2kygzay42a3mxxrnaae6gcj3ga")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

