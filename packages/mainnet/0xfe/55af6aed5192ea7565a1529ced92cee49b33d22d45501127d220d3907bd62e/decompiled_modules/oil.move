module 0xfe55af6aed5192ea7565a1529ced92cee49b33d22d45501127d220d3907bd62e::oil {
    struct OIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: OIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OIL>(arg0, 6, b"OIL", b"OilCoin", b"$OIL is a community token on Sui designed to represent energy, momentum, and unstoppable growth. Built around a bold oil-drop logo, the project embraces the symbolism of raw energy fueling markets.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeih5li436bnd3shldw4plg3eyqlq64ascq3ungdz6pqtxyynvls274")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OIL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

