module 0x5db18efd05331cc25820ed20cfd62c5daf272d2e60af413abe2f1451e8e6a0bb::fafo {
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

