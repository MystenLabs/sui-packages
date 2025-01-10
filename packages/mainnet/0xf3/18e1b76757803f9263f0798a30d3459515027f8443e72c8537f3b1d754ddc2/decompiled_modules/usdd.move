module 0xf318e1b76757803f9263f0798a30d3459515027f8443e72c8537f3b1d754ddc2::usdd {
    struct USDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDD>(arg0, 9, b"USDD", b"USDD", b"SUI USDD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/a1GDua6xLAZXEh-W2o8blz6zbY6UNDCdt-Rno8-kmkA")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USDD>(&mut v2, 900000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDD>>(v2, @0x938ad6b777c14ae479d93e324892153fa4b745a22daf2679bbae14a7c1b427ac);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

