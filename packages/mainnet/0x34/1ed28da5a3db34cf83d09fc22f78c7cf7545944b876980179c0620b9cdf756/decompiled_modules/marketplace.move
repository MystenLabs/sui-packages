module 0x341ed28da5a3db34cf83d09fc22f78c7cf7545944b876980179c0620b9cdf756::marketplace {
    struct CoinRaffleCreated has copy, drop {
        name: 0x1::string::String,
        address: address,
    }

    struct RaffleCreated has copy, drop {
        name: 0x1::string::String,
        address: address,
    }

    struct CoinRaffleTicketBought has copy, drop {
        buyer: address,
        amount: u64,
        event: address,
    }

    struct RaffleTicketBought has copy, drop {
        buyer: address,
        amount: u64,
        event: address,
    }

    struct CoinRaffleWinnerSelected has copy, drop {
        winner: address,
        event: address,
    }

    struct RaffleWinnerSelected has copy, drop {
        winner: address,
        event: address,
    }

    struct CoinRaffleRewardClaimed has copy, drop {
        winner: address,
        event: address,
    }

    struct RaffleRewardClaimed has copy, drop {
        winner: address,
        event: address,
    }

    struct MarketplaceData has key {
        id: 0x2::object::UID,
        active_events: vector<address>,
        past_events: vector<address>,
        publisher: address,
        total_sity_spent: u64,
    }

    struct CoinRaffleEvent<phantom T0> has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        ticket_price: u64,
        start_time: u64,
        duration: u64,
        max_participants: u64,
        current_participants: u64,
        is_active: bool,
        winner: address,
        reward_balance: 0x2::balance::Balance<T0>,
        participants: vector<address>,
        participant_weights: vector<u64>,
        total_weight: u64,
        max_ticket_per_user: u64,
    }

    struct RaffleEvent has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        ticket_price: u64,
        start_time: u64,
        duration: u64,
        max_participants: u64,
        current_participants: u64,
        is_active: bool,
        winner: address,
        reward: address,
        participants: vector<address>,
        participant_weights: vector<u64>,
        total_weight: u64,
        max_ticket_per_user: u64,
    }

    public fun buy_coin_ticket<T0>(arg0: &mut MarketplaceData, arg1: &mut CoinRaffleEvent<T0>, arg2: &mut 0x341ed28da5a3db34cf83d09fc22f78c7cf7545944b876980179c0620b9cdf756::nft::GameData, arg3: &mut 0x341ed28da5a3db34cf83d09fc22f78c7cf7545944b876980179c0620b9cdf756::nft::Wallet, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_active, 1);
        assert!(arg1.current_participants < arg1.max_participants, 4);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 < arg1.start_time + arg1.duration, 2);
        assert!(v0 >= arg1.start_time, 3);
        assert!(arg5 <= arg1.max_ticket_per_user, 8);
        0x341ed28da5a3db34cf83d09fc22f78c7cf7545944b876980179c0620b9cdf756::nft::do_sity_payment(arg2, arg3, arg5 * arg1.ticket_price, arg6);
        arg0.total_sity_spent = arg0.total_sity_spent + arg5 * arg1.ticket_price;
        0x1::vector::push_back<address>(&mut arg1.participants, 0x2::tx_context::sender(arg6));
        0x1::vector::push_back<u64>(&mut arg1.participant_weights, arg5);
        arg1.current_participants = arg1.current_participants + 1;
        arg1.total_weight = arg1.total_weight + arg5;
        let v1 = CoinRaffleTicketBought{
            buyer  : 0x2::tx_context::sender(arg6),
            amount : arg1.ticket_price,
            event  : 0x2::object::uid_to_address(&arg1.id),
        };
        0x2::event::emit<CoinRaffleTicketBought>(v1);
    }

    public fun buy_raffle_ticket(arg0: &mut MarketplaceData, arg1: &mut RaffleEvent, arg2: &mut 0x341ed28da5a3db34cf83d09fc22f78c7cf7545944b876980179c0620b9cdf756::nft::GameData, arg3: &mut 0x341ed28da5a3db34cf83d09fc22f78c7cf7545944b876980179c0620b9cdf756::nft::Wallet, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_active, 1);
        assert!(arg1.current_participants < arg1.max_participants, 4);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 < arg1.start_time + arg1.duration, 2);
        assert!(v0 >= arg1.start_time, 3);
        assert!(arg5 <= arg1.max_ticket_per_user, 8);
        0x341ed28da5a3db34cf83d09fc22f78c7cf7545944b876980179c0620b9cdf756::nft::do_sity_payment(arg2, arg3, arg5 * arg1.ticket_price, arg6);
        arg0.total_sity_spent = arg0.total_sity_spent + arg5 * arg1.ticket_price;
        0x1::vector::push_back<address>(&mut arg1.participants, 0x2::tx_context::sender(arg6));
        0x1::vector::push_back<u64>(&mut arg1.participant_weights, arg5);
        arg1.current_participants = arg1.current_participants + 1;
        arg1.total_weight = arg1.total_weight + arg5;
        let v1 = RaffleTicketBought{
            buyer  : 0x2::tx_context::sender(arg6),
            amount : arg1.ticket_price,
            event  : 0x2::object::uid_to_address(&arg1.id),
        };
        0x2::event::emit<RaffleTicketBought>(v1);
    }

    public fun claim_coin_reward<T0>(arg0: &mut CoinRaffleEvent<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_active, 1);
        assert!(0x2::tx_context::sender(arg1) == arg0.winner, 7);
        arg0.is_active = false;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.reward_balance, 0x2::balance::value<T0>(&arg0.reward_balance), arg1), 0x2::tx_context::sender(arg1));
        let v0 = CoinRaffleRewardClaimed{
            winner : 0x2::tx_context::sender(arg1),
            event  : 0x2::object::uid_to_address(&arg0.id),
        };
        0x2::event::emit<CoinRaffleRewardClaimed>(v0);
    }

    public fun claim_raffle_reward(arg0: &mut RaffleEvent, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_active, 1);
        assert!(0x2::tx_context::sender(arg1) == arg0.winner, 7);
        arg0.is_active = false;
        let v0 = RaffleRewardClaimed{
            winner : 0x2::tx_context::sender(arg1),
            event  : 0x2::object::uid_to_address(&arg0.id),
        };
        0x2::event::emit<RaffleRewardClaimed>(v0);
    }

    public fun create_coin_raffle<T0>(arg0: &mut MarketplaceData, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0x2::coin::Coin<T0>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg8) == arg0.publisher, 0);
        let v0 = CoinRaffleEvent<T0>{
            id                   : 0x2::object::new(arg8),
            name                 : arg1,
            ticket_price         : arg2,
            start_time           : arg3,
            duration             : arg4,
            max_participants     : arg5,
            current_participants : 0,
            is_active            : true,
            winner               : @0x0,
            reward_balance       : 0x2::coin::into_balance<T0>(arg7),
            participants         : 0x1::vector::empty<address>(),
            participant_weights  : 0x1::vector::empty<u64>(),
            total_weight         : 0,
            max_ticket_per_user  : arg6,
        };
        let v1 = CoinRaffleCreated{
            name    : arg1,
            address : 0x2::object::uid_to_address(&v0.id),
        };
        0x2::event::emit<CoinRaffleCreated>(v1);
        0x1::vector::push_back<address>(&mut arg0.active_events, 0x2::object::uid_to_address(&v0.id));
        0x2::transfer::share_object<CoinRaffleEvent<T0>>(v0);
    }

    public fun create_raffle(arg0: &mut MarketplaceData, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg8) == arg0.publisher, 0);
        let v0 = RaffleEvent{
            id                   : 0x2::object::new(arg8),
            name                 : arg1,
            ticket_price         : arg2,
            start_time           : arg3,
            duration             : arg4,
            max_participants     : arg5,
            current_participants : 0,
            is_active            : false,
            winner               : @0x0,
            reward               : arg6,
            participants         : 0x1::vector::empty<address>(),
            participant_weights  : 0x1::vector::empty<u64>(),
            total_weight         : 0,
            max_ticket_per_user  : arg7,
        };
        let v1 = RaffleCreated{
            name    : arg1,
            address : 0x2::object::uid_to_address(&v0.id),
        };
        0x2::event::emit<RaffleCreated>(v1);
        0x1::vector::push_back<address>(&mut arg0.active_events, 0x2::object::uid_to_address(&v0.id));
        0x2::transfer::share_object<RaffleEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketplaceData{
            id               : 0x2::object::new(arg0),
            active_events    : 0x1::vector::empty<address>(),
            past_events      : 0x1::vector::empty<address>(),
            publisher        : 0x2::tx_context::sender(arg0),
            total_sity_spent : 0,
        };
        0x2::transfer::share_object<MarketplaceData>(v0);
    }

    entry fun select_coin_winner<T0>(arg0: &0x2::random::Random, arg1: &mut MarketplaceData, arg2: &mut CoinRaffleEvent<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.publisher, 0);
        assert!(arg2.is_active, 1);
        assert!(arg2.winner == @0x0, 6);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg2.start_time + arg2.duration, 5);
        let v0 = 0x2::random::new_generator(arg0, arg4);
        let v1 = 0x2::random::generate_u64_in_range(&mut v0, 0, arg2.total_weight);
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg2.participant_weights)) {
            let v4 = 0x1::vector::borrow<u64>(&arg2.participant_weights, v3);
            if (v1 < *v4) {
                v2 = v3;
                break
            };
            v1 = v1 - *v4;
            v3 = v3 + 1;
        };
        let v5 = 0x1::vector::borrow<address>(&arg2.participants, v2);
        arg2.winner = *v5;
        0x1::vector::push_back<address>(&mut arg1.past_events, 0x2::object::uid_to_address(&arg2.id));
        let v6 = 0;
        while (v6 < 0x1::vector::length<address>(&arg1.active_events)) {
            let v7 = 0x2::object::uid_to_address(&arg2.id);
            if (0x1::vector::borrow<address>(&arg1.active_events, v6) == &v7) {
                0x1::vector::remove<address>(&mut arg1.active_events, v6);
            };
            v6 = v6 + 1;
        };
        let v8 = CoinRaffleWinnerSelected{
            winner : *v5,
            event  : 0x2::object::uid_to_address(&arg2.id),
        };
        0x2::event::emit<CoinRaffleWinnerSelected>(v8);
    }

    entry fun select_raffle_winner(arg0: &0x2::random::Random, arg1: &mut MarketplaceData, arg2: &mut RaffleEvent, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.publisher, 0);
        assert!(arg2.is_active, 1);
        assert!(arg2.winner == @0x0, 6);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg2.start_time + arg2.duration, 5);
        let v0 = 0x2::random::new_generator(arg0, arg4);
        let v1 = 0x2::random::generate_u64_in_range(&mut v0, 0, arg2.total_weight);
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg2.participant_weights)) {
            let v4 = 0x1::vector::borrow<u64>(&arg2.participant_weights, v3);
            if (v1 < *v4) {
                v2 = v3;
                break
            };
            v1 = v1 - *v4;
            v3 = v3 + 1;
        };
        let v5 = 0x1::vector::borrow<address>(&arg2.participants, v2);
        arg2.winner = *v5;
        0x1::vector::push_back<address>(&mut arg1.past_events, 0x2::object::uid_to_address(&arg2.id));
        let v6 = 0;
        while (v6 < 0x1::vector::length<address>(&arg1.active_events)) {
            let v7 = 0x2::object::uid_to_address(&arg2.id);
            if (0x1::vector::borrow<address>(&arg1.active_events, v6) == &v7) {
                0x1::vector::remove<address>(&mut arg1.active_events, v6);
            };
            v6 = v6 + 1;
        };
        let v8 = RaffleWinnerSelected{
            winner : *v5,
            event  : 0x2::object::uid_to_address(&arg2.id),
        };
        0x2::event::emit<RaffleWinnerSelected>(v8);
    }

    // decompiled from Move bytecode v6
}

