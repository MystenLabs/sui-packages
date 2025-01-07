module 0x9df5a3646ae8f566bca7fdb92e6a14f078dc545855457c355b0c3063cbab8179::woofy {
    struct WOOFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOFY>(arg0, 9, b"WOOFY", b"Woof", b"Forever sui, forever Woof! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/74e3cc3d-3ec5-4cf2-9796-003cf210ab97.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOOFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

