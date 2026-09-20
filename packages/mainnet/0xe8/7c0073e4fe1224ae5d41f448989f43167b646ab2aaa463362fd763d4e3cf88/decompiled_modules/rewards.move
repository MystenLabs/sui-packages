module 0xe87c0073e4fe1224ae5d41f448989f43167b646ab2aaa463362fd763d4e3cf88::rewards {
    struct RewardEpoch<phantom T0> has key {
        id: 0x2::object::UID,
        epoch_no: u64,
        status: u8,
        reward_bps: u16,
        start_checkpoint: u64,
        end_checkpoint: u64,
        pool: 0x2::balance::Balance<T0>,
        funded_amount: u64,
        total_allocated: u64,
        total_claimed: u64,
        residual: u64,
        eligible_supply: u128,
        holder_count: u64,
        distribution_root: vector<u8>,
        entitlements: 0x2::table::Table<address, u64>,
        claims_made: u64,
    }

    struct EpochCreated has copy, drop {
        epoch_id: 0x2::object::ID,
        epoch_no: u64,
        reward_bps: u16,
        start_checkpoint: u64,
        end_checkpoint: u64,
        reward_coin_type: 0x1::string::String,
    }

    struct EpochFunded has copy, drop {
        epoch_id: 0x2::object::ID,
        epoch_no: u64,
        amount: u64,
        reward_coin_type: 0x1::string::String,
    }

    struct EntitlementsAdded has copy, drop {
        epoch_id: 0x2::object::ID,
        epoch_no: u64,
        batch_size: u64,
        batch_total: u64,
        running_total: u64,
    }

    struct EpochFinalized has copy, drop {
        epoch_id: 0x2::object::ID,
        epoch_no: u64,
        total_allocated: u64,
        residual: u64,
        holder_count: u64,
        eligible_supply: u128,
        distribution_root: vector<u8>,
    }

    struct RewardClaimed has copy, drop {
        epoch_id: 0x2::object::ID,
        epoch_no: u64,
        recipient: address,
        amount: u64,
        reward_coin_type: 0x1::string::String,
    }

    public fun claim<T0>(arg0: &mut RewardEpoch<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.status == 2, 100);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, u64>(&arg0.entitlements, v0), 102);
        let v1 = 0x2::table::remove<address, u64>(&mut arg0.entitlements, v0);
        arg0.total_claimed = arg0.total_claimed + v1;
        arg0.claims_made = arg0.claims_made + 1;
        let v2 = RewardClaimed{
            epoch_id         : 0x2::object::id<RewardEpoch<T0>>(arg0),
            epoch_no         : arg0.epoch_no,
            recipient        : v0,
            amount           : v1,
            reward_coin_type : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
        };
        0x2::event::emit<RewardClaimed>(v2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pool, v1), arg1)
    }

    public fun claim_to_sender<T0>(arg0: &mut RewardEpoch<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = claim<T0>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun claims_made<T0>(arg0: &RewardEpoch<T0>) : u64 {
        arg0.claims_made
    }

    public fun create_epoch<T0, T1>(arg0: &0xe87c0073e4fe1224ae5d41f448989f43167b646ab2aaa463362fd763d4e3cf88::admin::AdminCap, arg1: &mut 0xe87c0073e4fe1224ae5d41f448989f43167b646ab2aaa463362fd763d4e3cf88::admin::RewardsConfig, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xe87c0073e4fe1224ae5d41f448989f43167b646ab2aaa463362fd763d4e3cf88::admin::assert_not_paused(arg1);
        0xe87c0073e4fe1224ae5d41f448989f43167b646ab2aaa463362fd763d4e3cf88::admin::assert_holder_coin<T0>(arg1);
        assert!(arg3 > arg2, 109);
        let v0 = 0xe87c0073e4fe1224ae5d41f448989f43167b646ab2aaa463362fd763d4e3cf88::admin::take_next_epoch_no(arg1);
        let v1 = 0xe87c0073e4fe1224ae5d41f448989f43167b646ab2aaa463362fd763d4e3cf88::admin::default_reward_bps(arg1);
        let v2 = RewardEpoch<T1>{
            id                : 0x2::object::new(arg4),
            epoch_no          : v0,
            status            : 0,
            reward_bps        : v1,
            start_checkpoint  : arg2,
            end_checkpoint    : arg3,
            pool              : 0x2::balance::zero<T1>(),
            funded_amount     : 0,
            total_allocated   : 0,
            total_claimed     : 0,
            residual          : 0,
            eligible_supply   : 0,
            holder_count      : 0,
            distribution_root : b"",
            entitlements      : 0x2::table::new<address, u64>(arg4),
            claims_made       : 0,
        };
        let v3 = EpochCreated{
            epoch_id         : 0x2::object::id<RewardEpoch<T1>>(&v2),
            epoch_no         : v0,
            reward_bps       : v1,
            start_checkpoint : arg2,
            end_checkpoint   : arg3,
            reward_coin_type : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>())),
        };
        0x2::event::emit<EpochCreated>(v3);
        0x2::transfer::share_object<RewardEpoch<T1>>(v2);
    }

    public fun distribution_root<T0>(arg0: &RewardEpoch<T0>) : vector<u8> {
        arg0.distribution_root
    }

    public fun eligible_supply<T0>(arg0: &RewardEpoch<T0>) : u128 {
        arg0.eligible_supply
    }

    public fun end_checkpoint<T0>(arg0: &RewardEpoch<T0>) : u64 {
        arg0.end_checkpoint
    }

    public fun entitlement_of<T0>(arg0: &RewardEpoch<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.entitlements, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.entitlements, arg1)
        } else {
            0
        }
    }

    public fun epoch_no<T0>(arg0: &RewardEpoch<T0>) : u64 {
        arg0.epoch_no
    }

    public fun finalize_epoch<T0>(arg0: &0xe87c0073e4fe1224ae5d41f448989f43167b646ab2aaa463362fd763d4e3cf88::admin::AdminCap, arg1: &mut 0xe87c0073e4fe1224ae5d41f448989f43167b646ab2aaa463362fd763d4e3cf88::admin::RewardsConfig, arg2: &mut RewardEpoch<T0>, arg3: vector<u8>, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 1, 100);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 110);
        let v0 = arg2.funded_amount - arg2.total_allocated;
        assert!(arg2.total_allocated + v0 == arg2.funded_amount, 104);
        assert!(0x2::balance::value<T0>(&arg2.pool) == arg2.funded_amount, 104);
        arg2.residual = v0;
        arg2.distribution_root = arg3;
        arg2.eligible_supply = arg4;
        arg2.status = 2;
        0xe87c0073e4fe1224ae5d41f448989f43167b646ab2aaa463362fd763d4e3cf88::admin::record_finalized(arg1);
        let v1 = EpochFinalized{
            epoch_id          : 0x2::object::id<RewardEpoch<T0>>(arg2),
            epoch_no          : arg2.epoch_no,
            total_allocated   : arg2.total_allocated,
            residual          : v0,
            holder_count      : arg2.holder_count,
            eligible_supply   : arg4,
            distribution_root : arg3,
        };
        0x2::event::emit<EpochFinalized>(v1);
    }

    public fun fund_epoch<T0>(arg0: &0xe87c0073e4fe1224ae5d41f448989f43167b646ab2aaa463362fd763d4e3cf88::admin::TreasurerCap, arg1: &0xe87c0073e4fe1224ae5d41f448989f43167b646ab2aaa463362fd763d4e3cf88::admin::RewardsConfig, arg2: &mut RewardEpoch<T0>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xe87c0073e4fe1224ae5d41f448989f43167b646ab2aaa463362fd763d4e3cf88::admin::assert_not_paused(arg1);
        assert!(arg2.status == 0 || arg2.status == 1, 100);
        let v0 = 0x2::coin::value<T0>(&arg3);
        0x2::balance::join<T0>(&mut arg2.pool, 0x2::coin::into_balance<T0>(arg3));
        arg2.funded_amount = arg2.funded_amount + v0;
        arg2.status = 1;
        let v1 = EpochFunded{
            epoch_id         : 0x2::object::id<RewardEpoch<T0>>(arg2),
            epoch_no         : arg2.epoch_no,
            amount           : v0,
            reward_coin_type : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
        };
        0x2::event::emit<EpochFunded>(v1);
    }

    public fun funded_amount<T0>(arg0: &RewardEpoch<T0>) : u64 {
        arg0.funded_amount
    }

    public fun has_claimed<T0>(arg0: &RewardEpoch<T0>, arg1: address) : bool {
        arg0.status == 2 && !0x2::table::contains<address, u64>(&arg0.entitlements, arg1)
    }

    public fun holder_count<T0>(arg0: &RewardEpoch<T0>) : u64 {
        arg0.holder_count
    }

    public fun max_batch() : u64 {
        900
    }

    public fun pool_balance<T0>(arg0: &RewardEpoch<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.pool)
    }

    public fun reconciles<T0>(arg0: &RewardEpoch<T0>) : bool {
        arg0.status != 2 && 0x2::balance::value<T0>(&arg0.pool) == arg0.funded_amount - arg0.total_claimed || 0x2::balance::value<T0>(&arg0.pool) == arg0.total_allocated - arg0.total_claimed + arg0.residual
    }

    public fun residual<T0>(arg0: &RewardEpoch<T0>) : u64 {
        arg0.residual
    }

    public fun reward_bps<T0>(arg0: &RewardEpoch<T0>) : u16 {
        arg0.reward_bps
    }

    public fun set_entitlements<T0>(arg0: &0xe87c0073e4fe1224ae5d41f448989f43167b646ab2aaa463362fd763d4e3cf88::admin::KeeperCap, arg1: &mut RewardEpoch<T0>, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 1, 100);
        assert!(arg1.status != 2, 101);
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 105);
        assert!(v0 > 0, 106);
        assert!(v0 <= 900, 111);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<address>(&arg2, v2);
            let v4 = *0x1::vector::borrow<u64>(&arg3, v2);
            assert!(v4 > 0, 108);
            assert!(!0x2::table::contains<address, u64>(&arg1.entitlements, v3), 107);
            0x2::table::add<address, u64>(&mut arg1.entitlements, v3, v4);
            v1 = v1 + v4;
            v2 = v2 + 1;
        };
        arg1.total_allocated = arg1.total_allocated + v1;
        arg1.holder_count = arg1.holder_count + v0;
        assert!(arg1.total_allocated <= arg1.funded_amount, 103);
        let v5 = EntitlementsAdded{
            epoch_id      : 0x2::object::id<RewardEpoch<T0>>(arg1),
            epoch_no      : arg1.epoch_no,
            batch_size    : v0,
            batch_total   : v1,
            running_total : arg1.total_allocated,
        };
        0x2::event::emit<EntitlementsAdded>(v5);
    }

    public fun start_checkpoint<T0>(arg0: &RewardEpoch<T0>) : u64 {
        arg0.start_checkpoint
    }

    public fun status<T0>(arg0: &RewardEpoch<T0>) : u8 {
        arg0.status
    }

    public fun status_created() : u8 {
        0
    }

    public fun status_finalized() : u8 {
        2
    }

    public fun status_funded() : u8 {
        1
    }

    public fun total_allocated<T0>(arg0: &RewardEpoch<T0>) : u64 {
        arg0.total_allocated
    }

    public fun total_claimed<T0>(arg0: &RewardEpoch<T0>) : u64 {
        arg0.total_claimed
    }

    public fun unclaimed<T0>(arg0: &RewardEpoch<T0>) : u64 {
        arg0.total_allocated - arg0.total_claimed
    }

    // decompiled from Move bytecode v7
}

