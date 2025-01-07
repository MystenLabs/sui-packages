module 0x44dc700323d153bb69d7797b0c983c9afb95f820e40077842045f4cb1acf510f::trumpsol {
    struct TRUMPSOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPSOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPSOL>(arg0, 9, b"TRUMPSOL", b"TRUMP SOL", b"TRUMP WILL WIN THIS YEAR'S ELECTION, SUPPORT TRUMP WITH TRUMP TOKEN ON THE SOL SYSTEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/88e4e884-3f24-4d4c-a3b2-7b5fe1afc259.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPSOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPSOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

