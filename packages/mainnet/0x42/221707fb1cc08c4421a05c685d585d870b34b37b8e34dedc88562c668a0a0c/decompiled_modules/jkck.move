module 0x42221707fb1cc08c4421a05c685d585d870b34b37b8e34dedc88562c668a0a0c::jkck {
    struct JKCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JKCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JKCK>(arg0, 9, b"JKCK", b"Hua", b"Jjaj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/811eaf0b-7cb9-496f-a145-a35f05af0f52.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JKCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JKCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

