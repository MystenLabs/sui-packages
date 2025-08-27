module 0xe827ed1881138670e19476d02a2e7c79b8b31cbe45316f53ba7a17c867bec652::game {
    struct GAME has drop {
        dummy_field: bool,
    }

    struct BetInfo has copy, drop, store {
        player_address: address,
        tickets: u64,
        is_high_bet: bool,
    }

    struct Epoch has store, key {
        id: 0x2::object::UID,
        epoch_id: u64,
        start_time_ms: u64,
        end_time_ms: u64,
        betting_close_time_ms: u64,
        betting_price: u64,
        high_pool_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        low_pool_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_high_tickets: u64,
        total_low_tickets: u64,
        bets: vector<BetInfo>,
        is_resolved: bool,
        final_price: u64,
    }

    struct PlayerData has store {
        referrer: 0x1::option::Option<address>,
        points: u64,
        lifetime_tickets: u64,
    }

    struct GameAdmin has store, key {
        id: 0x2::object::UID,
    }

    struct GameData has key {
        id: 0x2::object::UID,
        current_epoch_id: u64,
        player_profiles: 0x2::table::Table<address, PlayerData>,
        epochs: 0x2::table::Table<u64, Epoch>,
        platform_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        lifetime_tickets_bought: u64,
        ticket_price_in_mist: u64,
    }

    struct PlayerRegistered has copy, drop {
        player_address: address,
        referrer: 0x1::option::Option<address>,
    }

    struct BetPlaced has copy, drop {
        epoch_id: u64,
        player_address: address,
        tickets: u64,
        is_high_bet: bool,
    }

    struct EpochResolved has copy, drop {
        epoch_id: u64,
        winning_side: bool,
        final_price: u64,
        total_high_tickets: u64,
        total_low_tickets: u64,
    }

    struct FeesWithdrawn has copy, drop {
        to_address: address,
        amount: u64,
    }

    struct TicketPriceChanged has copy, drop {
        new_price_in_mist: u64,
    }

    public fun current_epoch_id(arg0: &GameData) : u64 {
        arg0.current_epoch_id
    }

    public fun get_epoch(arg0: &GameData, arg1: u64) : &Epoch {
        0x2::table::borrow<u64, Epoch>(&arg0.epochs, arg1)
    }

    public fun get_player_data(arg0: &GameData, arg1: address) : &PlayerData {
        0x2::table::borrow<address, PlayerData>(&arg0.player_profiles, arg1)
    }

    fun init(arg0: GAME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GameAdmin{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<GameAdmin>(v0, 0x2::tx_context::sender(arg1));
        let v1 = Epoch{
            id                    : 0x2::object::new(arg1),
            epoch_id              : 0,
            start_time_ms         : 0,
            end_time_ms           : 1,
            betting_close_time_ms : 0,
            betting_price         : 100000000,
            high_pool_balance     : 0x2::balance::zero<0x2::sui::SUI>(),
            low_pool_balance      : 0x2::balance::zero<0x2::sui::SUI>(),
            total_high_tickets    : 0,
            total_low_tickets     : 0,
            bets                  : 0x1::vector::empty<BetInfo>(),
            is_resolved           : false,
            final_price           : 0,
        };
        let v2 = 0x2::table::new<u64, Epoch>(arg1);
        0x2::table::add<u64, Epoch>(&mut v2, 0, v1);
        let v3 = GameData{
            id                      : 0x2::object::new(arg1),
            current_epoch_id        : 0,
            player_profiles         : 0x2::table::new<address, PlayerData>(arg1),
            epochs                  : v2,
            platform_fees           : 0x2::balance::zero<0x2::sui::SUI>(),
            lifetime_tickets_bought : 0,
            ticket_price_in_mist    : 100000,
        };
        0x2::transfer::share_object<GameData>(v3);
    }

    public fun place_bet(arg0: &mut GameData, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, PlayerData>(&arg0.player_profiles, v0), 8);
        assert!(arg2 > 0, 12);
        let v1 = arg0.current_epoch_id;
        let v2 = 0x2::table::borrow_mut<u64, Epoch>(&mut arg0.epochs, v1);
        assert!(0x2::clock::timestamp_ms(arg4) < v2.betting_close_time_ms, 1);
        assert!((0x2::coin::value<0x2::sui::SUI>(&arg1) as u128) == (arg2 as u128) * (arg0.ticket_price_in_mist as u128), 11);
        let v3 = BetInfo{
            player_address : v0,
            tickets        : arg2,
            is_high_bet    : arg3,
        };
        0x1::vector::push_back<BetInfo>(&mut v2.bets, v3);
        if (arg3) {
            0x2::balance::join<0x2::sui::SUI>(&mut v2.high_pool_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
            v2.total_high_tickets = v2.total_high_tickets + arg2;
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut v2.low_pool_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
            v2.total_low_tickets = v2.total_low_tickets + arg2;
        };
        let v4 = BetPlaced{
            epoch_id       : v1,
            player_address : v0,
            tickets        : arg2,
            is_high_bet    : arg3,
        };
        0x2::event::emit<BetPlaced>(v4);
        let v5 = 0x2::table::borrow_mut<address, PlayerData>(&mut arg0.player_profiles, v0);
        v5.lifetime_tickets = v5.lifetime_tickets + arg2;
        arg0.lifetime_tickets_bought = arg0.lifetime_tickets_bought + arg2;
    }

    public fun register(arg0: &mut GameData, arg1: 0x1::option::Option<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, PlayerData>(&arg0.player_profiles, v0), 3);
        if (0x1::option::is_some<address>(&arg1)) {
            assert!(0x2::table::contains<address, PlayerData>(&arg0.player_profiles, *0x1::option::borrow<address>(&arg1)), 4);
        };
        let v1 = PlayerData{
            referrer         : arg1,
            points           : 0,
            lifetime_tickets : 0,
        };
        0x2::table::add<address, PlayerData>(&mut arg0.player_profiles, v0, v1);
        let v2 = PlayerRegistered{
            player_address : v0,
            referrer       : arg1,
        };
        0x2::event::emit<PlayerRegistered>(v2);
    }

    public fun resolve_epoch_and_create_next(arg0: &mut GameData, arg1: &GameAdmin, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.current_epoch_id;
        let v1 = 0x2::table::borrow_mut<u64, Epoch>(&mut arg0.epochs, v0);
        assert!(0x2::clock::timestamp_ms(arg3) >= v1.end_time_ms, 2);
        assert!(!v1.is_resolved, 6);
        v1.is_resolved = true;
        v1.final_price = arg2;
        let v2 = arg2 > v1.betting_price;
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&v1.high_pool_balance) + 0x2::balance::value<0x2::sui::SUI>(&v1.low_pool_balance);
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&v1.low_pool_balance);
        if (v4 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut v1.high_pool_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v1.low_pool_balance, v4));
        };
        let v5 = &mut v1.high_pool_balance;
        let v6 = if (v2) {
            v1.total_high_tickets
        } else {
            v1.total_low_tickets
        };
        if (v6 > 0) {
            let v7 = 0;
            while (v7 < 0x1::vector::length<BetInfo>(&v1.bets)) {
                let v8 = *0x1::vector::borrow<BetInfo>(&v1.bets, v7);
                let v9 = (((v8.tickets as u128) * (arg0.ticket_price_in_mist as u128) / 1000000000 * 1) as u64);
                let v10 = 0x2::table::borrow_mut<address, PlayerData>(&mut arg0.player_profiles, v8.player_address);
                v10.points = v10.points + v9;
                if (0x1::option::is_some<address>(&v10.referrer)) {
                    let v11 = *0x1::option::borrow<address>(&v10.referrer);
                    if (0x2::table::contains<address, PlayerData>(&arg0.player_profiles, v11)) {
                        let v12 = 0x2::table::borrow_mut<address, PlayerData>(&mut arg0.player_profiles, v11);
                        v12.points = v12.points + (((v9 as u128) * (1000 as u128) / 10000) as u64);
                    };
                };
                if (v8.is_high_bet == v2) {
                    let v13 = (v8.tickets as u128) * (v3 as u128) / (v6 as u128);
                    let v14 = v13 * (50 as u128) / 10000;
                    let v15 = v13 - v14;
                    if (v15 > 0) {
                        0x2::balance::join<0x2::sui::SUI>(&mut arg0.platform_fees, 0x2::balance::split<0x2::sui::SUI>(v5, (v14 as u64)));
                        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v5, (v15 as u64)), arg4), v8.player_address);
                    };
                };
                v7 = v7 + 1;
            };
        };
        let v16 = EpochResolved{
            epoch_id           : v0,
            winning_side       : v2,
            final_price        : arg2,
            total_high_tickets : v1.total_high_tickets,
            total_low_tickets  : v1.total_low_tickets,
        };
        0x2::event::emit<EpochResolved>(v16);
        let v17 = 0x2::balance::value<0x2::sui::SUI>(v5);
        if (v17 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.platform_fees, 0x2::balance::split<0x2::sui::SUI>(v5, v17));
        };
        let v18 = v0 + 1;
        let v19 = 0x2::clock::timestamp_ms(arg3);
        let v20 = Epoch{
            id                    : 0x2::object::new(arg4),
            epoch_id              : v18,
            start_time_ms         : v19,
            end_time_ms           : v19 + 86400000,
            betting_close_time_ms : v19 + 43200000,
            betting_price         : arg2,
            high_pool_balance     : 0x2::balance::zero<0x2::sui::SUI>(),
            low_pool_balance      : 0x2::balance::zero<0x2::sui::SUI>(),
            total_high_tickets    : 0,
            total_low_tickets     : 0,
            bets                  : 0x1::vector::empty<BetInfo>(),
            is_resolved           : false,
            final_price           : 0,
        };
        0x2::table::add<u64, Epoch>(&mut arg0.epochs, v18, v20);
        arg0.current_epoch_id = v18;
    }

    public fun set_ticket_price(arg0: &GameAdmin, arg1: &mut GameData, arg2: u64) {
        arg1.ticket_price_in_mist = arg2;
        let v0 = TicketPriceChanged{new_price_in_mist: arg2};
        0x2::event::emit<TicketPriceChanged>(v0);
    }

    public fun withdraw_fees(arg0: &mut GameData, arg1: &GameAdmin, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.platform_fees) >= arg2, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.platform_fees, arg2), arg3), v0);
        let v1 = FeesWithdrawn{
            to_address : v0,
            amount     : arg2,
        };
        0x2::event::emit<FeesWithdrawn>(v1);
    }

    // decompiled from Move bytecode v6
}

