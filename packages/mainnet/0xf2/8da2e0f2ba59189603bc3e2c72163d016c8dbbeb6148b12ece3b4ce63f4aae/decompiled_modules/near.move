module 0xf28da2e0f2ba59189603bc3e2c72163d016c8dbbeb6148b12ece3b4ce63f4aae::near {
    struct NEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEAR>(arg0, 12, b"NEAR", b"near", b"NEAR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"NEAR")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NEAR>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEAR>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NEAR>>(v2);
    }

    // decompiled from Move bytecode v6
}

