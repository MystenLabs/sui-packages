module 0xc6c49ef15a28b91f9481d0f806e7141f73c07fd92d195e7f74ca48682fa37bb2::anal {
    struct ANAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANAL>(arg0, 9, b"anal", b"ape now, analyze later", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUtTniaagqWgPd5D3wF1jdEGkeYYJueqwsj7WBoccyP6B")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ANAL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANAL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

