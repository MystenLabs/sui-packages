module 0x86c9cb7aa6fae34a2ac29ef4318c7134036fa2142b4090d21c22471e6f84c2a4::mse {
    struct MSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSE>(arg0, 9, b"MSE", b"Memes", b"Me Me Me Me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5594055b-2537-4e8d-bc88-07329b707f37.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

