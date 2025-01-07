module 0x885d8af6c45680f9b6103d9f7594b217e16816fe1e2684bc33f8e692a979de09::suiplug {
    struct SUIPLUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPLUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPLUG>(arg0, 6, b"SUIPLUG", b"Plug on SUI", x"4d6f726520616e64204d6f72652061726520636f6d696e67206f7574206f6620746865200a5472656e63686573200a5468652074696d6520666f7220757320697320736f6f6e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/o_Glptlhh_400x400_cf88b1a00a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPLUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPLUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

