module 0xcb4d2ae1c9daa04d42dc61f6c12bd7c1034b71dbd7888c6cec9b05d5ca035a56::shiroshim {
    struct SHIROSHIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIROSHIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIROSHIM>(arg0, 9, b"Shiroshim", b"Shiro-shimagatsuo", b"Shiro-shimagatsuo teru", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dribbble.com/users/135467/screenshots/15538881/media/7175e7aa6560a9756881e3e7aaebc01b.gif")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHIROSHIM>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIROSHIM>>(v2, @0x3e6f93f81e9cc2660e8eb52283f5c8c06c04abc6920ffa99bd849d3da0ddccee);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIROSHIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

