module 0x6b228c3fc6b917ae8bd632df868780af981151734ebe880e3da58df8c3500d0f::mogul_dfs_coin {
    struct MOGUL_DFS_COIN has drop {
        dummy_field: bool,
    }

    struct CoinRegistry has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<MOGUL_DFS_COIN>,
    }

    public(friend) fun burn_token(arg0: &mut CoinRegistry, arg1: 0x2::coin::Coin<MOGUL_DFS_COIN>) {
        0x2::coin::burn<MOGUL_DFS_COIN>(&mut arg0.treasury, arg1);
    }

    public fun get_treasury_value(arg0: &CoinRegistry) : u64 {
        0x2::coin::total_supply<MOGUL_DFS_COIN>(&arg0.treasury)
    }

    fun init(arg0: MOGUL_DFS_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOGUL_DFS_COIN>(arg0, 9, b"MOGUL_DFS", b"MOGUL DFS Coin", b"MOGUL DFS Coin is a coin that is used to play the DFS game.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://a1.moviepassblack.com/prod/mogul-images/brand/mogul.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOGUL_DFS_COIN>>(v1);
        let v2 = CoinRegistry{
            id       : 0x2::object::new(arg1),
            treasury : v0,
        };
        0x2::transfer::share_object<CoinRegistry>(v2);
    }

    public(friend) fun mint_token(arg0: &mut CoinRegistry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MOGUL_DFS_COIN> {
        0x2::coin::mint<MOGUL_DFS_COIN>(&mut arg0.treasury, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

