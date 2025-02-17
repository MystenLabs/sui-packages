module 0xa44c7714f41a423180ab850c44d82d6c0aa2aa0fcd97f11b14f198092f094bbf::valentine {
    struct VALENTINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VALENTINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VALENTINE>(arg0, 7, b"valentine", b"valentine", b"valentine", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"valentine")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VALENTINE>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VALENTINE>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<VALENTINE>>(v2);
    }

    // decompiled from Move bytecode v6
}

