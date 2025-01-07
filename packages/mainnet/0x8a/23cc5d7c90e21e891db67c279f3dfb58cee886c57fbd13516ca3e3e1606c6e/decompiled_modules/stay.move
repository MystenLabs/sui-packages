module 0x8a23cc5d7c90e21e891db67c279f3dfb58cee886c57fbd13516ca3e3e1606c6e::stay {
    struct STAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAY>(arg0, 9, b"STAY", b"STAY", b"Something majestic)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSn3lCenvQEmSAOdzvZGM6JyDBSN8KprXVpMw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STAY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

