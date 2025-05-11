module 0x315b8c54a54d4b592c8522cb12a69a09228f0317c61e0462bfab8dea4be6025a::np {
    struct NP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NP>(arg0, 6, b"NP", b"No Pokemon", b"No Pokemon, No Pokemon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeih7mbamitis5uxemwwmf2f6awe47ewyg6gimcv3g3paamzvpwckzy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

