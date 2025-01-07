module 0x2fca576d3397bdcbdbeab0ea15f309cd7fbe0453b6b97d4cfa9f64564e985916::pokko {
    struct POKKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKKO>(arg0, 9, b"POKKO", b"MamyPokko", b"The best Brand diapers in the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9c2257df-827c-4b5e-b1b5-06c61de2f08b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POKKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

