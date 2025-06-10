module 0x30401b53aa7ce5fc1b7f351ea0091cd7e6e97a5ae630bc323d3662b3b61ff9ff::pb {
    struct PB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PB>(arg0, 6, b"PB", b"Biggest Project", b"i want to test move pump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_biggest_construction_project_world_1200x750_e193a26d85.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PB>>(v1);
    }

    // decompiled from Move bytecode v6
}

