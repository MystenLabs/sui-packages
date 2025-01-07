module 0xe2dc8c4a418a9ad8932422f96b4fc2557383643da6f9542036335bb31cefec12::brew {
    struct BREW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BREW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BREW>(arg0, 6, b"BREW", b"Trippie Brew", b"In the heart of the Caribbean lies the enchanting Trippie Island, a haven shrouded in mystery and magic.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/brew_463b567cd8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BREW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BREW>>(v1);
    }

    // decompiled from Move bytecode v6
}

