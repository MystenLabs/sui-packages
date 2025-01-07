module 0xf556b723e7875e27152425883460d681f4f70df1fd3a7f80a5595fde0f54e37c::ursuila {
    struct URSUILA has drop {
        dummy_field: bool,
    }

    fun init(arg0: URSUILA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<URSUILA>(arg0, 6, b"URSUILA", b"Ursuila", x"465249444159205448452031335448204953204a5553542054484520424547494e4e494e47202f2f204255524e2031332520494e2044455821210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ok_c7d0b6933f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<URSUILA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<URSUILA>>(v1);
    }

    // decompiled from Move bytecode v6
}

