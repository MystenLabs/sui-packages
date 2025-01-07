module 0xd88ec8759404fd32ce00f7180dfe605b1f9c6a1a02b7f7a623f61112c48ef97e::sexsui {
    struct SEXSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEXSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEXSUI>(arg0, 9, b"SEXSUI", b"sexsui ", b"Sexsui is new memecoin in the sui Blockchain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c86255dd-575e-4852-b31b-cb6e9ed1e01b-1000058441.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEXSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEXSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

