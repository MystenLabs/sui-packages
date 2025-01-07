module 0x63cecc6dabafcd7b1e3c9193f53301c6d230fd547825585b2acd25d4752bc8e9::monty {
    struct MONTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONTY>(arg0, 6, b"MONTY", b"MONTY on SUI", b"MONTY the monkey on fire", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/M_Jf9bvzo_400x400_5baffe014c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

