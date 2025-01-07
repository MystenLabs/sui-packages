module 0xc4686c11ce5bb0c626075b31de4e853f674686c205ba7a41d270075c61149e64::myro {
    struct MYRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYRO>(arg0, 6, b"MYRO", b"SuiMyro", b"MYRO on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000390_1f0f1b6f90.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MYRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

