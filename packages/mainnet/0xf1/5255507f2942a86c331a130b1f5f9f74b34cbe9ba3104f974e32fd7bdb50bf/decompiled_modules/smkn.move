module 0xf15255507f2942a86c331a130b1f5f9f74b34cbe9ba3104f974e32fd7bdb50bf::smkn {
    struct SMKN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMKN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMKN>(arg0, 6, b"SMKN", b"SMOKIN CAT", x"534d4f4b494e204341543a20412043524541544956450a464f524345204154204c45414b4520535452454554", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigwdj3mfjqjesyum4eheb4unni4q66ekekwqnpkjrki5ceyph4ila")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMKN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SMKN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

