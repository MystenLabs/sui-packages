module 0xb24664de0f55bfacb414b65b6c72e06d7f9e04419cc2e8289f2edcfcd56bf67::peng {
    struct PENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENG>(arg0, 6, b"Peng", b"Penguin", b"About Penguin's MEME Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731207767789.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

