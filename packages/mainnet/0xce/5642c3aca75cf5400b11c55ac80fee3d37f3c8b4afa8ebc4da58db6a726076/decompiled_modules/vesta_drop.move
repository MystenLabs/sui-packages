module 0xce5642c3aca75cf5400b11c55ac80fee3d37f3c8b4afa8ebc4da58db6a726076::vesta_drop {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        vesta_drop: 0x2::object::ID,
    }

    struct VestaDrop<phantom T0> has key {
        id: 0x2::object::UID,
        start_time: u64,
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
        admin_cap_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        start_time: u64,
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

    public fun allocate<T0>(arg0: &AdminCap, arg1: &mut VestaDrop<T0>, arg2: address, arg3: u64) {
        assert!(arg0.vesta_drop == 0x2::object::id<VestaDrop<T0>>(arg1), 0xce5642c3aca75cf5400b11c55ac80fee3d37f3c8b4afa8ebc4da58db6a726076::error::admin_error());
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

    public fun claim<T0>(arg0: &mut VestaDrop<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 >= arg0.start_time, 0xce5642c3aca75cf5400b11c55ac80fee3d37f3c8b4afa8ebc4da58db6a726076::error::claim_not_start_error());
        assert!(0x2::table::contains<address, AirdropInfo>(&arg0.claims, 0x2::tx_context::sender(arg2)), 0xce5642c3aca75cf5400b11c55ac80fee3d37f3c8b4afa8ebc4da58db6a726076::error::no_allocate_error());
        let v0 = 0x2::table::borrow_mut<address, AirdropInfo>(&mut arg0.claims, 0x2::tx_context::sender(arg2));
        assert!(!v0.claimed, 0xce5642c3aca75cf5400b11c55ac80fee3d37f3c8b4afa8ebc4da58db6a726076::error::already_claimed_error());
        v0.claimed = true;
        assert!(0x2::balance::value<T0>(&arg0.balance) >= v0.amount, 0xce5642c3aca75cf5400b11c55ac80fee3d37f3c8b4afa8ebc4da58db6a726076::error::not_enough_fund_error());
        let v1 = v0.amount;
        arg0.claimed_amount = arg0.claimed_amount + v1;
        let v2 = ClaimEvent{
            vesta_drop_id : 0x2::object::id<VestaDrop<T0>>(arg0),
            recipient     : 0x2::tx_context::sender(arg2),
            amount        : v1,
        };
        0x2::event::emit<ClaimEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v1), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun create<T0>(arg0: u64, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 < arg0, 0xce5642c3aca75cf5400b11c55ac80fee3d37f3c8b4afa8ebc4da58db6a726076::error::start_time_error());
        let v0 = VestaDrop<T0>{
            id             : 0x2::object::new(arg2),
            start_time     : arg0,
            total_amount   : 0,
            claimed_amount : 0,
            balance        : 0x2::balance::zero<T0>(),
            claims         : 0x2::table::new<address, AirdropInfo>(arg2),
        };
        let v1 = AdminCap{
            id         : 0x2::object::new(arg2),
            vesta_drop : 0x2::object::id<VestaDrop<T0>>(&v0),
        };
        let v2 = CreateEvent{
            vesta_drop_id : 0x2::object::id<VestaDrop<T0>>(&v0),
            admin_cap_id  : 0x2::object::id<AdminCap>(&v1),
            coin_type     : 0x1::type_name::get<T0>(),
            start_time    : arg0,
        };
        0x2::event::emit<CreateEvent>(v2);
        0x2::transfer::share_object<VestaDrop<T0>>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun deposit<T0>(arg0: &mut VestaDrop<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, arg2, arg3)));
        let v0 = DepositEvent{
            vesta_drop_id : 0x2::object::id<VestaDrop<T0>>(arg0),
            amount        : arg2,
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    public fun update_start_time<T0>(arg0: &AdminCap, arg1: &mut VestaDrop<T0>, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg3) / 1000 < arg2, 0xce5642c3aca75cf5400b11c55ac80fee3d37f3c8b4afa8ebc4da58db6a726076::error::start_time_error());
        assert!(arg0.vesta_drop == 0x2::object::id<VestaDrop<T0>>(arg1), 0xce5642c3aca75cf5400b11c55ac80fee3d37f3c8b4afa8ebc4da58db6a726076::error::admin_error());
        let v0 = UpdateStartTimeEvent{
            vesta_drop_id  : 0x2::object::id<VestaDrop<T0>>(arg1),
            old_start_time : arg1.start_time,
            new_start_time : arg2,
        };
        0x2::event::emit<UpdateStartTimeEvent>(v0);
        arg1.start_time = arg2;
    }

    // decompiled from Move bytecode v6
}

