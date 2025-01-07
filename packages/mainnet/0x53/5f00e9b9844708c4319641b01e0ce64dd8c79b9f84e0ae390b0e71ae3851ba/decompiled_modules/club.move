module 0x535f00e9b9844708c4319641b01e0ce64dd8c79b9f84e0ae390b0e71ae3851ba::club {
    struct CLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLUB>(arg0, 6, b"CLUB", b"27 Club", b"We pay our tribute to the legendary 27 club and the legends that left us to soon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031342_c8c233bb60.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

