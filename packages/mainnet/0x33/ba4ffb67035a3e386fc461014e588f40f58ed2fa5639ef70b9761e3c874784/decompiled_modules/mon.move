module 0x33ba4ffb67035a3e386fc461014e588f40f58ed2fa5639ef70b9761e3c874784::mon {
    struct MON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MON>(arg0, 9, b"MON", b"MONYET", b"Stupid People Like a Monkey", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/acfd5a1d-a70f-466f-804f-791fcafad957.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MON>>(v1);
    }

    // decompiled from Move bytecode v6
}

