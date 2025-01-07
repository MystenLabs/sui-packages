module 0xc693299ca005669521cd94c1ed3e048865a3c99187c351ee85f0fa99153ba5af::warcat {
    struct WARCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WARCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARCAT>(arg0, 9, b"WARCAT", b"WOW", b"From another univers to another univers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1c8e9fbc-18b4-4d85-bff8-3b9d6ffe8909.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WARCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

