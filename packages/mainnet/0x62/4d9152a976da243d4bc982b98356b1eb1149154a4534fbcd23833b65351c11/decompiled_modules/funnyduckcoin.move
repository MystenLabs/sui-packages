module 0x624d9152a976da243d4bc982b98356b1eb1149154a4534fbcd23833b65351c11::funnyduckcoin {
    struct FUNNYDUCKCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUNNYDUCKCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUNNYDUCKCOIN>(arg0, 6, b"FunnyDuckCoin", b"FunnyDuck", b"FunnyDuck to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4032_26e671bbee.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUNNYDUCKCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUNNYDUCKCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

