module 0xb994dd454a13e1b7c2939086244b574b677ac4442084e14b6b52f2e9c4af9a06::potatoteam {
    struct POTATOTEAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: POTATOTEAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POTATOTEAM>(arg0, 9, b"POTATOTEAM", b"Potato", x"4e657720616476656e7475726573206f6620706f7461746f65730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ebf02a08-9ecf-4638-ad05-3df5caa62088.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POTATOTEAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POTATOTEAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

