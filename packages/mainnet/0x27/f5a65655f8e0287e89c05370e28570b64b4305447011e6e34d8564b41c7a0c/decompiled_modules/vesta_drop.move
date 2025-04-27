module 0x27f5a65655f8e0287e89c05370e28570b64b4305447011e6e34d8564b41c7a0c::vesta_drop {
    struct VestaDrop<phantom T0> has key {
        id: 0x2::object::UID,
        manager: address,
        start_time: u64,
        end_time: u64,
        total_amount: u64,
        claimed_amount: u64,
        balance: 0x2::balance::Balance<T0>,
        claims: 0x2::table::Table<address, AirdropInfo>,
    }

    struct AirdropInfo has copy, drop, store {
        amount: u64,
        claimed: bool,
    }

    struct CreateEvent has copy, drop {
        vesta_drop_id: 0x2::object::ID,
        manager: address,
        coin_type: 0x1::type_name::TypeName,
        start_time: u64,
        end_time: u64,
    }

    struct DepositEvent has copy, drop {
        vesta_drop_id: 0x2::object::ID,
        amount: u64,
    }

    struct ClaimEvent has copy, drop {
        vesta_drop_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
    }

    struct UpdateStartTimeEvent has copy, drop {
        vesta_drop_id: 0x2::object::ID,
        old_start_time: u64,
        new_start_time: u64,
    }

    struct UpdateEndTimeEvent has copy, drop {
        vesta_drop_id: 0x2::object::ID,
        old_end_time: u64,
        new_end_time: u64,
    }

    struct UpdateManager has copy, drop {
        vesta_drop_id: 0x2::object::ID,
        old_manager: address,
        new_manager: address,
    }

    public fun allocate<T0>(arg0: &0x27f5a65655f8e0287e89c05370e28570b64b4305447011e6e34d8564b41c7a0c::versioned::Versioned, arg1: &mut VestaDrop<T0>, arg2: address, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0x27f5a65655f8e0287e89c05370e28570b64b4305447011e6e34d8564b41c7a0c::versioned::check_version(arg0);
        assert!(arg1.manager == 0x2::tx_context::sender(arg4), 0x27f5a65655f8e0287e89c05370e28570b64b4305447011e6e34d8564b41c7a0c::errors::err_not_vesta_manager());
        if (0x2::table::contains<address, AirdropInfo>(&arg1.claims, arg2)) {
            return
        };
        let v0 = AirdropInfo{
            amount  : arg3,
            claimed : false,
        };
        0x2::table::add<address, AirdropInfo>(&mut arg1.claims, arg2, v0);
        arg1.total_amount = arg1.total_amount + arg3;
    }

    public fun check_claim_time<T0>(arg0: &VestaDrop<T0>, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 >= arg0.start_time, 0x27f5a65655f8e0287e89c05370e28570b64b4305447011e6e34d8564b41c7a0c::errors::claim_not_start_error());
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 < arg0.end_time, 0x27f5a65655f8e0287e89c05370e28570b64b4305447011e6e34d8564b41c7a0c::errors::claim_has_end_error());
    }

    public fun claim<T0>(arg0: &0x27f5a65655f8e0287e89c05370e28570b64b4305447011e6e34d8564b41c7a0c::versioned::Versioned, arg1: &mut VestaDrop<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x27f5a65655f8e0287e89c05370e28570b64b4305447011e6e34d8564b41c7a0c::versioned::check_version(arg0);
        check_claim_time<T0>(arg1, arg2);
        assert!(0x2::table::contains<address, AirdropInfo>(&arg1.claims, 0x2::tx_context::sender(arg3)), 0x27f5a65655f8e0287e89c05370e28570b64b4305447011e6e34d8564b41c7a0c::errors::no_allocate_error());
        let v0 = 0x2::table::borrow_mut<address, AirdropInfo>(&mut arg1.claims, 0x2::tx_context::sender(arg3));
        assert!(!v0.claimed, 0x27f5a65655f8e0287e89c05370e28570b64b4305447011e6e34d8564b41c7a0c::errors::already_claimed_error());
        v0.claimed = true;
        assert!(0x2::balance::value<T0>(&arg1.balance) >= v0.amount, 0x27f5a65655f8e0287e89c05370e28570b64b4305447011e6e34d8564b41c7a0c::errors::not_enough_fund_error());
        let v1 = v0.amount;
        arg1.claimed_amount = arg1.claimed_amount + v1;
        let v2 = ClaimEvent{
            vesta_drop_id : 0x2::object::id<VestaDrop<T0>>(arg1),
            recipient     : 0x2::tx_context::sender(arg3),
            amount        : v1,
        };
        0x2::event::emit<ClaimEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v1), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun create<T0>(arg0: &0x27f5a65655f8e0287e89c05370e28570b64b4305447011e6e34d8564b41c7a0c::versioned::Versioned, arg1: &0x27f5a65655f8e0287e89c05370e28570b64b4305447011e6e34d8564b41c7a0c::admin_cap::AdminCap, arg2: address, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x27f5a65655f8e0287e89c05370e28570b64b4305447011e6e34d8564b41c7a0c::versioned::check_version(arg0);
        assert!(0x2::clock::timestamp_ms(arg5) / 1000 < arg3, 0x27f5a65655f8e0287e89c05370e28570b64b4305447011e6e34d8564b41c7a0c::errors::start_time_error());
        assert!(arg3 < arg4, 0x27f5a65655f8e0287e89c05370e28570b64b4305447011e6e34d8564b41c7a0c::errors::end_time_error());
        let v0 = VestaDrop<T0>{
            id             : 0x2::object::new(arg6),
            manager        : arg2,
            start_time     : arg3,
            end_time       : arg4,
            total_amount   : 0,
            claimed_amount : 0,
            balance        : 0x2::balance::zero<T0>(),
            claims         : 0x2::table::new<address, AirdropInfo>(arg6),
        };
        let v1 = CreateEvent{
            vesta_drop_id : 0x2::object::id<VestaDrop<T0>>(&v0),
            manager       : arg2,
            coin_type     : 0x1::type_name::get<T0>(),
            start_time    : arg3,
            end_time      : arg4,
        };
        0x2::event::emit<CreateEvent>(v1);
        0x2::transfer::share_object<VestaDrop<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &0x27f5a65655f8e0287e89c05370e28570b64b4305447011e6e34d8564b41c7a0c::versioned::Versioned, arg1: &mut VestaDrop<T0>, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x27f5a65655f8e0287e89c05370e28570b64b4305447011e6e34d8564b41c7a0c::versioned::check_version(arg0);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, arg3, arg4)));
        let v0 = DepositEvent{
            vesta_drop_id : 0x2::object::id<VestaDrop<T0>>(arg1),
            amount        : arg3,
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    public fun update_end_time<T0>(arg0: &0x27f5a65655f8e0287e89c05370e28570b64b4305447011e6e34d8564b41c7a0c::versioned::Versioned, arg1: &0x27f5a65655f8e0287e89c05370e28570b64b4305447011e6e34d8564b41c7a0c::admin_cap::AdminCap, arg2: &mut VestaDrop<T0>, arg3: u64) {
        0x27f5a65655f8e0287e89c05370e28570b64b4305447011e6e34d8564b41c7a0c::versioned::check_version(arg0);
        assert!(arg3 > arg2.start_time, 0x27f5a65655f8e0287e89c05370e28570b64b4305447011e6e34d8564b41c7a0c::errors::start_time_error());
        let v0 = UpdateEndTimeEvent{
            vesta_drop_id : 0x2::object::id<VestaDrop<T0>>(arg2),
            old_end_time  : arg2.end_time,
            new_end_time  : arg3,
        };
        0x2::event::emit<UpdateEndTimeEvent>(v0);
        arg2.end_time = arg3;
    }

    public fun update_manager<T0>(arg0: &0x27f5a65655f8e0287e89c05370e28570b64b4305447011e6e34d8564b41c7a0c::versioned::Versioned, arg1: &0x27f5a65655f8e0287e89c05370e28570b64b4305447011e6e34d8564b41c7a0c::admin_cap::AdminCap, arg2: &mut VestaDrop<T0>, arg3: address) {
        0x27f5a65655f8e0287e89c05370e28570b64b4305447011e6e34d8564b41c7a0c::versioned::check_version(arg0);
        arg2.manager = arg3;
        let v0 = UpdateManager{
            vesta_drop_id : 0x2::object::id<VestaDrop<T0>>(arg2),
            old_manager   : arg2.manager,
            new_manager   : arg3,
        };
        0x2::event::emit<UpdateManager>(v0);
    }

    public fun update_start_time<T0>(arg0: &0x27f5a65655f8e0287e89c05370e28570b64b4305447011e6e34d8564b41c7a0c::versioned::Versioned, arg1: &0x27f5a65655f8e0287e89c05370e28570b64b4305447011e6e34d8564b41c7a0c::admin_cap::AdminCap, arg2: &mut VestaDrop<T0>, arg3: u64) {
        0x27f5a65655f8e0287e89c05370e28570b64b4305447011e6e34d8564b41c7a0c::versioned::check_version(arg0);
        let v0 = UpdateStartTimeEvent{
            vesta_drop_id  : 0x2::object::id<VestaDrop<T0>>(arg2),
            old_start_time : arg2.start_time,
            new_start_time : arg3,
        };
        0x2::event::emit<UpdateStartTimeEvent>(v0);
        arg2.start_time = arg3;
    }

    // decompiled from Move bytecode v6
}

