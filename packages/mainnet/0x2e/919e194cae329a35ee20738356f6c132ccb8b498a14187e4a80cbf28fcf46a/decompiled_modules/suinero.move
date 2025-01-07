module 0x2e919e194cae329a35ee20738356f6c132ccb8b498a14187e4a80cbf28fcf46a::suinero {
    struct SUINERO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINERO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINERO>(arg0, 9, b"SUINERO", b"SUINERO", b"dinero", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUINERO>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINERO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINERO>>(v1);
    }

    // decompiled from Move bytecode v6
}

