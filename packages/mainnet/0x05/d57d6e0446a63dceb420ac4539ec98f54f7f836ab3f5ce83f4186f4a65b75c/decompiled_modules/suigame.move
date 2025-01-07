module 0x5d57d6e0446a63dceb420ac4539ec98f54f7f836ab3f5ce83f4186f4a65b75c::suigame {
    struct SUIGAME has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIGAME>, arg1: 0x2::coin::Coin<SUIGAME>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIGAME>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIGAME>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: SUIGAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGAME>(arg0, 6, b"SuiGame", b"GAME", b"the greatest films of recent years.  https://t.me/gamee ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dashboard-assets.dappradar.com/document/49412/gamee-project-games-49412-logo-166x166_5886a5eae5ecf9134d016dd11dfa8d3b.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIGAME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGAME>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<SUIGAME>, arg1: 0x2::coin::Coin<SUIGAME>) : u64 {
        0x2::coin::burn<SUIGAME>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<SUIGAME>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SUIGAME> {
        0x2::coin::mint<SUIGAME>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

