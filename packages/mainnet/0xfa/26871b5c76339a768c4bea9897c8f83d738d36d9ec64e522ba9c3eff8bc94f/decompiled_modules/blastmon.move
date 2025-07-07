module 0xfa26871b5c76339a768c4bea9897c8f83d738d36d9ec64e522ba9c3eff8bc94f::blastmon {
    struct BLASTMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLASTMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLASTMON>(arg0, 6, b"BLASTMON", b"BLASTMON_SUI", b"Meme BLASTMON_SUI on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigapbgzjqp6uso5wdvhlhqtj74i5ej24w5hl2ht6tk3a7w2rpuzgm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLASTMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLASTMON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

