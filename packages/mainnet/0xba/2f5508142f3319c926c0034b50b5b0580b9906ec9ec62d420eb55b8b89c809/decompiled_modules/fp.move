module 0xba2f5508142f3319c926c0034b50b5b0580b9906ec9ec62d420eb55b8b89c809::fp {
    struct FP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FP>(arg0, 9, b"FP", b"Free Pales", b"Free Palestine ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/82b1757e-3480-4b0d-af66-82ebf163af8e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FP>>(v1);
    }

    // decompiled from Move bytecode v6
}

