module 0xe1b6899b973f4b64893174d4e5c6659ed9e693b1d7129d3b170bca8527c8bbd2::POPE {
    struct POPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPE>(arg0, 6, b"POPE", b"trumpope", b"the greatest....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmbtTwKGpuCed4TLBQQGNgZoudq2PgGR37pUJtr6sqFypQ")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

