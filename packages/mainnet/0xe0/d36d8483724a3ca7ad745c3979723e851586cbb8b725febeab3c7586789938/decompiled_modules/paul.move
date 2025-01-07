module 0xe0d36d8483724a3ca7ad745c3979723e851586cbb8b725febeab3c7586789938::paul {
    struct PAUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAUL>(arg0, 9, b"PAUL", b"PaulKevin", b"Token Paul ensures secure, fast API management with core functions like Run and Stop. Enhance efficiency now!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/15c81b93-24af-440d-a306-e497100987eb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

