module 0x3f82a4b9b9d68bf6e6beeccf0619b345f1b1583c6df7fc0488cbf19a5b115052::ronda {
    struct RONDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RONDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RONDA>(arg0, 6, b"Ronda", b"RondaOnSui", b"$Ronda On Sui on the Road to Bigger and Better Things! Never Looking Back!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/11jpg_a4088efeab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RONDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RONDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

