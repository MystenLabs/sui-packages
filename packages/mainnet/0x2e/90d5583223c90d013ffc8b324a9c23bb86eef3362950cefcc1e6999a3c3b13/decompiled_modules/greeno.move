module 0x2e90d5583223c90d013ffc8b324a9c23bb86eef3362950cefcc1e6999a3c3b13::greeno {
    struct GREENO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREENO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREENO>(arg0, 9, b"GREENO", b"Mr. Greeman", b"Greeno is the CEO of green candles, are you green enough to join?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmSEMfngES16ykM6jA4qQYxLqqcSrBSAuSZThk6bmVZBHc")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GREENO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GREENO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREENO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

