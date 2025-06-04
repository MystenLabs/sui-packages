module 0x109aaf511cbd83ebaf29b7ad50a913deb266ccda41c519ad9ec5957b55fb8342::spup {
    struct SPUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPUP>(arg0, 6, b"SPUP", b"SUIPUPPYS", b"$SPUP represent the resilient, chaotic, and fun-loving energy of the crypto community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihookq7skrq34ikvpaajfkhkfnglhut4z5w7sdcbvcb7smiprixfy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPUP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

