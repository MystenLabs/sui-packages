module 0xcc95341b0340c4f7eebf7594dbf3a4db097cc75498fad9b1e7bd2ef54e09e6b1::dcm {
    struct DCM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DCM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCM>(arg0, 6, b"DCM", b"Ducky City Earn Token", x"57656c636f6d6520746f204475636b79436974792c2077686572652066616e74617379206d65657473207265616c6974792e0a496d6d6572736520796f757273656c6620696e2074686973207265766f6c7574696f6e617279202364617070207468617420636f6d62696e65732047616d6566692c204d657461766572736520616e6420536f6369616c66692e0a436f6e6e65637420626f756e646c6573736c792c206561726e20656e646c6573736c792c20616e64206d616b6520746865207669727475616c20776f726c6420796f7572206f79737465722120204a6f696e207573206e6f77206f6e207468697320696e6372656469626c65206a6f75726e657921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ducky_1ebce672dd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DCM>>(v1);
    }

    // decompiled from Move bytecode v6
}

