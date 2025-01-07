module 0x2a024b62a0acf6e3d72343a9de636a47db7ea1367d0dd0b49a294816cb52442e::starship5 {
    struct STARSHIP5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARSHIP5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARSHIP5>(arg0, 6, b"Starship5", b"Starship", b"Let We Lunch StarShip ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1212_6e1658dc8a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARSHIP5>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STARSHIP5>>(v1);
    }

    // decompiled from Move bytecode v6
}

