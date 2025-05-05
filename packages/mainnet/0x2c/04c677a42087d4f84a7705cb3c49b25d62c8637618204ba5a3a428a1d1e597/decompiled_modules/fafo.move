module 0x2c04c677a42087d4f84a7705cb3c49b25d62c8637618204ba5a3a428a1d1e597::fafo {
    struct FAFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAFO>(arg0, 6, b"FAFO", b"Fed Agency for Fin Oversight", b"Fed Agency for Fin Oversight.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWGinse11SPCUDcDKHPqqYngSXfuwpkxKqobscVUxzqF1")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAFO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAFO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

