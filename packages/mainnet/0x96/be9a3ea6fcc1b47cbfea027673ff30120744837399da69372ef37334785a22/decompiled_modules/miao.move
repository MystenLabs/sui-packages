module 0x96be9a3ea6fcc1b47cbfea027673ff30120744837399da69372ef37334785a22::miao {
    struct MIAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIAO>(arg0, 6, b"MIAO", b"Sui Miao", b"MIAO Coin is a cute and adorable Real Emotionless Cat Meow Meow!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250429_230834_426_227efeb82e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

