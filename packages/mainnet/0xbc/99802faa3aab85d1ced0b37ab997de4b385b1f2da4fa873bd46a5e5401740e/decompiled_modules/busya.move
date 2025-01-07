module 0xbc99802faa3aab85d1ced0b37ab997de4b385b1f2da4fa873bd46a5e5401740e::busya {
    struct BUSYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUSYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUSYA>(arg0, 6, b"BUSYA", b"BUSYA CAT", b"MEOW MEEEOW ! MEOW MEOW MEEOOW ! MEOOOOOW ! MEOW MEOW ! MEEEEEEOW MEEEEEEOW ! MEOW MEOW !MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEEEOW ! MEOW MEOW MEEOOW ! MEOOOOOW ! MEOW MEOW ! MEEEEEEOW MEEEEEEOW ! MEOW MEOW !MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEEEOW ! MEOW MEOW MEEOOW ! MEOOOOOW ! MEOW MEOW ! MEEEEEEOW MEEEEEEOW ! MEOW MEOW !MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW MEOW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/132_d9af33772e.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUSYA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUSYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

