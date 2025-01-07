module 0x60765bfde74ba0cc36d8237b70007bf49f92187c67d50e39b8b00fb82c30a2fd::fss {
    struct FSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSS>(arg0, 6, b"fss", b"fss", b"erdefcd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FSS>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

