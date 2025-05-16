module 0x1ea073f9d93ab021f9533aecb1ea818e59b9c4e8d99940377d3c37b6cfefb3c1::schu {
    struct SCHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCHU>(arg0, 6, b"Schu", b"Shibachu", x"466972737420646567656e20706f6b656d6f6e206d656d652e2e206120636f6c6c6162206265747765656e2074686520322062696767657374206e61727261746976657320696e206f6e6520636f696e200a0a48756765", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifc6kin6mgluriyiysljdqgj5en7uut54fvvmhmn6kspqmsyyxm2y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SCHU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

