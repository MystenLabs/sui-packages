module 0xf9db2ff9d2b2f0a2acc1583376b0e953b292a14b1637c2b61edc60df63d148be::state {
    struct STATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STATE>(arg0, 6, b"STATE", b"State AI Agent", b"A leading financial services provider serving some of the worlds most sophisticated institutions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_Z6se_Sss_400x400_1_b493bbb8a3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

