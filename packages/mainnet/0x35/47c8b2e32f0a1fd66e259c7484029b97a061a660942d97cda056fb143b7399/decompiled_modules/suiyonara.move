module 0x3547c8b2e32f0a1fd66e259c7484029b97a061a660942d97cda056fb143b7399::suiyonara {
    struct SUIYONARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIYONARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIYONARA>(arg0, 6, b"SUIYONARA", b"AAAAAAAAAA", b"This platform is full of motherfucking RUGSSSSSSSSSSSS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_11_011026_bd3508650e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIYONARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIYONARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

