module 0xd3d6dee65e1a68d05ab6e8b84f8f38ceef9dbc67b7bd2f9334f73d9ac213b38f::sudi {
    struct SUDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUDI>(arg0, 6, b"Sudi", b"Suidi", x"536175646920636f696e20666f7220636f696e200a6561636820302e3125", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731496935377.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUDI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUDI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

