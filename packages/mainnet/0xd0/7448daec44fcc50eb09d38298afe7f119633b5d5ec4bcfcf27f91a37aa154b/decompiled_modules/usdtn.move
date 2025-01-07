module 0xd07448daec44fcc50eb09d38298afe7f119633b5d5ec4bcfcf27f91a37aa154b::usdtn {
    struct USDTN has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDTN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDTN>(arg0, 9, b"USDTN", b"ERRORS", b"404", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cb2fa095-d58e-477a-b190-5546530b112c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDTN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDTN>>(v1);
    }

    // decompiled from Move bytecode v6
}

