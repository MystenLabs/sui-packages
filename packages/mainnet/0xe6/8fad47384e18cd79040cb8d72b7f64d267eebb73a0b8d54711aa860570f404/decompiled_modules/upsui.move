module 0xe68fad47384e18cd79040cb8d72b7f64d267eebb73a0b8d54711aa860570f404::upsui {
    struct UPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UPSUI>(arg0, 9, b"UPSUI", b"Double Up Sui", b"Double Up Staked Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.doubleup.fun/Diamond_Only.png")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UPSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

