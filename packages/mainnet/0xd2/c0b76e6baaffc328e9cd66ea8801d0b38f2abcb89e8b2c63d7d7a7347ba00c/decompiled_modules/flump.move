module 0xd2c0b76e6baaffc328e9cd66ea8801d0b38f2abcb89e8b2c63d7d7a7347ba00c::flump {
    struct FLUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUMP>(arg0, 6, b"FLUMP", b"FLUMPY", b"Flumpy is a simple purple creature meme character with a cute face n big round eyes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibiysdfclgdnfgk2uimxtbrvsdy2upr47wo2yzcmpqohbb5jrjcae")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FLUMP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

