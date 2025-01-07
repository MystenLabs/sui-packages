module 0x67c103b5a041da233ae2a47302c6f3ebe5b0d33a0c18215c9b47debad9e17c06::smurf {
    struct SMURF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMURF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMURF>(arg0, 9, b"SMURF", b"Smurf ", b"100x now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9172d40c-b23c-414d-bf03-04495ee13169.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMURF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMURF>>(v1);
    }

    // decompiled from Move bytecode v6
}

