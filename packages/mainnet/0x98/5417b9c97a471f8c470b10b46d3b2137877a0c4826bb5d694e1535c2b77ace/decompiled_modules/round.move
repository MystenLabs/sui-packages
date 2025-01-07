module 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::round {
    struct RoundKey<phantom T0, phantom T1> has copy, drop, store {
        epoch: u64,
    }

    struct RoundInfo<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        epoch: u64,
        start_timestamp: u64,
        lock_timestamp: u64,
        close_timestamp: u64,
        lock_price: u128,
        close_price: u128,
        price_decimal: u16,
        lock_oracle_id: u64,
        close_oracle_id: u64,
        total_amount: u64,
        bull_amount: u64,
        bear_amount: u64,
        reward_base_cal_amount: u64,
        reward_amount: u64,
        total_user: u64,
        is_finished: bool,
        error_code: u64,
    }

    struct StartRoundEvent has copy, drop {
        round_id: 0x2::object::ID,
        pool: 0x1::string::String,
        pair_name: 0x1::string::String,
        pair_index: u32,
        epoch: u64,
    }

    struct LockRoundEvent has copy, drop {
        round_id: 0x2::object::ID,
        pool: 0x1::string::String,
        pair_name: 0x1::string::String,
        pair_index: u32,
        epoch: u64,
        lock_oracle_id: u64,
        lock_price: u128,
    }

    struct EndRoundEvent has copy, drop {
        round_id: 0x2::object::ID,
        pool: 0x1::string::String,
        pair_name: 0x1::string::String,
        pair_index: u32,
        epoch: u64,
        oracle_round_id: u64,
        close_price: u128,
        price_decimal: u16,
    }

    struct RewardCalculatedEvent has copy, drop {
        round_id: 0x2::object::ID,
        pool: 0x1::string::String,
        pair_name: 0x1::string::String,
        pair_index: u32,
        epoch: u64,
        reward_base_cal_amount: u64,
        reward_amount: u64,
        treasury_amount: u64,
    }

    struct ForceStopRoundEvent has copy, drop {
        round_id: 0x2::object::ID,
        pool: 0x1::string::String,
        pair_name: 0x1::string::String,
        pair_index: u32,
        epoch: u64,
        oracle_round_id: u64,
        price: u128,
        price_decimal: u16,
        error_code: u64,
    }

    public fun bettable<T0, T1>(arg0: &RoundInfo<T0, T1>, arg1: u64) : bool {
        arg0.start_timestamp != 0 && arg0.lock_timestamp != 0 && arg1 > arg0.start_timestamp && arg1 < arg0.lock_timestamp
    }

    public(friend) fun calculate_rewards<T0, T1>(arg0: &0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::Configuration<T0, T1>, arg1: &mut RoundInfo<T0, T1>, arg2: u64) : u64 {
        assert!(arg1.reward_base_cal_amount == 0 && arg1.reward_amount == 0, 400);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        if (arg1.is_finished && arg1.error_code == 0) {
            if (arg1.close_price > arg1.lock_price) {
                v0 = arg1.bull_amount;
                let v3 = ((((arg1.total_amount * 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_treasury_fee<T0, T1>(arg0)) as u128) / 10000) as u64);
                v1 = v3;
                v2 = arg1.total_amount - v3;
            } else if (arg1.close_price < arg1.lock_price) {
                v0 = arg1.bear_amount;
                let v4 = ((((arg1.total_amount * 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_treasury_fee<T0, T1>(arg0)) as u128) / 10000) as u64);
                v1 = v4;
                v2 = arg1.total_amount - v4;
            } else {
                v1 = arg1.total_amount;
            };
            arg1.reward_base_cal_amount = v0;
            arg1.reward_amount = v2;
            let v5 = RewardCalculatedEvent{
                round_id               : 0x2::object::uid_to_inner(&arg1.id),
                pool                   : 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pool<T0, T1>(arg0),
                pair_name              : 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pair_name<T0, T1>(arg0),
                pair_index             : 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pair_index<T0, T1>(arg0),
                epoch                  : arg2,
                reward_base_cal_amount : v0,
                reward_amount          : v2,
                treasury_amount        : v1,
            };
            0x2::event::emit<RewardCalculatedEvent>(v5);
        };
        v1
    }

    public(friend) fun end_round<T0, T1>(arg0: &0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::Configuration<T0, T1>, arg1: &mut RoundInfo<T0, T1>, arg2: u64, arg3: u64, arg4: u128, arg5: u16, arg6: u64) {
        arg1.close_timestamp = arg6;
        arg1.close_price = arg4;
        arg1.price_decimal = arg5;
        arg1.close_oracle_id = arg3;
        arg1.is_finished = true;
        let v0 = EndRoundEvent{
            round_id        : 0x2::object::uid_to_inner(&arg1.id),
            pool            : 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pool<T0, T1>(arg0),
            pair_name       : 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pair_name<T0, T1>(arg0),
            pair_index      : 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pair_index<T0, T1>(arg0),
            epoch           : arg2,
            oracle_round_id : arg3,
            close_price     : arg4,
            price_decimal   : arg5,
        };
        0x2::event::emit<EndRoundEvent>(v0);
    }

    public(friend) fun force_stop_round<T0, T1>(arg0: &0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::Configuration<T0, T1>, arg1: &mut RoundInfo<T0, T1>, arg2: u64, arg3: u64) {
        arg1.is_finished = true;
        arg1.error_code = arg3;
        let v0 = ForceStopRoundEvent{
            round_id        : 0x2::object::uid_to_inner(&arg1.id),
            pool            : 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pool<T0, T1>(arg0),
            pair_name       : 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pair_name<T0, T1>(arg0),
            pair_index      : 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pair_index<T0, T1>(arg0),
            epoch           : arg2,
            oracle_round_id : 0,
            price           : 0,
            price_decimal   : 0,
            error_code      : arg3,
        };
        0x2::event::emit<ForceStopRoundEvent>(v0);
    }

    public fun get_close_timestamp<T0, T1>(arg0: &RoundInfo<T0, T1>) : u64 {
        arg0.close_timestamp
    }

    public fun get_epoch<T0, T1>(arg0: &RoundInfo<T0, T1>) : u64 {
        arg0.epoch
    }

    public fun get_lock_timestamp<T0, T1>(arg0: &RoundInfo<T0, T1>) : u64 {
        arg0.lock_timestamp
    }

    public fun get_round_info<T0, T1>(arg0: &RoundInfo<T0, T1>) : (u64, bool, u64, u64, u64, u64, u128, u128, u16, u64, u64, u64, u64, u64, u64, u64, u64) {
        (arg0.epoch, arg0.is_finished, arg0.error_code, arg0.start_timestamp, arg0.lock_timestamp, arg0.close_timestamp, arg0.lock_price, arg0.close_price, arg0.price_decimal, arg0.total_amount, arg0.bull_amount, arg0.bear_amount, arg0.reward_base_cal_amount, arg0.reward_amount, arg0.lock_oracle_id, arg0.close_oracle_id, arg0.total_user)
    }

    public fun is_bear_round<T0, T1>(arg0: &RoundInfo<T0, T1>) : bool {
        arg0.is_finished && arg0.error_code == 0 && arg0.close_price > arg0.lock_price
    }

    public fun is_bull_round<T0, T1>(arg0: &RoundInfo<T0, T1>) : bool {
        arg0.is_finished && arg0.error_code == 0 && arg0.close_price < arg0.lock_price
    }

    public fun is_finished<T0, T1>(arg0: &RoundInfo<T0, T1>) : bool {
        arg0.is_finished
    }

    public(friend) fun lock_round<T0, T1>(arg0: &0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::Configuration<T0, T1>, arg1: &mut RoundInfo<T0, T1>, arg2: u64, arg3: u64, arg4: u128, arg5: u16, arg6: u64) {
        arg1.lock_timestamp = arg6;
        arg1.close_timestamp = arg6 + 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::utils::to_miliseconds(0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_interval_seconds<T0, T1>(arg0));
        arg1.lock_price = arg4;
        arg1.price_decimal = arg5;
        arg1.lock_oracle_id = arg3;
        let v0 = LockRoundEvent{
            round_id       : 0x2::object::uid_to_inner(&arg1.id),
            pool           : 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pool<T0, T1>(arg0),
            pair_name      : 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pair_name<T0, T1>(arg0),
            pair_index     : 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pair_index<T0, T1>(arg0),
            epoch          : arg2,
            lock_oracle_id : arg1.lock_oracle_id,
            lock_price     : arg1.lock_price,
        };
        0x2::event::emit<LockRoundEvent>(v0);
    }

    public(friend) fun new_round_key<T0, T1>(arg0: u64) : RoundKey<T0, T1> {
        RoundKey<T0, T1>{epoch: arg0}
    }

    public(friend) fun start_round<T0, T1>(arg0: &0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::Configuration<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : RoundInfo<T0, T1> {
        let v0 = RoundInfo<T0, T1>{
            id                     : 0x2::object::new(arg3),
            epoch                  : arg1,
            start_timestamp        : arg2,
            lock_timestamp         : arg2 + 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::utils::to_miliseconds(0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_interval_seconds<T0, T1>(arg0)),
            close_timestamp        : arg2 + 2 * 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::utils::to_miliseconds(0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_interval_seconds<T0, T1>(arg0)),
            lock_price             : 0,
            close_price            : 0,
            price_decimal          : 1,
            lock_oracle_id         : 0,
            close_oracle_id        : 0,
            total_amount           : 0,
            bull_amount            : 0,
            bear_amount            : 0,
            reward_base_cal_amount : 0,
            reward_amount          : 0,
            total_user             : 0,
            is_finished            : false,
            error_code             : 0,
        };
        let v1 = StartRoundEvent{
            round_id   : 0x2::object::uid_to_inner(&v0.id),
            pool       : 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pool<T0, T1>(arg0),
            pair_name  : 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pair_name<T0, T1>(arg0),
            pair_index : 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pair_index<T0, T1>(arg0),
            epoch      : arg1,
        };
        0x2::event::emit<StartRoundEvent>(v1);
        v0
    }

    public(friend) fun stop_end_round<T0, T1>(arg0: &0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::Configuration<T0, T1>, arg1: &mut RoundInfo<T0, T1>, arg2: u64, arg3: u64, arg4: u128, arg5: u16, arg6: u64, arg7: u64) {
        arg1.close_timestamp = arg6;
        arg1.close_price = arg4;
        arg1.price_decimal = arg5;
        arg1.close_oracle_id = arg3;
        arg1.is_finished = true;
        arg1.error_code = arg7;
        let v0 = ForceStopRoundEvent{
            round_id        : 0x2::object::uid_to_inner(&arg1.id),
            pool            : 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pool<T0, T1>(arg0),
            pair_name       : 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pair_name<T0, T1>(arg0),
            pair_index      : 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pair_index<T0, T1>(arg0),
            epoch           : arg2,
            oracle_round_id : arg3,
            price           : arg4,
            price_decimal   : arg5,
            error_code      : arg7,
        };
        0x2::event::emit<ForceStopRoundEvent>(v0);
    }

    public(friend) fun stop_lock_round<T0, T1>(arg0: &0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::Configuration<T0, T1>, arg1: &mut RoundInfo<T0, T1>, arg2: u64, arg3: u64, arg4: u128, arg5: u16, arg6: u64, arg7: u64) {
        arg1.lock_timestamp = arg6;
        arg1.close_timestamp = arg6 + 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::utils::to_miliseconds(0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_interval_seconds<T0, T1>(arg0));
        arg1.lock_price = arg4;
        arg1.price_decimal = arg5;
        arg1.lock_oracle_id = arg3;
        arg1.is_finished = true;
        arg1.error_code = arg7;
        let v0 = ForceStopRoundEvent{
            round_id        : 0x2::object::uid_to_inner(&arg1.id),
            pool            : 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pool<T0, T1>(arg0),
            pair_name       : 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pair_name<T0, T1>(arg0),
            pair_index      : 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pair_index<T0, T1>(arg0),
            epoch           : arg2,
            oracle_round_id : arg3,
            price           : arg4,
            price_decimal   : arg5,
            error_code      : arg7,
        };
        0x2::event::emit<ForceStopRoundEvent>(v0);
    }

    public(friend) fun update_bet_amount<T0, T1>(arg0: &mut RoundInfo<T0, T1>, arg1: u64, arg2: u8) {
        arg0.total_user = arg0.total_user + 1;
        arg0.total_amount = arg0.total_amount + arg1;
        if (0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::utils::is_bear_position(arg2)) {
            arg0.bear_amount = arg0.bear_amount + arg1;
        } else {
            arg0.bull_amount = arg0.bull_amount + arg1;
        };
    }

    // decompiled from Move bytecode v6
}

