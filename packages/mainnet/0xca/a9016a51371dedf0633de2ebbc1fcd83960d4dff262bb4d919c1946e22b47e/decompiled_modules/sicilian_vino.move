module 0xcaa9016a51371dedf0633de2ebbc1fcd83960d4dff262bb4d919c1946e22b47e::sicilian_vino {
    struct SicilianVino has store, key {
        id: 0x2::object::UID,
        coin: 0x2::coin::Coin<0x2::sui::SUI>,
        origin_pool: u8,
        minted_at: u64,
        last_moved_at: u64,
        absorption_count: u64,
    }

    struct FractalReserve has key {
        id: 0x2::object::UID,
        total_minted: u64,
        circulating_supply: u64,
        treasury_reserve: u64,
        collateral_locked: u64,
        circulating_pool: 0x2::table::Table<0x2::object::ID, SicilianVino>,
        treasury_pool: 0x2::table::Table<0x2::object::ID, SicilianVino>,
        collateral_pool: 0x2::table::Table<0x2::object::ID, SicilianVino>,
        equilibrium_value: u64,
        last_equilibrium_update: u64,
        ai_governor: address,
        is_paused: bool,
        treasury_cap: 0x2::coin::TreasuryCap<0x2::sui::SUI>,
    }

    struct CoinMinted has copy, drop {
        coin_id: 0x2::object::ID,
        amount: u64,
        pool: u8,
        reason: 0x1::string::String,
        timestamp: u64,
    }

    struct CoinAbsorbed has copy, drop {
        coin_id: 0x2::object::ID,
        from_pool: u8,
        to_pool: u8,
        reason: 0x1::string::String,
        timestamp: u64,
    }

    struct EquilibriumUpdated has copy, drop {
        old_value: u64,
        new_value: u64,
        circulating_supply: u64,
        treasury_reserve: u64,
        timestamp: u64,
    }

    public entry fun absorb_coins(arg0: &mut FractalReserve, arg1: vector<0x2::object::ID>, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.ai_governor, 0);
        assert!(!arg0.is_paused, 3);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&arg1, v2);
            if (0x2::table::contains<0x2::object::ID, SicilianVino>(&arg0.circulating_pool, v3)) {
                let v4 = 0x2::table::remove<0x2::object::ID, SicilianVino>(&mut arg0.circulating_pool, v3);
                v4.origin_pool = 1;
                v4.last_moved_at = v0;
                v4.absorption_count = v4.absorption_count + 1;
                let v5 = 0x2::coin::value<0x2::sui::SUI>(&v4.coin);
                0x2::table::add<0x2::object::ID, SicilianVino>(&mut arg0.treasury_pool, v3, v4);
                arg0.circulating_supply = arg0.circulating_supply - v5;
                arg0.treasury_reserve = arg0.treasury_reserve + v5;
                v1 = v1 + 1;
                let v6 = CoinAbsorbed{
                    coin_id   : v3,
                    from_pool : 0,
                    to_pool   : 1,
                    reason    : arg2,
                    timestamp : v0,
                };
                0x2::event::emit<CoinAbsorbed>(v6);
            };
            v2 = v2 + 1;
        };
        recalculate_equilibrium(arg0, arg3);
    }

    public fun ai_governor(arg0: &FractalReserve) : address {
        arg0.ai_governor
    }

    public entry fun change_governor(arg0: &mut FractalReserve, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.ai_governor, 0);
        arg0.ai_governor = arg1;
    }

    public fun circulating_supply(arg0: &FractalReserve) : u64 {
        arg0.circulating_supply
    }

    public fun equilibrium_value(arg0: &FractalReserve) : u64 {
        arg0.equilibrium_value
    }

    public entry fun initialize_fractal_reserve(arg0: 0x2::coin::TreasuryCap<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v1 = FractalReserve{
            id                      : 0x2::object::new(arg2),
            total_minted            : 1000000000000000,
            circulating_supply      : 0,
            treasury_reserve        : 1000000000000000,
            collateral_locked       : 0,
            circulating_pool        : 0x2::table::new<0x2::object::ID, SicilianVino>(arg2),
            treasury_pool           : 0x2::table::new<0x2::object::ID, SicilianVino>(arg2),
            collateral_pool         : 0x2::table::new<0x2::object::ID, SicilianVino>(arg2),
            equilibrium_value       : 1000000000,
            last_equilibrium_update : v0,
            ai_governor             : arg1,
            is_paused               : false,
            treasury_cap            : arg0,
        };
        let v2 = SicilianVino{
            id               : 0x2::object::new(arg2),
            coin             : 0x2::coin::mint<0x2::sui::SUI>(&mut arg0, 1000000000000000, arg2),
            origin_pool      : 1,
            minted_at        : v0,
            last_moved_at    : v0,
            absorption_count : 0,
        };
        0x2::table::add<0x2::object::ID, SicilianVino>(&mut v1.treasury_pool, 0x2::object::uid_to_inner(&v2.id), v2);
        let v3 = EquilibriumUpdated{
            old_value          : 0,
            new_value          : 1000000000,
            circulating_supply : 0,
            treasury_reserve   : 1000000000000000,
            timestamp          : v0,
        };
        0x2::event::emit<EquilibriumUpdated>(v3);
        0x2::transfer::share_object<FractalReserve>(v1);
    }

    public fun is_paused(arg0: &FractalReserve) : bool {
        arg0.is_paused
    }

    public entry fun mint_on_capital_absorption(arg0: &mut FractalReserve, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.ai_governor, 0);
        assert!(!arg0.is_paused, 3);
        assert!(arg1 == arg2, 2);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = SicilianVino{
            id               : 0x2::object::new(arg4),
            coin             : 0x2::coin::mint<0x2::sui::SUI>(&mut arg0.treasury_cap, arg1, arg4),
            origin_pool      : 1,
            minted_at        : v0,
            last_moved_at    : v0,
            absorption_count : 0,
        };
        let v2 = 0x2::object::uid_to_inner(&v1.id);
        0x2::table::add<0x2::object::ID, SicilianVino>(&mut arg0.treasury_pool, v2, v1);
        arg0.total_minted = arg0.total_minted + arg1;
        arg0.treasury_reserve = arg0.treasury_reserve + arg1;
        let v3 = CoinMinted{
            coin_id   : v2,
            amount    : arg1,
            pool      : 1,
            reason    : 0x1::string::utf8(b"Foreign Capital Absorption"),
            timestamp : v0,
        };
        0x2::event::emit<CoinMinted>(v3);
        recalculate_equilibrium(arg0, arg3);
    }

    public entry fun pause_reserve(arg0: &mut FractalReserve, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.ai_governor, 0);
        arg0.is_paused = true;
    }

    public fun recalculate_equilibrium(arg0: &mut FractalReserve, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = arg0.circulating_supply + arg0.treasury_reserve;
        let v2 = if (v1 > 0) {
            arg0.circulating_supply * 168 / v1
        } else {
            0
        };
        let v3 = if (v2 > 100) {
            arg0.equilibrium_value * 95 / 100
        } else if (v2 < 50) {
            arg0.equilibrium_value * 105 / 100
        } else {
            arg0.equilibrium_value
        };
        arg0.equilibrium_value = v3;
        arg0.last_equilibrium_update = v0;
        let v4 = EquilibriumUpdated{
            old_value          : arg0.equilibrium_value,
            new_value          : v3,
            circulating_supply : arg0.circulating_supply,
            treasury_reserve   : arg0.treasury_reserve,
            timestamp          : v0,
        };
        0x2::event::emit<EquilibriumUpdated>(v4);
    }

    public entry fun release_coins(arg0: &mut FractalReserve, arg1: vector<0x2::object::ID>, arg2: u64, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.ai_governor, 0);
        assert!(!arg0.is_paused, 3);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            let v2 = *0x1::vector::borrow<0x2::object::ID>(&arg1, v1);
            if (0x2::table::contains<0x2::object::ID, SicilianVino>(&arg0.treasury_pool, v2)) {
                let v3 = 0x2::table::remove<0x2::object::ID, SicilianVino>(&mut arg0.treasury_pool, v2);
                let v4 = SicilianVino{
                    id               : 0x2::object::new(arg5),
                    coin             : 0x2::coin::split<0x2::sui::SUI>(&mut v3.coin, arg2, arg5),
                    origin_pool      : 0,
                    minted_at        : v3.minted_at,
                    last_moved_at    : v0,
                    absorption_count : v3.absorption_count,
                };
                v3.last_moved_at = v0;
                0x2::table::add<0x2::object::ID, SicilianVino>(&mut arg0.treasury_pool, v2, v3);
                let v5 = 0x2::object::uid_to_inner(&v4.id);
                0x2::table::add<0x2::object::ID, SicilianVino>(&mut arg0.circulating_pool, v5, v4);
                arg0.circulating_supply = arg0.circulating_supply + arg2;
                arg0.treasury_reserve = arg0.treasury_reserve - arg2;
                let v6 = CoinAbsorbed{
                    coin_id   : v5,
                    from_pool : 1,
                    to_pool   : 0,
                    reason    : arg3,
                    timestamp : v0,
                };
                0x2::event::emit<CoinAbsorbed>(v6);
            };
            v1 = v1 + 1;
        };
        recalculate_equilibrium(arg0, arg4);
    }

    public fun total_minted(arg0: &FractalReserve) : u64 {
        arg0.total_minted
    }

    public fun treasury_reserve(arg0: &FractalReserve) : u64 {
        arg0.treasury_reserve
    }

    public entry fun unpause_reserve(arg0: &mut FractalReserve, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.ai_governor, 0);
        arg0.is_paused = false;
    }

    // decompiled from Move bytecode v6
}

