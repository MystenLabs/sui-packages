module 0x7a2b7da5b6d3d242fffecc4067ca40afebb233bbf7ac482b67ae54ac02bb5b8b::ffff {
    struct FFFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFFF>(arg0, 9, b"FFFF", b"Tcyvbh", b"Fhdvjf ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/efb8aa29-0b6d-447b-a347-8d78df1e9e44.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FFFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

