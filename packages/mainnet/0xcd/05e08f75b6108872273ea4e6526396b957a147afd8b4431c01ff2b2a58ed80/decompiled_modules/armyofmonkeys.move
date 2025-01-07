module 0xcd05e08f75b6108872273ea4e6526396b957a147afd8b4431c01ff2b2a58ed80::armyofmonkeys {
    struct ARMYOFMONKEYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARMYOFMONKEYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARMYOFMONKEYS>(arg0, 6, b"ArmyOfMonkeys", b"Army Of Monkeys", b"Planet of the monkeys is reatdy to take over sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000006899_f9f5f06136.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARMYOFMONKEYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARMYOFMONKEYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

