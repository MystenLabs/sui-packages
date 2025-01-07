module 0x2cee6efe8b363925ee9177749f0155a006c3f610ac72005fbc6e2ca622844c3d::fwogtober {
    struct FWOGTOBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWOGTOBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWOGTOBER>(arg0, 9, b"FWOGTOBER", b"Sui Fwogtober", b"Fwog on October? Fwogtober", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmaMUueLKcJMEBFzQ5DGM8vwJxfn4kp5x75k7qzkVu1qtS?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FWOGTOBER>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWOGTOBER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWOGTOBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

