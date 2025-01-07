module 0x70d45a63c847098fda9ef6af609ae6ab821abf8df2ef842713fac01cf7f6b0cc::prt {
    struct PRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRT>(arg0, 9, b"PRT", b"PARROT", b"h1 w0rld", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/05830700-0440-4294-8e29-423eb5e59c3f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

