module 0xcb44b7898e31545dd925ae02e50a3da3a10f71a7a1eb2bb8239ba592885a179a::meepo_coin {
    struct MEEPO_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MEEPO_COIN>, arg1: 0x2::coin::Coin<MEEPO_COIN>) {
        0x2::coin::burn<MEEPO_COIN>(arg0, arg1);
    }

    fun init(arg0: MEEPO_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEEPO_COIN>(arg0, 8, b"Meepo", b"Meepo Hero Coin", b"A coin repsenting the Meepo Heroes of dota2", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEEPO_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEEPO_COIN>>(v1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MEEPO_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MEEPO_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

