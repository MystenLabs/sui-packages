module 0x68c21221e075736c4c14d7bf1c4b1cef98fac338cc0838a3031ddcb9511f95c5::air {
    struct AIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIR>(arg0, 9, b"AIR", b"Airs", b"You must be in air to get air", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6d4d56ec-b628-4dde-8217-0952c209c4f1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIR>>(v1);
    }

    // decompiled from Move bytecode v6
}

