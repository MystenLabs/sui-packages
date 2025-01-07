module 0xebe98c4d71705e87876f96a8c19be504eaca1a88eaeb2a04802de2478f22fd55::pitzospena {
    struct PITZOSPENA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PITZOSPENA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PITZOSPENA>(arg0, 6, b"PITZOSPENA", b"SUIPITZOS", b"KFC CAT :feliz jueves pena(el menu de  hoy son: besitos)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zg3bi2_WUAQK_Pnd_98f15f90ca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PITZOSPENA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PITZOSPENA>>(v1);
    }

    // decompiled from Move bytecode v6
}

