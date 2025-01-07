module 0x34f0a232a2f8f751368ea88b38db550bbae9270a187ddd1df4cecb7501c6b75c::hack {
    struct HACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HACK>(arg0, 9, b"HACK", b"Hacker", b"Nothing to change", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cdf3a160-dad7-4ff5-94dc-06d74a863e04.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

