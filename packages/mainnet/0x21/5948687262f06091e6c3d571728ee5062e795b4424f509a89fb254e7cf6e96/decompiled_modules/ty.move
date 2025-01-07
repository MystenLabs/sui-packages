module 0x215948687262f06091e6c3d571728ee5062e795b4424f509a89fb254e7cf6e96::ty {
    struct TY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TY>(arg0, 9, b"TY", b"Hi", b"Gd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d66b4ed-2a57-43d8-93d6-c303b0cf3245.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TY>>(v1);
    }

    // decompiled from Move bytecode v6
}

