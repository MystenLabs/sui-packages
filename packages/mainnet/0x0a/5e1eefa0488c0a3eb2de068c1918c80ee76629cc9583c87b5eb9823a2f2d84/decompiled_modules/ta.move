module 0xa5e1eefa0488c0a3eb2de068c1918c80ee76629cc9583c87b5eb9823a2f2d84::ta {
    struct TA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TA>(arg0, 6, b"TA", b"yoyo", b"hello", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreighxf5e3m53fw35qudl2tyib5qkgdfxhizffsgtycj3533ie3crhy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

