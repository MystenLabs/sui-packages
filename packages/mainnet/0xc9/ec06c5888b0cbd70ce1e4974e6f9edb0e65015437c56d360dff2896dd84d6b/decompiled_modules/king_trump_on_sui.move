module 0xc9ec06c5888b0cbd70ce1e4974e6f9edb0e65015437c56d360dff2896dd84d6b::king_trump_on_sui {
    struct KING_TRUMP_ON_SUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KING_TRUMP_ON_SUI>, arg1: 0x2::coin::Coin<KING_TRUMP_ON_SUI>) {
        0x2::coin::burn<KING_TRUMP_ON_SUI>(arg0, arg1);
    }

    fun init(arg0: KING_TRUMP_ON_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KING_TRUMP_ON_SUI>(arg0, 9, b"KINGT", b"King Trump on SUI", b"https://t.me/+vELgJwV8a1JkZDFl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1854990604188504064/qO7NxPDJ_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KING_TRUMP_ON_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KING_TRUMP_ON_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KING_TRUMP_ON_SUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KING_TRUMP_ON_SUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

