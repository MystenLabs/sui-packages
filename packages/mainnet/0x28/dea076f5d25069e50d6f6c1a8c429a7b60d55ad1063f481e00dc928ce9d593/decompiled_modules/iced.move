module 0x28dea076f5d25069e50d6f6c1a8c429a7b60d55ad1063f481e00dc928ce9d593::iced {
    struct ICED has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICED>(arg0, 6, b"ICED", b"Iced The penguin", b"ICED is that penguin, always by your side, bringing luck, fun, and just the right amount of degen energy to every adventure on the blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000070584_d19450ed80.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ICED>>(v1);
    }

    // decompiled from Move bytecode v6
}

