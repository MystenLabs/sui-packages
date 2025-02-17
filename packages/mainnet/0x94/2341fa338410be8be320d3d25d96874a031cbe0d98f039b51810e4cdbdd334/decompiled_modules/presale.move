module 0xf272bd31acd233ed9ad1e50775172eef711793e4f4ca8156bf51364c19a4f6d1::presale {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct VestingManager<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        vesting_balance: 0x2::balance::Balance<T0>,
        funding_balance: 0x2::balance::Balance<T1>,
        start_time_s: u64,
        end_time_s: u64,
        denominator: u64,
    }

    struct AdminVestingManager<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        manager: 0x2::object::ID,
    }

    struct FundingCollectedEvent has copy, drop, store {
        manager_id: 0x2::object::ID,
        funding_collected: u64,
        mtoken_type: 0x1::type_name::TypeName,
        funding_type: 0x1::type_name::TypeName,
    }

    struct UpdateVestingManager has copy, drop, store {
        start_time_s: u64,
        end_time_s: u64,
        denominator: u64,
    }

    entry fun new<T0: drop, T1>(arg0: &AdminCap, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > arg2, 0);
        let v0 = VestingManager<T0, T1>{
            id              : 0x2::object::new(arg4),
            vesting_balance : 0x2::coin::into_balance<T0>(arg1),
            funding_balance : 0x2::balance::zero<T1>(),
            start_time_s    : arg2,
            end_time_s      : arg3,
            denominator     : 100000000000,
        };
        let v1 = AdminVestingManager<T0, T1>{
            id      : 0x2::object::new(arg4),
            manager : 0x2::object::uid_to_inner(&v0.id),
        };
        0x2::transfer::public_transfer<AdminVestingManager<T0, T1>>(v1, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_share_object<VestingManager<T0, T1>>(v0);
    }

    public fun add_mtoken<T0, T1>(arg0: &AdminCap, arg1: &AdminVestingManager<T0, T1>, arg2: &mut VestingManager<T0, T1>, arg3: 0x2::coin::Coin<T0>) : u64 {
        assert!(arg1.manager == 0x2::object::uid_to_inner(&arg2.id), 8);
        0x2::balance::join<T0>(&mut arg2.vesting_balance, 0x2::coin::into_balance<T0>(arg3))
    }

    public fun funding<T0, T1>(arg0: &mut VestingManager<T0, T1>, arg1: u64, arg2: &mut 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        assert!(v0 >= arg0.start_time_s, 2);
        assert!(v0 <= arg0.end_time_s, 6);
        let v1 = ((arg1 / arg0.denominator * 1000000000) as u64);
        assert!(v1 > 0, 7);
        0x2::balance::join<T1>(&mut arg0.funding_balance, 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(arg2), v1));
        let v2 = FundingCollectedEvent{
            manager_id        : 0x2::object::uid_to_inner(&arg0.id),
            funding_collected : v1,
            mtoken_type       : 0x1::type_name::get<T0>(),
            funding_type      : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<FundingCollectedEvent>(v2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vesting_balance, arg1), arg4)
    }

    public fun funding_withdraw<T0, T1>(arg0: &AdminCap, arg1: &AdminVestingManager<T0, T1>, arg2: &mut VestingManager<T0, T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg1.manager == 0x2::object::uid_to_inner(&arg2.id), 8);
        assert!(0x2::balance::value<T1>(&arg2.funding_balance) >= arg3, 1);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg2.funding_balance, arg3), arg4)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun update_denominator<T0, T1>(arg0: &AdminCap, arg1: &AdminVestingManager<T0, T1>, arg2: &mut VestingManager<T0, T1>, arg3: u64) {
        assert!(arg1.manager == 0x2::object::uid_to_inner(&arg2.id), 8);
        assert!(arg3 > 0, 5);
        arg2.denominator = arg3;
        let v0 = UpdateVestingManager{
            start_time_s : arg2.start_time_s,
            end_time_s   : arg2.end_time_s,
            denominator  : arg2.denominator,
        };
        0x2::event::emit<UpdateVestingManager>(v0);
    }

    public fun update_end_time_s<T0, T1>(arg0: &AdminCap, arg1: &AdminVestingManager<T0, T1>, arg2: &mut VestingManager<T0, T1>, arg3: u64) {
        assert!(arg1.manager == 0x2::object::uid_to_inner(&arg2.id), 8);
        assert!(arg2.start_time_s < arg3, 4);
        arg2.end_time_s = arg3;
        let v0 = UpdateVestingManager{
            start_time_s : arg2.start_time_s,
            end_time_s   : arg2.end_time_s,
            denominator  : arg2.denominator,
        };
        0x2::event::emit<UpdateVestingManager>(v0);
    }

    public fun update_start_time_s<T0, T1>(arg0: &AdminCap, arg1: &AdminVestingManager<T0, T1>, arg2: &mut VestingManager<T0, T1>, arg3: u64) {
        assert!(arg1.manager == 0x2::object::uid_to_inner(&arg2.id), 8);
        assert!(arg3 < arg2.end_time_s, 3);
        arg2.start_time_s = arg3;
        let v0 = UpdateVestingManager{
            start_time_s : arg2.start_time_s,
            end_time_s   : arg2.end_time_s,
            denominator  : arg2.denominator,
        };
        0x2::event::emit<UpdateVestingManager>(v0);
    }

    public fun vesting_topup<T0, T1>(arg0: &AdminCap, arg1: &AdminVestingManager<T0, T1>, arg2: &mut VestingManager<T0, T1>, arg3: &mut 0x2::coin::Coin<T0>, arg4: u64) : u64 {
        assert!(arg1.manager == 0x2::object::uid_to_inner(&arg2.id), 8);
        0x2::balance::join<T0>(&mut arg2.vesting_balance, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg3), arg4 * 1000000000))
    }

    public fun vesting_withdraw<T0, T1>(arg0: &AdminCap, arg1: &AdminVestingManager<T0, T1>, arg2: &mut VestingManager<T0, T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.manager == 0x2::object::uid_to_inner(&arg2.id), 8);
        assert!(0x2::balance::value<T0>(&arg2.vesting_balance) >= arg3, 1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.vesting_balance, arg3), arg4)
    }

    // decompiled from Move bytecode v6
}

