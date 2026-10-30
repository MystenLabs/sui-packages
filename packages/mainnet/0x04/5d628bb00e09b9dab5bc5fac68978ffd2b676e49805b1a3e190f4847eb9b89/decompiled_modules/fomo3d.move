module 0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::fomo3d {
    struct FOMO3D has drop {
        dummy_field: bool,
    }

    struct Halving_cycle has store, key {
        id: 0x2::object::UID,
        current: u64,
        remaining: u64,
        halved: u64,
    }

    struct Minter has store, key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<FOMO3D>,
        total_burned: u64,
    }

    struct TokenInitialized has copy, drop {
        minter_id: 0x2::object::ID,
        halving_cycle_id: 0x2::object::ID,
        metadata_id: 0x2::object::ID,
        decimals: u8,
        configured_supply_cap: u64,
    }

    struct MintProcessed has copy, drop {
        minter_id: 0x2::object::ID,
        kind: u8,
        requested_amount: u64,
        actual_minted: u64,
        recipient: 0x1::option::Option<address>,
        minted_coin_id: 0x1::option::Option<0x2::object::ID>,
        reward_divisor: 0x1::option::Option<u64>,
        circulating_supply_after: u64,
        total_burned: u64,
    }

    struct TokensBurned has copy, drop {
        minter_id: 0x2::object::ID,
        amount: u64,
        circulating_supply_after: u64,
        total_burned: u64,
    }

    struct HalvingApplied has copy, drop {
        halving_cycle_id: 0x2::object::ID,
        lifetime_issued: u64,
        old_divisor: u64,
        new_divisor: u64,
        old_threshold: u64,
        new_threshold: u64,
    }

    public entry fun burn(arg0: &mut Minter, arg1: 0x2::coin::Coin<FOMO3D>) {
        let v0 = 0x2::coin::value<FOMO3D>(&arg1);
        arg0.total_burned = arg0.total_burned + v0;
        0x2::coin::burn<FOMO3D>(&mut arg0.cap, arg1);
        let v1 = TokensBurned{
            minter_id                : 0x2::object::id<Minter>(arg0),
            amount                   : v0,
            circulating_supply_after : 0x2::coin::total_supply<FOMO3D>(&arg0.cap),
            total_burned             : arg0.total_burned,
        };
        0x2::event::emit<TokensBurned>(v1);
    }

    public(friend) fun mint(arg0: &mut Minter, arg1: &mut Halving_cycle, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::total_supply<FOMO3D>(&arg0.cap) + arg0.total_burned;
        halved(v0, arg1);
        let v1 = arg2 / arg1.halved;
        if (v0 < 10000000000000000000 && v1 > 0) {
            0x2::coin::mint_and_transfer<FOMO3D>(&mut arg0.cap, v1, 0x2::tx_context::sender(arg3), arg3);
        };
        let v2 = MintProcessed{
            minter_id                : 0x2::object::id<Minter>(arg0),
            kind                     : 0,
            requested_amount         : arg2,
            actual_minted            : 0x2::coin::total_supply<FOMO3D>(&arg0.cap) - 0x2::coin::total_supply<FOMO3D>(&arg0.cap),
            recipient                : 0x1::option::some<address>(0x2::tx_context::sender(arg3)),
            minted_coin_id           : 0x1::option::none<0x2::object::ID>(),
            reward_divisor           : 0x1::option::some<u64>(arg1.halved),
            circulating_supply_after : 0x2::coin::total_supply<FOMO3D>(&arg0.cap),
            total_burned             : arg0.total_burned,
        };
        0x2::event::emit<MintProcessed>(v2);
    }

    fun halved(arg0: u64, arg1: &mut Halving_cycle) {
        if (arg0 >= arg1.remaining && arg1.halved <= 536870912) {
            arg1.halved = arg1.halved * 2;
            arg1.current = 10000000000000000000 - arg1.remaining;
            arg1.remaining = arg1.current / 4 + arg1.remaining;
            let v0 = HalvingApplied{
                halving_cycle_id : 0x2::object::id<Halving_cycle>(arg1),
                lifetime_issued  : arg0,
                old_divisor      : arg1.halved,
                new_divisor      : arg1.halved,
                old_threshold    : arg1.remaining,
                new_threshold    : arg1.remaining,
            };
            0x2::event::emit<HalvingApplied>(v0);
        };
    }

    fun init(arg0: FOMO3D, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 9;
        let (v1, v2) = 0x2::coin::create_currency<FOMO3D>(arg0, v0, b"FOMO3D", b"Fomo3dGameCoin", b"The only way you lose is if you stop playing!Give your memecoin something to market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicpom5zalu3nk5ldxkbiidnx2xu4fiquhjd46edgfv6jl76jytr4u")), arg1);
        let v3 = v2;
        let v4 = Halving_cycle{
            id        : 0x2::object::new(arg1),
            current   : 10000000000000000000,
            remaining : 10000000000000000000 / 4,
            halved    : 1,
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOMO3D>>(v3);
        let v5 = Minter{
            id           : 0x2::object::new(arg1),
            cap          : v1,
            total_burned : 0,
        };
        let v6 = TokenInitialized{
            minter_id             : 0x2::object::id<Minter>(&v5),
            halving_cycle_id      : 0x2::object::id<Halving_cycle>(&v4),
            metadata_id           : 0x2::object::id<0x2::coin::CoinMetadata<FOMO3D>>(&v3),
            decimals              : v0,
            configured_supply_cap : 10000000000000000000,
        };
        0x2::event::emit<TokenInitialized>(v6);
        0x2::transfer::share_object<Minter>(v5);
        0x2::transfer::public_share_object<Halving_cycle>(v4);
    }

    public(friend) fun mint_ico(arg0: &mut Minter, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::total_supply<FOMO3D>(&arg0.cap) + arg0.total_burned < 10000000000000000000 && arg1 > 0) {
            0x2::coin::mint_and_transfer<FOMO3D>(&mut arg0.cap, arg1, 0x2::tx_context::sender(arg2), arg2);
        };
        let v0 = MintProcessed{
            minter_id                : 0x2::object::id<Minter>(arg0),
            kind                     : 1,
            requested_amount         : arg1,
            actual_minted            : 0x2::coin::total_supply<FOMO3D>(&arg0.cap) - 0x2::coin::total_supply<FOMO3D>(&arg0.cap),
            recipient                : 0x1::option::some<address>(0x2::tx_context::sender(arg2)),
            minted_coin_id           : 0x1::option::none<0x2::object::ID>(),
            reward_divisor           : 0x1::option::none<u64>(),
            circulating_supply_after : 0x2::coin::total_supply<FOMO3D>(&arg0.cap),
            total_burned             : arg0.total_burned,
        };
        0x2::event::emit<MintProcessed>(v0);
    }

    public(friend) fun mint_init(arg0: &mut Minter, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<FOMO3D> {
        let v0 = 0x2::coin::mint<FOMO3D>(&mut arg0.cap, arg1, arg2);
        let v1 = MintProcessed{
            minter_id                : 0x2::object::id<Minter>(arg0),
            kind                     : 2,
            requested_amount         : arg1,
            actual_minted            : 0x2::coin::value<FOMO3D>(&v0),
            recipient                : 0x1::option::none<address>(),
            minted_coin_id           : 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::coin::Coin<FOMO3D>>(&v0)),
            reward_divisor           : 0x1::option::none<u64>(),
            circulating_supply_after : 0x2::coin::total_supply<FOMO3D>(&arg0.cap),
            total_burned             : arg0.total_burned,
        };
        0x2::event::emit<MintProcessed>(v1);
        v0
    }

    // decompiled from Move bytecode v7
}

