module 0x732ce6fd07519ba4c2698168c46482e95199891f4f810d896ad0dfc3d9e294d8::heist {
    struct HEIST has drop {
        dummy_field: bool,
    }

    struct Session has store, key {
        id: 0x2::object::UID,
        active: bool,
        paused: bool,
        wins_claimed: vector<bool>,
        vault: 0x2::balance::Balance<HEIST>,
        treasury: address,
        authority: address,
        treasury_fee_bps: u64,
        draw_count: u8,
        last_number: u8,
        drawn_numbers: vector<u8>,
        bankrupt_count: u8,
    }

    struct Device has store, key {
        id: 0x2::object::UID,
        session_id: 0x2::object::ID,
        device_index: u8,
        grid: vector<vector<u8>>,
    }

    struct Vesting has store, key {
        id: 0x2::object::UID,
        beneficiary: address,
        total_locked: u64,
        claimed: u64,
        start_ms: u64,
        duration_ms: u64,
        vault: 0x2::balance::Balance<HEIST>,
    }

    struct AirdropPool has store, key {
        id: 0x2::object::UID,
        authority: address,
        remaining: u64,
        vault: 0x2::balance::Balance<HEIST>,
    }

    struct SessionRegistry has store, key {
        id: 0x2::object::UID,
        authority: address,
        treasury: address,
        current_session_id: 0x2::object::ID,
        paused: bool,
        pause_end_ms: u64,
    }

    struct HeistAdmin has store, key {
        id: 0x2::object::UID,
        authority: address,
        treasury_cap: 0x2::coin::TreasuryCap<HEIST>,
        prices: 0x2::table::Table<0x1::type_name::TypeName, u64>,
    }

    struct SessionCreated has copy, drop {
        session_id: 0x2::object::ID,
        authority: address,
        treasury: address,
        treasury_fee_bps: u64,
    }

    struct DeviceMinted has copy, drop {
        session_id: 0x2::object::ID,
        device_index: u8,
        owner: address,
        amount_paid: u64,
        payment_value: u64,
        discounted: bool,
        coin: 0x1::string::String,
        treasury_fee: u64,
        vault_added: u64,
        grid: vector<u8>,
    }

    struct WinClaimed has copy, drop {
        session_id: 0x2::object::ID,
        win_type: u8,
        num_winners: u64,
        total_payout: u64,
        bps: u64,
    }

    struct NumberDrawn has copy, drop {
        session_id: 0x2::object::ID,
        number: u8,
        draw_count: u8,
        remaining: u8,
    }

    struct HeistMinted has copy, drop {
        amount: u64,
        to: address,
    }

    struct HeistBurned has copy, drop {
        amount: u64,
    }

    struct VestedReleased has copy, drop {
        amount: u64,
        to: address,
    }

    struct AirdropClaimed has copy, drop {
        amount: u64,
        to: address,
        remaining: u64,
    }

    public fun advance_session(arg0: &mut SessionRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.authority, 9);
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 7) {
            0x1::vector::push_back<bool>(&mut v0, false);
            v1 = v1 + 1;
        };
        let v2 = Session{
            id               : 0x2::object::new(arg1),
            active           : true,
            paused           : false,
            wins_claimed     : v0,
            vault            : 0x2::balance::zero<HEIST>(),
            treasury         : arg0.treasury,
            authority        : arg0.authority,
            treasury_fee_bps : 100,
            draw_count       : 0,
            last_number      : 0,
            drawn_numbers    : b"",
            bankrupt_count   : 0,
        };
        let v3 = 0x2::object::id<Session>(&v2);
        0x2::transfer::share_object<Session>(v2);
        arg0.current_session_id = v3;
        let v4 = SessionCreated{
            session_id       : v3,
            authority        : arg0.authority,
            treasury         : arg0.treasury,
            treasury_fee_bps : 100,
        };
        0x2::event::emit<SessionCreated>(v4);
    }

    public fun burn_heist(arg0: &mut 0x2::coin::TreasuryCap<HEIST>, arg1: 0x2::coin::Coin<HEIST>) {
        let v0 = HeistBurned{amount: 0x2::coin::burn<HEIST>(arg0, arg1)};
        0x2::event::emit<HeistBurned>(v0);
    }

    public fun claim_airdrop(arg0: &mut AirdropPool, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.authority, 9);
        assert!(arg1 <= arg0.remaining, 15);
        arg0.remaining = arg0.remaining - arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<HEIST>>(0x2::coin::take<HEIST>(&mut arg0.vault, arg1, arg3), arg2);
        let v0 = AirdropClaimed{
            amount    : arg1,
            to        : arg2,
            remaining : arg0.remaining,
        };
        0x2::event::emit<AirdropClaimed>(v0);
    }

    public fun claim_vested(arg0: &mut Vesting, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg1);
        let v1 = if (v0 > arg0.start_ms) {
            v0 - arg0.start_ms
        } else {
            0
        };
        let v2 = if (v1 >= arg0.duration_ms) {
            arg0.total_locked
        } else {
            (((arg0.total_locked as u128) * (v1 as u128) / (arg0.duration_ms as u128)) as u64)
        };
        let v3 = v2 - arg0.claimed;
        assert!(v3 > 0, 14);
        arg0.claimed = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<HEIST>>(0x2::coin::take<HEIST>(&mut arg0.vault, v3, arg1), arg0.beneficiary);
        let v4 = VestedReleased{
            amount : v3,
            to     : arg0.beneficiary,
        };
        0x2::event::emit<VestedReleased>(v4);
    }

    public fun claim_win_split(arg0: &mut Session, arg1: vector<address>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.authority, 9);
        assert!(arg0.active, 1);
        assert!(!arg0.paused, 2);
        assert!(arg2 < 7, 4);
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 > 0, 5);
        assert!(v0 <= 100, 10);
        let v1 = 0x1::vector::borrow_mut<bool>(&mut arg0.wins_claimed, (arg2 as u64));
        assert!(!*v1, 3);
        *v1 = true;
        let v2 = get_win_bps(arg2);
        let v3 = 0x2::balance::value<HEIST>(&arg0.vault) * v2 / 10000;
        assert!(v3 > 0, 6);
        let v4 = v3 / v0;
        let v5 = 0;
        while (v5 < v0) {
            let v6 = if (v5 == v0 - 1) {
                v4 + v3 - v4 * v0
            } else {
                v4
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<HEIST>>(0x2::coin::take<HEIST>(&mut arg0.vault, v6, arg3), *0x1::vector::borrow<address>(&arg1, v5));
            v5 = v5 + 1;
        };
        let v7 = WinClaimed{
            session_id   : 0x2::object::id<Session>(arg0),
            win_type     : arg2,
            num_winners  : v0,
            total_payout : v3,
            bps          : v2,
        };
        0x2::event::emit<WinClaimed>(v7);
    }

    public fun create_admin(arg0: 0x2::coin::TreasuryCap<HEIST>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = HeistAdmin{
            id           : 0x2::object::new(arg1),
            authority    : 0x2::tx_context::sender(arg1),
            treasury_cap : arg0,
            prices       : 0x2::table::new<0x1::type_name::TypeName, u64>(arg1),
        };
        0x2::transfer::share_object<HeistAdmin>(v0);
    }

    public fun create_airdrop_pool(arg0: &mut HeistAdmin, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.authority, 9);
        assert!(0x2::coin::total_supply<HEIST>(&arg0.treasury_cap) + arg1 <= 2000000000000000000, 12);
        let v0 = AirdropPool{
            id        : 0x2::object::new(arg2),
            authority : 0x2::tx_context::sender(arg2),
            remaining : arg1,
            vault     : 0x2::coin::into_balance<HEIST>(0x2::coin::mint<HEIST>(&mut arg0.treasury_cap, arg1, arg2)),
        };
        0x2::transfer::share_object<AirdropPool>(v0);
    }

    public fun create_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SessionRegistry{
            id                 : 0x2::object::new(arg0),
            authority          : 0x2::tx_context::sender(arg0),
            treasury           : 0x2::tx_context::sender(arg0),
            current_session_id : 0x2::object::id_from_address(@0x0),
            paused             : false,
            pause_end_ms       : 0,
        };
        0x2::transfer::share_object<SessionRegistry>(v0);
    }

    public fun create_vesting(arg0: &mut HeistAdmin, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.authority, 9);
        assert!(0x2::coin::total_supply<HEIST>(&arg0.treasury_cap) + arg2 <= 2000000000000000000, 12);
        let v0 = Vesting{
            id           : 0x2::object::new(arg4),
            beneficiary  : arg1,
            total_locked : arg2,
            claimed      : 0,
            start_ms     : 0x2::tx_context::epoch_timestamp_ms(arg4),
            duration_ms  : arg3,
            vault        : 0x2::coin::into_balance<HEIST>(0x2::coin::mint<HEIST>(&mut arg0.treasury_cap, arg2, arg4)),
        };
        0x2::transfer::share_object<Vesting>(v0);
    }

    public fun draw_number(arg0: &mut Session, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.authority, 9);
        assert!(arg0.active, 1);
        assert!(!arg0.paused, 2);
        let v0 = 0x1::vector::length<u8>(&arg0.drawn_numbers);
        assert!(v0 < (59 as u64), 11);
        let v1 = 90 - v0;
        let v2 = b"";
        let v3 = 1;
        while (v3 <= 90) {
            let v4 = false;
            let v5 = 0;
            while (v5 < v0) {
                if (*0x1::vector::borrow<u8>(&arg0.drawn_numbers, v5) == v3) {
                    v4 = true;
                    break
                };
                v5 = v5 + 1;
            };
            if (!v4) {
                0x1::vector::push_back<u8>(&mut v2, v3);
            };
            v3 = v3 + 1;
        };
        let v6 = *0x1::vector::borrow<u8>(&v2, (*0x1::vector::borrow<u8>(0x2::tx_context::digest(arg1), 0) as u64) % v1);
        arg0.last_number = v6;
        arg0.draw_count = arg0.draw_count + 1;
        0x1::vector::push_back<u8>(&mut arg0.drawn_numbers, v6);
        let v7 = NumberDrawn{
            session_id : 0x2::object::id<Session>(arg0),
            number     : v6,
            draw_count : arg0.draw_count,
            remaining  : ((v1 - 1) as u8),
        };
        0x2::event::emit<NumberDrawn>(v7);
    }

    public fun end_session(arg0: &mut Session, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.authority, 9);
        arg0.active = false;
    }

    fun flatten_grid(arg0: &vector<vector<u8>>) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 3) {
            let v2 = 0x1::vector::borrow<vector<u8>>(arg0, v1);
            let v3 = 0;
            while (v3 < 9) {
                0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(v2, v3));
                v3 = v3 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun generate_grid(arg0: &0x2::tx_context::TxContext) : vector<vector<u8>> {
        let v0 = 0x2::tx_context::digest(arg0);
        let v1 = 0;
        let v2 = x"000000000000000000";
        let v3 = 0;
        while (v3 < 6) {
            let v4 = &mut v1;
            let v5 = (next_entropy(v0, v4) as u64) % 9;
            if (*0x1::vector::borrow<u8>(&v2, v5) == 0) {
                *0x1::vector::borrow_mut<u8>(&mut v2, v5) = 1;
                v3 = v3 + 1;
            };
        };
        let v6 = vector[];
        let v7 = 0;
        while (v7 < 3) {
            let v8 = b"";
            let v9 = 0;
            while (v9 < 9) {
                0x1::vector::push_back<u8>(&mut v8, 0);
                v9 = v9 + 1;
            };
            0x1::vector::push_back<vector<u8>>(&mut v6, v8);
            v7 = v7 + 1;
        };
        let v10 = x"000000";
        let v11 = 0;
        while (v11 < 9) {
            let v12 = b"";
            let v13 = 0;
            while (v13 < 10) {
                0x1::vector::push_back<u8>(&mut v12, (((v11 as u64) * 10 + 1 + v13) as u8));
                v13 = v13 + 1;
            };
            let v14 = 0;
            while (v14 < ((1 + *0x1::vector::borrow<u8>(&v2, v11)) as u64)) {
                let v15 = &mut v1;
                let v16 = (next_entropy(v0, v15) as u64) % 0x1::vector::length<u8>(&v12);
                0x1::vector::remove<u8>(&mut v12, v16);
                let v17 = 0;
                let v18 = 0;
                while (v18 < 3) {
                    if (*0x1::vector::borrow<u8>(0x1::vector::borrow<vector<u8>>(&v6, v18), v11) == 0) {
                    };
                    v18 = v18 + 1;
                };
                *0x1::vector::borrow_mut<u8>(0x1::vector::borrow_mut<vector<u8>>(&mut v6, v17), v11) = *0x1::vector::borrow<u8>(&v12, v16);
                *0x1::vector::borrow_mut<u8>(&mut v10, v17) = *0x1::vector::borrow<u8>(&v10, v17) + 1;
                v14 = v14 + 1;
            };
            v11 = v11 + 1;
        };
        v6
    }

    fun get_win_bps(arg0: u8) : u64 {
        if (arg0 == 0) {
            500
        } else if (arg0 == 1) {
            500
        } else if (arg0 == 2) {
            500
        } else if (arg0 == 3) {
            500
        } else if (arg0 == 4) {
            1950
        } else if (arg0 == 5) {
            1950
        } else {
            assert!(arg0 == 6, 4);
            4000
        }
    }

    fun init(arg0: HEIST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEIST>(arg0, 9, b"HEIST", b"HEIST", b"HEIST - RANSOME gaming token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEIST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEIST>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun initialize_session(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 7) {
            0x1::vector::push_back<bool>(&mut v1, false);
            v2 = v2 + 1;
        };
        let v3 = Session{
            id               : 0x2::object::new(arg1),
            active           : true,
            paused           : false,
            wins_claimed     : v1,
            vault            : 0x2::balance::zero<HEIST>(),
            treasury         : arg0,
            authority        : v0,
            treasury_fee_bps : 100,
            draw_count       : 0,
            last_number      : 0,
            drawn_numbers    : b"",
            bankrupt_count   : 0,
        };
        0x2::transfer::share_object<Session>(v3);
        let v4 = SessionCreated{
            session_id       : 0x2::object::id<Session>(&v3),
            authority        : v0,
            treasury         : arg0,
            treasury_fee_bps : 100,
        };
        0x2::event::emit<SessionCreated>(v4);
    }

    public fun mint_device<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut Session, arg2: &mut HeistAdmin, arg3: bool, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) : Device {
        assert!(arg1.active, 1);
        assert!(!arg1.paused, 2);
        assert!(arg4 < 20, 8);
        let v0 = 0x1::type_name::with_original_ids<HEIST>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, u64>(&arg2.prices, v0), 17);
        let v1 = *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg2.prices, v0);
        assert!(v1 > 0, 17);
        let v2 = if (arg3) {
            v1 / 2
        } else {
            v1
        };
        let v3 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, u64>(&arg2.prices, v3), 16);
        let v4 = if (arg3) {
            *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg2.prices, v3) / 2
        } else {
            *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg2.prices, v3)
        };
        let v5 = 0x2::coin::value<T0>(&arg0);
        assert!(v5 >= v4, 7);
        let v6 = 0x2::coin::split<T0>(&mut arg0, v4, arg5);
        let v7 = v4 / 100;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v6, v7, arg5), arg1.treasury);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, arg1.treasury);
        let v8 = 0x2::tx_context::sender(arg5);
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, v8);
        };
        assert!((0x2::coin::total_supply<HEIST>(&arg2.treasury_cap) as u128) + (v2 as u128) <= (2000000000000000000 as u128), 12);
        let v9 = (((v2 as u128) * 99 / 100) as u64);
        0x2::balance::join<HEIST>(&mut arg1.vault, 0x2::coin::into_balance<HEIST>(0x2::coin::mint<HEIST>(&mut arg2.treasury_cap, v9, arg5)));
        0x2::transfer::public_transfer<0x2::coin::Coin<HEIST>>(0x2::coin::mint<HEIST>(&mut arg2.treasury_cap, v2 / 100, arg5), arg1.treasury);
        let v10 = generate_grid(arg5);
        let v11 = DeviceMinted{
            session_id    : 0x2::object::id<Session>(arg1),
            device_index  : arg4,
            owner         : v8,
            amount_paid   : v2,
            payment_value : v5,
            discounted    : arg3,
            coin          : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            treasury_fee  : v7,
            vault_added   : v9,
            grid          : flatten_grid(&v10),
        };
        0x2::event::emit<DeviceMinted>(v11);
        Device{
            id           : 0x2::object::new(arg5),
            session_id   : 0x2::object::id<Session>(arg1),
            device_index : arg4,
            grid         : v10,
        }
    }

    public fun mint_heist(arg0: &mut HeistAdmin, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.authority, 9);
        assert!(0x2::coin::total_supply<HEIST>(&arg0.treasury_cap) + arg1 <= 2000000000000000000, 12);
        0x2::transfer::public_transfer<0x2::coin::Coin<HEIST>>(0x2::coin::mint<HEIST>(&mut arg0.treasury_cap, arg1, arg3), arg2);
        let v0 = HeistMinted{
            amount : arg1,
            to     : arg2,
        };
        0x2::event::emit<HeistMinted>(v0);
    }

    fun next_entropy(arg0: &vector<u8>, arg1: &mut u64) : u8 {
        *arg1 = *arg1 + 1;
        *0x1::vector::borrow<u8>(arg0, *arg1 % 0x1::vector::length<u8>(arg0))
    }

    public fun pause_game(arg0: &mut SessionRegistry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.authority, 9);
        arg0.paused = true;
        if (arg1 > 0) {
            arg0.pause_end_ms = 0x2::tx_context::epoch_timestamp_ms(arg2) + arg1;
        } else {
            arg0.pause_end_ms = 0;
        };
    }

    public fun pause_session(arg0: &mut Session, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.authority, 9);
        arg0.paused = true;
    }

    public fun register_initial_session(arg0: &mut SessionRegistry, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.authority, 9);
        arg0.current_session_id = arg1;
    }

    public fun resume_game(arg0: &mut SessionRegistry, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.authority, 9);
        arg0.paused = false;
        arg0.pause_end_ms = 0;
    }

    public fun resume_session(arg0: &mut Session, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.authority, 9);
        arg0.paused = false;
    }

    public fun set_price<T0>(arg0: &mut HeistAdmin, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.authority, 9);
        assert!(arg1 > 0, 13);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.prices, v0)) {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.prices, v0) = arg1;
        } else {
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.prices, v0, arg1);
        };
    }

    public fun set_treasury(arg0: &mut SessionRegistry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.authority, 9);
        arg0.treasury = arg1;
    }

    public fun sweep_remaining(arg0: &mut Session, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.authority, 9);
        let v0 = 0x2::balance::value<HEIST>(&arg0.vault);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<HEIST>>(0x2::coin::take<HEIST>(&mut arg0.vault, v0, arg1), arg0.treasury);
        };
    }

    // decompiled from Move bytecode v7
}

