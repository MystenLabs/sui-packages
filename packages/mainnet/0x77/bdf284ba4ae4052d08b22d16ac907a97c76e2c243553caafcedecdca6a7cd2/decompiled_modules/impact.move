module 0x77bdf284ba4ae4052d08b22d16ac907a97c76e2c243553caafcedecdca6a7cd2::impact {
    struct IMPACT has drop {
        dummy_field: bool,
    }

    fun init(arg0: IMPACT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IMPACT>(arg0, 6, b"IMPACT", b"Impact Coin", b" Impact Coin: Crypto for Real-World Change  Impact Coin is a charity-driven cryptocurrency where the community decides how to make a difference!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/23452345_f37cf61e18.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IMPACT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IMPACT>>(v1);
    }

    // decompiled from Move bytecode v6
}

