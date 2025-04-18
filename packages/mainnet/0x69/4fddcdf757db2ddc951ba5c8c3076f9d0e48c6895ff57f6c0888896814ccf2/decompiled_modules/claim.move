module 0x694fddcdf757db2ddc951ba5c8c3076f9d0e48c6895ff57f6c0888896814ccf2::claim {
    struct ManageCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        claim_id: 0x2::object::ID,
    }

    struct Claim<phantom T0> has store, key {
        id: 0x2::object::UID,
        emergency: bool,
        start_time: u64,
        end_time: u64,
        balance: 0x2::coin::Coin<T0>,
        claim_members: 0x2::bag::Bag,
        unclaim_members: 0x2::bag::Bag,
    }

    struct ClaimEvent has copy, drop {
        address: address,
        amount: u64,
    }

    public entry fun claim<T0>(arg0: &mut Claim<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.emergency, 1001);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::bag::contains<address>(&arg0.unclaim_members, v0), 1002);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(v1 >= arg0.start_time && v1 <= arg0.end_time, 1004);
        let v2 = (v1 - arg0.start_time) / 2592000000;
        0x1::debug::print<u64>(&v2);
        if (v2 == 1) {
            assert!(0x2::bag::contains<address>(&arg0.claim_members, v0), 1006);
            assert!(*0x2::bag::borrow_mut<address, u64>(&mut arg0.claim_members, v0) == *0x2::bag::borrow_mut<address, u64>(&mut arg0.unclaim_members, v0) / 3, 1005);
        } else if (v2 == 2) {
            assert!(0x2::bag::contains<address>(&arg0.claim_members, v0), 1006);
            assert!(*0x2::bag::borrow_mut<address, u64>(&mut arg0.claim_members, v0) == *0x2::bag::borrow_mut<address, u64>(&mut arg0.unclaim_members, v0) / 3 * 2, 1005);
        } else {
            assert!(v2 == 0, 1007);
            assert!(!0x2::bag::contains<address>(&arg0.claim_members, v0), 1005);
        };
        if (0x2::bag::contains<address>(&arg0.claim_members, v0)) {
            let v3 = 0x2::bag::borrow<address, u64>(&arg0.unclaim_members, v0);
            let v4 = 0x2::bag::borrow_mut<address, u64>(&mut arg0.claim_members, v0);
            assert!(*v3 > *v4, 1002);
            let v5 = *v3 / 3;
            *v4 = *v4 + v5;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.balance, v5, arg2), v0);
            let v6 = ClaimEvent{
                address : v0,
                amount  : v5,
            };
            0x2::event::emit<ClaimEvent>(v6);
        } else {
            let v7 = *0x2::bag::borrow<address, u64>(&arg0.unclaim_members, v0) / 3;
            0x2::bag::add<address, u64>(&mut arg0.claim_members, v0, v7);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.balance, v7, arg2), v0);
            let v8 = ClaimEvent{
                address : v0,
                amount  : v7,
            };
            0x2::event::emit<ClaimEvent>(v8);
        };
    }

    public entry fun add_wait_claim_list<T0>(arg0: &mut Claim<T0>, arg1: &ManageCap<T0>, arg2: vector<address>, arg3: vector<u64>) {
        assert!(0x2::object::id<Claim<T0>>(arg0) == arg1.claim_id, 1000);
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 1003);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::pop_back<address>(&mut arg2);
            if (0x2::bag::contains<address>(&arg0.unclaim_members, v2)) {
                *0x2::bag::borrow_mut<address, u64>(&mut arg0.unclaim_members, v2) = 0x1::vector::pop_back<u64>(&mut arg3);
            } else {
                0x2::bag::add<address, u64>(&mut arg0.unclaim_members, v2, 0x1::vector::pop_back<u64>(&mut arg3));
            };
            v1 = v1 + 1;
        };
    }

    public entry fun change_end_time<T0>(arg0: &mut Claim<T0>, arg1: &ManageCap<T0>, arg2: u64) {
        assert!(0x2::object::id<Claim<T0>>(arg0) == arg1.claim_id, 1000);
        arg0.end_time = arg2;
    }

    public entry fun change_start_time<T0>(arg0: &mut Claim<T0>, arg1: &ManageCap<T0>, arg2: u64) {
        assert!(0x2::object::id<Claim<T0>>(arg0) == arg1.claim_id, 1000);
        arg0.start_time = arg2;
    }

    public fun claim_amount<T0>(arg0: &mut Claim<T0>, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x2::bag::contains<address>(&arg0.unclaim_members, 0x2::tx_context::sender(arg1)), 1002);
        *0x2::bag::borrow<address, u64>(&arg0.unclaim_members, 0x2::tx_context::sender(arg1))
    }

    public fun claimed_amount<T0>(arg0: &mut Claim<T0>, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x2::bag::contains<address>(&arg0.claim_members, 0x2::tx_context::sender(arg1)), 1002);
        *0x2::bag::borrow<address, u64>(&arg0.claim_members, 0x2::tx_context::sender(arg1))
    }

    public entry fun create_claim<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Claim<T0>{
            id              : 0x2::object::new(arg3),
            emergency       : false,
            start_time      : arg1,
            end_time        : arg2,
            balance         : arg0,
            claim_members   : 0x2::bag::new(arg3),
            unclaim_members : 0x2::bag::new(arg3),
        };
        let v1 = ManageCap<T0>{
            id       : 0x2::object::new(arg3),
            claim_id : 0x2::object::id<Claim<T0>>(&v0),
        };
        0x2::transfer::public_transfer<ManageCap<T0>>(v1, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_share_object<Claim<T0>>(v0);
    }

    public entry fun emergency_depost<T0>(arg0: &mut Claim<T0>, arg1: &ManageCap<T0>, arg2: 0x2::coin::Coin<T0>) {
        assert!(0x2::object::id<Claim<T0>>(arg0) == arg1.claim_id, 1000);
        0x2::coin::join<T0>(&mut arg0.balance, arg2);
    }

    public entry fun emergency_switch<T0>(arg0: &mut Claim<T0>, arg1: &ManageCap<T0>) {
        assert!(0x2::object::id<Claim<T0>>(arg0) == arg1.claim_id, 1000);
        arg0.emergency = !arg0.emergency;
    }

    public entry fun emergency_withdraw<T0>(arg0: &mut Claim<T0>, arg1: &ManageCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Claim<T0>>(arg0) == arg1.claim_id, 1000);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.balance, 0x2::coin::value<T0>(&arg0.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

