module 0xe21d52c81ba527b7313938254d1997520ea1ff75e4cf7d8b98b684ea6fa5c1f5::piii {
    struct PIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIII>(arg0, 12, b"piii", b"piii", b"piii", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"piii")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PIII>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIII>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PIII>>(v2);
    }

    // decompiled from Move bytecode v6
}

