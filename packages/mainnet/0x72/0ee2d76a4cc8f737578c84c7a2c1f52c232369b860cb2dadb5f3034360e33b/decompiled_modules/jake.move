module 0x720ee2d76a4cc8f737578c84c7a2c1f52c232369b860cb2dadb5f3034360e33b::jake {
    struct JAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAKE>(arg0, 6, b"JAKE", b"JAKE THE LIL YETI", x"4a414b45205448452059455449204841532046494e4e414c592041525249564544204f4e2053554920424c4f434b434841494e0a4252494e47494e47204120464c55525259204f462046554e20414e44204d4147494320544f2045564552594f4e452048450a4d454554532e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidisnfrr2lbyjujebgli32pf6gc2laxpjamgee7gjcl7hjmsk5aaa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JAKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

