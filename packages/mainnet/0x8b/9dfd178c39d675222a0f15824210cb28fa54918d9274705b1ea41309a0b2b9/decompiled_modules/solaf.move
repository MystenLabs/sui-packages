module 0x8b9dfd178c39d675222a0f15824210cb28fa54918d9274705b1ea41309a0b2b9::solaf {
    struct SOLAF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLAF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLAF>(arg0, 6, b"SOLAF", b"SOLAF on SUI", b"The Magical Mascot On SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/X6uxwzoz_400x400_8e028d829c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLAF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOLAF>>(v1);
    }

    // decompiled from Move bytecode v6
}

