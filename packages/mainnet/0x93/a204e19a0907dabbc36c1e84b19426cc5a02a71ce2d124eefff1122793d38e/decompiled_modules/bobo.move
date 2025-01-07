module 0x93a204e19a0907dabbc36c1e84b19426cc5a02a71ce2d124eefff1122793d38e::bobo {
    struct BOBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBO>(arg0, 9, b"BOBO", b"Bobo", x"424f424f2045534341504544204d4158494d554d20e2808b42554c4c2052554e205345435552495459", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co/9GcvjzW/1.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOBO>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOBO>(&mut v2, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBO>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

