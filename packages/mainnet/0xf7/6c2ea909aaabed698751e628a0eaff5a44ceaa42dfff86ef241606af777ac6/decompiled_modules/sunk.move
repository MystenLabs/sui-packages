module 0xf76c2ea909aaabed698751e628a0eaff5a44ceaa42dfff86ef241606af777ac6::sunk {
    struct SUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNK>(arg0, 6, b"SUNK", b"SUI Sunk", b"It's like BONK but on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sunk_564aa00e67.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

