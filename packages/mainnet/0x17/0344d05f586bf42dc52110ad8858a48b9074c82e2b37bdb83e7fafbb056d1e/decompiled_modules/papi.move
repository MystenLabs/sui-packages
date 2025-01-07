module 0x170344d05f586bf42dc52110ad8858a48b9074c82e2b37bdb83e7fafbb056d1e::papi {
    struct PAPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAPI>(arg0, 9, b"PAPI", b"PAPI GUSTO", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PAPI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAPI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

