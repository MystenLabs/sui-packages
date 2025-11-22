module 0x334d46ed6eb6f4fe21e290425f73fbecb018e41ecfdfde810f62b60329efc440::reward_pool {
    struct RewardPool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        admin: address,
        merkle_root: 0x1::option::Option<vector<u8>>,
        claimed: 0x2::table::Table<address, bool>,
        is_claimable: bool,
        total_claimed: u64,
        claim_count: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        admin: address,
    }

    struct FundsAdded has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        new_balance: u64,
    }

    struct MerkleRootSet has copy, drop {
        pool_id: 0x2::object::ID,
        merkle_root: vector<u8>,
    }

    struct ClaimingEnabled has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct RewardClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        amount: u64,
        timestamp: u64,
    }

    public fun add_funds(arg0: &mut RewardPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = FundsAdded{
            pool_id     : 0x2::object::uid_to_inner(&arg0.id),
            amount      : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            new_balance : 0x2::balance::value<0x2::sui::SUI>(&arg0.balance),
        };
        0x2::event::emit<FundsAdded>(v0);
    }

    public entry fun claim_reward(arg0: &mut RewardPool, arg1: u64, arg2: vector<vector<u8>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.is_claimable, 2);
        assert!(!is_claimed(arg0, v0), 3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg1, 5);
        assert!(0x334d46ed6eb6f4fe21e290425f73fbecb018e41ecfdfde810f62b60329efc440::merkle_proof::verify(&arg2, 0x1::option::borrow<vector<u8>>(&arg0.merkle_root), 0x334d46ed6eb6f4fe21e290425f73fbecb018e41ecfdfde810f62b60329efc440::merkle_proof::create_leaf(v0, arg1, arg3), arg3), 4);
        0x2::table::add<address, bool>(&mut arg0.claimed, v0, true);
        arg0.total_claimed = arg0.total_claimed + arg1;
        arg0.claim_count = arg0.claim_count + 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg1, arg4), v0);
        let v1 = RewardClaimed{
            pool_id   : 0x2::object::uid_to_inner(&arg0.id),
            user      : v0,
            amount    : arg1,
            timestamp : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<RewardClaimed>(v1);
    }

    public entry fun create_pool(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x2::tx_context::sender(arg0);
        let v3 = RewardPool{
            id            : v0,
            balance       : 0x2::balance::zero<0x2::sui::SUI>(),
            admin         : v2,
            merkle_root   : 0x1::option::none<vector<u8>>(),
            claimed       : 0x2::table::new<address, bool>(arg0),
            is_claimable  : false,
            total_claimed : 0,
            claim_count   : 0,
        };
        let v4 = AdminCap{
            id      : 0x2::object::new(arg0),
            pool_id : v1,
        };
        let v5 = PoolCreated{
            pool_id : v1,
            admin   : v2,
        };
        0x2::event::emit<PoolCreated>(v5);
        0x2::transfer::share_object<RewardPool>(v3);
        0x2::transfer::transfer<AdminCap>(v4, v2);
    }

    public entry fun enable_claiming(arg0: &mut RewardPool, arg1: &AdminCap, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        assert!(0x1::option::is_some<vector<u8>>(&arg0.merkle_root), 7);
        arg0.is_claimable = true;
        let v0 = ClaimingEnabled{pool_id: 0x2::object::uid_to_inner(&arg0.id)};
        0x2::event::emit<ClaimingEnabled>(v0);
    }

    public fun get_balance(arg0: &RewardPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_claim_count(arg0: &RewardPool) : u64 {
        arg0.claim_count
    }

    public fun get_merkle_root(arg0: &RewardPool) : &0x1::option::Option<vector<u8>> {
        &arg0.merkle_root
    }

    public fun get_total_claimed(arg0: &RewardPool) : u64 {
        arg0.total_claimed
    }

    public fun is_claimable(arg0: &RewardPool) : bool {
        arg0.is_claimable
    }

    public fun is_claimed(arg0: &RewardPool, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.claimed, arg1)
    }

    public entry fun set_merkle_root(arg0: &mut RewardPool, arg1: &AdminCap, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 1);
        assert!(0x1::option::is_none<vector<u8>>(&arg0.merkle_root), 6);
        arg0.merkle_root = 0x1::option::some<vector<u8>>(arg2);
        let v0 = MerkleRootSet{
            pool_id     : 0x2::object::uid_to_inner(&arg0.id),
            merkle_root : arg2,
        };
        0x2::event::emit<MerkleRootSet>(v0);
    }

    public fun withdraw_all(arg0: &mut RewardPool, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v0, arg2), arg1);
        };
    }

    // decompiled from Move bytecode v6
}

