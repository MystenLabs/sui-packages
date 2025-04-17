module 0x5acc2c426ef434e15917055715f4769853e5eb4235605ce9fd356b1c16268d48::mmtow {
    struct MMTOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMTOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMTOW>(arg0, 9, b"MMTOW", b"SUI-MEME", b"GOOD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e181e72d1070718b77f9a9f68a3c01aeblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMTOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMTOW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

