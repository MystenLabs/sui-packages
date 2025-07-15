module 0x535afb9bf5fc65dc16bde45b2e2db069d9739c3a9ee063a80883ec43e76b89e1::tsts {
    struct TSTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSTS>(arg0, 6, b"TSTS", b"Test", b"Just test feature", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibnqia3dvbvfcyj2ipx4uzbg465my7ca5fy7ijbs5uzfp54e75xli")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TSTS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

