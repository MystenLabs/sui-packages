module 0x33260bafb80ee578841376475659f96997d71fa829a1d9a7dfcc637501cdab4c::pino {
    struct PINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINO>(arg0, 6, b"PINO", b"PINO ON SUI", x"4d6565742050494e4f2120596f7572206661766f726974652064696e6f73617572206f6e205355492e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pino_8ca6542746.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

