module 0x930774cda842642dfa66ade5fc37fb48f6863b630ba11fd6e0e76bc26de59580::game {
    struct CreateGameEvent has copy, drop {
        id: address,
        participation_fee: u64,
        max_participation_fee: u64,
        increment: u64,
        increment_interval: u64,
        time_limit: u64,
    }

    struct StartGameEvent has copy, drop {
        id: address,
        reward: u64,
        participation_fee: u64,
    }

    struct PressGameEvent has copy, drop {
        id: address,
        count: u64,
        current_contender: address,
        end_time: u64,
        current_reward: u64,
    }

    struct EndGameEvent has copy, drop {
        id: address,
        winner: address,
        reward: u64,
    }

    struct Game<phantom T0> has key {
        id: 0x2::object::UID,
        count: u64,
        reward: 0x2::balance::Balance<T0>,
        current_contender: address,
        end_time: u64,
        time_limit: u64,
        base_participation_fee: u64,
        increment: u64,
        increment_interval: u64,
        platform_fee_bps: u16,
        started: bool,
        max_participation_fee: u64,
        final_reward: u64,
        ended: bool,
    }

    struct GameAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun create<T0>(arg0: &GameAdminCap, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x930774cda842642dfa66ade5fc37fb48f6863b630ba11fd6e0e76bc26de59580::platform::Platform, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg9);
        let v1 = Game<T0>{
            id                     : v0,
            count                  : 0,
            reward                 : 0x2::coin::into_balance<T0>(arg2),
            current_contender      : @0x0,
            end_time               : 0x2::clock::timestamp_ms(arg7) + arg1,
            time_limit             : arg1,
            base_participation_fee : arg3,
            increment              : arg4,
            increment_interval     : arg5,
            platform_fee_bps       : 0x930774cda842642dfa66ade5fc37fb48f6863b630ba11fd6e0e76bc26de59580::platform::get_platform_fee_bps(arg8),
            started                : false,
            max_participation_fee  : arg6,
            final_reward           : 0,
            ended                  : false,
        };
        0x2::transfer::share_object<Game<T0>>(v1);
        let v2 = CreateGameEvent{
            id                    : 0x2::object::uid_to_address(&v0),
            participation_fee     : arg3,
            max_participation_fee : arg6,
            increment             : arg4,
            increment_interval    : arg5,
            time_limit            : arg1,
        };
        0x2::event::emit<CreateGameEvent>(v2);
    }

    public fun end_game<T0>(arg0: &mut Game<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.ended, 5);
        arg0.ended = true;
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.end_time, 4);
        let v0 = 0x2::balance::zero<T0>();
        0x2::balance::join<T0>(&mut v0, 0x2::balance::withdraw_all<T0>(&mut arg0.reward));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg2), arg0.current_contender);
        let v1 = EndGameEvent{
            id     : 0x2::object::uid_to_address(&arg0.id),
            winner : arg0.current_contender,
            reward : 0x2::balance::value<T0>(&arg0.reward),
        };
        0x2::event::emit<EndGameEvent>(v1);
    }

    fun get_participation_fee<T0>(arg0: &Game<T0>) : u64 {
        arg0.base_participation_fee + arg0.increment * arg0.count / arg0.increment_interval
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<GameAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun press<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut Game<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x930774cda842642dfa66ade5fc37fb48f6863b630ba11fd6e0e76bc26de59580::platform::Platform, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 < arg1.end_time || !arg1.started, 4);
        if (!arg1.started) {
            arg1.started = true;
            let v1 = StartGameEvent{
                id                : 0x2::object::uid_to_address(&arg1.id),
                reward            : 0x2::balance::value<T0>(&arg1.reward),
                participation_fee : arg1.base_participation_fee,
            };
            0x2::event::emit<StartGameEvent>(v1);
        };
        assert!(0x2::tx_context::sender(arg4) != arg1.current_contender, 3);
        let v2 = get_participation_fee<T0>(arg1);
        assert!(0x2::coin::value<T0>(&arg0) >= v2, 5);
        let v3 = if (v2 > arg1.max_participation_fee) {
            0x2::coin::split<T0>(&mut arg0, arg1.max_participation_fee, arg4)
        } else {
            0x2::coin::split<T0>(&mut arg0, v2, arg4)
        };
        let v4 = v3;
        if (0x930774cda842642dfa66ade5fc37fb48f6863b630ba11fd6e0e76bc26de59580::platform::get_platform_fee_bps(arg3) > 0) {
            0x930774cda842642dfa66ade5fc37fb48f6863b630ba11fd6e0e76bc26de59580::platform::deposit_coin<T0>(arg3, 0x2::coin::split<T0>(&mut v4, v2 * (arg1.platform_fee_bps as u64) / 10000, arg4));
        };
        0x2::balance::join<T0>(&mut arg1.reward, 0x2::coin::into_balance<T0>(v4));
        arg1.count = arg1.count + 1;
        arg1.end_time = v0 + arg1.time_limit;
        arg1.current_contender = 0x2::tx_context::sender(arg4);
        arg1.final_reward = 0x2::balance::value<T0>(&arg1.reward);
        let v5 = PressGameEvent{
            id                : 0x2::object::uid_to_address(&arg1.id),
            count             : arg1.count,
            current_contender : arg1.current_contender,
            end_time          : arg1.end_time,
            current_reward    : 0x2::balance::value<T0>(&arg1.reward),
        };
        0x2::event::emit<PressGameEvent>(v5);
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg4));
        };
    }

    // decompiled from Move bytecode v6
}

