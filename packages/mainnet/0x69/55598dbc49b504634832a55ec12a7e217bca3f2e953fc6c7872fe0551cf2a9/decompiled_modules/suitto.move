module 0x6955598dbc49b504634832a55ec12a7e217bca3f2e953fc6c7872fe0551cf2a9::suitto {
    struct SUITTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITTO>(arg0, 6, b"SUITTO", b"SUITO", x"53756974746f2077696c6c207472616e73666f726d205375692e204d6f72706820696e746f20746865207472656e6420616e642062656174206a6565746572730a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/x_QX_Bmck_Z_400x400_c36860156b_10a9d7a643.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

