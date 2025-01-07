module 0xba1d79766955cf2b26cca3f2835ab5fcbf41019a0ce503148e500a9fee73ef15::cowrable {
    struct COWRABLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COWRABLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COWRABLE>(arg0, 9, b"COWRABLE", b"COW", b"Cow was most powerful animals, their milk is very good for health ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b074839f-a8a2-4f22-965f-3b838b0e3cc5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COWRABLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COWRABLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

