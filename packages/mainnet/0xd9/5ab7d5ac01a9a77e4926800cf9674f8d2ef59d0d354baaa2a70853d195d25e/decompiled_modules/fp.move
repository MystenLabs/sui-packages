module 0xd95ab7d5ac01a9a77e4926800cf9674f8d2ef59d0d354baaa2a70853d195d25e::fp {
    struct FP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FP>(arg0, 9, b"FP", b"Free Pales", b"Free Palestine ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a0fe63a7-48d1-4fc2-b707-9c8a4d569c90.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FP>>(v1);
    }

    // decompiled from Move bytecode v6
}

