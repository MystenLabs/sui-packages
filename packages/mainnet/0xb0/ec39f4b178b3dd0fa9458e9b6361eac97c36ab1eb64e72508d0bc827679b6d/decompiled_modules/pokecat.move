module 0xb0ec39f4b178b3dd0fa9458e9b6361eac97c36ab1eb64e72508d0bc827679b6d::pokecat {
    struct POKECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKECAT>(arg0, 6, b"PokeCAT", b"Persian", b"Cat Lover", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1730474524414_8da0bb6b5587f2150f41b08e0d61a80827d7229f_ad5f415ef1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POKECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

