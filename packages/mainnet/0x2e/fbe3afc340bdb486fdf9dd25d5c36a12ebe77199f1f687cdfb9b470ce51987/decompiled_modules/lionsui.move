module 0x2efbe3afc340bdb486fdf9dd25d5c36a12ebe77199f1f687cdfb9b470ce51987::lionsui {
    struct LIONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIONSUI>(arg0, 6, b"LIONSUI", b"suiliononsui", b"colony of suilions taking over sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suilion_3279516eba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

