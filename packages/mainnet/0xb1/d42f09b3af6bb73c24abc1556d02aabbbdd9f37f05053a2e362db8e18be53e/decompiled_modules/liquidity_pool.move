module 0xb1d42f09b3af6bb73c24abc1556d02aabbbdd9f37f05053a2e362db8e18be53e::liquidity_pool {
    struct LIQUIDITY_POOL has drop {
        dummy_field: bool,
    }

    struct PoolCap has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<LIQUIDITY_POOL>,
    }

    public entry fun burn(arg0: &mut PoolCap, arg1: 0x2::coin::Coin<LIQUIDITY_POOL>) {
        0x2::coin::burn<LIQUIDITY_POOL>(&mut arg0.treasury_cap, arg1);
    }

    public entry fun mint(arg0: &mut PoolCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LIQUIDITY_POOL>>(0x2::coin::mint<LIQUIDITY_POOL>(&mut arg0.treasury_cap, arg1, arg3), arg2);
    }

    public fun total_supply(arg0: &PoolCap) : u64 {
        0x2::coin::total_supply<LIQUIDITY_POOL>(&arg0.treasury_cap)
    }

    fun init(arg0: LIQUIDITY_POOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIQUIDITY_POOL>(arg0, 9, b"POOL", b"Pool Token", b"Liquidity Pool Token for AMM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/your-token-icon-url")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIQUIDITY_POOL>>(v1);
        let v2 = PoolCap{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::transfer<PoolCap>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

