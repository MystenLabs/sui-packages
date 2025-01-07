module 0xc0a8760bc6f723f5a702955798d7ddedbcc4e9144e7d31054e953a41115bb1fd::cls {
    struct CLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLS>(arg0, 9, b"CLS", b"CoralShrimp", b"gem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFnS36suwCPUQ2wdefB5AvPLdSDHlIt-F3GPcgu1lHWAbgzUJ6Ux8K0PgNvO55idCTrkM&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CLS>(&mut v2, 200000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

