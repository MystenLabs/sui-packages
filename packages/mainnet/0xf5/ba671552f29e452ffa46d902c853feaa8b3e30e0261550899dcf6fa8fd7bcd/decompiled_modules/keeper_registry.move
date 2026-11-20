module 0xf5ba671552f29e452ffa46d902c853feaa8b3e30e0261550899dcf6fa8fd7bcd::keeper_registry {
    struct Keeper has store {
        stake: 0x2::balance::Balance<0x2::sui::SUI>,
        pubkey: vector<u8>,
        unstake_available_at: u64,
    }

    struct Registry has store, key {
        id: 0x2::object::UID,
        keepers: 0x2::table::Table<address, Keeper>,
        keeper_count: u64,
        total_stake: u64,
        threshold: u8,
        min_stake: u64,
        cap: u64,
    }

    struct KeeperRegistered has copy, drop {
        keeper: address,
        stake: u64,
    }

    struct UnstakeRequested has copy, drop {
        keeper: address,
        available_at: u64,
    }

    struct StakeWithdrawn has copy, drop {
        keeper: address,
        amount: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id           : 0x2::object::new(arg0),
            keepers      : 0x2::table::new<address, Keeper>(arg0),
            keeper_count : 0,
            total_stake  : 0,
            threshold    : 4,
            min_stake    : 5000000000,
            cap          : 0,
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun is_keeper(arg0: &Registry, arg1: address) : bool {
        0x2::table::contains<address, Keeper>(&arg0.keepers, arg1)
    }

    public fun keeper_count(arg0: &Registry) : u64 {
        arg0.keeper_count
    }

    fun keeper_mut(arg0: &mut Registry, arg1: address) : &mut Keeper {
        assert!(0x2::table::contains<address, Keeper>(&arg0.keepers, arg1), 2);
        0x2::table::borrow_mut<address, Keeper>(&mut arg0.keepers, arg1)
    }

    public fun min_stake(arg0: &Registry) : u64 {
        arg0.min_stake
    }

    public fun pubkey_of(arg0: &Registry, arg1: address) : vector<u8> {
        0x2::table::borrow<address, Keeper>(&arg0.keepers, arg1).pubkey
    }

    public fun register_keeper(arg0: &mut Registry, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::table::contains<address, Keeper>(&arg0.keepers, v0), 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.min_stake, 0);
        assert!(arg0.cap == 0 || arg0.keeper_count < arg0.cap, 7);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 3);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v1, 0);
        0x1::vector::append<u8>(&mut v1, arg2);
        assert!(0x2::hash::blake2b256(&v1) == 0x2::address::to_bytes(v0), 3);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v3 = Keeper{
            stake                : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            pubkey               : arg2,
            unstake_available_at : 0,
        };
        0x2::table::add<address, Keeper>(&mut arg0.keepers, v0, v3);
        arg0.keeper_count = arg0.keeper_count + 1;
        arg0.total_stake = arg0.total_stake + v2;
        let v4 = KeeperRegistered{
            keeper : v0,
            stake  : v2,
        };
        0x2::event::emit<KeeperRegistered>(v4);
    }

    public fun request_unstake(arg0: &mut Registry, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = keeper_mut(arg0, v0);
        assert!(v1.unstake_available_at == 0, 4);
        v1.unstake_available_at = 0x2::clock::timestamp_ms(arg1) + 604800000;
        let v2 = UnstakeRequested{
            keeper       : v0,
            available_at : v1.unstake_available_at,
        };
        0x2::event::emit<UnstakeRequested>(v2);
    }

    public fun stake_of(arg0: &Registry, arg1: address) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&0x2::table::borrow<address, Keeper>(&arg0.keepers, arg1).stake)
    }

    public fun threshold(arg0: &Registry) : u8 {
        arg0.threshold
    }

    public fun total_stake(arg0: &Registry) : u64 {
        arg0.total_stake
    }

    public fun unstaking_at(arg0: &Registry, arg1: address) : u64 {
        0x2::table::borrow<address, Keeper>(&arg0.keepers, arg1).unstake_available_at
    }

    public fun withdraw_stake(arg0: &mut Registry, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = keeper_mut(arg0, v0);
        assert!(v1.unstake_available_at != 0, 5);
        assert!(0x2::clock::timestamp_ms(arg1) >= v1.unstake_available_at, 6);
        let Keeper {
            stake                : v2,
            pubkey               : _,
            unstake_available_at : _,
        } = 0x2::table::remove<address, Keeper>(&mut arg0.keepers, v0);
        let v5 = v2;
        let v6 = 0x2::balance::value<0x2::sui::SUI>(&v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v5, arg2), v0);
        arg0.keeper_count = arg0.keeper_count - 1;
        arg0.total_stake = arg0.total_stake - v6;
        let v7 = StakeWithdrawn{
            keeper : v0,
            amount : v6,
        };
        0x2::event::emit<StakeWithdrawn>(v7);
    }

    // decompiled from Move bytecode v7
}

