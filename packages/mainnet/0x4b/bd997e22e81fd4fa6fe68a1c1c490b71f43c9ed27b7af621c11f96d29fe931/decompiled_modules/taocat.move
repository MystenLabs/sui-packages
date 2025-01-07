module 0x4bbd997e22e81fd4fa6fe68a1c1c490b71f43c9ed27b7af621c11f96d29fe931::taocat {
    struct TAOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAOCAT>(arg0, 6, b"TAOCAT", b"TAOCATS", b"TAOCAT | $TAOCAT DECENTRALIZED WORLD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ext_M_Jk5a_400x400_40a1bcb3f1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAOCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAOCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

