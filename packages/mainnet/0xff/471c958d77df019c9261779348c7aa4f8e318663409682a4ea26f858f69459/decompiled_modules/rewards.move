module 0xff471c958d77df019c9261779348c7aa4f8e318663409682a4ea26f858f69459::rewards {
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
        claimed: 0x2::table::Table<address, bool>,
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

    public fun claim<T0, T1>(arg0: &0xff471c958d77df019c9261779348c7aa4f8e318663409682a4ea26f858f69459::ledger::Pool<T0>, arg1: &mut Epoch<T1>, arg2: u64, arg3: u64, arg4: vector<vector<u8>>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xff471c958d77df019c9261779348c7aa4f8e318663409682a4ea26f858f69459::ledger::assert_version<T0>(arg0);
        assert!(arg1.pool == 0x2::object::id<0xff471c958d77df019c9261779348c7aa4f8e318663409682a4ea26f858f69459::ledger::Pool<T0>>(arg0), 13835058742476931073);
        assert!(!0xff471c958d77df019c9261779348c7aa4f8e318663409682a4ea26f858f69459::ledger::reward_claims_paused<T0>(arg0), 13836466121656107019);
        let v0 = 0x2::tx_context::sender(arg5);
        0xff471c958d77df019c9261779348c7aa4f8e318663409682a4ea26f858f69459::proof::verify(&arg1.root, reward_digest<T1>(arg1.context, arg1.distributor, arg1.pool, arg1.epoch, v0, arg2), arg3, &arg4);
        assert!(!0x2::table::contains<address, bool>(&arg1.claimed, v0), 13835903184587325447);
        assert!(arg2 > 0 && arg2 <= 0x2::balance::value<T1>(&arg1.funds), 13836184663859134473);
        0x2::table::add<address, bool>(&mut arg1.claimed, v0, true);
        let v1 = RewardClaimed<T1>{
            pool        : arg1.pool,
            epoch       : arg1.epoch,
            beneficiary : v0,
            amount      : arg2,
        };
        0x2::event::emit<RewardClaimed<T1>>(v1);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.funds, arg2), arg5)
    }

    fun create_distributor<T0>(arg0: &0xff471c958d77df019c9261779348c7aa4f8e318663409682a4ea26f858f69459::ledger::Pool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Distributor{
            id           : 0x2::object::new(arg2),
            pool         : 0x2::object::id<0xff471c958d77df019c9261779348c7aa4f8e318663409682a4ea26f858f69459::ledger::Pool<T0>>(arg0),
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

    public fun init_distributor<T0>(arg0: &mut 0xff471c958d77df019c9261779348c7aa4f8e318663409682a4ea26f858f69459::ledger::Pool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0xff471c958d77df019c9261779348c7aa4f8e318663409682a4ea26f858f69459::ledger::mark_distributor<T0>(arg0, arg2);
        create_distributor<T0>(arg0, 0x2::clock::timestamp_ms(arg1), arg2);
    }

    public fun init_scheduled_distributor<T0>(arg0: &mut 0xff471c958d77df019c9261779348c7aa4f8e318663409682a4ea26f858f69459::ledger::Pool<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xff471c958d77df019c9261779348c7aa4f8e318663409682a4ea26f858f69459::ledger::schedule_distributor<T0>(arg0, arg1, arg2, arg3, arg4);
        let v0 = CalendarScheduled{
            pool        : 0x2::object::id<0xff471c958d77df019c9261779348c7aa4f8e318663409682a4ea26f858f69459::ledger::Pool<T0>>(arg0),
            start_ms    : arg1,
            duration_ms : 0xff471c958d77df019c9261779348c7aa4f8e318663409682a4ea26f858f69459::ledger::reward_duration_ms<T0>(arg0),
        };
        0x2::event::emit<CalendarScheduled>(v0);
        create_distributor<T0>(arg0, arg1, arg4);
    }

    public fun publish_budget<T0, T1>(arg0: &mut 0xff471c958d77df019c9261779348c7aa4f8e318663409682a4ea26f858f69459::ledger::Pool<T0>, arg1: &mut Distributor, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        seal<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0xff471c958d77df019c9261779348c7aa4f8e318663409682a4ea26f858f69459::ledger::draw_rewards<T0, T1>(arg0, arg2, arg5), arg6, arg7);
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
        0xff471c958d77df019c9261779348c7aa4f8e318663409682a4ea26f858f69459::proof::leaf(2, 0x2::bcs::to_bytes<Allocation>(&v0))
    }

    fun seal<T0, T1>(arg0: &0xff471c958d77df019c9261779348c7aa4f8e318663409682a4ea26f858f69459::ledger::Pool<T0>, arg1: &mut Distributor, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool == 0x2::object::id<0xff471c958d77df019c9261779348c7aa4f8e318663409682a4ea26f858f69459::ledger::Pool<T0>>(arg0), 13835058532023533569);
        let v0 = 0xff471c958d77df019c9261779348c7aa4f8e318663409682a4ea26f858f69459::ledger::epoch_start<T0>(arg0, arg7);
        assert!(0x2::clock::timestamp_ms(arg6) >= v0 && arg2 < 0xff471c958d77df019c9261779348c7aa4f8e318663409682a4ea26f858f69459::ledger::current_epoch<T0>(arg0, arg6), 13835058540613468161);
        if (arg1.opened_at_ms > v0) {
            assert!(arg2 >= (arg1.opened_at_ms - v0) / 0xff471c958d77df019c9261779348c7aa4f8e318663409682a4ea26f858f69459::ledger::reward_duration_ms<T0>(arg0), 13835058549203402753);
        };
        let v1 = if (0x1::vector::length<u8>(&arg3) == 32) {
            if (0x1::vector::length<u8>(&arg4) == 32) {
                0x2::balance::value<T1>(&arg5) > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 13835340032770179075);
        let v2 = EpochKey<T1>{epoch: arg2};
        assert!(!0x2::dynamic_field::exists_<EpochKey<T1>>(&arg1.id, v2), 13835621512041988101);
        let v3 = Epoch<T1>{
            id             : 0x2::object::new(arg7),
            pool           : arg1.pool,
            epoch          : arg2,
            root           : arg3,
            snapshots      : arg4,
            funded_initial : 0x2::balance::value<T1>(&arg5),
            distributor    : 0x2::object::id<Distributor>(arg1),
            context        : 0xff471c958d77df019c9261779348c7aa4f8e318663409682a4ea26f858f69459::ledger::migration_context<T0>(arg0),
            funds          : arg5,
            claimed        : 0x2::table::new<address, bool>(arg7),
        };
        let v4 = EpochKey<T1>{epoch: arg2};
        0x2::dynamic_field::add<EpochKey<T1>, 0x2::object::ID>(&mut arg1.id, v4, 0x2::object::id<Epoch<T1>>(&v3));
        let v5 = Published<T1>{
            pool        : v3.pool,
            distributor : v3.distributor,
            epoch       : arg2,
            funded      : v3.funded_initial,
            operator    : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<Published<T1>>(v5);
        0x2::transfer::share_object<Epoch<T1>>(v3);
    }

    // decompiled from Move bytecode v7
}

