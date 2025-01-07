module 0x4e1aa6c38aa6ca42d65a96eaf1642665d2709dd88ca21dd21af303a0e54d7227::shl {
    struct SHL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHL>(arg0, 9, b"SHL", b"Shell", b"We are on the same wavelength", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5bc456b3-cf27-402c-9141-07b9168b2f9b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHL>>(v1);
    }

    // decompiled from Move bytecode v6
}

