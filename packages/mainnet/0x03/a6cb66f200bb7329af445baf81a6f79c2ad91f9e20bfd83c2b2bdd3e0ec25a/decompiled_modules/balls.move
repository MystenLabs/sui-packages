module 0x3a6cb66f200bb7329af445baf81a6f79c2ad91f9e20bfd83c2b2bdd3e0ec25a::balls {
    struct BALLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALLS>(arg0, 6, b"BALLS", b"Ballsac", b"Parody off of GTA V's Stock market BAWSAQ. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ballsac_2a49ed0945.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

