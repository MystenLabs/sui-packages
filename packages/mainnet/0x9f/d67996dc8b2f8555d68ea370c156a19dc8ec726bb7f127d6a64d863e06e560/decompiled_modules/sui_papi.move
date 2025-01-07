module 0x9fd67996dc8b2f8555d68ea370c156a19dc8ec726bb7f127d6a64d863e06e560::sui_papi {
    struct SUI_PAPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_PAPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_PAPI>(arg0, 9, b"SUI PAPI", x"f09f90b65375692050617069", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_PAPI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_PAPI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_PAPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

