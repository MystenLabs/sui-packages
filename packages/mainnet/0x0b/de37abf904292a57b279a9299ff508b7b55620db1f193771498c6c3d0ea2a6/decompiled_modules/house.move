module 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::house {
    struct StakedCoin<phantom T0> has drop {
        dummy_field: bool,
    }

    struct PoolDebt<phantom T0> has drop {
        dummy_field: bool,
    }

    struct SupplyGrave<phantom T0> has store, key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<T0>,
    }

    struct Weights has copy, drop, store {
        pos0: u64,
        pos1: u64,
        pos2: u64,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        max_capacity: u64,
        pipe_debt: 0x2::balance::Supply<PoolDebt<T0>>,
        metadata: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct House<phantom T0> has store, key {
        id: 0x2::object::UID,
        coin_decimals: u8,
        public_supply: 0x2::balance::Supply<StakedCoin<T0>>,
        public_deposit_fee: u64,
        private_pool_daily_withdrawal_limit: u64,
        private_pool_withdrawn_amount_current_day: u64,
        private_pool_last_day_reset: u64,
        private_pool: Pool<T0>,
        whitelist_pools: vector<Pool<T0>>,
        public_pool: Pool<T0>,
        rakeback_pool: Pool<T0>,
        distribution_mode: u8,
        distribution_weights: Weights,
        whitelist_pool_weights: vector<u64>,
        whitelist_pool_owners: vector<address>,
    }

    struct StakeEvent<phantom T0> has copy, drop {
        user: address,
        amount: u64,
        s_coin_amount: u64,
    }

    struct WithdrawStakeEvent<phantom T0> has copy, drop {
        user: address,
        amount: u64,
        s_coin_amount: u64,
    }

    struct WhitelistPoolDestroyedEvent<phantom T0> has copy, drop {
        owner: address,
        pool_id: 0x2::object::ID,
    }

    struct WhitelistPoolDepositEvent<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        depositor: address,
        pool_owner: address,
        amount: u64,
    }

    public(friend) fun new<T0>(arg0: u8, arg1: &mut 0x2::tx_context::TxContext) : House<T0> {
        let v0 = 0x2::object::new(arg1);
        let v1 = StakedCoin<T0>{dummy_field: false};
        let v2 = new_pool<T0>(arg1);
        let v3 = new_pool<T0>(arg1);
        let v4 = Weights{
            pos0 : 1,
            pos1 : 1,
            pos2 : 1,
        };
        House<T0>{
            id                                        : v0,
            coin_decimals                             : arg0,
            public_supply                             : 0x2::balance::create_supply<StakedCoin<T0>>(v1),
            public_deposit_fee                        : 0,
            private_pool_daily_withdrawal_limit       : 0,
            private_pool_withdrawn_amount_current_day : 0,
            private_pool_last_day_reset               : 0,
            private_pool                              : v2,
            whitelist_pools                           : 0x1::vector::empty<Pool<T0>>(),
            public_pool                               : v3,
            rakeback_pool                             : new_pool<T0>(arg1),
            distribution_mode                         : 0,
            distribution_weights                      : v4,
            whitelist_pool_weights                    : 0x1::vector::empty<u64>(),
            whitelist_pool_owners                     : 0x1::vector::empty<address>(),
        }
    }

    public(friend) fun borrow_pool_from_id<T0>(arg0: &House<T0>, arg1: &0x2::object::ID) : &Pool<T0> {
        let v0 = get_id<T0>(&arg0.private_pool);
        if (arg1 == &v0) {
            return &arg0.private_pool
        };
        let v1 = get_id<T0>(&arg0.public_pool);
        if (arg1 == &v1) {
            return &arg0.public_pool
        };
        let v2 = get_id<T0>(&arg0.rakeback_pool);
        if (arg1 == &v2) {
            return &arg0.rakeback_pool
        };
        let v3 = 0;
        let v4 = false;
        let v5 = 0;
        while (v3 < 0x1::vector::length<Pool<T0>>(&arg0.whitelist_pools)) {
            let v6 = get_id<T0>(0x1::vector::borrow<Pool<T0>>(&arg0.whitelist_pools, v3));
            if (&v6 == arg1) {
                v4 = true;
                v5 = v3;
                break
            };
            v3 = v3 + 1;
        };
        if (!v4) {
            abort 13837030068042072077
        };
        0x1::vector::borrow<Pool<T0>>(&arg0.whitelist_pools, v5)
    }

    public(friend) fun borrow_pool_mut_from_id<T0>(arg0: &mut House<T0>, arg1: &0x2::object::ID) : &mut Pool<T0> {
        let v0 = get_id<T0>(&arg0.private_pool);
        if (arg1 == &v0) {
            return &mut arg0.private_pool
        };
        let v1 = get_id<T0>(&arg0.public_pool);
        if (arg1 == &v1) {
            return &mut arg0.public_pool
        };
        let v2 = get_id<T0>(&arg0.rakeback_pool);
        if (arg1 == &v2) {
            return &mut arg0.rakeback_pool
        };
        let v3 = 0;
        let v4 = false;
        let v5 = 0;
        while (v3 < 0x1::vector::length<Pool<T0>>(&arg0.whitelist_pools)) {
            let v6 = get_id<T0>(0x1::vector::borrow<Pool<T0>>(&arg0.whitelist_pools, v3));
            if (&v6 == arg1) {
                v4 = true;
                v5 = v3;
                break
            };
            v3 = v3 + 1;
        };
        if (!v4) {
            abort 13837030218365927437
        };
        0x1::vector::borrow_mut<Pool<T0>>(&mut arg0.whitelist_pools, v5)
    }

    public(friend) fun create_whitelist_pool<T0>(arg0: &mut House<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.whitelist_pool_owners)) {
            if (*0x1::vector::borrow<address>(&arg0.whitelist_pool_owners, v0) == arg1) {
                abort 13839283796296990747
            };
            v0 = v0 + 1;
        };
        assert!(0x1::vector::length<address>(&arg0.whitelist_pool_owners) < 50, 13840691188361068581);
        0x1::vector::push_back<Pool<T0>>(&mut arg0.whitelist_pools, new_pool<T0>(arg2));
        0x1::vector::push_back<address>(&mut arg0.whitelist_pool_owners, arg1);
        0x1::vector::push_back<u64>(&mut arg0.whitelist_pool_weights, 1);
        assert!(0x1::vector::length<Pool<T0>>(&arg0.whitelist_pools) == 0x1::vector::length<address>(&arg0.whitelist_pool_owners), 13838720880703045655);
        assert!(0x1::vector::length<Pool<T0>>(&arg0.whitelist_pools) == 0x1::vector::length<u64>(&arg0.whitelist_pool_weights), 13838720884998012951);
    }

    public(friend) fun delete_empty_whitelist_pool<T0>(arg0: &mut House<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Pool<T0>>(&arg0.whitelist_pools)) {
            if (*0x1::vector::borrow<address>(&arg0.whitelist_pool_owners, v1) == arg1) {
                v0 = true;
            };
            if (*0x1::vector::borrow<address>(&arg0.whitelist_pool_owners, v1) == arg1 && 0x2::balance::value<T0>(&0x1::vector::borrow<Pool<T0>>(&arg0.whitelist_pools, v1).balance) == 0) {
                let v2 = 0x1::vector::remove<Pool<T0>>(&mut arg0.whitelist_pools, v1);
                0x1::vector::remove<u64>(&mut arg0.whitelist_pool_weights, v1);
                destroy_empty_pool<T0>(v2, arg2);
                let v3 = WhitelistPoolDestroyedEvent<T0>{
                    owner   : 0x1::vector::remove<address>(&mut arg0.whitelist_pool_owners, v1),
                    pool_id : get_id<T0>(&v2),
                };
                0x2::event::emit<WhitelistPoolDestroyedEvent<T0>>(v3);
                break
            };
            v1 = v1 + 1;
        };
        assert!(v0, 13839565447367491613);
    }

    public(friend) fun deposit_public_pool<T0>(arg0: &mut House<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<StakedCoin<T0>> {
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = total_public_pool_balance<T0>(arg0);
        assert!(v0 + v1 <= arg0.public_pool.max_capacity, 13836468479593152523);
        let v2 = 0x2::balance::supply_value<StakedCoin<T0>>(&arg0.public_supply);
        0x2::balance::join<T0>(&mut arg0.public_pool.balance, arg1);
        if (v2 == 0 || v1 == 0) {
            let v3 = v0 + v1;
            let v4 = StakeEvent<T0>{
                user          : 0x2::tx_context::sender(arg2),
                amount        : v0,
                s_coin_amount : v3,
            };
            0x2::event::emit<StakeEvent<T0>>(v4);
            return 0x2::coin::from_balance<StakedCoin<T0>>(0x2::balance::increase_supply<StakedCoin<T0>>(&mut arg0.public_supply, v3), arg2)
        };
        let v5 = (((v0 as u128) * (v2 as u128) / (v1 as u128)) as u64);
        let v6 = StakeEvent<T0>{
            user          : 0x2::tx_context::sender(arg2),
            amount        : v0,
            s_coin_amount : v5,
        };
        0x2::event::emit<StakeEvent<T0>>(v6);
        0x2::coin::from_balance<StakedCoin<T0>>(0x2::balance::increase_supply<StakedCoin<T0>>(&mut arg0.public_supply, v5), arg2)
    }

    public(friend) fun deposit_whitelist_pool<T0>(arg0: &mut House<T0>, arg1: address, arg2: address, arg3: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0.whitelist_pool_owners)) {
            if (*0x1::vector::borrow<address>(&arg0.whitelist_pool_owners, v1) == arg2) {
                break
            };
            v1 = v1 + 1;
        };
        if (v1 == 0x1::vector::length<address>(&arg0.whitelist_pool_owners)) {
            abort 13839565524676902941
        };
        let v2 = 0x1::vector::borrow_mut<Pool<T0>>(&mut arg0.whitelist_pools, v1);
        assert!(get_pool_total_value<T0>(v2) + v0 <= v2.max_capacity, 13839847012538646559);
        0x2::balance::join<T0>(&mut v2.balance, arg3);
        let v3 = WhitelistPoolDepositEvent<T0>{
            pool_id    : get_id<T0>(v2),
            depositor  : arg1,
            pool_owner : arg2,
            amount     : v0,
        };
        0x2::event::emit<WhitelistPoolDepositEvent<T0>>(v3);
    }

    fun destroy_empty_pool<T0>(arg0: Pool<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let Pool {
            id           : v0,
            balance      : v1,
            max_capacity : _,
            pipe_debt    : v3,
            metadata     : _,
        } = arg0;
        let v5 = v3;
        let v6 = v1;
        if (0x2::balance::value<T0>(&v6) > 0) {
            abort 13838999435102126105
        };
        0x2::balance::destroy_zero<T0>(v6);
        if (0x2::balance::supply_value<PoolDebt<T0>>(&v5) > 0) {
            abort 13838999456576962585
        };
        let v7 = SupplyGrave<PoolDebt<T0>>{
            id     : 0x2::object::new(arg1),
            supply : v5,
        };
        0x2::transfer::public_transfer<SupplyGrave<PoolDebt<T0>>>(v7, @0x0);
        0x2::object::delete(v0);
    }

    public(friend) fun edit_coin_decimals<T0>(arg0: &mut House<T0>, arg1: u8) {
        arg0.coin_decimals = arg1;
    }

    public(friend) fun edit_public_pool_max_capacity<T0>(arg0: &mut House<T0>, arg1: u64) {
        arg0.public_pool.max_capacity = arg1;
    }

    public(friend) fun edit_whitelist_pool_max_capacity<T0>(arg0: &mut House<T0>, arg1: address, arg2: u64) {
        let v0 = 0x1::vector::length<Pool<T0>>(&arg0.whitelist_pools);
        let v1 = 0;
        while (v1 < v0) {
            if (0x1::vector::borrow<address>(&arg0.whitelist_pool_owners, v1) == &arg1) {
                0x1::vector::borrow_mut<Pool<T0>>(&mut arg0.whitelist_pools, v1).max_capacity = arg2;
                break
            };
            v1 = v1 + 1;
        };
        if (v1 == v0) {
            abort 13839563029300903965
        };
    }

    public fun get_coin_decimals<T0>(arg0: &House<T0>) : u8 {
        arg0.coin_decimals
    }

    public(friend) fun get_distribution_type<T0>(arg0: &House<T0>) : u8 {
        arg0.distribution_mode
    }

    public(friend) fun get_distribution_weights<T0>(arg0: &House<T0>) : Weights {
        arg0.distribution_weights
    }

    public(friend) fun get_id<T0>(arg0: &Pool<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun get_pool_total_value<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance) + 0x2::balance::supply_value<PoolDebt<T0>>(&arg0.pipe_debt)
    }

    public(friend) fun get_private_pool_daily_withdrawal_limit<T0>(arg0: &House<T0>) : u64 {
        arg0.private_pool_daily_withdrawal_limit
    }

    public(friend) fun get_private_weight(arg0: &Weights) : u64 {
        arg0.pos0
    }

    public(friend) fun get_public_deposit_fee<T0>(arg0: &House<T0>) : u64 {
        arg0.public_deposit_fee
    }

    public(friend) fun get_public_pool_max_capacity<T0>(arg0: &House<T0>) : u64 {
        arg0.public_pool.max_capacity
    }

    public(friend) fun get_public_weight(arg0: &Weights) : u64 {
        arg0.pos2
    }

    public(friend) fun get_whitelist_pool_id<T0>(arg0: &House<T0>, arg1: address) : 0x2::object::ID {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Pool<T0>>(&arg0.whitelist_pools)) {
            if (*0x1::vector::borrow<address>(&arg0.whitelist_pool_owners, v0) == arg1) {
                return get_id<T0>(0x1::vector::borrow<Pool<T0>>(&arg0.whitelist_pools, v0))
            };
            v0 = v0 + 1;
        };
        abort 13839562870387114013
    }

    public(friend) fun get_whitelist_pool_max_capacity<T0>(arg0: &House<T0>, arg1: address) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Pool<T0>>(&arg0.whitelist_pools)) {
            if (*0x1::vector::borrow<address>(&arg0.whitelist_pool_owners, v0) == arg1) {
                return 0x1::vector::borrow<Pool<T0>>(&arg0.whitelist_pools, v0).max_capacity
            };
            v0 = v0 + 1;
        };
        abort 13839562818847506461
    }

    public(friend) fun get_whitelist_weight(arg0: &Weights) : u64 {
        arg0.pos1
    }

    public(friend) fun join_private_pool<T0>(arg0: &mut House<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.private_pool.balance, arg1);
    }

    public(friend) fun join_public_pool<T0>(arg0: &mut House<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.public_pool.balance, arg1);
    }

    fun new_pool<T0>(arg0: &mut 0x2::tx_context::TxContext) : Pool<T0> {
        let v0 = PoolDebt<T0>{dummy_field: false};
        Pool<T0>{
            id           : 0x2::object::new(arg0),
            balance      : 0x2::balance::zero<T0>(),
            max_capacity : 0,
            pipe_debt    : 0x2::balance::create_supply<PoolDebt<T0>>(v0),
            metadata     : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        }
    }

    public(friend) fun pool_values<T0>(arg0: &Pool<T0>) : (0x2::object::ID, u64, u64, u64) {
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        let v1 = 0x2::balance::supply_value<PoolDebt<T0>>(&arg0.pipe_debt);
        (get_id<T0>(arg0), v0, v1, v0 + v1)
    }

    public(friend) fun private_pool_values<T0>(arg0: &House<T0>) : (0x2::object::ID, u64, u64, u64) {
        pool_values<T0>(&arg0.private_pool)
    }

    public(friend) fun public_pool_values<T0>(arg0: &House<T0>) : (0x2::object::ID, u64, u64, u64) {
        pool_values<T0>(&arg0.public_pool)
    }

    public(friend) fun put_into_pool_for_pipe<T0>(arg0: &mut Pool<T0>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<PoolDebt<T0>>) {
        assert!(0x2::balance::supply_value<PoolDebt<T0>>(&arg0.pipe_debt) >= 0x2::balance::value<PoolDebt<T0>>(&arg2), 13838439783683325973);
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
        0x2::balance::decrease_supply<PoolDebt<T0>>(&mut arg0.pipe_debt, arg2);
    }

    public(friend) fun put_private_pool<T0>(arg0: &mut House<T0>, arg1: 0x2::balance::Balance<T0>) {
        join_private_pool<T0>(arg0, arg1);
    }

    public(friend) fun put_public_pool<T0>(arg0: &mut House<T0>, arg1: 0x2::balance::Balance<T0>) {
        join_public_pool<T0>(arg0, arg1);
    }

    public(friend) fun put_rakeback_pool<T0>(arg0: &mut House<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.rakeback_pool.balance, arg1);
    }

    public(friend) fun put_whitelist_pools<T0>(arg0: &mut House<T0>, arg1: 0x2::balance::Balance<T0>) : vector<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::WhitelistPoolSourceShare> {
        let v0 = 0x1::vector::length<Pool<T0>>(&arg0.whitelist_pools);
        let v1 = 0x1::vector::empty<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::WhitelistPoolSourceShare>();
        if (v0 == 0) {
            if (0x2::balance::value<T0>(&arg1) > 0) {
                abort 13837311916681068559
            };
            0x2::balance::destroy_zero<T0>(arg1);
            return v1
        };
        let v2 = 0x2::balance::value<T0>(&arg1);
        let v3 = 0x2::balance::zero<T0>();
        0x2::balance::join<T0>(&mut v3, arg1);
        let v4 = v2;
        let v5 = 1;
        while (v5 < v0) {
            let v6 = (((*0x1::vector::borrow<u64>(&arg0.whitelist_pool_weights, v5) as u128) * (v2 as u128) / (0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::utils::sum(&arg0.whitelist_pool_weights) as u128)) as u64);
            v4 = v4 - v6;
            0x2::balance::join<T0>(&mut 0x1::vector::borrow_mut<Pool<T0>>(&mut arg0.whitelist_pools, v5).balance, 0x2::balance::split<T0>(&mut v3, v6));
            if (v6 > 0) {
                0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::WhitelistPoolSourceShare>(&mut v1, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::make_whitelist_pool_source_share(*0x1::vector::borrow<address>(&arg0.whitelist_pool_owners, v5), v6));
            };
            v5 = v5 + 1;
        };
        0x2::balance::join<T0>(&mut 0x1::vector::borrow_mut<Pool<T0>>(&mut arg0.whitelist_pools, 0).balance, 0x2::balance::split<T0>(&mut v3, v4));
        if (v4 > 0) {
            0x1::vector::push_back<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::WhitelistPoolSourceShare>(&mut v1, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::make_whitelist_pool_source_share(*0x1::vector::borrow<address>(&arg0.whitelist_pool_owners, 0), v4));
        };
        0x2::balance::destroy_zero<T0>(v3);
        v1
    }

    public(friend) fun rakeback_pool_values<T0>(arg0: &House<T0>) : (0x2::object::ID, u64, u64, u64) {
        pool_values<T0>(&arg0.rakeback_pool)
    }

    public(friend) fun redeem_public_pool<T0>(arg0: &mut House<T0>, arg1: 0x2::balance::Balance<StakedCoin<T0>>, arg2: address) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<StakedCoin<T0>>(&arg1);
        let v1 = 0x2::balance::supply_value<StakedCoin<T0>>(&arg0.public_supply);
        0x2::balance::decrease_supply<StakedCoin<T0>>(&mut arg0.public_supply, arg1);
        let v2 = if (v1 > 0) {
            (((v0 as u128) * (total_public_pool_balance<T0>(arg0) as u128) / (v1 as u128)) as u64)
        } else {
            total_public_pool_balance<T0>(arg0)
        };
        let v3 = WithdrawStakeEvent<T0>{
            user          : arg2,
            amount        : v2,
            s_coin_amount : v0,
        };
        0x2::event::emit<WithdrawStakeEvent<T0>>(v3);
        split_public_pool<T0>(arg0, v2)
    }

    public(friend) fun set_distribution_mode<T0>(arg0: &mut House<T0>, arg1: u8) {
        arg0.distribution_mode = arg1;
    }

    public(friend) fun set_private_pool_daily_withdrawal_limit<T0>(arg0: &mut House<T0>, arg1: u64) {
        arg0.private_pool_daily_withdrawal_limit = arg1;
    }

    public(friend) fun set_public_deposit_fee<T0>(arg0: &mut House<T0>, arg1: u64) {
        arg0.public_deposit_fee = arg1;
    }

    public(friend) fun split_private_pool<T0>(arg0: &mut House<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::balance::value<T0>(&arg0.private_pool.balance) >= arg1, 13835341484469125123);
        0x2::balance::split<T0>(&mut arg0.private_pool.balance, arg1)
    }

    public(friend) fun split_public_pool<T0>(arg0: &mut House<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::balance::value<T0>(&arg0.public_pool.balance) >= arg1, 13835904790905094151);
        0x2::balance::split<T0>(&mut arg0.public_pool.balance, arg1)
    }

    public(friend) fun take_from_pool_for_pipe<T0>(arg0: &mut Pool<T0>, arg1: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<PoolDebt<T0>>) {
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 13838158244281974803);
        assert!(((0x2::balance::value<T0>(&arg0.balance) - arg1) as u128) * 9 >= ((0x2::balance::supply_value<PoolDebt<T0>>(&arg0.pipe_debt) + arg1) as u128), 13840128590594703393);
        (0x2::balance::split<T0>(&mut arg0.balance, arg1), 0x2::balance::increase_supply<PoolDebt<T0>>(&mut arg0.pipe_debt, arg1))
    }

    public(friend) fun take_private_pool<T0>(arg0: &mut House<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        split_private_pool<T0>(arg0, arg1)
    }

    public(friend) fun take_public_pool<T0>(arg0: &mut House<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        split_public_pool<T0>(arg0, arg1)
    }

    public(friend) fun take_rakeback_pool<T0>(arg0: &mut House<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::balance::value<T0>(&arg0.rakeback_pool.balance) >= arg1, 13836186441975595017);
        0x2::balance::split<T0>(&mut arg0.rakeback_pool.balance, arg1)
    }

    public(friend) fun take_using_stake_ticket_sources<T0, T1: drop>(arg0: &mut House<T0>, arg1: u64, arg2: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::StakeTicket<T0, T1>) : 0x2::balance::Balance<T0> {
        let v0 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::private_source_amount<T0, T1>(arg2);
        let v1 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::public_source_amount<T0, T1>(arg2);
        let v2 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::whitelist_source_share_count<T0, T1>(arg2);
        let v3 = v0 + v1;
        let v4 = 0;
        while (v4 < v2) {
            v3 = v3 + 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::whitelist_source_amount_at<T0, T1>(arg2, v4);
            v4 = v4 + 1;
        };
        let v5 = 0x2::balance::zero<T0>();
        assert!(v3 > 0, 13837875386325663761);
        let v6 = (((arg1 as u128) * (v0 as u128) / (v3 as u128)) as u64);
        let v7 = v6;
        let v8 = (((arg1 as u128) * (v1 as u128) / (v3 as u128)) as u64);
        let v9 = v8;
        let v10 = 0x1::vector::empty<u64>();
        let v11 = v6 + v8;
        v4 = 0;
        while (v4 < v2) {
            let v12 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::whitelist_source_amount_at<T0, T1>(arg2, v4);
            let v13 = (((arg1 as u128) * (v12 as u128) / (v3 as u128)) as u64);
            v11 = v11 + v13;
            0x1::vector::push_back<u64>(&mut v10, v13);
            v4 = v4 + 1;
        };
        let v14 = arg1 - v11;
        if (v14 > 0) {
            if (v1 > 0) {
                v9 = v8 + v14;
            } else if (v2 < v2) {
                let v15 = 0x1::vector::borrow_mut<u64>(&mut v10, v2);
                *v15 = *v15 + v14;
            } else {
                v7 = v6 + v14;
            };
        };
        if (v7 > 0) {
            assert!(0x2::balance::value<T0>(&arg0.private_pool.balance) >= v7, 13835342266153172995);
            0x2::balance::join<T0>(&mut v5, 0x2::balance::split<T0>(&mut arg0.private_pool.balance, v7));
        };
        v4 = 0;
        while (v4 < v2) {
            let v16 = *0x1::vector::borrow<u64>(&v10, v4);
            if (v16 > 0) {
                let v17 = withdraw_whitelist_pool<T0>(arg0, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::whitelist_source_owner_at<T0, T1>(arg2, v4), v16);
                0x2::balance::join<T0>(&mut v5, v17);
            };
            v4 = v4 + 1;
        };
        if (v9 > 0) {
            assert!(0x2::balance::value<T0>(&arg0.public_pool.balance) >= v9, 13835905293416267783);
            0x2::balance::join<T0>(&mut v5, 0x2::balance::split<T0>(&mut arg0.public_pool.balance, v9));
        };
        v5
    }

    public(friend) fun total_private_pool_balance<T0>(arg0: &House<T0>) : u64 {
        get_pool_total_value<T0>(&arg0.private_pool)
    }

    public(friend) fun total_public_pool_balance<T0>(arg0: &House<T0>) : u64 {
        get_pool_total_value<T0>(&arg0.public_pool)
    }

    public(friend) fun total_rakeback_pool_balance<T0>(arg0: &House<T0>) : u64 {
        get_pool_total_value<T0>(&arg0.rakeback_pool)
    }

    public(friend) fun total_whitelist_pools_balance<T0>(arg0: &House<T0>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Pool<T0>>(&arg0.whitelist_pools)) {
            let v2 = v0 + 0x2::balance::value<T0>(&0x1::vector::borrow<Pool<T0>>(&arg0.whitelist_pools, v1).balance);
            v0 = v2 + 0x2::balance::supply_value<PoolDebt<T0>>(&0x1::vector::borrow<Pool<T0>>(&arg0.whitelist_pools, v1).pipe_debt);
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun whitelist_pool_deposit_event_values<T0>(arg0: &WhitelistPoolDepositEvent<T0>) : (0x2::object::ID, address, address, u64) {
        (arg0.pool_id, arg0.depositor, arg0.pool_owner, arg0.amount)
    }

    public(friend) fun whitelist_pool_values_at<T0>(arg0: &House<T0>, arg1: u64) : (0x2::object::ID, address, u64, u64, u64) {
        let v0 = 0x1::vector::borrow<Pool<T0>>(&arg0.whitelist_pools, arg1);
        let v1 = 0x2::balance::value<T0>(&v0.balance);
        let v2 = 0x2::balance::supply_value<PoolDebt<T0>>(&v0.pipe_debt);
        (get_id<T0>(v0), *0x1::vector::borrow<address>(&arg0.whitelist_pool_owners, arg1), v1, v2, v1 + v2)
    }

    public(friend) fun whitelist_pools_len<T0>(arg0: &House<T0>) : u64 {
        0x1::vector::length<Pool<T0>>(&arg0.whitelist_pools)
    }

    public(friend) fun withdraw_all_private_pool<T0>(arg0: &mut House<T0>) : 0x2::balance::Balance<T0> {
        0x2::balance::withdraw_all<T0>(&mut arg0.private_pool.balance)
    }

    public(friend) fun withdraw_all_whitelist_pool<T0>(arg0: &mut House<T0>, arg1: address) : 0x2::balance::Balance<T0> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.whitelist_pool_owners)) {
            if (*0x1::vector::borrow<address>(&arg0.whitelist_pool_owners, v0) == arg1) {
                break
            };
            v0 = v0 + 1;
        };
        if (v0 == 0x1::vector::length<address>(&arg0.whitelist_pool_owners)) {
            abort 13839565228324159517
        };
        0x2::balance::withdraw_all<T0>(&mut 0x1::vector::borrow_mut<Pool<T0>>(&mut arg0.whitelist_pools, v0).balance)
    }

    public(friend) fun withdraw_private_pool<T0>(arg0: &mut House<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        split_private_pool<T0>(arg0, arg1)
    }

    public(friend) fun withdraw_private_pool_with_daily_withdrawal_limit<T0>(arg0: &mut House<T0>, arg1: u64, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 86400000;
        if (arg0.private_pool_last_day_reset < v0) {
            arg0.private_pool_withdrawn_amount_current_day = 0;
            arg0.private_pool_last_day_reset = v0;
        };
        let v1 = (arg0.private_pool_withdrawn_amount_current_day as u128) + (arg1 as u128);
        assert!(v1 <= (arg0.private_pool_daily_withdrawal_limit as u128), 13840409021894492195);
        arg0.private_pool_withdrawn_amount_current_day = (v1 as u64);
        withdraw_private_pool<T0>(arg0, arg1)
    }

    public(friend) fun withdraw_whitelist_pool<T0>(arg0: &mut House<T0>, arg1: address, arg2: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.whitelist_pool_owners)) {
            if (*0x1::vector::borrow<address>(&arg0.whitelist_pool_owners, v0) == arg1) {
                break
            };
            v0 = v0 + 1;
        };
        if (v0 == 0x1::vector::length<address>(&arg0.whitelist_pool_owners)) {
            abort 13839565129539911709
        };
        assert!(0x2::balance::value<T0>(&0x1::vector::borrow<Pool<T0>>(&arg0.whitelist_pools, v0).balance) >= arg2, 13835624505634193413);
        0x2::balance::split<T0>(&mut 0x1::vector::borrow_mut<Pool<T0>>(&mut arg0.whitelist_pools, v0).balance, arg2)
    }

    // decompiled from Move bytecode v6
}

