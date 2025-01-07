module 0x95d5f0d366ceadc30305ab151acf6cbaee8bd2913e656f601f0a27f6351902c2::suipapi {
    struct SUIPAPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPAPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPAPI>(arg0, 9, b"SUIPAPI", x"f09f90955375692050617069", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIPAPI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPAPI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPAPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

