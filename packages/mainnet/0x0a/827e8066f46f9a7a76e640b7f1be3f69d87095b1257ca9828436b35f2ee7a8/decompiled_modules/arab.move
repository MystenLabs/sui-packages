module 0xa827e8066f46f9a7a76e640b7f1be3f69d87095b1257ca9828436b35f2ee7a8::arab {
    struct ARAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARAB>(arg0, 6, b"ARAB", b"Arab cat", x"4172616220636174206973206120746f6b656e20726570726573656e74696e6720746865206172616269616e20636f6d6d756e69747920696e2063727970746f2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/uq_R4t_Ay_W_400x400_36465dd2c7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

