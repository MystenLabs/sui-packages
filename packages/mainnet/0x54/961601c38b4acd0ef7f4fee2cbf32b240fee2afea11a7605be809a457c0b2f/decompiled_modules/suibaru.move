module 0x54961601c38b4acd0ef7f4fee2cbf32b240fee2afea11a7605be809a457c0b2f::suibaru {
    struct SUIBARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBARU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBARU>(arg0, 6, b"SUIBARU", b"Suibaru WRX", b"Suibaru WRX? Its not just a car; its your good-time buddy on four wheels, ready to tear up the backroads, make some noise, and leave everyone else in the dust, with a bit of that ol' rally spirit thrown in for good measure.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/83d85c14_d803_463c_b52c_1c0999a2c64a_cab06f890d.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBARU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBARU>>(v1);
    }

    // decompiled from Move bytecode v6
}

