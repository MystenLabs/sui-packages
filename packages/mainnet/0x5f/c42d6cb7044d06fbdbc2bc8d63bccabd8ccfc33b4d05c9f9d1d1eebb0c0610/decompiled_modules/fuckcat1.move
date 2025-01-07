module 0x5fc42d6cb7044d06fbdbc2bc8d63bccabd8ccfc33b4d05c9f9d1d1eebb0c0610::fuckcat1 {
    struct FUCKCAT1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCKCAT1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCKCAT1>(arg0, 9, b"FUCKCAT1", b"Fuckcat", b"Fuck cat ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1a25caed-4c74-46dd-a2c6-2609e79247c7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKCAT1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUCKCAT1>>(v1);
    }

    // decompiled from Move bytecode v6
}

