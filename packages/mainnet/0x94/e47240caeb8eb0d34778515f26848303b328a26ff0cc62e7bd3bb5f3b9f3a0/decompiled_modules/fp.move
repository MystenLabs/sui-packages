module 0x94e47240caeb8eb0d34778515f26848303b328a26ff0cc62e7bd3bb5f3b9f3a0::fp {
    struct FP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FP>(arg0, 9, b"FP", b"Free Pales", b"Palestine", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8a63f3a5-94b7-46d4-ac02-c59a1cb73dcc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FP>>(v1);
    }

    // decompiled from Move bytecode v6
}

