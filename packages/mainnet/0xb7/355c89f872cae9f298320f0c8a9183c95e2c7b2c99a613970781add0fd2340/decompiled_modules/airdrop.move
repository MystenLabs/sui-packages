module 0xb7355c89f872cae9f298320f0c8a9183c95e2c7b2c99a613970781add0fd2340::airdrop {
    struct ManageCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        claim_id: 0x2::object::ID,
    }

    struct Airdrop has store {
        next_cliam_time: u64,
        next_months_idx: u64,
        first_cliam_time: u64,
        claimd: u64,
        unclaim: u64,
        end: bool,
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
        month: u64,
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

    public fun claim<T0>(arg0: &Claim<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (!0x2::bag::contains<address>(&arg0.unclaim_members, v0)) {
            return (0, 0, 0)
        };
        if (0x2::bag::contains<address>(&arg0.claim_members, v0)) {
            let v4 = (0x2::clock::timestamp_ms(arg1) - arg0.start_time) / 2592000000 + 2;
            let v5 = v4;
            if (v4 > 10) {
                v5 = 10;
            };
            let v6 = 0x2::bag::borrow<address, u64>(&arg0.unclaim_members, v0);
            let v7 = 0x2::bag::borrow<address, Airdrop>(&arg0.claim_members, v0);
            (*v6, v7.claimd, *v6 / 10 * v5 - v7.claimd)
        } else {
            let v8 = (0x2::clock::timestamp_ms(arg1) - arg0.start_time) / 2592000000;
            let v9 = 0x2::bag::borrow<address, u64>(&arg0.unclaim_members, v0);
            let v10 = if (v8 != 0) {
                2 + v8
            } else {
                2
            };
            let v11 = v10;
            if (v10 > 10) {
                v11 = 10;
            };
            (*v9, 0, *v9 / 10 * v11)
        }
    }

    public fun claim_amount<T0>(arg0: &mut Claim<T0>, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x2::bag::contains<address>(&arg0.unclaim_members, 0x2::tx_context::sender(arg1)), 1002);
        *0x2::bag::borrow<address, u64>(&arg0.unclaim_members, 0x2::tx_context::sender(arg1))
    }

    public entry fun claim_entry<T0>(arg0: &mut Claim<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(!arg0.emergency, 1001);
        assert!(0x2::bag::contains<address>(&arg0.unclaim_members, v0), 1002);
        assert!(v1 >= arg0.start_time && v1 <= arg0.end_time, 1004);
        if (0x2::bag::contains<address>(&arg0.claim_members, v0)) {
            let v2 = (v1 - arg0.start_time) / 2592000000 + 2;
            if (v2 > 10) {
                v2 = 10;
            };
            0x1::debug::print<u64>(&v2);
            let v3 = 0x2::bag::borrow<address, u64>(&arg0.unclaim_members, v0);
            let v4 = 0x2::bag::remove<address, Airdrop>(&mut arg0.claim_members, v0);
            assert!(!v4.end, 1002);
            let v5 = v4.next_months_idx;
            assert!(v4.next_cliam_time <= v1, 1002);
            assert!(*v3 > v4.claimd, 1002);
            let v6 = *v3 / 10 * v2;
            v4.claimd = v6;
            v4.unclaim = *v3 - v6;
            if (v5 + 1 > 10) {
                v4.next_months_idx = 10;
                v4.end = true;
            } else {
                v4.next_months_idx = v2;
                v4.next_cliam_time = arg0.start_time + 2592000000 * (v2 - 1);
            };
            let v7 = ClaimEvent{
                address : v0,
                amount  : v6,
                month   : v5,
            };
            0x2::event::emit<ClaimEvent>(v7);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.balance, v6 - v4.claimd, arg2), v0);
            0x2::bag::add<address, Airdrop>(&mut arg0.claim_members, 0x2::tx_context::sender(arg2), v4);
        } else {
            let v8 = (v1 - arg0.start_time) / 2592000000;
            let v9 = 0x2::bag::borrow<address, u64>(&arg0.unclaim_members, v0);
            let v10 = if (v8 != 0) {
                2 + v8
            } else {
                2
            };
            let v11 = v10;
            if (v10 > 10) {
                v11 = 10;
            };
            let v12 = *v9 / 10 * v11;
            let v13 = v11 == 10;
            let v14 = Airdrop{
                next_cliam_time  : arg0.start_time + 2592000000 * (v11 - 1),
                next_months_idx  : v11 - 1,
                first_cliam_time : v1,
                claimd           : v12,
                unclaim          : *v9 - v12,
                end              : v13,
            };
            let v15 = ClaimEvent{
                address : v0,
                amount  : v12,
                month   : 2,
            };
            0x2::event::emit<ClaimEvent>(v15);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.balance, v12, arg2), v0);
            0x2::bag::add<address, Airdrop>(&mut arg0.claim_members, 0x2::tx_context::sender(arg2), v14);
        };
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

    public entry fun emergency_deposit<T0>(arg0: &mut Claim<T0>, arg1: &ManageCap<T0>, arg2: 0x2::coin::Coin<T0>) {
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

