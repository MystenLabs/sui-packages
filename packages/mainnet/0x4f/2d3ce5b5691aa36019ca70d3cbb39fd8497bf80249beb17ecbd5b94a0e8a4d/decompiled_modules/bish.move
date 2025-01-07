module 0x4f2d3ce5b5691aa36019ca70d3cbb39fd8497bf80249beb17ecbd5b94a0e8a4d::bish {
    struct BISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BISH>(arg0, 6, b"BISH", b"Burnt Fish", b"It's a fish that has been burned.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_26_bcdf36ffef.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

