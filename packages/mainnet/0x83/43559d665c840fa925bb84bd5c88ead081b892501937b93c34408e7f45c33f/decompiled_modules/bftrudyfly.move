module 0x8343559d665c840fa925bb84bd5c88ead081b892501937b93c34408e7f45c33f::bftrudyfly {
    struct BFTRUDYFLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFTRUDYFLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BFTRUDYFLY>(arg0, 9, b"BFTRUDYFLY", b"flying", b"butterfly on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dba21484-a9c9-40eb-878a-8e18fa6bd31f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BFTRUDYFLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BFTRUDYFLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

