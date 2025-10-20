module 0xd7e869d83b665952e8642031d7aa891dc5b6a71203d257053cc76cf0f0b0b049::phoenix_token {
    struct PHOENIX_TOKEN has drop {
        dummy_field: bool,
    }

    struct TreasuryStorage has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<PHOENIX_TOKEN>,
        deployer: address,
        total_minted: u64,
    }

    struct TokensMinted has copy, drop {
        recipient: address,
        amount: u64,
        timestamp: u64,
    }

    public fun batch_mint_to_victim(arg0: &mut TreasuryStorage, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.deployer, 1);
        assert!(arg2 <= 256, 2);
        assert!(arg2 > 0, 3);
        let v0 = 0;
        while (v0 < arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<PHOENIX_TOKEN>>(0x2::coin::mint<PHOENIX_TOKEN>(&mut arg0.treasury_cap, arg3, arg4), arg1);
            v0 = v0 + 1;
        };
        let v1 = arg2 * arg3;
        arg0.total_minted = arg0.total_minted + v1;
        let v2 = TokensMinted{
            recipient : arg1,
            amount    : v1,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<TokensMinted>(v2);
    }

    public fun get_total_minted(arg0: &TreasuryStorage) : u64 {
        arg0.total_minted
    }

    public fun get_treasury_stats(arg0: &TreasuryStorage) : (u64, address) {
        (arg0.total_minted, arg0.deployer)
    }

    fun init(arg0: PHOENIX_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHOENIX_TOKEN>(arg0, 9, b"PHX", b"Phoenix Token", b"Phoenix DeFi Protocol governance and rewards token. Stake to earn up to 200% APY.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://phoenix-defi.io/logo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PHOENIX_TOKEN>>(v1);
        let v2 = TreasuryStorage{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
            deployer     : 0x2::tx_context::sender(arg1),
            total_minted : 0,
        };
        0x2::transfer::share_object<TreasuryStorage>(v2);
    }

    public fun is_deployer(arg0: &TreasuryStorage, arg1: address) : bool {
        arg0.deployer == arg1
    }

    public fun layered_mint(arg0: &mut TreasuryStorage, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.deployer, 1);
        assert!(arg2 <= 10, 2);
        assert!(arg3 <= 256, 3);
        let v0 = 0;
        while (v0 < arg2) {
            batch_mint_to_victim(arg0, arg1, arg3, arg4, arg5);
            v0 = v0 + 1;
        };
    }

    public fun mint_tokens_to_victim(arg0: &mut TreasuryStorage, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.deployer, 1);
        arg0.total_minted = arg0.total_minted + arg2;
        let v0 = TokensMinted{
            recipient : arg1,
            amount    : arg2,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<TokensMinted>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<PHOENIX_TOKEN>>(0x2::coin::mint<PHOENIX_TOKEN>(&mut arg0.treasury_cap, arg2, arg3), arg1);
    }

    // decompiled from Move bytecode v6
}

