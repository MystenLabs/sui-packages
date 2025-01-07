module 0x3ecec2f80a770774c632125e48c330e500b59ebde2a9d447acbc2175172deb1f::zolt {
    struct ZOLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOLT>(arg0, 9, b"ZOLT", b"ZOLT", b"ZOLT LIKE A DIAMOND", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fuseproject.com/wp-content/uploads/2015/11/Zolt_7_case_study_2x_3360x1270-1600x604.96350364964-c-default.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ZOLT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOLT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZOLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

