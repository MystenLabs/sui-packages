module 0x68ac33bc3503ceec41a069ec74ed022a4e45c56ec293628c1d0585a3137df9fb::nerio {
    struct NERIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NERIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NERIO>(arg0, 6, b"NERIO", b"NERIO SUI", x"244e4549524f2e20546865206e657720536869626120496e7520646f672c20737563636573736f7220746f2074686520446f676520646f67206166746572206865722070617373696e672e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/K1b_i2u5_400x400_0b814dfd53.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NERIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NERIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

