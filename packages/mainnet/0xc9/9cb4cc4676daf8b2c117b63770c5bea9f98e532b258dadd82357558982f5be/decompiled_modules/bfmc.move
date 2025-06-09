module 0xc99cb4cc4676daf8b2c117b63770c5bea9f98e532b258dadd82357558982f5be::bfmc {
    struct BFMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BFMC>(arg0, 6, b"BFMC", b"Bored Fish Marine Club", x"576865726520626f72656420666973682073757266207468652053554920776176650a776974686f757420612064726f70206f66206578636974656d656e7421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicfs6b2jwp3pnd2rd7rdyf7qypywlqudqygmvyvipczu3jcmuoceq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BFMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BFMC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

