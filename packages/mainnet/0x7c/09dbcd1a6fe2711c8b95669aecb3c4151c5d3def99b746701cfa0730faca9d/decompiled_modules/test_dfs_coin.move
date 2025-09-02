module 0x7c09dbcd1a6fe2711c8b95669aecb3c4151c5d3def99b746701cfa0730faca9d::test_dfs_coin {
    struct TEST_DFS_COIN has drop {
        dummy_field: bool,
    }

    struct CoinRegistry has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<TEST_DFS_COIN>,
    }

    public(friend) fun burn_token(arg0: &mut CoinRegistry, arg1: 0x2::coin::Coin<TEST_DFS_COIN>) {
        0x2::coin::burn<TEST_DFS_COIN>(&mut arg0.treasury, arg1);
    }

    public fun get_treasury_value(arg0: &CoinRegistry) : u64 {
        0x2::coin::total_supply<TEST_DFS_COIN>(&arg0.treasury)
    }

    fun init(arg0: TEST_DFS_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_DFS_COIN>(arg0, 9, b"TEST_DFS", b"TEST DFS Coin", b"TEST DFS Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_DFS_COIN>>(v1);
        let v2 = CoinRegistry{
            id       : 0x2::object::new(arg1),
            treasury : v0,
        };
        0x2::transfer::share_object<CoinRegistry>(v2);
    }

    public(friend) fun mint_token(arg0: &mut CoinRegistry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TEST_DFS_COIN> {
        0x2::coin::mint<TEST_DFS_COIN>(&mut arg0.treasury, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

