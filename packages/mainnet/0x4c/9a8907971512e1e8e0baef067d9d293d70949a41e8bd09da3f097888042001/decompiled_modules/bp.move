module 0x4c9a8907971512e1e8e0baef067d9d293d70949a41e8bd09da3f097888042001::bp {
    struct BP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BP>(arg0, 6, b"BP", b"Biggest Project", b"I want to test how Move Pump Works", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_biggest_construction_project_world_1200x750_25cbd57093.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BP>>(v1);
    }

    // decompiled from Move bytecode v6
}

