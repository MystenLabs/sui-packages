module 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi {
    struct LUMI has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        lumi_reserve: 0x2::balance::Balance<LUMI>,
        operations_wallet: address,
        paused: bool,
    }

    struct GenesisCreated has copy, drop {
        total_supply: u64,
        operations_allocation: u64,
        vault_allocation: u64,
        operations_wallet: address,
    }

    struct VaultPaused has copy, drop {
        paused: bool,
    }

    public fun decimals() : u8 {
        2
    }

    fun init(arg0: LUMI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LUMI>(arg0, 2, b"LUMI", b"Liquidity Union", b"Curated liquidity-farm access on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lumiliquidityunion.github.io/lumi/lumi-logo.jpg")), arg1);
        let v3 = v1;
        let v4 = 0x2::coin::mint<LUMI>(&mut v3, 10000000000, arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LUMI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<LUMI>>(0x2::coin::split<LUMI>(&mut v4, 1240000000, arg1), v0);
        let v5 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v5, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUMI>>(v3, @0x0);
        let v6 = Vault{
            id                : 0x2::object::new(arg1),
            lumi_reserve      : 0x2::coin::into_balance<LUMI>(v4),
            operations_wallet : v0,
            paused            : false,
        };
        0x2::transfer::share_object<Vault>(v6);
        let v7 = GenesisCreated{
            total_supply          : 10000000000,
            operations_allocation : 1240000000,
            vault_allocation      : 0x2::coin::value<LUMI>(&v4),
            operations_wallet     : v0,
        };
        0x2::event::emit<GenesisCreated>(v7);
    }

    public fun is_paused(arg0: &Vault) : bool {
        arg0.paused
    }

    public fun operations_allocation() : u64 {
        1240000000
    }

    public fun operations_wallet(arg0: &Vault) : address {
        arg0.operations_wallet
    }

    public fun set_paused(arg0: &mut Vault, arg1: &AdminCap, arg2: bool) {
        arg0.paused = arg2;
        let v0 = VaultPaused{paused: arg2};
        0x2::event::emit<VaultPaused>(v0);
    }

    public fun total_supply() : u64 {
        10000000000
    }

    public fun vault_balance(arg0: &Vault) : u64 {
        0x2::balance::value<LUMI>(&arg0.lumi_reserve)
    }

    public fun withdraw_lumi_reserve(arg0: &mut Vault, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LUMI> {
        assert!(!arg0.paused, 1);
        assert!(arg2 > 0 && arg2 <= 0x2::balance::value<LUMI>(&arg0.lumi_reserve), 2);
        0x2::coin::from_balance<LUMI>(0x2::balance::split<LUMI>(&mut arg0.lumi_reserve, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

