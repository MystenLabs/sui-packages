module 0x9c6ab343088fe40772fd5e1901f40845cfb898b8bf79eab7b9b96f847332537d::guanguan {
    struct GUANGUAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUANGUAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUANGUAN>(arg0, 6, b"Guanguan", b"GuanYinCoin", b"To celebrate Guan Yin Mecw Mecw  birth in world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1d9edc9d9ebfd7d8416441a6835280e_1aa9bdb035.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUANGUAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUANGUAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

