module 0x710426ace1413778a0f9397da260e33685209187231e6f81213c9a077ec1ebcc::pumpe {
    struct PUMPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPE>(arg0, 6, b"PUMPE", b"Trumpe Pumpe", x"57656c636f6d6520746f20746865205472756d70652050756d70650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/V_Mdrc_La_P_400x400_6449d6c9c8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

