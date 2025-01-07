module 0xa00461657a696cefb59f7771261de4e99dd6019a23397fee0cadc906417a06e3::trip {
    struct TRIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRIP>(arg0, 6, b"TRIP", b"Blockchain Boy on Trip", x"4a757374206120426f79206f6e206869732054524950207468726f7567682074686520426c6f636b636861696e732e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/trip_ec1af225a1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

