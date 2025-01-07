module 0xa5f6e0503ed58b8ee94b9884ad7e072677e7ee9fa50219d2d009fce592f2e5bc::jamtb_199x {
    struct JAMTB_199X has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAMTB_199X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAMTB_199X>(arg0, 9, b"JAMTB_199X", b"Jamtb", x"f09fa6b4f09fa6b4f09fa6b4", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/de9566c6-5ecf-45b1-a867-b8328340db2f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAMTB_199X>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAMTB_199X>>(v1);
    }

    // decompiled from Move bytecode v6
}

