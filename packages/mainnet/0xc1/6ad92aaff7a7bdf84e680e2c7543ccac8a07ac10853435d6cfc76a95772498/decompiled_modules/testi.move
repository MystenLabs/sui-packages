module 0xc16ad92aaff7a7bdf84e680e2c7543ccac8a07ac10853435d6cfc76a95772498::testi {
    struct TESTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTI>(arg0, 9, b"TESTI", b"TESTI", b"TESTIO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESTI>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

