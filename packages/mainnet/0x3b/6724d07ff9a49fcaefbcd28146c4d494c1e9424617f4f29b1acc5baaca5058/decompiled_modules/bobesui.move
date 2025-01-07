module 0x3b6724d07ff9a49fcaefbcd28146c4d494c1e9424617f4f29b1acc5baaca5058::bobesui {
    struct BOBESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBESUI>(arg0, 6, b"BOBESUI", b"BOBE LAUNCHIBG DAY", b"BOB DOG BOBE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000039432_d44f3eeeb6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

