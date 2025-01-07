module 0x934d30e20c530288ff0258ff9fcdcd822b7305daa16fed2061e9b898c2990994::cik {
    struct CIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIK>(arg0, 6, b"CIK", b"CASH IS KING", x"2443415348206f6e204150540a44654669206d61786920736561726368696e6720666f7220706f7369746976652073756d206c69717569646974792067616d6573202f2f204c6966652c204c6962657274792c20616e64202443415348", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GL_Db_Fy38_400x400_64f6b5d2d8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

