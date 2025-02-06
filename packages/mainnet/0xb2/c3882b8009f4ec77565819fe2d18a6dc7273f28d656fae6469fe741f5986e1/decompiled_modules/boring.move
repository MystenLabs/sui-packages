module 0xb2c3882b8009f4ec77565819fe2d18a6dc7273f28d656fae6469fe741f5986e1::boring {
    struct BORING has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BORING>(arg0, 9, b"boring", b"boring", b"boring", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"boring")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BORING>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BORING>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BORING>>(v2);
    }

    // decompiled from Move bytecode v6
}

