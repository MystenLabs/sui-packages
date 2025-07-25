module 0xaa4cd6fcccb6ef0332e439de03659c12c2a36e39f20a24823fb22f76240e8eb4::vsui_test {
    struct VSUI_TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: VSUI_TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VSUI_TEST>(arg0, 9, b"VSUI_TEST", b"VSUI Token Test", b"xxx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"xxx")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VSUI_TEST>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VSUI_TEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VSUI_TEST>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

