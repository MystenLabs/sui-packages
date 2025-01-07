module 0x4b1fe2099000c18f0e0f4e3864a122b93b6865dac5773159bb68eb604a7ca321::baaa {
    struct BAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAAA>(arg0, 9, b"BAAA", b"BAAA", b"Official token of boo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.wikia.nocookie.net/diceblock/images/d/da/600px-BooNSMBWii-1-.png/revision/latest/scale-to-width-down/250?cb=20181109170546")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BAAA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAAA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

