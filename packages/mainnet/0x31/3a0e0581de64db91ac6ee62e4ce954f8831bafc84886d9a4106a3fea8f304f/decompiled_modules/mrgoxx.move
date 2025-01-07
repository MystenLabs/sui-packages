module 0x313a0e0581de64db91ac6ee62e4ce954f8831bafc84886d9a4106a3fea8f304f::mrgoxx {
    struct MRGOXX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRGOXX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRGOXX>(arg0, 6, b"MRGOXX", b"Mr. Goxx", b"@BuyMrGoxx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/KX_Vo776b_400x400_814e2651ab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRGOXX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRGOXX>>(v1);
    }

    // decompiled from Move bytecode v6
}

