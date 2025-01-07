module 0x10115edc777fe7758502cbdc4b74a3836973c2f2139648782c41262bb8f7de29::meowdeng {
    struct MEOWDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOWDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOWDENG>(arg0, 6, b"MeowDeng", b"Meow Deng", b"Meow Deng is a hippocatapuss for those wondering", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009503_0efdc10e7c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOWDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOWDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

