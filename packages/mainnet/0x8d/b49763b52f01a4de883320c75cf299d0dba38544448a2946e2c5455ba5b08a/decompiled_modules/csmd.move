module 0x8db49763b52f01a4de883320c75cf299d0dba38544448a2946e2c5455ba5b08a::csmd {
    struct CSMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSMD>(arg0, 6, b"CSMD", b"Cosmocadia", x"546865206e756d626572203120636f6d6d756e6974792d6261736564206661726d696e672067616d65206f6e200a405375696e6574776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/STQCP_Mx_V_400x400_143a9e0621.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSMD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CSMD>>(v1);
    }

    // decompiled from Move bytecode v6
}

