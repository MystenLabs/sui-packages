module 0x7680b576c664baf5d82cef94210792570fb43b33be5f34e9bf44904c6ceea6f::marlin {
    struct MARLIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARLIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARLIN>(arg0, 6, b"Marlin", b"SuiMarlin", b"Marlin is not just a coin, it a movement of memes, madness, and moon missions Join our school and swim to financial freedom!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibuzirrgec4r3trebuankpytmsmldxvzt7nnte7f6zhkhab4cu6qq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARLIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MARLIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

