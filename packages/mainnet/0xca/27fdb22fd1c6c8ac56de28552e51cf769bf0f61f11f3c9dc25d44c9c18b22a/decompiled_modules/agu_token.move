module 0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::agu_token {
    struct AGU_TOKEN has drop {
        dummy_field: bool,
    }

    struct TokenDistributed has copy, drop {
        category: vector<u8>,
        amount: u64,
        recipient: address,
    }

    struct TreasuryCapFrozen has copy, drop {
        total_supply: u64,
        message: vector<u8>,
    }

    public fun alloc_agent_rewards() : u64 {
        300000000000000000
    }

    public fun alloc_core_team() : u64 {
        100000000000000000
    }

    public fun alloc_ecosystem() : u64 {
        150000000000000000
    }

    public fun alloc_liquidity() : u64 {
        50000000000000000
    }

    public fun alloc_partners() : u64 {
        100000000000000000
    }

    public fun alloc_reserve() : u64 {
        100000000000000000
    }

    public fun alloc_staking_pool() : u64 {
        200000000000000000
    }

    fun init(arg0: AGU_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGU_TOKEN>(arg0, 9, b"AGU", b"Agent Governance Unit", b"Native governance and utility token of the AGENTUMI AI Agent marketplace. Fixed supply, zero inflation, DAO-governed treasury, Proof of Agent Work incentives.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicume2wmwjv7sxcb7ljpjwbzeo4gpkbkteqyzkelxoy6wvelxcele")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<AGU_TOKEN>>(0x2::coin::mint<AGU_TOKEN>(&mut v2, 300000000000000000, arg1), @0x82c5b7af8bf85a397db43bea14198eb63968bc5717afad2803675e6991341ef6);
        let v3 = TokenDistributed{
            category  : b"Agent Work Rewards",
            amount    : 300000000000000000,
            recipient : @0x82c5b7af8bf85a397db43bea14198eb63968bc5717afad2803675e6991341ef6,
        };
        0x2::event::emit<TokenDistributed>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<AGU_TOKEN>>(0x2::coin::mint<AGU_TOKEN>(&mut v2, 200000000000000000, arg1), @0x232c3e5664e8158d96f98d8c92dd9e3af64735bd58d0799cbe6fabc0bc7efbb9);
        let v4 = TokenDistributed{
            category  : b"Staking Rewards",
            amount    : 200000000000000000,
            recipient : @0x232c3e5664e8158d96f98d8c92dd9e3af64735bd58d0799cbe6fabc0bc7efbb9,
        };
        0x2::event::emit<TokenDistributed>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<AGU_TOKEN>>(0x2::coin::mint<AGU_TOKEN>(&mut v2, 150000000000000000, arg1), @0x5aa7a83bac1418e98d4b4934f8f255e358ebff8b22a2e9be60ccdb7351ed4e2);
        let v5 = TokenDistributed{
            category  : b"Ecosystem & Development",
            amount    : 150000000000000000,
            recipient : @0x5aa7a83bac1418e98d4b4934f8f255e358ebff8b22a2e9be60ccdb7351ed4e2,
        };
        0x2::event::emit<TokenDistributed>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<AGU_TOKEN>>(0x2::coin::mint<AGU_TOKEN>(&mut v2, 100000000000000000, arg1), @0xac8cc1482247dd22769a2a92b4d6eff65a1b439a77f1f6fcd6e9da7bf7192d02);
        let v6 = TokenDistributed{
            category  : b"Core Team & Advisors",
            amount    : 100000000000000000,
            recipient : @0xac8cc1482247dd22769a2a92b4d6eff65a1b439a77f1f6fcd6e9da7bf7192d02,
        };
        0x2::event::emit<TokenDistributed>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<AGU_TOKEN>>(0x2::coin::mint<AGU_TOKEN>(&mut v2, 100000000000000000, arg1), @0x2a77ac71c8ee2ed94e5e5536794d2bb874f1c43b28a7754e11f653be60ee0ba0);
        let v7 = TokenDistributed{
            category  : b"Strategic Partners",
            amount    : 100000000000000000,
            recipient : @0x2a77ac71c8ee2ed94e5e5536794d2bb874f1c43b28a7754e11f653be60ee0ba0,
        };
        0x2::event::emit<TokenDistributed>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<AGU_TOKEN>>(0x2::coin::mint<AGU_TOKEN>(&mut v2, 100000000000000000, arg1), @0xef83cf69bd9ff39437b7d0b98b33b247b314dda42e755495763c6e150fde49de);
        let v8 = TokenDistributed{
            category  : b"Reserve (DAO)",
            amount    : 100000000000000000,
            recipient : @0xef83cf69bd9ff39437b7d0b98b33b247b314dda42e755495763c6e150fde49de,
        };
        0x2::event::emit<TokenDistributed>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<AGU_TOKEN>>(0x2::coin::mint<AGU_TOKEN>(&mut v2, 50000000000000000, arg1), @0xbdba3c0eae73b358d11e1de80060bf991bf7d6cc7494a995f186f409bce3455c);
        let v9 = TokenDistributed{
            category  : b"Liquidity",
            amount    : 50000000000000000,
            recipient : @0xbdba3c0eae73b358d11e1de80060bf991bf7d6cc7494a995f186f409bce3455c,
        };
        0x2::event::emit<TokenDistributed>(v9);
        let v10 = TreasuryCapFrozen{
            total_supply : 1000000000000000000,
            message      : b"TreasuryCap frozen forever. No additional minting possible.",
        };
        0x2::event::emit<TreasuryCapFrozen>(v10);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AGU_TOKEN>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGU_TOKEN>>(v1);
    }

    public fun total_supply_fixed() : u64 {
        1000000000000000000
    }

    // decompiled from Move bytecode v6
}

