module 0x70cda887b96c78d130a9c32a839cadec139b99caf194063555ab41208436b8b2::suispin {
    struct SUISPIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISPIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISPIN>(arg0, 6, b"SUISPIN", b"Suispin", b"SuiSpin is a revolutionary decentralized casino spin game that brings the thrill of gaming to the cutting edge of blockchain technology. Built on the SUI Network, SuiSpin ensures a fast, secure, and transparent gaming experience, where every spin is backed by the power of decentralized smart contracts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000043378_dee2d26c9c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISPIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISPIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

