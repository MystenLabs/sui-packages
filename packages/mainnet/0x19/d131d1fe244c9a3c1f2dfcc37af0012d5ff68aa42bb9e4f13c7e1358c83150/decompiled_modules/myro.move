module 0x19d131d1fe244c9a3c1f2dfcc37af0012d5ff68aa42bb9e4f13c7e1358c83150::myro {
    struct MYRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYRO>(arg0, 6, b"MYRO", b"Myro on sui", b"The richest dog on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1001668010_82d84348d4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MYRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

