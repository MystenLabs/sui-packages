module 0x69ca79d286d3600fc560a168908591ab855c7a53c5a79e7d86cb3ae56bdc5340::monster {
    struct MONSTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONSTER>(arg0, 6, b"MONSTER", b"MONSTERSUI", b"Monster of the Sui network MONSTERUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000197634_434d21bf22.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONSTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONSTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

