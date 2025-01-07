module 0x7c991b1fc056424e34c86f1637662fee3c5e4a02121d54b80361be811f0ab700::gods {
    struct GODS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODS>(arg0, 6, b"GODS", b"The Super Gods", b"For the love of gods", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_f_OF_8_RU_23_R_GZ_2_N1jw_SJJ_5w_26e7ca4efd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GODS>>(v1);
    }

    // decompiled from Move bytecode v6
}

