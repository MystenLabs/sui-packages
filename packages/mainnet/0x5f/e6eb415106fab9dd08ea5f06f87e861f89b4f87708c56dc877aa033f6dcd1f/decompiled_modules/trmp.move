module 0x5fe6eb415106fab9dd08ea5f06f87e861f89b4f87708c56dc877aa033f6dcd1f::trmp {
    struct TRMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRMP>(arg0, 9, b"TRMP", b"Tremp", b"Make America flex again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/acc4a698-b730-4e17-8d58-9dd83c88e8f5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

