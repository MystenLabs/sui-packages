module 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe_factory {
    struct BRIBE_FACTORY has drop {
        dummy_field: bool,
    }

    struct BribePair has store {
        internal_bribe: 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::Bribe,
        external_bribe: 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::Bribe,
    }

    struct BribeFactory has key {
        id: 0x2::object::UID,
        bribes: 0x2::linked_table::LinkedTable<0x2::object::ID, BribePair>,
    }

    public fun all_lock_earned(arg0: &BribeFactory, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter) : (vector<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::RewardWithType>, vector<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::RewardWithType>) {
        let (v0, v1) = bribes(arg0, arg1);
        (0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::all_lock_earned(v0, arg2, arg3), 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::all_lock_earned(v1, arg2, arg3))
    }

    public fun all_rewards(arg0: &BribeFactory, arg1: 0x2::object::ID, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter) : (vector<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::RewardWithType>, vector<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::RewardWithType>) {
        let (v0, v1) = bribes(arg0, arg1);
        (0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::all_rewards(v0, arg2), 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::all_rewards(v1, arg2))
    }

    public fun balance_of(arg0: &BribeFactory, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter) : u64 {
        let (_, v1) = bribes(arg0, arg1);
        0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::balance_of(v1, arg2, arg3)
    }

    public fun balance_of_at(arg0: &BribeFactory, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64) : u64 {
        let (_, v1) = bribes(arg0, arg1);
        0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::balance_of_at(v1, arg2, arg3)
    }

    public fun carry_bribes_to_next_epoch(arg0: &mut BribeFactory, arg1: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe_coin_whitelist::BribeCoinWhitelist, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter, arg3: &0x2::clock::Clock) {
        carry_bribes_to_next_epoch_(arg0, arg1, arg2, arg3);
    }

    public fun earned<T0>(arg0: &BribeFactory, arg1: 0x2::object::ID, arg2: bool, arg3: 0x2::object::ID, arg4: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter) : u64 {
        let (v0, v1) = bribes(arg0, arg1);
        if (arg2) {
            0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::earned<T0>(v0, arg3, arg4)
        } else {
            0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::earned<T0>(v1, arg3, arg4)
        }
    }

    public fun get_reward<T0>(arg0: &mut BribeFactory, arg1: 0x2::object::ID, arg2: bool, arg3: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::voting_escrow::VotingEscrow, arg4: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = bribes_mut(arg0, arg1);
        if (arg2) {
            0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::get_reward<T0>(v0, arg3, arg4, arg5)
        } else {
            0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::get_reward<T0>(v1, arg3, arg4, arg5)
        }
    }

    public fun is_reward_coin<T0>(arg0: &BribeFactory, arg1: 0x2::object::ID, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe_coin_whitelist::BribeCoinWhitelist) : bool {
        let (_, v1) = bribes(arg0, arg1);
        0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::is_reward_coin<T0>(v1, arg2)
    }

    public fun notify_reward_amount<T0>(arg0: &mut BribeFactory, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe_coin_whitelist::BribeCoinWhitelist, arg4: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = bribes_mut(arg0, arg1);
        0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::notify_reward_amount<T0>(v1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun total_supply(arg0: &BribeFactory, arg1: 0x2::object::ID, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter) : u64 {
        let (_, v1) = bribes(arg0, arg1);
        0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::total_supply(v1, arg2)
    }

    public fun total_supply_at(arg0: &BribeFactory, arg1: 0x2::object::ID, arg2: u64) : u64 {
        let (_, v1) = bribes(arg0, arg1);
        0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::total_supply_at(v1, arg2)
    }

    fun bribes(arg0: &BribeFactory, arg1: 0x2::object::ID) : (&0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::Bribe, &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::Bribe) {
        let v0 = 0x2::linked_table::borrow<0x2::object::ID, BribePair>(&arg0.bribes, arg1);
        (&v0.internal_bribe, &v0.external_bribe)
    }

    public fun bribes_mut(arg0: &mut BribeFactory, arg1: 0x2::object::ID) : (&mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::Bribe, &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::Bribe) {
        let v0 = 0x2::linked_table::borrow_mut<0x2::object::ID, BribePair>(&mut arg0.bribes, arg1);
        (&mut v0.internal_bribe, &mut v0.external_bribe)
    }

    fun carry_bribes_to_next_epoch_(arg0: &mut BribeFactory, arg1: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe_coin_whitelist::BribeCoinWhitelist, arg2: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::minter::Minter, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::linked_table::front<0x2::object::ID, BribePair>(&arg0.bribes);
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        while (0x1::option::is_some<0x2::object::ID>(v0)) {
            let v2 = *0x1::option::borrow<0x2::object::ID>(v0);
            0x1::vector::push_back<0x2::object::ID>(&mut v1, v2);
            v0 = 0x2::linked_table::next<0x2::object::ID, BribePair>(&arg0.bribes, v2);
        };
        0x1::vector::reverse<0x2::object::ID>(&mut v1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            let (v4, v5) = bribes_mut(arg0, 0x1::vector::pop_back<0x2::object::ID>(&mut v1));
            0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::carry_bribes_to_next_epoch(v4, arg1, arg2, arg3);
            0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::carry_bribes_to_next_epoch(v5, arg1, arg2, arg3);
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(v1);
    }

    public fun create_bribe_pair<T0, T1>(arg0: &mut BribeFactory, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        create_bribe_pair_<T0, T1>(arg0, arg1, arg2);
    }

    fun create_bribe_pair_<T0, T1>(arg0: &mut BribeFactory, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = BribePair{
            internal_bribe : 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::init_bribe<T0, T1>(arg2),
            external_bribe : 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::init_bribe<T0, T1>(arg2),
        };
        0x2::linked_table::push_back<0x2::object::ID, BribePair>(&mut arg0.bribes, arg1, v0);
    }

    fun init(arg0: BRIBE_FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BribeFactory{
            id     : 0x2::object::new(arg1),
            bribes : 0x2::linked_table::new<0x2::object::ID, BribePair>(arg1),
        };
        0x2::transfer::share_object<BribeFactory>(v0);
    }

    entry fun migrate_all_bribes(arg0: &mut BribeFactory, arg1: &0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::AdminCap) {
        let v0 = 0x2::linked_table::front<0x2::object::ID, BribePair>(&arg0.bribes);
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        while (0x1::option::is_some<0x2::object::ID>(v0)) {
            let v2 = *0x1::option::borrow<0x2::object::ID>(v0);
            0x1::vector::push_back<0x2::object::ID>(&mut v1, v2);
            v0 = 0x2::linked_table::next<0x2::object::ID, BribePair>(&arg0.bribes, v2);
        };
        0x1::vector::reverse<0x2::object::ID>(&mut v1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            let (v4, v5) = bribes_mut(arg0, 0x1::vector::pop_back<0x2::object::ID>(&mut v1));
            0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::migrate(v4, arg1);
            0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::bribe::migrate(v5, arg1);
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(v1);
    }

    // decompiled from Move bytecode v6
}

