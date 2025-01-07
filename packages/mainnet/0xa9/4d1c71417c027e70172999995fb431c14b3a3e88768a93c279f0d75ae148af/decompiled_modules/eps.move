module 0xa94d1c71417c027e70172999995fb431c14b3a3e88768a93c279f0d75ae148af::eps {
    struct EPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EPS>(arg0, 9, b"EPS", b"EPSON", b"EPSON for u", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EPS>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EPS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

