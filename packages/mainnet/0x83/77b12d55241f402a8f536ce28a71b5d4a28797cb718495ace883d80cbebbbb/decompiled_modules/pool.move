module 0x8377b12d55241f402a8f536ce28a71b5d4a28797cb718495ace883d80cbebbbb::pool {
    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        token_reserve: 0x2::balance::Balance<T0>,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        virtual_sui_mist: u64,
        k: u128,
        launch_time_ms: u64,
        start_fee_bps: u64,
        base_fee_bps: u64,
        decay_duration_ms: u64,
        creator_fee_bps: u64,
        creator_fees_earned: u64,
        total_volume_sui: u64,
        total_swaps: u64,
        anchor_id: 0x2::object::ID,
        creator: address,
    }

    public fun anchor_id<T0>(arg0: &Pool<T0>) : 0x2::object::ID {
        arg0.anchor_id
    }

    public(friend) fun create_and_share<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: u128, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: 0x2::object::ID, arg9: address, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = Pool<T0>{
            id                  : 0x2::object::new(arg10),
            token_reserve       : arg0,
            sui_reserve         : 0x2::balance::zero<0x2::sui::SUI>(),
            virtual_sui_mist    : arg1,
            k                   : arg2,
            launch_time_ms      : arg3,
            start_fee_bps       : arg4,
            base_fee_bps        : arg5,
            decay_duration_ms   : arg6,
            creator_fee_bps     : arg7,
            creator_fees_earned : 0,
            total_volume_sui    : 0,
            total_swaps         : 0,
            anchor_id           : arg8,
            creator             : arg9,
        };
        0x2::transfer::share_object<Pool<T0>>(v0);
        0x2::object::id<Pool<T0>>(&v0)
    }

    public fun creator_fee_bps<T0>(arg0: &Pool<T0>) : u64 {
        arg0.creator_fee_bps
    }

    public fun creator_fees_earned<T0>(arg0: &Pool<T0>) : u64 {
        arg0.creator_fees_earned
    }

    public fun current_fee_bps<T0>(arg0: &Pool<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = if (v0 > arg0.launch_time_ms) {
            v0 - arg0.launch_time_ms
        } else {
            0
        };
        if (v1 >= arg0.decay_duration_ms) {
            arg0.base_fee_bps
        } else {
            arg0.start_fee_bps - (((v1 as u128) * ((arg0.start_fee_bps - arg0.base_fee_bps) as u128) / (arg0.decay_duration_ms as u128)) as u64)
        }
    }

    public(friend) fun deposit_sui<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public(friend) fun deposit_tokens<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.token_reserve, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun effective_sui<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) + arg0.virtual_sui_mist
    }

    public fun k<T0>(arg0: &Pool<T0>) : u128 {
        arg0.k
    }

    public fun pool_creator<T0>(arg0: &Pool<T0>) : address {
        arg0.creator
    }

    public fun real_sui_reserve<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve)
    }

    public fun real_token_reserve<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.token_reserve)
    }

    public(friend) fun record_swap<T0>(arg0: &mut Pool<T0>, arg1: u64) {
        arg0.total_volume_sui = arg0.total_volume_sui + arg1;
        arg0.total_swaps = arg0.total_swaps + 1;
    }

    public fun total_swaps<T0>(arg0: &Pool<T0>) : u64 {
        arg0.total_swaps
    }

    public fun total_volume_sui<T0>(arg0: &Pool<T0>) : u64 {
        arg0.total_volume_sui
    }

    public fun virtual_sui_mist<T0>(arg0: &Pool<T0>) : u64 {
        arg0.virtual_sui_mist
    }

    public(friend) fun withdraw_creator_fee<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = (((arg1 as u128) * (arg0.creator_fee_bps as u128) / 10000) as u64);
        arg0.creator_fees_earned = arg0.creator_fees_earned + v0;
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v0), arg2)
    }

    public(friend) fun withdraw_sui<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, arg1), arg2)
    }

    public(friend) fun withdraw_tokens<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_reserve, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

