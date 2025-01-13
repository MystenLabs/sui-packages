module 0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::snl_v2 {
    struct InitEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
    }

    struct CreateFeeCollectorEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        fee_collector_id: 0x2::object::ID,
    }

    struct CreateGameEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        reward_coin_type: 0x1::type_name::TypeName,
        version: u64,
        game_id: 0x2::object::ID,
        round: u64,
        max_number: u16,
        min_number: u16,
        pay_fee_bp: u16,
        win_fee_bp: u16,
        ticket_price: u64,
        lose_reward_amount_per_ticket: u64,
        special_reward_amount: u64,
        create_at: u64,
    }

    struct FinishGameEvent has copy, drop {
        game_id: 0x2::object::ID,
        pool_balance: u64,
        special_reward_balance: u64,
        lose_ticket_reward_balance: u64,
        win_number: u16,
        total_ticket_num: u64,
        win_protocol_fee: u64,
        win_ticket_num: u64,
        end_at: u64,
    }

    struct BuyTicketsEvent has copy, drop {
        buyer: address,
        numbers: vector<u16>,
        total_price: u64,
        game_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        buy_at: u64,
    }

    struct ClaimRewardEvent has copy, drop {
        coin_type_t: 0x1::type_name::TypeName,
        coin_type_r: 0x1::type_name::TypeName,
        game_id: 0x2::object::ID,
        sender: address,
        win_ticket_num: u64,
        lose_ticket_num: u64,
        win_amount_t: u64,
        lose_amount_r: u64,
        special_reward_amount_s: u64,
        claim_at: u64,
    }

    struct AdditionalAmountToPoolEvent has copy, drop {
        sender: address,
        coin_type: 0x1::type_name::TypeName,
        game_id: 0x2::object::ID,
        amount: u64,
    }

    entry fun claim_fees<T0>(arg0: &0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::admin::AdminCap, arg1: &mut 0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::fee_collector::FeeCollector<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::fee_collector::claim_fees<T0>(arg1, arg2, arg3, arg4);
    }

    public entry fun claim_reward<T0, T1>(arg0: &mut 0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::game::Game<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::game::get_version<T0, T1>(arg0) == 1, 13);
        let (v0, v1, v2, v3, v4) = 0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::game::claim_reward<T0, T1>(arg0, 0x2::tx_context::sender(arg2), arg2);
        let v5 = ClaimRewardEvent{
            coin_type_t             : 0x1::type_name::get<T0>(),
            coin_type_r             : 0x1::type_name::get<T1>(),
            game_id                 : 0x2::object::id<0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::game::Game<T0, T1>>(arg0),
            sender                  : 0x2::tx_context::sender(arg2),
            win_ticket_num          : v0,
            lose_ticket_num         : v1,
            win_amount_t            : v2,
            lose_amount_r           : v3,
            special_reward_amount_s : v4,
            claim_at                : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<ClaimRewardEvent>(v5);
    }

    public entry fun AdditionalAmountToPool<T0, T1>(arg0: &mut 0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::game::Game<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::game::get_version<T0, T1>(arg0) == 1, 13);
        0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::game::add_pool_balance<T0, T1>(arg0, arg1);
        let v0 = AdditionalAmountToPoolEvent{
            sender    : 0x2::tx_context::sender(arg2),
            coin_type : 0x1::type_name::get<T1>(),
            game_id   : 0x2::object::id<0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::game::Game<T0, T1>>(arg0),
            amount    : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<AdditionalAmountToPoolEvent>(v0);
    }

    public entry fun buy_tickets<T0, T1>(arg0: &mut 0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::game::Game<T0, T1>, arg1: &mut 0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::fee_collector::FeeCollector<T0>, arg2: 0x2::coin::Coin<T0>, arg3: vector<u16>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::game::get_version<T0, T1>(arg0) == 1, 13);
        assert!(0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::fee_collector::get_version<T0>(arg1) == 1, 13);
        let v0 = 0x1::vector::length<u16>(&arg3);
        assert!(v0 > 0, 12);
        let v1 = 0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::game::get_ticket_price<T0, T1>(arg0) * v0;
        let v2 = 0x2::coin::into_balance<T0>(arg2);
        0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::game::add_tickets<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v2, v1), arg3, 0x2::tx_context::sender(arg5), arg5);
        let v3 = BuyTicketsEvent{
            buyer       : 0x2::tx_context::sender(arg5),
            numbers     : arg3,
            total_price : v1,
            game_id     : 0x2::object::id<0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::game::Game<T0, T1>>(arg0),
            coin_type   : 0x1::type_name::get<T0>(),
            buy_at      : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<BuyTicketsEvent>(v3);
        if (0x2::balance::value<T0>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg5), 0x2::tx_context::sender(arg5));
        } else {
            0x2::balance::destroy_zero<T0>(v2);
        };
    }

    public entry fun create_counter<T0>(arg0: &0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::counter::Counter<T0>>(0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::counter::new<T0>(arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun create_fee_collector<T0>(arg0: &0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::fee_collector::new<T0>(1, arg1);
        0x2::transfer::public_share_object<0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::fee_collector::FeeCollector<T0>>(v0);
        let v1 = CreateFeeCollectorEvent{
            coin_type        : 0x1::type_name::get<T0>(),
            fee_collector_id : 0x2::object::id<0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::fee_collector::FeeCollector<T0>>(&v0),
        };
        0x2::event::emit<CreateFeeCollectorEvent>(v1);
    }

    public entry fun create_game<T0, T1>(arg0: &0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::admin::AdminCap, arg1: &mut 0x2::coin::TreasuryCap<T1>, arg2: u16, arg3: u16, arg4: u16, arg5: u16, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::counter::Counter<T0>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::game::new_and_shared<T0, T1>(1, arg2, arg3, arg4, arg5, arg6, arg7, 0x2::coin::mint<T1>(arg1, arg8, arg11), arg9, arg10, arg11);
        let v2 = CreateGameEvent{
            coin_type                     : 0x1::type_name::get<T0>(),
            reward_coin_type              : 0x1::type_name::get<T1>(),
            version                       : 1,
            game_id                       : v0,
            round                         : 0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::counter::get_count<T0>(arg9),
            max_number                    : arg2,
            min_number                    : arg3,
            pay_fee_bp                    : arg4,
            win_fee_bp                    : arg5,
            ticket_price                  : arg6,
            lose_reward_amount_per_ticket : arg7,
            special_reward_amount         : arg8,
            create_at                     : v1,
        };
        0x2::event::emit<CreateGameEvent>(v2);
    }

    entry fun finish_game<T0, T1>(arg0: &0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::admin::AdminCap, arg1: &mut 0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::game::Game<T0, T1>, arg2: &mut 0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::fee_collector::FeeCollector<T0>, arg3: &mut 0x2::coin::TreasuryCap<T1>, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::game::get_version<T0, T1>(arg1) == 1, 13);
        0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::game::create_random_winner_number<T0, T1>(arg1, arg4, arg5, arg6);
        0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::game::calc_result<T0, T1>(arg1);
        0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::game::distribute<T0, T1>(arg1, arg2, arg3, 0x2::tx_context::sender(arg6), arg6);
        let v0 = FinishGameEvent{
            game_id                    : 0x2::object::id<0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::game::Game<T0, T1>>(arg1),
            pool_balance               : 0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::game::get_pool_balance<T0, T1>(arg1),
            special_reward_balance     : 0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::game::get_special_reward_balance<T0, T1>(arg1),
            lose_ticket_reward_balance : 0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::game::get_lose_ticket_reward_balance<T0, T1>(arg1),
            win_number                 : 0x1::option::destroy_some<u16>(0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::game::get_win_number<T0, T1>(arg1)),
            total_ticket_num           : 0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::game::get_total_ticket_num<T0, T1>(arg1),
            win_protocol_fee           : 0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::game::get_win_protocol_fee<T0, T1>(arg1),
            win_ticket_num             : 0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::game::get_total_winner_ticket_num<T0, T1>(arg1),
            end_at                     : 0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::game::get_end_time<T0, T1>(arg1),
        };
        0x2::event::emit<FinishGameEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::admin::new(arg0);
        0x2::transfer::public_transfer<0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::admin::AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = InitEvent{admin_cap_id: 0x2::object::id<0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::admin::AdminCap>(&v0)};
        0x2::event::emit<InitEvent>(v1);
    }

    entry fun migrate<T0, T1>(arg0: &0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::admin::AdminCap, arg1: &mut 0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::game::Game<T0, T1>, arg2: &mut 0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::fee_collector::FeeCollector<T0>) {
        assert!(0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::game::get_version<T0, T1>(arg1) < 1, 13);
        assert!(0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::fee_collector::get_version<T0>(arg2) < 1, 13);
        0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::game::set_version<T0, T1>(arg1, 1);
        0x1b72932183a635cfd667c9794a732bb1ee6cc4cf655ec335feb865d992eaa479::fee_collector::set_version<T0>(arg2, 1);
    }

    // decompiled from Move bytecode v6
}

