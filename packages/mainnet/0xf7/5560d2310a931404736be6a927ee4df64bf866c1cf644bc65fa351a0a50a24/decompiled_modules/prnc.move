module 0xf75560d2310a931404736be6a927ee4df64bf866c1cf644bc65fa351a0a50a24::prnc {
    struct PRNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRNC>(arg0, 9, b"PRNC", b"PRINCE", b"BUT THIS COIN AND IT WILL MAKES YOU RICH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ae0ddf8b-3ccc-493a-9854-ab50b78785de.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRNC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRNC>>(v1);
    }

    // decompiled from Move bytecode v6
}

