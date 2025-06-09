module 0x38a5dd0a576b6d792a3bff6ff30f8294cc96ada856601c3e88e62d5173a60194::bfmc {
    struct BFMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BFMC>(arg0, 6, b"BFMC", b"Bored Fish Marine Club", x"576865726520626f7265642066697368207269646520746865205355492077617665200a776974686f757420612064726f70206f66206578636974656d656e74212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicfs6b2jwp3pnd2rd7rdyf7qypywlqudqygmvyvipczu3jcmuoceq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BFMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BFMC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

