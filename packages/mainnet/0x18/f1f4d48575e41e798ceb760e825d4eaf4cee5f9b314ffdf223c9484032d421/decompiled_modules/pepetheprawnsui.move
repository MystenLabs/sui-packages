module 0x18f1f4d48575e41e798ceb760e825d4eaf4cee5f9b314ffdf223c9484032d421::pepetheprawnsui {
    struct PEPETHEPRAWNSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPETHEPRAWNSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPETHEPRAWNSUI>(arg0, 6, b"PepeThePrawnSui", b"PEPE THE KING PRAWN", b"The original Pepe, introduced in 1955 as part of the Muppets, has now united with Sui to reclaim his rightful throne. Behold, the reign of KING Pepe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_6_99eddb0b93.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPETHEPRAWNSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPETHEPRAWNSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

