module 0xd721cef0d4ee79f64feaa9be906766bbb01f26ae710d7c1336e07ed69ac4fc31::lambo {
    struct LAMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMBO>(arg0, 6, b"LAMBO", b"LamboSuini", x"4c616d626f737569206973206120636f6d6d756e6974792d64726976656e205355492d626173656420746f6b656e2074686174206d6572676573207468652069636f6e69632073796d626f6c206f662063727970746f2063756c7475726520e2809420746865204c616d626f726768696e6920e28094207769746820666f72776172642d6c6f6f6b696e67205765623320746563686e6f6c6f67792e204974e2809973206d61646520666f722074686f73652077686f206e6f206c6f6e6765722061736b20e2809c57656e204c616d626f3fe2809d206275742072617468657220e2809c446f20796f7520616c7265616479206f776e204c616d626f7375693fe2809d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748863060188.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAMBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMBO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

