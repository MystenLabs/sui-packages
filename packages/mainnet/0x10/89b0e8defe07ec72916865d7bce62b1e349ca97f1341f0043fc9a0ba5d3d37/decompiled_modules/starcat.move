module 0x1089b0e8defe07ec72916865d7bce62b1e349ca97f1341f0043fc9a0ba5d3d37::starcat {
    struct STARCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARCAT>(arg0, 6, b"StarCat", b"Star Cat", b"First Cat Star Launching On sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_ae_a_20240914004706_673ff326d6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STARCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

