module 0xf7d73a6980c853742f3b2eefd126ceda16329af2cf1ac8227b3fc53cdee08f8d::brrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr {
    struct BRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR>(arg0, 6, b"Brrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr", b"Moneyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy", b"Crypto investors when fed cuts rates 'Money go brrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr!'", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/brrrr_3c54ca5338.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR>>(v1);
    }

    // decompiled from Move bytecode v6
}

