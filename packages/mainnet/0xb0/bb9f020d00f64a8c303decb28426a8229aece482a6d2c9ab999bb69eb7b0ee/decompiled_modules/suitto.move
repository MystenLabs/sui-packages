module 0xb0bb9f020d00f64a8c303decb28426a8229aece482a6d2c9ab999bb69eb7b0ee::suitto {
    struct SUITTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITTO>(arg0, 6, b"SUITTO", b"SUITO", x"53756974746f2077696c6c207472616e73666f726d205375692e204d6f72706820696e746f20746865207472656e6420616e642062656174206a656574657273200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/x_QX_Bmck_Z_400x400_c36860156b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

