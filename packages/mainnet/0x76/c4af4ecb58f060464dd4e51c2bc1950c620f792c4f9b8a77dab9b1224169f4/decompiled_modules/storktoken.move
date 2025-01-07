module 0x3cf6e24398c526fd1e0c46e22d4c1f88e3f3c14ba3df6fdaa6dd6d4aab202736::storktoken {
    struct STORKTOKEN has drop {
        dummy_field: bool,
    }

    struct ProtocolTreasury has key {
        id: 0x2::object::UID,
        total_staking_supply: u64,
        total_airdrop_supply: u64,
        staking_supply: 0x2::balance::Balance<STORKTOKEN>,
        airdrop_supply: 0x2::balance::Balance<STORKTOKEN>,
    }

    struct ProtocolCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: STORKTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<STORKTOKEN>(arg0, 9, b"STORK", b"Stork", b"Stork Protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ipfs://bafkreifzywtr5nd23hgaj6foc3s3ushigsyqfinqhh2aryfr4de6gshbya")), arg1);
        let v3 = v1;
        let v4 = ProtocolTreasury{
            id                   : 0x2::object::new(arg1),
            total_staking_supply : 22500000,
            total_airdrop_supply : 2500000,
            staking_supply       : 0x2::coin::mint_balance<STORKTOKEN>(&mut v3, 22500000),
            airdrop_supply       : 0x2::coin::mint_balance<STORKTOKEN>(&mut v3, 2500000),
        };
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STORKTOKEN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STORKTOKEN>>(v3, v0);
        0x2::transfer::share_object<ProtocolTreasury>(v4);
    }

    public fun max_airdrop_supply(arg0: &ProtocolTreasury) : u64 {
        arg0.total_airdrop_supply
    }

    public fun max_staking_supply(arg0: &ProtocolTreasury) : u64 {
        arg0.total_staking_supply
    }

    public fun remaining_airdrop_supply(arg0: &ProtocolTreasury) : u64 {
        0x2::balance::value<STORKTOKEN>(&arg0.airdrop_supply)
    }

    public fun remaining_staking_supply(arg0: &ProtocolTreasury) : u64 {
        0x2::balance::value<STORKTOKEN>(&arg0.staking_supply)
    }

    public(friend) fun withdraw_staking(arg0: &mut ProtocolTreasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<STORKTOKEN> {
        0x2::coin::take<STORKTOKEN>(&mut arg0.staking_supply, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

