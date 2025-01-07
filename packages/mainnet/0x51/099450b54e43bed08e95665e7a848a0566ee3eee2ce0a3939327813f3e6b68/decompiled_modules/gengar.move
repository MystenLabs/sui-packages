module 0x51099450b54e43bed08e95665e7a848a0566ee3eee2ce0a3939327813f3e6b68::gengar {
    struct GENGAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENGAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENGAR>(arg0, 6, b"GENGAR", b"Gengar", b"The scariest pokemon has hit the sui market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Engar_33e5e3b47c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENGAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GENGAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

