module 0xde6a273a2a0ccf8bb9b6a4978d6a2b7b5101979848beb49a2c1f992b958b1cf1::pool {
    struct RewardCap has store, key {
        id: 0x2::object::UID,
    }

    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        total_lots: u64,
        minted_count: u64,
        numbers: 0x2::table::Table<u64, 0x2::object::ID>,
        rounds: vector<Round<T0>>,
    }

    struct Round<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        initial_reward: u64,
        per_lot_amount: u64,
        remaining_claimable_lots: u64,
    }

    struct RewardsInjected<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        round: u64,
        initial_reward: u64,
        snapshot_total_lots: u64,
        per_lot_amount: u64,
        funder: address,
    }

    public fun add_rewards<T0>(arg0: &mut Pool<T0>, arg1: &RewardCap, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = arg0.total_lots;
        assert!(v0 > 0, 0xde6a273a2a0ccf8bb9b6a4978d6a2b7b5101979848beb49a2c1f992b958b1cf1::errors::no_lots());
        assert!(arg3 < 12, 0xde6a273a2a0ccf8bb9b6a4978d6a2b7b5101979848beb49a2c1f992b958b1cf1::errors::invalid_params());
        let v1 = 0x2::coin::value<T0>(&arg2);
        let v2 = v1 / v0;
        let v3 = 0x1::vector::length<Round<T0>>(&arg0.rounds);
        assert!(arg3 == v3, 0xde6a273a2a0ccf8bb9b6a4978d6a2b7b5101979848beb49a2c1f992b958b1cf1::errors::invalid_params());
        assert!(v2 != 0, 0xde6a273a2a0ccf8bb9b6a4978d6a2b7b5101979848beb49a2c1f992b958b1cf1::errors::invalid_params());
        let v4 = Round<T0>{
            balance                  : 0x2::coin::into_balance<T0>(arg2),
            initial_reward           : v1,
            per_lot_amount           : v2,
            remaining_claimable_lots : v0,
        };
        0x1::vector::push_back<Round<T0>>(&mut arg0.rounds, v4);
        let v5 = RewardsInjected<T0>{
            pool_id             : 0x2::object::id<Pool<T0>>(arg0),
            round               : v3,
            initial_reward      : v1,
            snapshot_total_lots : v0,
            per_lot_amount      : v2,
            funder              : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<RewardsInjected<T0>>(v5);
    }

    public(friend) fun claim_rewards<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: u64) : 0x2::balance::Balance<T0> {
        assert!(arg1 < 0x1::vector::length<Round<T0>>(&arg0.rounds), 0xde6a273a2a0ccf8bb9b6a4978d6a2b7b5101979848beb49a2c1f992b958b1cf1::errors::wrong_round());
        let v0 = 0x1::vector::borrow_mut<Round<T0>>(&mut arg0.rounds, arg1);
        assert!(v0.remaining_claimable_lots >= arg2, 0xde6a273a2a0ccf8bb9b6a4978d6a2b7b5101979848beb49a2c1f992b958b1cf1::errors::insufficient_lots());
        v0.remaining_claimable_lots = v0.remaining_claimable_lots - arg2;
        0x2::balance::split<T0>(&mut v0.balance, (((v0.per_lot_amount as u128) * (arg2 as u128)) as u64))
    }

    public fun has_nft<T0>(arg0: &Pool<T0>, arg1: u64) : bool {
        0x2::table::contains<u64, 0x2::object::ID>(&arg0.numbers, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<RewardCap>(v0, 0x2::tx_context::sender(arg0));
        new_pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0);
        new_pool<0x2::sui::SUI>(arg0);
    }

    public fun minted_count<T0>(arg0: &Pool<T0>) : u64 {
        arg0.minted_count
    }

    fun new_pool<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0>{
            id           : 0x2::object::new(arg0),
            total_lots   : 0,
            minted_count : 0,
            numbers      : 0x2::table::new<u64, 0x2::object::ID>(arg0),
            rounds       : 0x1::vector::empty<Round<T0>>(),
        };
        0x2::transfer::share_object<Pool<T0>>(v0);
    }

    public fun nft_id<T0>(arg0: &Pool<T0>, arg1: u64) : 0x2::object::ID {
        *0x2::table::borrow<u64, 0x2::object::ID>(&arg0.numbers, arg1)
    }

    public(friend) fun record_mint<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: 0x2::object::ID) : u64 {
        assert!(0x1::vector::is_empty<Round<T0>>(&arg0.rounds), 0xde6a273a2a0ccf8bb9b6a4978d6a2b7b5101979848beb49a2c1f992b958b1cf1::errors::mint_locked());
        arg0.total_lots = arg0.total_lots + arg1;
        arg0.minted_count = arg0.minted_count + 1;
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.numbers, arg0.minted_count, arg2);
        arg0.minted_count
    }

    public fun round_balance<T0>(arg0: &Pool<T0>, arg1: u64) : u64 {
        0x2::balance::value<T0>(&0x1::vector::borrow<Round<T0>>(&arg0.rounds, arg1).balance)
    }

    public fun round_initial_reward<T0>(arg0: &Pool<T0>, arg1: u64) : u64 {
        0x1::vector::borrow<Round<T0>>(&arg0.rounds, arg1).initial_reward
    }

    public fun round_per_lot_amount<T0>(arg0: &Pool<T0>, arg1: u64) : u64 {
        0x1::vector::borrow<Round<T0>>(&arg0.rounds, arg1).per_lot_amount
    }

    public fun round_remaining_lots<T0>(arg0: &Pool<T0>, arg1: u64) : u64 {
        0x1::vector::borrow<Round<T0>>(&arg0.rounds, arg1).remaining_claimable_lots
    }

    public fun total_lots<T0>(arg0: &Pool<T0>) : u64 {
        arg0.total_lots
    }

    public fun total_rounds<T0>(arg0: &Pool<T0>) : u64 {
        0x1::vector::length<Round<T0>>(&arg0.rounds)
    }

    // decompiled from Move bytecode v7
}

