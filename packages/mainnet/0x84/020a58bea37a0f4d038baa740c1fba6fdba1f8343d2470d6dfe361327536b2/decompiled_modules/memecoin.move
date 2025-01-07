module 0x84020a58bea37a0f4d038baa740c1fba6fdba1f8343d2470d6dfe361327536b2::memecoin {
    struct MEMECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMECOIN>(arg0, 9, b"MEMECOIN", b"Tung", x"5472c6b0c6a16e672056c4836e2054c3b96e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/699d0710-cfd9-42f2-9953-5efa9e674831.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMECOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMECOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

