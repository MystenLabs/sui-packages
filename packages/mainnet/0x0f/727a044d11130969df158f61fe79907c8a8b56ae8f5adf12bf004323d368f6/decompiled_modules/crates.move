module 0xf727a044d11130969df158f61fe79907c8a8b56ae8f5adf12bf004323d368f6::crates {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RollEntry has copy, drop, store {
        threshold: u64,
        value: u64,
    }

    struct TierConfig has copy, drop, store {
        bub_cost: u64,
        bublz_cost: u64,
        sui_cost: u64,
        bub_burn_bps: u64,
        bubbler_rate_bps: u64,
        cosmetic_rate_bps: u64,
        enabled: bool,
    }

    struct PendingTicket has drop, store {
        owner: address,
        tier: u64,
        purchased_at_ms: u64,
        sui_paid: u64,
    }

    struct CratePool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        admin: address,
        bot: address,
        paused: bool,
        treasury_recipient: address,
        sui_treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        bubbler_bag: 0x2::object_bag::ObjectBag,
        cosmetic_bag: 0x2::object_bag::ObjectBag,
        bubbler_keys: vector<vector<u64>>,
        cosmetic_keys: vector<vector<u64>>,
        next_nft_key: u64,
        tiers: vector<TierConfig>,
        bubbler_tables: vector<vector<RollEntry>>,
        cosmetic_tables: vector<vector<RollEntry>>,
        pending_tickets: 0x2::table::Table<u64, PendingTicket>,
        next_ticket_id: u64,
        pending_count: u64,
        total_opened: u64,
        total_bub_burned: u64,
        total_bublz_burned: u64,
    }

    struct TicketCreated has copy, drop {
        ticket_id: u64,
        player: address,
        tier: u64,
    }

    struct CrateOpened has copy, drop {
        ticket_id: u64,
        player: address,
        tier: u64,
        bubbler_tier: u64,
        cosmetic_rarity: u64,
    }

    struct TicketCancelled has copy, drop {
        ticket_id: u64,
        player: address,
        sui_refunded: u64,
    }

    struct NFTDeposited has copy, drop {
        nft_type: u64,
        tier_or_rarity: u64,
        key: u64,
    }

    struct ConfigUpdated has copy, drop {
        tier: u64,
        action: u64,
    }

    public entry fun admin_force_cancel<T0, T1>(arg0: &AdminCap, arg1: &mut CratePool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, PendingTicket>(&arg1.pending_tickets, arg2), 6);
        let v0 = 0x2::table::borrow<u64, PendingTicket>(&arg1.pending_tickets, arg2);
        assert!(0x2::clock::timestamp_ms(arg3) >= v0.purchased_at_ms + 3600000, 10);
        let v1 = v0.sui_paid;
        let v2 = v0.owner;
        0x2::table::remove<u64, PendingTicket>(&mut arg1.pending_tickets, arg2);
        arg1.pending_count = arg1.pending_count - 1;
        if (v1 > 0) {
            assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.sui_treasury) >= v1, 4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_treasury, v1), arg4), v2);
        };
        let v3 = TicketCancelled{
            ticket_id    : arg2,
            player       : v2,
            sui_refunded : v1,
        };
        0x2::event::emit<TicketCancelled>(v3);
    }

    public entry fun buy_ticket<T0, T1>(arg0: &mut CratePool<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        assert!(arg1 < 2, 3);
        let v0 = *0x1::vector::borrow<TierConfig>(&arg0.tiers, arg1);
        assert!(v0.enabled, 7);
        assert!(total_bubblers(&arg0.bubbler_keys) + total_cosmetics(&arg0.cosmetic_keys) > 0, 5);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        assert!(v2 >= v0.sui_cost, 4);
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg4);
        if (v2 > v0.sui_cost) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, v2 - v0.sui_cost), arg6), v1);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_treasury, v3);
        let v4 = 0x2::coin::value<T0>(&arg2);
        assert!(v4 >= v0.bub_cost, 4);
        let v5 = 0x2::coin::into_balance<T0>(arg2);
        if (v4 > v0.bub_cost) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v5, v4 - v0.bub_cost), arg6), v1);
        };
        let v6 = (((0x2::balance::value<T0>(&v5) as u128) * (v0.bub_burn_bps as u128) / (10000 as u128)) as u64);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v5, v6), arg6), @0x0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg6), arg0.treasury_recipient);
        arg0.total_bub_burned = arg0.total_bub_burned + v6;
        let v7 = 0x2::coin::value<T1>(&arg3);
        assert!(v7 >= v0.bublz_cost, 4);
        if (v7 > v0.bublz_cost) {
            let v8 = 0x2::coin::into_balance<T1>(arg3);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v8, v7 - v0.bublz_cost), arg6), v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v8, arg6), @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg3, @0x0);
        };
        arg0.total_bublz_burned = arg0.total_bublz_burned + v0.bublz_cost;
        let v9 = arg0.next_ticket_id;
        arg0.next_ticket_id = v9 + 1;
        arg0.pending_count = arg0.pending_count + 1;
        let v10 = PendingTicket{
            owner           : v1,
            tier            : arg1,
            purchased_at_ms : 0x2::clock::timestamp_ms(arg5),
            sui_paid        : v0.sui_cost,
        };
        0x2::table::add<u64, PendingTicket>(&mut arg0.pending_tickets, v9, v10);
        let v11 = TicketCreated{
            ticket_id : v9,
            player    : v1,
            tier      : arg1,
        };
        0x2::event::emit<TicketCreated>(v11);
    }

    public entry fun cancel_ticket<T0, T1>(arg0: &mut CratePool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, PendingTicket>(&arg0.pending_tickets, arg1), 6);
        let v0 = 0x2::table::borrow<u64, PendingTicket>(&arg0.pending_tickets, arg1);
        assert!(v0.owner == 0x2::tx_context::sender(arg3), 9);
        assert!(0x2::clock::timestamp_ms(arg2) >= v0.purchased_at_ms + 3600000, 10);
        let v1 = v0.sui_paid;
        let v2 = v0.owner;
        0x2::table::remove<u64, PendingTicket>(&mut arg0.pending_tickets, arg1);
        arg0.pending_count = arg0.pending_count - 1;
        if (v1 > 0) {
            assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_treasury) >= v1, 4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_treasury, v1), arg3), v2);
        };
        let v3 = TicketCancelled{
            ticket_id    : arg1,
            player       : v2,
            sui_refunded : v1,
        };
        0x2::event::emit<TicketCancelled>(v3);
    }

    public entry fun create_pool<T0, T1>(arg0: &AdminCap, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<TierConfig>();
        let v1 = 0x1::vector::empty<vector<RollEntry>>();
        let v2 = 0x1::vector::empty<vector<RollEntry>>();
        let v3 = 0;
        while (v3 < 2) {
            let v4 = TierConfig{
                bub_cost          : 0,
                bublz_cost        : 0,
                sui_cost          : 0,
                bub_burn_bps      : 7000,
                bubbler_rate_bps  : 9770,
                cosmetic_rate_bps : 230,
                enabled           : false,
            };
            0x1::vector::push_back<TierConfig>(&mut v0, v4);
            0x1::vector::push_back<vector<RollEntry>>(&mut v1, 0x1::vector::empty<RollEntry>());
            0x1::vector::push_back<vector<RollEntry>>(&mut v2, 0x1::vector::empty<RollEntry>());
            v3 = v3 + 1;
        };
        let v5 = 0x1::vector::empty<vector<u64>>();
        v3 = 0;
        while (v3 < 13) {
            0x1::vector::push_back<vector<u64>>(&mut v5, 0x1::vector::empty<u64>());
            v3 = v3 + 1;
        };
        let v6 = 0x1::vector::empty<vector<u64>>();
        v3 = 0;
        while (v3 < 5) {
            0x1::vector::push_back<vector<u64>>(&mut v6, 0x1::vector::empty<u64>());
            v3 = v3 + 1;
        };
        let v7 = CratePool<T0, T1>{
            id                 : 0x2::object::new(arg3),
            admin              : 0x2::tx_context::sender(arg3),
            bot                : arg1,
            paused             : false,
            treasury_recipient : arg2,
            sui_treasury       : 0x2::balance::zero<0x2::sui::SUI>(),
            bubbler_bag        : 0x2::object_bag::new(arg3),
            cosmetic_bag       : 0x2::object_bag::new(arg3),
            bubbler_keys       : v5,
            cosmetic_keys      : v6,
            next_nft_key       : 0,
            tiers              : v0,
            bubbler_tables     : v1,
            cosmetic_tables    : v2,
            pending_tickets    : 0x2::table::new<u64, PendingTicket>(arg3),
            next_ticket_id     : 0,
            pending_count      : 0,
            total_opened       : 0,
            total_bub_burned   : 0,
            total_bublz_burned : 0,
        };
        0x2::transfer::share_object<CratePool<T0, T1>>(v7);
    }

    public entry fun deposit_bubbler<T0, T1, T2: store + key>(arg0: &AdminCap, arg1: &mut CratePool<T0, T1>, arg2: T2, arg3: u64) {
        assert!(arg3 < 13, 3);
        let v0 = arg1.next_nft_key;
        arg1.next_nft_key = v0 + 1;
        0x2::object_bag::add<u64, T2>(&mut arg1.bubbler_bag, v0, arg2);
        0x1::vector::push_back<u64>(0x1::vector::borrow_mut<vector<u64>>(&mut arg1.bubbler_keys, arg3), v0);
        let v1 = NFTDeposited{
            nft_type       : 0,
            tier_or_rarity : arg3,
            key            : v0,
        };
        0x2::event::emit<NFTDeposited>(v1);
    }

    public entry fun deposit_cosmetic<T0, T1, T2: store + key>(arg0: &AdminCap, arg1: &mut CratePool<T0, T1>, arg2: T2, arg3: u64) {
        assert!(arg3 < 5, 3);
        let v0 = arg1.next_nft_key;
        arg1.next_nft_key = v0 + 1;
        0x2::object_bag::add<u64, T2>(&mut arg1.cosmetic_bag, v0, arg2);
        0x1::vector::push_back<u64>(0x1::vector::borrow_mut<vector<u64>>(&mut arg1.cosmetic_keys, arg3), v0);
        let v1 = NFTDeposited{
            nft_type       : 1,
            tier_or_rarity : arg3,
            key            : v0,
        };
        0x2::event::emit<NFTDeposited>(v1);
    }

    public fun get_next_ticket_id<T0, T1>(arg0: &CratePool<T0, T1>) : u64 {
        arg0.next_ticket_id
    }

    public fun get_pending_count<T0, T1>(arg0: &CratePool<T0, T1>) : u64 {
        arg0.pending_count
    }

    public fun get_total_bub_burned<T0, T1>(arg0: &CratePool<T0, T1>) : u64 {
        arg0.total_bub_burned
    }

    public fun get_total_opened<T0, T1>(arg0: &CratePool<T0, T1>) : u64 {
        arg0.total_opened
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun reveal_ticket<T0, T1, T2: store + key, T3: store + key>(arg0: &mut CratePool<T0, T1>, arg1: u64, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.bot, 8);
        assert!(0x2::table::contains<u64, PendingTicket>(&arg0.pending_tickets, arg1), 6);
        arg0.pending_count = arg0.pending_count - 1;
        let PendingTicket {
            owner           : v0,
            tier            : v1,
            purchased_at_ms : _,
            sui_paid        : v3,
        } = 0x2::table::remove<u64, PendingTicket>(&mut arg0.pending_tickets, arg1);
        let v4 = *0x1::vector::borrow<TierConfig>(&arg0.tiers, v1);
        let v5 = 0x2::random::new_generator(arg2, arg3);
        let v6 = 0;
        let v7 = 0;
        let v8 = false;
        if (0x2::random::generate_u64_in_range(&mut v5, 0, 9999) < v4.bubbler_rate_bps && total_bubblers(&arg0.bubbler_keys) > 0) {
            let v9 = roll_lookup(0x1::vector::borrow<vector<RollEntry>>(&arg0.bubbler_tables, v1), 0x2::random::generate_u64_in_range(&mut v5, 0, 9999));
            if (v9 >= 1 && v9 <= 13) {
                let v10 = 0x1::vector::borrow_mut<vector<u64>>(&mut arg0.bubbler_keys, v9 - 1);
                if (0x1::vector::length<u64>(v10) > 0) {
                    0x2::transfer::public_transfer<T2>(0x2::object_bag::remove<u64, T2>(&mut arg0.bubbler_bag, 0x1::vector::pop_back<u64>(v10)), v0);
                    v6 = v9;
                    v8 = true;
                };
            };
            if (!v8) {
                let v11 = 0;
                while (v11 < 13 && !v8) {
                    let v12 = 0x1::vector::borrow_mut<vector<u64>>(&mut arg0.bubbler_keys, v11);
                    if (0x1::vector::length<u64>(v12) > 0) {
                        0x2::transfer::public_transfer<T2>(0x2::object_bag::remove<u64, T2>(&mut arg0.bubbler_bag, 0x1::vector::pop_back<u64>(v12)), v0);
                        v6 = v11 + 1;
                        v8 = true;
                    };
                    v11 = v11 + 1;
                };
            };
        } else if (total_cosmetics(&arg0.cosmetic_keys) > 0) {
            let v13 = roll_lookup(0x1::vector::borrow<vector<RollEntry>>(&arg0.cosmetic_tables, v1), 0x2::random::generate_u64_in_range(&mut v5, 0, 9999));
            if (v13 >= 1 && v13 <= 5) {
                let v14 = 0x1::vector::borrow_mut<vector<u64>>(&mut arg0.cosmetic_keys, v13 - 1);
                if (0x1::vector::length<u64>(v14) > 0) {
                    0x2::transfer::public_transfer<T3>(0x2::object_bag::remove<u64, T3>(&mut arg0.cosmetic_bag, 0x1::vector::pop_back<u64>(v14)), v0);
                    v7 = v13;
                    v8 = true;
                };
            };
            if (!v8) {
                let v15 = 0;
                while (v15 < 5 && !v8) {
                    let v16 = 0x1::vector::borrow_mut<vector<u64>>(&mut arg0.cosmetic_keys, v15);
                    if (0x1::vector::length<u64>(v16) > 0) {
                        0x2::transfer::public_transfer<T3>(0x2::object_bag::remove<u64, T3>(&mut arg0.cosmetic_bag, 0x1::vector::pop_back<u64>(v16)), v0);
                        v7 = v15 + 1;
                        v8 = true;
                    };
                    v15 = v15 + 1;
                };
            };
        };
        if (!v8 && total_cosmetics(&arg0.cosmetic_keys) > 0) {
            let v17 = 0;
            while (v17 < 5 && !v8) {
                let v18 = 0x1::vector::borrow_mut<vector<u64>>(&mut arg0.cosmetic_keys, v17);
                if (0x1::vector::length<u64>(v18) > 0) {
                    0x2::transfer::public_transfer<T3>(0x2::object_bag::remove<u64, T3>(&mut arg0.cosmetic_bag, 0x1::vector::pop_back<u64>(v18)), v0);
                    v7 = v17 + 1;
                    v8 = true;
                };
                v17 = v17 + 1;
            };
        };
        if (!v8 && total_bubblers(&arg0.bubbler_keys) > 0) {
            let v19 = 0;
            while (v19 < 13 && !v8) {
                let v20 = 0x1::vector::borrow_mut<vector<u64>>(&mut arg0.bubbler_keys, v19);
                if (0x1::vector::length<u64>(v20) > 0) {
                    0x2::transfer::public_transfer<T2>(0x2::object_bag::remove<u64, T2>(&mut arg0.bubbler_bag, 0x1::vector::pop_back<u64>(v20)), v0);
                    v6 = v19 + 1;
                    v8 = true;
                };
                v19 = v19 + 1;
            };
        };
        let v21 = if (!v8) {
            if (v3 > 0) {
                0x2::balance::value<0x2::sui::SUI>(&arg0.sui_treasury) >= v3
            } else {
                false
            }
        } else {
            false
        };
        if (v21) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_treasury, v3), arg3), v0);
        };
        arg0.total_opened = arg0.total_opened + 1;
        let v22 = CrateOpened{
            ticket_id       : arg1,
            player          : v0,
            tier            : v1,
            bubbler_tier    : v6,
            cosmetic_rarity : v7,
        };
        0x2::event::emit<CrateOpened>(v22);
    }

    fun roll_lookup(arg0: &vector<RollEntry>, arg1: u64) : u64 {
        let v0 = 0x1::vector::length<RollEntry>(arg0);
        if (v0 == 0) {
            return 0
        };
        let v1 = 0;
        while (v1 < v0) {
            if (arg1 <= 0x1::vector::borrow<RollEntry>(arg0, v1).threshold) {
                return 0x1::vector::borrow<RollEntry>(arg0, v1).value
            };
            v1 = v1 + 1;
        };
        0x1::vector::borrow<RollEntry>(arg0, v0 - 1).value
    }

    public entry fun set_bot<T0, T1>(arg0: &AdminCap, arg1: &mut CratePool<T0, T1>, arg2: address) {
        arg1.bot = arg2;
    }

    public entry fun set_bubbler_table<T0, T1>(arg0: &AdminCap, arg1: &mut CratePool<T0, T1>, arg2: u64, arg3: vector<u64>, arg4: vector<u64>) {
        assert!(arg2 < 2, 3);
        assert!(0x1::vector::length<u64>(&arg3) == 0x1::vector::length<u64>(&arg4), 4);
        assert!(arg1.pending_count == 0, 11);
        let v0 = 0x1::vector::empty<RollEntry>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg3)) {
            let v2 = RollEntry{
                threshold : *0x1::vector::borrow<u64>(&arg3, v1),
                value     : *0x1::vector::borrow<u64>(&arg4, v1),
            };
            0x1::vector::push_back<RollEntry>(&mut v0, v2);
            v1 = v1 + 1;
        };
        *0x1::vector::borrow_mut<vector<RollEntry>>(&mut arg1.bubbler_tables, arg2) = v0;
        let v3 = ConfigUpdated{
            tier   : arg2,
            action : 1,
        };
        0x2::event::emit<ConfigUpdated>(v3);
    }

    public entry fun set_cosmetic_table<T0, T1>(arg0: &AdminCap, arg1: &mut CratePool<T0, T1>, arg2: u64, arg3: vector<u64>, arg4: vector<u64>) {
        assert!(arg2 < 2, 3);
        assert!(0x1::vector::length<u64>(&arg3) == 0x1::vector::length<u64>(&arg4), 4);
        assert!(arg1.pending_count == 0, 11);
        let v0 = 0x1::vector::empty<RollEntry>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg3)) {
            let v2 = RollEntry{
                threshold : *0x1::vector::borrow<u64>(&arg3, v1),
                value     : *0x1::vector::borrow<u64>(&arg4, v1),
            };
            0x1::vector::push_back<RollEntry>(&mut v0, v2);
            v1 = v1 + 1;
        };
        *0x1::vector::borrow_mut<vector<RollEntry>>(&mut arg1.cosmetic_tables, arg2) = v0;
        let v3 = ConfigUpdated{
            tier   : arg2,
            action : 2,
        };
        0x2::event::emit<ConfigUpdated>(v3);
    }

    public entry fun set_paused<T0, T1>(arg0: &AdminCap, arg1: &mut CratePool<T0, T1>, arg2: bool) {
        arg1.paused = arg2;
    }

    public entry fun set_tier_config<T0, T1>(arg0: &AdminCap, arg1: &mut CratePool<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool) {
        assert!(arg2 < 2, 3);
        assert!(arg6 <= 10000, 4);
        assert!(arg7 + arg8 == 10000, 4);
        assert!(arg1.pending_count == 0, 11);
        let v0 = 0x1::vector::borrow_mut<TierConfig>(&mut arg1.tiers, arg2);
        v0.bub_cost = arg3;
        v0.bublz_cost = arg4;
        v0.sui_cost = arg5;
        v0.bub_burn_bps = arg6;
        v0.bubbler_rate_bps = arg7;
        v0.cosmetic_rate_bps = arg8;
        v0.enabled = arg9;
        let v1 = ConfigUpdated{
            tier   : arg2,
            action : 0,
        };
        0x2::event::emit<ConfigUpdated>(v1);
    }

    public entry fun set_treasury_recipient<T0, T1>(arg0: &AdminCap, arg1: &mut CratePool<T0, T1>, arg2: address) {
        arg1.treasury_recipient = arg2;
    }

    fun total_bubblers(arg0: &vector<vector<u64>>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u64>>(arg0)) {
            v0 = v0 + 0x1::vector::length<u64>(0x1::vector::borrow<vector<u64>>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun total_cosmetics(arg0: &vector<vector<u64>>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u64>>(arg0)) {
            v0 = v0 + 0x1::vector::length<u64>(0x1::vector::borrow<vector<u64>>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun withdraw_bubbler<T0, T1, T2: store + key>(arg0: &AdminCap, arg1: &mut CratePool<T0, T1>, arg2: u64, arg3: address) {
        assert!(arg2 < 13, 3);
        assert!(arg1.pending_count == 0, 11);
        let v0 = 0x1::vector::borrow_mut<vector<u64>>(&mut arg1.bubbler_keys, arg2);
        assert!(0x1::vector::length<u64>(v0) > 0, 5);
        0x2::transfer::public_transfer<T2>(0x2::object_bag::remove<u64, T2>(&mut arg1.bubbler_bag, 0x1::vector::pop_back<u64>(v0)), arg3);
    }

    public entry fun withdraw_cosmetic<T0, T1, T2: store + key>(arg0: &AdminCap, arg1: &mut CratePool<T0, T1>, arg2: u64, arg3: address) {
        assert!(arg2 < 5, 3);
        assert!(arg1.pending_count == 0, 11);
        let v0 = 0x1::vector::borrow_mut<vector<u64>>(&mut arg1.cosmetic_keys, arg2);
        assert!(0x1::vector::length<u64>(v0) > 0, 5);
        0x2::transfer::public_transfer<T2>(0x2::object_bag::remove<u64, T2>(&mut arg1.cosmetic_bag, 0x1::vector::pop_back<u64>(v0)), arg3);
    }

    public entry fun withdraw_sui<T0, T1>(arg0: &AdminCap, arg1: &mut CratePool<T0, T1>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pending_count == 0, 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_treasury, arg2), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

