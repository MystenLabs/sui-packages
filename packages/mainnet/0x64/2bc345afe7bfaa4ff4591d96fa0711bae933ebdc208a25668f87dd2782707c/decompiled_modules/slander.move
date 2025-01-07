module 0x642bc345afe7bfaa4ff4591d96fa0711bae933ebdc208a25668f87dd2782707c::slander {
    struct SLANDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLANDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLANDER>(arg0, 9, b"SLANDER", b"Suilander", x"4c616e6465722066616d696c79206973206172726976696e6720746f20535549206e6574776f726b2e2e2e6d656574c2a027656dc2a0616c6c21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/45e9913eaf6e38ba573a948d26930dfcblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLANDER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLANDER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

