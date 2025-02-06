module 0x21ee2d2d25f793cdb147317bcb8af20088d91227c3ae6144c8b80c2bbfe4b9e2::minh {
    struct MINH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINH>(arg0, 9, b"Minh", b"Minh", b"string", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"string")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MINH>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINH>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MINH>>(v2);
    }

    // decompiled from Move bytecode v6
}

