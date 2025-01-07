module 0x414ca15c95add366243a98235b1cb535a4c24adac80906a8944a1344b0286ec7::hopperrab {
    struct HOPPERRAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPERRAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPPERRAB>(arg0, 6, b"HOPPERRAB", b"Hopper the rabbits", x"5468652066617374657374206372656174757265206f6e200a405375696e6574776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hopper_the_rabbits_db4aa6d457.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPPERRAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPPERRAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

