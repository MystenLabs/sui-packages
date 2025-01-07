module 0x31d6a441a8971867beaf486c33c054fad46e07d9cf01fbafede97f8bad68dc9d::bringo {
    struct BRINGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRINGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRINGO>(arg0, 6, b"Bringo", b"El'BLUERINGO", b"The blue-ringed octopus, despite its small size, carries enough venom to kill 26 adult humans within minutes. Their bites are tiny and often painless, with many victims not realizing they have been envenomated until respiratory depression and paralysis begins. No blue-ringed octopus antivenom is available.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/beautiful_blue_ringed_octopus_1_626c952970.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRINGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRINGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

