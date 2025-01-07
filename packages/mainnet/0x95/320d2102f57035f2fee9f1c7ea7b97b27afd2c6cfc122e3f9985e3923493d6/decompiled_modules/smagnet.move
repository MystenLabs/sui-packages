module 0x95320d2102f57035f2fee9f1c7ea7b97b27afd2c6cfc122e3f9985e3923493d6::smagnet {
    struct SMAGNET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMAGNET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMAGNET>(arg0, 6, b"sMAGNET", b"Magnet On Sui", b"MAGNET coming to SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_Char_c46f571982.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMAGNET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMAGNET>>(v1);
    }

    // decompiled from Move bytecode v6
}

