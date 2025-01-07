module 0xaee8e7a2870bfc378605939dfae824e1dea771cebb4fd1265869a023471fe37c::dig {
    struct DIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIG>(arg0, 6, b"DIG", b"CAN YOU DIG IT", b"DIG IT DIG IT DIG IT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_06_14_14_48_56_559a6a8c8c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

