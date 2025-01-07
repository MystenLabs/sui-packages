module 0x62088ec3b3fb6c6388c40e2a808eae41e7ee7521f702fa004701081c68079001::capi {
    struct CAPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPI>(arg0, 9, b"CAPI", b"CAPI", b"CAPI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"CAPI")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CAPI>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

