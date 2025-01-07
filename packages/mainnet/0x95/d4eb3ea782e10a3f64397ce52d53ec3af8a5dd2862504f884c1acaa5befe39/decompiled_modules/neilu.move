module 0x95d4eb3ea782e10a3f64397ce52d53ec3af8a5dd2862504f884c1acaa5befe39::neilu {
    struct NEILU has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEILU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEILU>(arg0, 6, b"NEILU", b"CHINESE NEIRO", x"4e45494c554f20697320666f72204e4549524f0a486f770a50454950454920697320666f722050455045", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6296580665239520047_7d477812a5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEILU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEILU>>(v1);
    }

    // decompiled from Move bytecode v6
}

