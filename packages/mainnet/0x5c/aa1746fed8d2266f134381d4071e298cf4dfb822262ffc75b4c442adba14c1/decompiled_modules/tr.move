module 0x5caa1746fed8d2266f134381d4071e298cf4dfb822262ffc75b4c442adba14c1::tr {
    struct TR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TR>(arg0, 9, b"TR", b"Trumpi", b"TRUMPI DIG BIG LOL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3316dbaf-cb3b-4f50-87bd-277505f6ccf6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TR>>(v1);
    }

    // decompiled from Move bytecode v6
}

