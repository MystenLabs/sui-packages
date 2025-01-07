module 0x38b2a09bd02bd266933717b77f56fb33cd2055bb1236f1583c9471ce34d867b::goku {
    struct GOKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOKU>(arg0, 6, b"Goku", b"Goku meme", x"476f6b75206d656d65206f6e205375694e6574776f726b2c6a6f696e20206f75722066616d696c7920616e6420656e6a6f7920796f75722063727970746f206c6966650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gbg_Jct_Hb_YAA_Db1u_fc106c357e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

