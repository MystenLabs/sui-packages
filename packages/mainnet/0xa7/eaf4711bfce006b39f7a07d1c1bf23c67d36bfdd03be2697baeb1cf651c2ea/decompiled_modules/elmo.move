module 0xa7eaf4711bfce006b39f7a07d1c1bf23c67d36bfdd03be2697baeb1cf651c2ea::elmo {
    struct ELMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELMO>(arg0, 6, b"ELMO", b"ELMO Sui", b"ELMO is Adeniyi's favorite doll", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004393_cdcdab6831.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

