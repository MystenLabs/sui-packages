module 0x650268dd0d805ca14081cc3870261ee1a0188f9dbafe3565f7abd3db87eef381::lucky {
    struct LUCKY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LUCKY>, arg1: 0x2::coin::Coin<LUCKY>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LUCKY>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LUCKY>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: LUCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCKY>(arg0, 6, b"Lucky SuI", b"LUCKY", b"LuckySea is a NFT Lootbox platform! Users can unlock treasure chests and have the opportunity to win incredible NFT   https://x.com/luckysui   https://t.me/luckysui_", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dashboard-assets.dappradar.com/document/46519/luckysea-project-gambling-46519-logo-166x166_d2960ff8daf005c1994e556c6650cfc6.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUCKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCKY>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<LUCKY>, arg1: 0x2::coin::Coin<LUCKY>) : u64 {
        0x2::coin::burn<LUCKY>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<LUCKY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LUCKY> {
        0x2::coin::mint<LUCKY>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

