module 0x68078dd726884e4565930500725716e419c3dd38a78caebada4d5df7d6541a95::meesui {
    struct MEESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEESUI>(arg0, 6, b"MEESUI", b"Mr.Meesuiks", b"Mr.Meesuiks the brother of Mr.Meeseeks from Rick and Morty come in the SUI world.  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mr_1_6e47fb7814.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

