module 0x8a2f10f89aa108238f35bdb9e1ffde6178d68c49dd2acc4bfaf6736cadaffe1a::rewards {
    struct Distributor has key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
        opened_at_ms: u64,
    }

    struct RewardsOpened has copy, drop {
        pool: 0x2::object::ID,
        distributor: 0x2::object::ID,
        opened_at_ms: u64,
    }

    struct CalendarScheduled has copy, drop {
        pool: 0x2::object::ID,
        start_ms: u64,
        duration_ms: u64,
    }

    struct EpochKey<phantom T0> has copy, drop, store {
        epoch: u64,
    }

    struct Epoch<phantom T0> has key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
        epoch: u64,
        root: vector<u8>,
        snapshots: vector<u8>,
        funded_initial: u64,
        distributor: 0x2::object::ID,
        context: vector<u8>,
        funds: 0x2::balance::Balance<T0>,
        revision: u64,
        paid: 0x2::table::Table<address, u64>,
    }

    struct Revised<phantom T0> has copy, drop {
        pool: 0x2::object::ID,
        epoch: u64,
        revision: u64,
        previous_remaining: u64,
        outstanding: u64,
        root: vector<u8>,
    }

    struct Published<phantom T0> has copy, drop {
        pool: 0x2::object::ID,
        distributor: 0x2::object::ID,
        epoch: u64,
        funded: u64,
        operator: address,
    }

    struct RewardClaimed<phantom T0> has copy, drop {
        pool: 0x2::object::ID,
        epoch: u64,
        revision: u64,
        beneficiary: address,
        amount: u64,
    }

    struct Allocation has drop {
        context: vector<u8>,
        distributor: 0x2::object::ID,
        pool: 0x2::object::ID,
        epoch: u64,
        asset: 0x1::type_name::TypeName,
        user: address,
        amount: u64,
    }

    public fun claim<T0, T1>(arg0: &0x8a2f10f89aa108238f35bdb9e1ffde6178d68c49dd2acc4bfaf6736cadaffe1a::staking::Pool<T0>, arg1: &mut Epoch<T1>, arg2: u64, arg3: u64, arg4: vector<vector<u8>>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x8a2f10f89aa108238f35bdb9e1ffde6178d68c49dd2acc4bfaf6736cadaffe1a::staking::assert_version<T0>(arg0);
        assert!(arg1.pool == 0x2::object::id<0x8a2f10f89aa108238f35bdb9e1ffde6178d68c49dd2acc4bfaf6736cadaffe1a::staking::Pool<T0>>(arg0), 13835058875620917249);
        assert!(!0x8a2f10f89aa108238f35bdb9e1ffde6178d68c49dd2acc4bfaf6736cadaffe1a::staking::reward_claims_paused<T0>(arg0), 13836466254800093195);
        let v0 = 0x2::tx_context::sender(arg5);
        0x8a2f10f89aa108238f35bdb9e1ffde6178d68c49dd2acc4bfaf6736cadaffe1a::merkle_proof::verify(&arg1.root, reward_digest<T1>(arg1.context, arg1.distributor, arg1.pool, arg1.epoch, v0, arg2), arg3, &arg4);
        assert!(arg2 > 0, 13836184797003120649);
        let v1 = if (0x2::table::contains<address, u64>(&arg1.paid, v0)) {
            *0x2::table::borrow<address, u64>(&arg1.paid, v0)
        } else {
            0
        };
        assert!(arg2 > v1, 13835903330616213511);
        let v2 = arg2 - v1;
        assert!(v2 <= 0x2::balance::value<T1>(&arg1.funds), 13836184814182989833);
        if (v1 == 0) {
            0x2::table::add<address, u64>(&mut arg1.paid, v0, arg2);
        } else {
            *0x2::table::borrow_mut<address, u64>(&mut arg1.paid, v0) = arg2;
        };
        let v3 = RewardClaimed<T1>{
            pool        : arg1.pool,
            epoch       : arg1.epoch,
            revision    : arg1.revision,
            beneficiary : v0,
            amount      : v2,
        };
        0x2::event::emit<RewardClaimed<T1>>(v3);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.funds, v2), arg5)
    }

    fun create_distributor<T0>(arg0: &0x8a2f10f89aa108238f35bdb9e1ffde6178d68c49dd2acc4bfaf6736cadaffe1a::staking::Pool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Distributor{
            id           : 0x2::object::new(arg2),
            pool         : 0x2::object::id<0x8a2f10f89aa108238f35bdb9e1ffde6178d68c49dd2acc4bfaf6736cadaffe1a::staking::Pool<T0>>(arg0),
            opened_at_ms : arg1,
        };
        let v1 = RewardsOpened{
            pool         : v0.pool,
            distributor  : 0x2::object::id<Distributor>(&v0),
            opened_at_ms : v0.opened_at_ms,
        };
        0x2::event::emit<RewardsOpened>(v1);
        0x2::transfer::share_object<Distributor>(v0);
    }

    public fun init_distributor<T0>(arg0: &mut 0x8a2f10f89aa108238f35bdb9e1ffde6178d68c49dd2acc4bfaf6736cadaffe1a::staking::Pool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        0x8a2f10f89aa108238f35bdb9e1ffde6178d68c49dd2acc4bfaf6736cadaffe1a::staking::register_first_epoch<T0>(arg0, v0, v0 + 0x8a2f10f89aa108238f35bdb9e1ffde6178d68c49dd2acc4bfaf6736cadaffe1a::staking::epoch_duration_ms(), arg1, arg2);
        create_distributor<T0>(arg0, v0, arg2);
    }

    public fun init_scheduled_distributor<T0>(arg0: &mut 0x8a2f10f89aa108238f35bdb9e1ffde6178d68c49dd2acc4bfaf6736cadaffe1a::staking::Pool<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = CalendarScheduled{
            pool        : 0x2::object::id<0x8a2f10f89aa108238f35bdb9e1ffde6178d68c49dd2acc4bfaf6736cadaffe1a::staking::Pool<T0>>(arg0),
            start_ms    : arg1,
            duration_ms : 0x8a2f10f89aa108238f35bdb9e1ffde6178d68c49dd2acc4bfaf6736cadaffe1a::staking::schedule_distributor<T0>(arg0, arg1, arg2, arg3, arg4),
        };
        0x2::event::emit<CalendarScheduled>(v0);
        create_distributor<T0>(arg0, arg1, arg4);
    }

    public fun publish_budget<T0, T1>(arg0: &mut 0x8a2f10f89aa108238f35bdb9e1ffde6178d68c49dd2acc4bfaf6736cadaffe1a::staking::Pool<T0>, arg1: &mut Distributor, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        seal<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x8a2f10f89aa108238f35bdb9e1ffde6178d68c49dd2acc4bfaf6736cadaffe1a::staking::draw_rewards<T0, T1>(arg0, arg2, arg5), arg6, arg7);
    }

    public fun revise<T0, T1>(arg0: &mut 0x8a2f10f89aa108238f35bdb9e1ffde6178d68c49dd2acc4bfaf6736cadaffe1a::staking::Pool<T0>, arg1: &0x8a2f10f89aa108238f35bdb9e1ffde6178d68c49dd2acc4bfaf6736cadaffe1a::staking::PoolAdminCap, arg2: &mut Epoch<T1>, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: u64) {
        assert!(arg2.pool == 0x2::object::id<0x8a2f10f89aa108238f35bdb9e1ffde6178d68c49dd2acc4bfaf6736cadaffe1a::staking::Pool<T0>>(arg0), 13835058725297061889);
        assert!(arg2.revision == arg3 && 0x2::balance::value<T1>(&arg2.funds) == arg4, 13836747579453079565);
        assert!(0x1::vector::length<u8>(&arg5) == 32 && 0x1::vector::length<u8>(&arg6) == 32, 13835340208863838211);
        0x8a2f10f89aa108238f35bdb9e1ffde6178d68c49dd2acc4bfaf6736cadaffe1a::staking::reconcile_rewards<T0, T1>(arg0, arg1, &mut arg2.funds, arg7);
        arg2.revision = arg2.revision + 1;
        arg2.root = arg5;
        arg2.snapshots = arg6;
        let v0 = Revised<T1>{
            pool               : arg2.pool,
            epoch              : arg2.epoch,
            revision           : arg2.revision,
            previous_remaining : arg4,
            outstanding        : arg7,
            root               : arg5,
        };
        0x2::event::emit<Revised<T1>>(v0);
    }

    public fun reward_digest<T0>(arg0: vector<u8>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: address, arg5: u64) : vector<u8> {
        let v0 = Allocation{
            context     : arg0,
            distributor : arg1,
            pool        : arg2,
            epoch       : arg3,
            asset       : 0x1::type_name::with_defining_ids<T0>(),
            user        : arg4,
            amount      : arg5,
        };
        0x8a2f10f89aa108238f35bdb9e1ffde6178d68c49dd2acc4bfaf6736cadaffe1a::merkle_proof::leaf(2, 0x2::bcs::to_bytes<Allocation>(&v0))
    }

    fun seal<T0, T1>(arg0: &0x8a2f10f89aa108238f35bdb9e1ffde6178d68c49dd2acc4bfaf6736cadaffe1a::staking::Pool<T0>, arg1: &mut Distributor, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool == 0x2::object::id<0x8a2f10f89aa108238f35bdb9e1ffde6178d68c49dd2acc4bfaf6736cadaffe1a::staking::Pool<T0>>(arg0), 13835058609332944897);
        0x8a2f10f89aa108238f35bdb9e1ffde6178d68c49dd2acc4bfaf6736cadaffe1a::staking::assert_reward_publisher<T0>(arg0, arg7);
        assert!(0x8a2f10f89aa108238f35bdb9e1ffde6178d68c49dd2acc4bfaf6736cadaffe1a::staking::epoch_ended<T0>(arg0, arg2, arg6), 13835058617922879489);
        let v0 = if (0x1::vector::length<u8>(&arg3) == 32) {
            if (0x1::vector::length<u8>(&arg4) == 32) {
                0x2::balance::value<T1>(&arg5) > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13835340097194688515);
        let v1 = EpochKey<T1>{epoch: arg2};
        assert!(!0x2::dynamic_field::exists_<EpochKey<T1>>(&arg1.id, v1), 13835621576466497541);
        let v2 = Epoch<T1>{
            id             : 0x2::object::new(arg7),
            pool           : arg1.pool,
            epoch          : arg2,
            root           : arg3,
            snapshots      : arg4,
            funded_initial : 0x2::balance::value<T1>(&arg5),
            distributor    : 0x2::object::id<Distributor>(arg1),
            context        : 0x8a2f10f89aa108238f35bdb9e1ffde6178d68c49dd2acc4bfaf6736cadaffe1a::staking::migration_context<T0>(arg0),
            funds          : arg5,
            revision       : 0,
            paid           : 0x2::table::new<address, u64>(arg7),
        };
        let v3 = EpochKey<T1>{epoch: arg2};
        0x2::dynamic_field::add<EpochKey<T1>, 0x2::object::ID>(&mut arg1.id, v3, 0x2::object::id<Epoch<T1>>(&v2));
        let v4 = Published<T1>{
            pool        : v2.pool,
            distributor : v2.distributor,
            epoch       : arg2,
            funded      : v2.funded_initial,
            operator    : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<Published<T1>>(v4);
        0x2::transfer::share_object<Epoch<T1>>(v2);
    }

    // decompiled from Move bytecode v7
}

