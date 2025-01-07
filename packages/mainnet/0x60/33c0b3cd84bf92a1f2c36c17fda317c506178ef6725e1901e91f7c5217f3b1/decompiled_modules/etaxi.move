module 0x6033c0b3cd84bf92a1f2c36c17fda317c506178ef6725e1901e91f7c5217f3b1::etaxi {
    struct ETAXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETAXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETAXI>(arg0, 6, b"ETAXI", b"RoboTaxi Elon", b"Musk's new groundbreaking plan centers around the development of Robotaxis", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6021587721891464723_1_ba8415d6f5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETAXI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETAXI>>(v1);
    }

    // decompiled from Move bytecode v6
}

