module 0x86ee0872b6e51b61488f605af6a763d504a70615393f6ca9aa58342c505c2b60::initial {
    struct INITIAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: INITIAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INITIAL>(arg0, 9, b"INITIAL", b"swat", b"My initial name is S Wa T ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3c23227c-9373-4f37-a6cf-9956878052de.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INITIAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INITIAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

