module 0xf56a7c35676c7486b2078822f5b3ae58e383ac47b9c189fe77c3df3ea03fe42e::circle {
    struct Circle<phantom T0> has key {
        id: 0x2::object::UID,
        name: vector<u8>,
        stewards: address,
        memory_account: 0x2::object::ID,
        contribution: u64,
        round_ms: u64,
        cycle_start_ms: u64,
        members: vector<address>,
        member_keys: 0x2::table::Table<address, vector<u8>>,
        order: vector<address>,
        cycle: u64,
        paid: 0x2::table::Table<u64, vector<address>>,
        paid_out: vector<bool>,
        pot: 0x2::balance::Balance<T0>,
    }

    struct Contributed has copy, drop {
        circle: 0x2::object::ID,
        cycle: u64,
        round: u64,
        member: address,
        payer: address,
        amount: u64,
    }

    struct PaidOut has copy, drop {
        circle: 0x2::object::ID,
        cycle: u64,
        round: u64,
        to: address,
        amount: u64,
    }

    struct Admitted has copy, drop {
        circle: 0x2::object::ID,
        member: address,
        key: vector<u8>,
    }

    struct Removed has copy, drop {
        circle: 0x2::object::ID,
        member: address,
        key: vector<u8>,
    }

    struct CycleStarted has copy, drop {
        circle: 0x2::object::ID,
        cycle: u64,
        order: vector<address>,
        start_ms: u64,
    }

    struct CircleCreated has copy, drop {
        circle: 0x2::object::ID,
        stewards: address,
        memory_account: 0x2::object::ID,
        contribution: u64,
        round_ms: u64,
    }

    public fun remove<T0>(arg0: &mut Circle<T0>, arg1: &0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.stewards, 1);
        assert!(0x2::object::id<0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount>(arg1) == arg0.memory_account, 14);
        assert!(is_between_cycles<T0>(arg0), 10);
        assert!(0x1::vector::contains<address>(&arg0.members, &arg2), 2);
        let v0 = 0x2::table::remove<address, vector<u8>>(&mut arg0.member_keys, arg2);
        assert!(!0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::is_delegate(arg1, &v0), 13);
        let (_, v2) = 0x1::vector::index_of<address>(&arg0.members, &arg2);
        0x1::vector::remove<address>(&mut arg0.members, v2);
        let v3 = Removed{
            circle : 0x2::object::id<Circle<T0>>(arg0),
            member : arg2,
            key    : v0,
        };
        0x2::event::emit<Removed>(v3);
    }

    public fun admit<T0>(arg0: &mut Circle<T0>, arg1: &0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount, arg2: address, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.stewards, 1);
        assert!(0x2::object::id<0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount>(arg1) == arg0.memory_account, 14);
        assert!(is_between_cycles<T0>(arg0), 10);
        assert!(0x1::vector::length<address>(&arg0.members) < 19, 8);
        assert!(!0x1::vector::contains<address>(&arg0.members, &arg2), 9);
        assert!(0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::is_delegate(arg1, &arg3), 12);
        0x1::vector::push_back<address>(&mut arg0.members, arg2);
        0x2::table::add<address, vector<u8>>(&mut arg0.member_keys, arg2, arg3);
        let v0 = Admitted{
            circle : 0x2::object::id<Circle<T0>>(arg0),
            member : arg2,
            key    : arg3,
        };
        0x2::event::emit<Admitted>(v0);
    }

    fun all_paid_out<T0>(arg0: &Circle<T0>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<bool>(&arg0.paid_out)) {
            if (!*0x1::vector::borrow<bool>(&arg0.paid_out, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun contribute<T0>(arg0: &mut Circle<T0>, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        contribute_for<T0>(arg0, arg1, 0x2::tx_context::sender(arg4), arg2, arg3, arg4);
    }

    public fun contribute_for<T0>(arg0: &mut Circle<T0>, arg1: u64, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.cycle > 0 && !all_paid_out<T0>(arg0), 15);
        assert!(0x1::vector::contains<address>(&arg0.members, &arg2), 2);
        assert!(arg1 < 0x1::vector::length<address>(&arg0.members) && arg1 <= current_round<T0>(arg0, arg4), 3);
        assert!(0x2::coin::value<T0>(&arg3) == arg0.contribution, 5);
        let v0 = arg0.cycle * 1000 + arg1;
        if (!0x2::table::contains<u64, vector<address>>(&arg0.paid, v0)) {
            0x2::table::add<u64, vector<address>>(&mut arg0.paid, v0, vector[]);
        };
        let v1 = 0x2::table::borrow_mut<u64, vector<address>>(&mut arg0.paid, v0);
        assert!(!0x1::vector::contains<address>(v1, &arg2), 4);
        0x1::vector::push_back<address>(v1, arg2);
        0x2::balance::join<T0>(&mut arg0.pot, 0x2::coin::into_balance<T0>(arg3));
        let v2 = Contributed{
            circle : 0x2::object::id<Circle<T0>>(arg0),
            cycle  : arg0.cycle,
            round  : arg1,
            member : arg2,
            payer  : 0x2::tx_context::sender(arg5),
            amount : 0x2::coin::value<T0>(&arg3),
        };
        0x2::event::emit<Contributed>(v2);
    }

    public fun contribution<T0>(arg0: &Circle<T0>) : u64 {
        arg0.contribution
    }

    public fun create<T0>(arg0: vector<u8>, arg1: &0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::owner(arg1) == 0x2::tx_context::sender(arg4), 14);
        assert!(arg2 > 0 && arg3 > 0, 5);
        let v0 = Circle<T0>{
            id             : 0x2::object::new(arg4),
            name           : arg0,
            stewards       : 0x2::tx_context::sender(arg4),
            memory_account : 0x2::object::id<0xe7c16fbea0560e7057e2bf7422feaa4fb313749fc69c9e9092fac7a33b81d7f5::account::MemWalAccount>(arg1),
            contribution   : arg2,
            round_ms       : arg3,
            cycle_start_ms : 0,
            members        : vector[],
            member_keys    : 0x2::table::new<address, vector<u8>>(arg4),
            order          : vector[],
            cycle          : 0,
            paid           : 0x2::table::new<u64, vector<address>>(arg4),
            paid_out       : vector[],
            pot            : 0x2::balance::zero<T0>(),
        };
        let v1 = CircleCreated{
            circle         : 0x2::object::id<Circle<T0>>(&v0),
            stewards       : v0.stewards,
            memory_account : v0.memory_account,
            contribution   : arg2,
            round_ms       : arg3,
        };
        0x2::event::emit<CircleCreated>(v1);
        0x2::transfer::share_object<Circle<T0>>(v0);
    }

    public fun current_round<T0>(arg0: &Circle<T0>, arg1: &0x2::clock::Clock) : u64 {
        (0x2::clock::timestamp_ms(arg1) - arg0.cycle_start_ms) / arg0.round_ms
    }

    public fun cycle<T0>(arg0: &Circle<T0>) : u64 {
        arg0.cycle
    }

    public fun has_paid<T0>(arg0: &Circle<T0>, arg1: u64, arg2: address) : bool {
        let v0 = arg0.cycle * 1000 + arg1;
        0x2::table::contains<u64, vector<address>>(&arg0.paid, v0) && 0x1::vector::contains<address>(0x2::table::borrow<u64, vector<address>>(&arg0.paid, v0), &arg2)
    }

    public fun is_between_cycles<T0>(arg0: &Circle<T0>) : bool {
        arg0.cycle == 0 || all_paid_out<T0>(arg0)
    }

    public fun is_paid_out<T0>(arg0: &Circle<T0>, arg1: u64) : bool {
        *0x1::vector::borrow<bool>(&arg0.paid_out, arg1)
    }

    public fun members<T0>(arg0: &Circle<T0>) : &vector<address> {
        &arg0.members
    }

    public fun memory_account<T0>(arg0: &Circle<T0>) : 0x2::object::ID {
        arg0.memory_account
    }

    public fun order<T0>(arg0: &Circle<T0>) : &vector<address> {
        &arg0.order
    }

    public fun payout<T0>(arg0: &mut Circle<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.cycle > 0 && arg1 < 0x1::vector::length<address>(&arg0.members), 3);
        assert!(!*0x1::vector::borrow<bool>(&arg0.paid_out, arg1), 7);
        let v0 = arg0.cycle * 1000 + arg1;
        assert!(0x2::table::contains<u64, vector<address>>(&arg0.paid, v0) && 0x1::vector::length<address>(0x2::table::borrow<u64, vector<address>>(&arg0.paid, v0)) == 0x1::vector::length<address>(&arg0.members), 6);
        let v1 = *0x1::vector::borrow<address>(&arg0.order, arg1);
        let v2 = arg0.contribution * 0x1::vector::length<address>(&arg0.members);
        *0x1::vector::borrow_mut<bool>(&mut arg0.paid_out, arg1) = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pot, v2), arg2), v1);
        let v3 = PaidOut{
            circle : 0x2::object::id<Circle<T0>>(arg0),
            cycle  : arg0.cycle,
            round  : arg1,
            to     : v1,
            amount : v2,
        };
        0x2::event::emit<PaidOut>(v3);
    }

    public fun pot_value<T0>(arg0: &Circle<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.pot)
    }

    fun same_set(arg0: &vector<address>, arg1: &vector<address>) : bool {
        if (0x1::vector::length<address>(arg0) != 0x1::vector::length<address>(arg1)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (!0x1::vector::contains<address>(arg1, 0x1::vector::borrow<address>(arg0, v0))) {
                return false
            };
            let v1 = 0;
            while (v1 < v0) {
                if (*0x1::vector::borrow<address>(arg0, v1) == *0x1::vector::borrow<address>(arg0, v0)) {
                    return false
                };
                v1 = v1 + 1;
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun start_cycle<T0>(arg0: &mut Circle<T0>, arg1: vector<address>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.stewards, 1);
        assert!(is_between_cycles<T0>(arg0), 10);
        assert!(0x1::vector::length<address>(&arg0.members) > 0, 16);
        assert!(same_set(&arg1, &arg0.members), 11);
        arg0.order = arg1;
        arg0.cycle = arg0.cycle + 1;
        arg0.cycle_start_ms = 0x2::clock::timestamp_ms(arg2);
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0.members)) {
            0x1::vector::push_back<bool>(&mut v0, false);
            v1 = v1 + 1;
        };
        arg0.paid_out = v0;
        let v2 = CycleStarted{
            circle   : 0x2::object::id<Circle<T0>>(arg0),
            cycle    : arg0.cycle,
            order    : arg0.order,
            start_ms : arg0.cycle_start_ms,
        };
        0x2::event::emit<CycleStarted>(v2);
    }

    public fun stewards<T0>(arg0: &Circle<T0>) : address {
        arg0.stewards
    }

    // decompiled from Move bytecode v6
}

