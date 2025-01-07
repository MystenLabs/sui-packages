module 0x75f2b658d9408524a042272d0d9b949841b70d60b268202feb08bef50cdfa075::TuScanisDeepSeaSprouts {
    struct TUSCANISDEEPSEASPROUTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUSCANISDEEPSEASPROUTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUSCANISDEEPSEASPROUTS>(arg0, 0, b"COS", b"Tu$cani's Deep-Sea Sprouts", b"Beware of the fisher-hand:  dancing lights lead you astray.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Tu$canis_Deep-Sea_Sprouts.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUSCANISDEEPSEASPROUTS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUSCANISDEEPSEASPROUTS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

