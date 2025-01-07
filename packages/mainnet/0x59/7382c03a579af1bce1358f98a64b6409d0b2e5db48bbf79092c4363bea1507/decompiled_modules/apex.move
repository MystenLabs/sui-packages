module 0x597382c03a579af1bce1358f98a64b6409d0b2e5db48bbf79092c4363bea1507::apex {
    struct APEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: APEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APEX>(arg0, 9, b"APEX", b"APEX", b"Check out my Youtube: @ApexBTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<APEX>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APEX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

