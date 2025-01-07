module 0xeac377496cc2579ca4bb0422e52093727cd6af3a279176b6257281d0537173b2::eggies {
    struct EGGIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGGIES>(arg0, 9, b"EGGIES", b"Eggi", x"d09fd180d0bed181d182d0be20d0bcd0bed18f20d18fd0b8d187d0bdd0b8d186d0b0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f1c68781-b012-40ee-9b3e-9e0bd8068529.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGGIES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EGGIES>>(v1);
    }

    // decompiled from Move bytecode v6
}

