module 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory {
    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        real_sui_reserves: 0x2::balance::Balance<0x2::sui::SUI>,
        real_token_reserves: 0x2::balance::Balance<T0>,
        ghost_sui_reserves: u64,
        decimals: u8,
        is_completed: bool,
        last_trade: u64,
        dex_target: vector<u8>,
        migrated: bool,
        creator: address,
    }

    public fun balance_a<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.real_sui_reserves)
    }

    public fun balance_b<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.real_token_reserves)
    }

    public(friend) fun borrow_mut_coin_a<T0>(arg0: &mut Pool<T0>) : &mut 0x2::balance::Balance<0x2::sui::SUI> {
        &mut arg0.real_sui_reserves
    }

    public(friend) fun borrow_mut_coin_b<T0>(arg0: &mut Pool<T0>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.real_token_reserves
    }

    public(friend) fun complete_pool<T0>(arg0: &mut Pool<T0>) {
        arg0.is_completed = true;
    }

    public(friend) fun create_pool<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u8, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : Pool<T0> {
        assert!(0x2::coin::value<T0>(&arg0) > 0, 6);
        Pool<T0>{
            id                  : 0x2::object::new(arg4),
            real_sui_reserves   : 0x2::balance::zero<0x2::sui::SUI>(),
            real_token_reserves : 0x2::coin::into_balance<T0>(arg0),
            ghost_sui_reserves  : arg1,
            decimals            : arg2,
            is_completed        : false,
            last_trade          : 0x2::tx_context::epoch_timestamp_ms(arg4),
            dex_target          : arg3,
            migrated            : false,
            creator             : 0x2::tx_context::sender(arg4),
        }
    }

    public(friend) fun deposit_a<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.real_sui_reserves, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public(friend) fun deposit_b<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.real_token_reserves, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun get_creator<T0>(arg0: &Pool<T0>) : address {
        arg0.creator
    }

    public fun get_decimals<T0>(arg0: &Pool<T0>) : u8 {
        arg0.decimals
    }

    public fun get_dex_target<T0>(arg0: &Pool<T0>) : vector<u8> {
        arg0.dex_target
    }

    public fun get_ghost_reserves<T0>(arg0: &Pool<T0>) : u64 {
        arg0.ghost_sui_reserves
    }

    public fun get_last_trade<T0>(arg0: &Pool<T0>) : u64 {
        arg0.last_trade
    }

    public fun get_pool_id<T0>(arg0: &Pool<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun is_completed<T0>(arg0: &Pool<T0>) : bool {
        arg0.is_completed
    }

    public(friend) fun set_dex_pool_id<T0>(arg0: &mut Pool<T0>, arg1: bool) {
        arg0.migrated = arg1;
    }

    public(friend) fun set_last_trade<T0>(arg0: &mut Pool<T0>, arg1: &0x2::tx_context::TxContext) {
        arg0.last_trade = 0x2::tx_context::epoch_timestamp_ms(arg1);
    }

    // decompiled from Move bytecode v6
}

