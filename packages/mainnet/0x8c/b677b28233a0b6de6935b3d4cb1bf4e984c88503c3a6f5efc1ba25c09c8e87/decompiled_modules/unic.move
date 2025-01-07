module 0x8cb677b28233a0b6de6935b3d4cb1bf4e984c88503c3a6f5efc1ba25c09c8e87::unic {
    struct UNIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNIC>(arg0, 9, b"UNIC", b"Unicorn", b"Unicorn Coin (UNIC) is a cryptocurrency on the Sui Network, designed for fast, secure, and scalable transactions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3320a92a-f3d2-428b-be4f-25969a6bc092.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

