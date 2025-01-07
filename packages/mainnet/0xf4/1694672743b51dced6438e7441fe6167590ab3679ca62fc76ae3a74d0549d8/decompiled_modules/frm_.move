module 0xf41694672743b51dced6438e7441fe6167590ab3679ca62fc76ae3a74d0549d8::frm_ {
    struct FRM_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRM_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRM_>(arg0, 9, b"FRM_", b"Narayana ", b"It's from one shot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6bb72717-a4e6-4248-bffd-a0a13e447a49.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRM_>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRM_>>(v1);
    }

    // decompiled from Move bytecode v6
}

