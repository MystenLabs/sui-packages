module 0x45f0ed76d49e64161d560ef1bd37a7c355610f39db76800e4d1f325b2fbdf29d::rewards {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RewardPool has key {
        id: 0x2::object::UID,
        admin: address,
        vault: 0x2::balance::Balance<0x2::sui::SUI>,
        campaigns: 0x2::table::Table<vector<u8>, RewardCampaign>,
        claimed: 0x2::table::Table<vector<u8>, bool>,
    }

    struct RewardCampaign has drop, store {
        merkle_root: vector<u8>,
        total_budget: u64,
        total_claimed: u64,
        paused: bool,
    }

    struct CampaignCreated has copy, drop {
        campaign_id: vector<u8>,
        merkle_root: vector<u8>,
        total_budget: u64,
    }

    struct Claimed has copy, drop {
        campaign_id: vector<u8>,
        recipient: address,
        amount: u64,
    }

    struct PoolCreated has copy, drop {
        pool_id: vector<u8>,
        admin: address,
    }

    struct AdminChanged has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct Deposited has copy, drop {
        amount: u64,
    }

    struct Withdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    public fun admin(arg0: &RewardPool) : address {
        arg0.admin
    }

    fun assert_admin(arg0: &RewardPool, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
    }

    fun borrow_campaign(arg0: &RewardPool, arg1: vector<u8>) : &RewardCampaign {
        assert!(0x2::table::contains<vector<u8>, RewardCampaign>(&arg0.campaigns, arg1), 3);
        0x2::table::borrow<vector<u8>, RewardCampaign>(&arg0.campaigns, arg1)
    }

    fun borrow_campaign_mut(arg0: &mut RewardPool, arg1: vector<u8>) : &mut RewardCampaign {
        assert!(0x2::table::contains<vector<u8>, RewardCampaign>(&arg0.campaigns, arg1), 3);
        0x2::table::borrow_mut<vector<u8>, RewardCampaign>(&mut arg0.campaigns, arg1)
    }

    fun bytes_less_or_equal(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        let v2 = if (v0 < v1) {
            v0
        } else {
            v1
        };
        let v3 = 0;
        while (v3 < v2) {
            let v4 = *0x1::vector::borrow<u8>(arg0, v3);
            let v5 = *0x1::vector::borrow<u8>(arg1, v3);
            if (v4 < v5) {
                return true
            };
            if (v4 > v5) {
                return false
            };
            v3 = v3 + 1;
        };
        v0 <= v1
    }

    public fun campaign_claimed(arg0: &RewardPool, arg1: vector<u8>) : u64 {
        borrow_campaign(arg0, arg1).total_claimed
    }

    public fun claim(arg0: &mut RewardPool, arg1: vector<u8>, arg2: u64, arg3: vector<vector<u8>>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 8);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = claimed_key(arg1, v0);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.claimed, v1), 4);
        let v2 = proof_root(claim_leaf(pool_id_bytes(arg0), arg1, v0, arg2), arg3);
        let v3 = borrow_campaign_mut(arg0, arg1);
        assert!(!v3.paused, 6);
        assert!(v2 == v3.merkle_root, 5);
        assert!(v3.total_claimed + arg2 <= v3.total_budget, 7);
        v3.total_claimed = v3.total_claimed + arg2;
        0x2::table::add<vector<u8>, bool>(&mut arg0.claimed, v1, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, arg2), arg4), v0);
        let v4 = Claimed{
            campaign_id : arg1,
            recipient   : v0,
            amount      : arg2,
        };
        0x2::event::emit<Claimed>(v4);
    }

    public fun claim_leaf(arg0: vector<u8>, arg1: vector<u8>, arg2: address, arg3: u64) : vector<u8> {
        let v0 = b"YOSO_REWARDS_LEAF_V1";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg3));
        0x2::hash::blake2b256(&v0)
    }

    fun claimed_key(arg0: vector<u8>, arg1: address) : vector<u8> {
        let v0 = b"YOSO_REWARDS_CLAIMED_V1";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        0x2::hash::blake2b256(&v0)
    }

    public fun create_campaign(arg0: &mut RewardPool, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg4);
        assert!(arg3 > 0, 8);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 9);
        assert!(!0x2::table::contains<vector<u8>, RewardCampaign>(&arg0.campaigns, arg1), 2);
        let v0 = RewardCampaign{
            merkle_root   : arg2,
            total_budget  : arg3,
            total_claimed : 0,
            paused        : false,
        };
        0x2::table::add<vector<u8>, RewardCampaign>(&mut arg0.campaigns, arg1, v0);
        let v1 = CampaignCreated{
            campaign_id  : arg1,
            merkle_root  : arg2,
            total_budget : arg3,
        };
        0x2::event::emit<CampaignCreated>(v1);
    }

    public fun create_pool(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = new_pool(arg1, arg2);
        emit_pool_created(&v0);
        0x2::transfer::share_object<RewardPool>(v0);
    }

    public fun deposit(arg0: &mut RewardPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 8);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.vault, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = Deposited{amount: v0};
        0x2::event::emit<Deposited>(v1);
    }

    fun emit_pool_created(arg0: &RewardPool) {
        let v0 = PoolCreated{
            pool_id : pool_id_bytes(arg0),
            admin   : arg0.admin,
        };
        0x2::event::emit<PoolCreated>(v0);
    }

    public fun has_claimed(arg0: &RewardPool, arg1: vector<u8>, arg2: address) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.claimed, claimed_key(arg1, arg2))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = new_pool(v0, arg0);
        emit_pool_created(&v2);
        0x2::transfer::share_object<RewardPool>(v2);
        0x2::transfer::public_transfer<AdminCap>(v1, v0);
    }

    fun new_pool(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : RewardPool {
        RewardPool{
            id        : 0x2::object::new(arg1),
            admin     : arg0,
            vault     : 0x2::balance::zero<0x2::sui::SUI>(),
            campaigns : 0x2::table::new<vector<u8>, RewardCampaign>(arg1),
            claimed   : 0x2::table::new<vector<u8>, bool>(arg1),
        }
    }

    public fun parent_hash(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = b"YOSO_REWARDS_NODE_V1";
        if (bytes_less_or_equal(&arg0, &arg1)) {
            0x1::vector::append<u8>(&mut v0, arg0);
            0x1::vector::append<u8>(&mut v0, arg1);
        } else {
            0x1::vector::append<u8>(&mut v0, arg1);
            0x1::vector::append<u8>(&mut v0, arg0);
        };
        0x2::hash::blake2b256(&v0)
    }

    public fun pool_id_bytes(arg0: &RewardPool) : vector<u8> {
        0x2::object::uid_to_bytes(&arg0.id)
    }

    public fun proof_root(arg0: vector<u8>, arg1: vector<vector<u8>>) : vector<u8> {
        let v0 = arg0;
        0x1::vector::reverse<vector<u8>>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg1)) {
            v0 = parent_hash(v0, 0x1::vector::pop_back<vector<u8>>(&mut arg1));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg1);
        v0
    }

    public fun set_admin(arg0: &mut RewardPool, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        arg0.admin = arg1;
        let v0 = AdminChanged{
            old_admin : arg0.admin,
            new_admin : arg1,
        };
        0x2::event::emit<AdminChanged>(v0);
    }

    public fun set_campaign_paused(arg0: &mut RewardPool, arg1: vector<u8>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        borrow_campaign_mut(arg0, arg1).paused = arg2;
    }

    public fun withdraw(arg0: &mut RewardPool, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        assert!(arg1 > 0, 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, arg1), arg3), arg2);
        let v0 = Withdrawn{
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<Withdrawn>(v0);
    }

    // decompiled from Move bytecode v7
}

