module 0xd9723c225985be2ea08001c5c7f337c1e14e355c26cc12c5f0d8b50a24f0b349::kend {
    struct KEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEND>(arg0, 9, b"KEND", b"jens ", b"ehbe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/41a797cd-56f4-4cfe-b782-723c7ea5e4eb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

