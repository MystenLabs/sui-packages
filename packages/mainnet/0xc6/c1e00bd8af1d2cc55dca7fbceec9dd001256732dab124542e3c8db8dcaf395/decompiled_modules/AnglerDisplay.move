module 0xc6c1e00bd8af1d2cc55dca7fbceec9dd001256732dab124542e3c8db8dcaf395::AnglerDisplay {
    struct ANGLERDISPLAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGLERDISPLAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGLERDISPLAY>(arg0, 0, b"COS", b"Angler Display", b"The fishers seek Them... Call not upon Their stare...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Angler_Display.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANGLERDISPLAY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGLERDISPLAY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

