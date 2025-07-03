module 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken {
    struct VEHEADAL has drop {
        dummy_field: bool,
    }

    struct VeHAEDAL<phantom T0> has store, key {
        id: 0x2::object::UID,
        locked_amount: u64,
        initial_amount: u64,
        current_amount: u64,
        lock_start_time: u64,
        lock_end_time: u64,
        owner: address,
        token_type: 0x1::type_name::TypeName,
        is_decaying: bool,
        remaining_lock_weeks_when_stopped_decay: u64,
        original_lock_weeks: u64,
    }

    public(friend) fun add_locked_amount<T0>(arg0: &mut VeHAEDAL<T0>, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = if (v0 >= arg0.lock_end_time) {
            0
        } else {
            (arg0.lock_end_time - v0) / 7 * 3600 * 1000
        };
        arg0.locked_amount = arg0.locked_amount + arg1;
        let v2 = arg0.initial_amount + arg1 * v1 / 52;
        arg0.initial_amount = v2;
        arg0.current_amount = get_current_value<T0>(arg0, arg2);
        v2
    }

    public(friend) fun create_veheadal<T0>(arg0: u64, arg1: u64, arg2: address, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : (VeHAEDAL<T0>, u64) {
        let v0 = arg0 * arg1 / 52;
        let v1 = VeHAEDAL<T0>{
            id                                      : 0x2::object::new(arg5),
            locked_amount                           : arg0,
            initial_amount                          : v0,
            current_amount                          : v0,
            lock_start_time                         : arg3,
            lock_end_time                           : arg3 + arg1 * 7 * 3600 * 1000,
            owner                                   : arg2,
            token_type                              : 0x1::type_name::get<T0>(),
            is_decaying                             : arg4,
            remaining_lock_weeks_when_stopped_decay : arg1,
            original_lock_weeks                     : arg1,
        };
        (v1, v0)
    }

    public(friend) fun destroy_veheadal<T0>(arg0: VeHAEDAL<T0>) {
        let VeHAEDAL {
            id                                      : v0,
            locked_amount                           : _,
            initial_amount                          : _,
            current_amount                          : _,
            lock_start_time                         : _,
            lock_end_time                           : _,
            owner                                   : _,
            token_type                              : _,
            is_decaying                             : _,
            remaining_lock_weeks_when_stopped_decay : _,
            original_lock_weeks                     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun extend_lock<T0>(arg0: &mut VeHAEDAL<T0>, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        let (v0, v1) = if (!arg0.is_decaying) {
            (0x2::clock::timestamp_ms(arg2) + arg0.remaining_lock_weeks_when_stopped_decay * 7 * 3600 * 1000 + arg1 * 7 * 3600 * 1000, arg0.remaining_lock_weeks_when_stopped_decay + arg1)
        } else {
            let v2 = arg0.lock_end_time + arg1 * 7 * 3600 * 1000;
            (v2, (v2 - arg0.lock_start_time) / 7 * 3600 * 1000)
        };
        let v3 = arg0.locked_amount * v1 / 52;
        arg0.initial_amount = v3;
        arg0.current_amount = v3;
        arg0.lock_end_time = v0;
        arg0.original_lock_weeks = v1;
        if (!arg0.is_decaying) {
            arg0.remaining_lock_weeks_when_stopped_decay = v1;
        };
        v3
    }

    public(friend) fun get_current_value<T0>(arg0: &VeHAEDAL<T0>, arg1: &0x2::clock::Clock) : u64 {
        if (!arg0.is_decaying) {
            return arg0.initial_amount
        };
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 >= arg0.lock_end_time) {
            return 0
        };
        if (v0 <= arg0.lock_start_time) {
            return arg0.initial_amount
        };
        let v1 = arg0.lock_end_time - arg0.lock_start_time;
        (((arg0.initial_amount as u128) * (((v1 - v0 - arg0.lock_start_time) * 10000 / v1) as u128) / (10000 as u128)) as u64)
    }

    public fun get_initial_amount<T0>(arg0: &VeHAEDAL<T0>) : u64 {
        arg0.initial_amount
    }

    public fun get_lock_end_time<T0>(arg0: &VeHAEDAL<T0>) : u64 {
        arg0.lock_end_time
    }

    public fun get_lock_start_time<T0>(arg0: &VeHAEDAL<T0>) : u64 {
        arg0.lock_start_time
    }

    public fun get_locked_amount<T0>(arg0: &VeHAEDAL<T0>) : u64 {
        arg0.locked_amount
    }

    public fun get_owner<T0>(arg0: &VeHAEDAL<T0>) : address {
        arg0.owner
    }

    public fun get_remaining_lock_weeks_when_stopped_decay<T0>(arg0: &VeHAEDAL<T0>) : u64 {
        arg0.remaining_lock_weeks_when_stopped_decay
    }

    public fun get_token_type<T0>(arg0: &VeHAEDAL<T0>) : 0x1::type_name::TypeName {
        arg0.token_type
    }

    public fun is_decaying<T0>(arg0: &VeHAEDAL<T0>) : bool {
        arg0.is_decaying
    }

    public fun is_expired<T0>(arg0: &VeHAEDAL<T0>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.lock_end_time
    }

    public fun is_expired_same_day<T0>(arg0: &VeHAEDAL<T0>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.lock_end_time / 3600 * 1000 * 3600 * 1000
    }

    public(friend) fun start_decay<T0>(arg0: &mut VeHAEDAL<T0>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (arg0.remaining_lock_weeks_when_stopped_decay > 0) {
            arg0.lock_end_time = v0 + arg0.remaining_lock_weeks_when_stopped_decay * 7 * 3600 * 1000;
            arg0.lock_start_time = v0;
        };
        arg0.is_decaying = true;
    }

    public(friend) fun stop_decay<T0>(arg0: &mut VeHAEDAL<T0>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = if (v0 >= arg0.lock_end_time) {
            0
        } else {
            let v2 = arg0.lock_end_time - v0;
            let v3 = 7 * 3600 * 1000;
            if (v2 % v3 > 0) {
                v2 / v3 + 1
            } else {
                v2 / v3
            }
        };
        arg0.remaining_lock_weeks_when_stopped_decay = v1;
        arg0.is_decaying = false;
    }

    public(friend) fun update_current_amount<T0>(arg0: &mut VeHAEDAL<T0>, arg1: &0x2::clock::Clock) {
        arg0.current_amount = get_current_value<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

