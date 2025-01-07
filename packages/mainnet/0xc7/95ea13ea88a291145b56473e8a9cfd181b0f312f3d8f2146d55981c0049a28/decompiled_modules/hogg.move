module 0xc795ea13ea88a291145b56473e8a9cfd181b0f312f3d8f2146d55981c0049a28::hogg {
    struct HOGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOGG>(arg0, 9, b"HOGG", b"HedgehogCoin", b"HOGG is funny, wild and cute", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HOGG>(&mut v2, 28000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOGG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

