module 0xd5f241ec62c0e193a9d93d4b683ce71648a26a0a1259a83f83b59971fcff7b71::usdtc {
    struct USDTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDTC>(arg0, 9, b"USDTc", b"USDTc", b"A project for MIGs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USDTC>(&mut v2, 5728913000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDTC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

