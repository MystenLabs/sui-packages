module 0xa971c7a0c7cf085b272e11370c7576ee756788b990d268bd640aa3ac0c9c1072::taro {
    struct TARO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARO>(arg0, 6, b"TARO", b"Shinjiro", b"Introducing Kabosu's best friend, $TARO. Shinjiro Ono, better known as Maru Taro.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A_Tcuoosa_400x400_8f749b0f1b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TARO>>(v1);
    }

    // decompiled from Move bytecode v6
}

