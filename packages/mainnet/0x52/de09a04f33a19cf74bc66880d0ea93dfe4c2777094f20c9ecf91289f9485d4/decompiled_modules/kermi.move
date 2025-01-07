module 0x52de09a04f33a19cf74bc66880d0ea93dfe4c2777094f20c9ecf91289f9485d4::kermi {
    struct KERMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KERMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KERMI>(arg0, 6, b"KERMI", b"RoboKermi", b"RoboKermi is 50% Robot and 50% PuppetFrog he was made to take over the Sui Netowrk his only purpose is to gather an army for the upcoming battles against his arch nemesis Pepe the Frog Join his army and let him know if he can count on you!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/loh_A_2d69392a9d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KERMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KERMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

