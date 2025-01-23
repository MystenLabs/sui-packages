module 0x69e5bb961fef402fc81333fa34e0484851487bbe34fd367dada0cb42f95b8662::papa {
    struct PAPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAPA>(arg0, 1, b"PAPA", b"PAPAAA", b"Risk or Lose", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/9f2cb1d0-d98c-11ef-80e8-811f7f414973")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAPA>>(v1);
        0x2::coin::mint_and_transfer<PAPA>(&mut v2, 11000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAPA>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

