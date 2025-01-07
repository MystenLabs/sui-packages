module 0x489638862354582e78413be35deaccf3102119e91cea0a167101896187440b05::csmd {
    struct CSMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSMD>(arg0, 6, b"CSMD", b"Cosmocadia", x"546865206e756d626572203120636f6d6d756e6974792d6261736564206661726d696e672067616d65206f6e200a405375696e6574776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/STQCP_Mx_V_400x400_26e3275f20.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSMD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CSMD>>(v1);
    }

    // decompiled from Move bytecode v6
}

