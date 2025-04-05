module 0x4e37bdff04dc591fd9da5fd7b536e4b56bfb15d1c72af315676b44de93063d13::azukie {
    struct AZUKIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZUKIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AZUKIE>(arg0, 6, b"AZUKIE", b"AZUKIE", b"AZUKI E", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreichtvjemx6iazqrune7tx3mirxmzyf34klbtefpye27xe5w2ioky4")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AZUKIE>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AZUKIE>>(v2, @0x273f3ecbdd48cb2c627609409e0d990ffb3c2adc26c3888b02784198c6fd275a);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AZUKIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

