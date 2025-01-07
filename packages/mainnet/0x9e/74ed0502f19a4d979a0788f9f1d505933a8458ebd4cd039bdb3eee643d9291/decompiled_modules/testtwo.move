module 0x9e74ed0502f19a4d979a0788f9f1d505933a8458ebd4cd039bdb3eee643d9291::testtwo {
    struct TESTTWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTTWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTTWO>(arg0, 9, b"TESTTWO", b"TEST2that", b"Test 2.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://drive.google.com/file/d/1STvDNhkQX5JOC7OiFF9hD5hwU-3gmXRI/view?usp=drivesdk")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESTTWO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTTWO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTTWO>>(v1);
    }

    // decompiled from Move bytecode v6
}

