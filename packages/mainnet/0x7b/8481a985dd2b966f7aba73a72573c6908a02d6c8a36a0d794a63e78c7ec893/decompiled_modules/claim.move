module 0x46e308d7b4d5a0b1be45f25dea55cfc82705800527b47ef68c69e93eeed23259::claim {
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

    struct CheckClaimInfoEvent has copy, drop {
        address: address,
        amount: u64,
        claimed_amount: u64,
    }

    struct ChangeStartTimeEvent has copy, drop {
        claim_id: 0x2::object::ID,
        start_time: u64,
    }

    struct ChangeEndTimeEvent has copy, drop {
        claim_id: 0x2::object::ID,
        end_time: u64,
    }

    public entry fun claim<T0>(arg0: &mut Claim<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.emergency, 1001);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::bag::contains<address>(&arg0.unclaim_members, v0), 1002);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(v1 >= arg0.start_time && v1 <= arg0.end_time, 1004);
        if (0x2::bag::contains<address>(&arg0.claim_members, v0)) {
            let v2 = 0x2::bag::borrow<address, u64>(&arg0.unclaim_members, v0);
            let v3 = 0x2::bag::borrow_mut<address, u64>(&mut arg0.claim_members, v0);
            assert!(*v2 > *v3, 1002);
            let v4 = *v2 - *v3;
            *v3 = *v2;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.balance, v4, arg2), v0);
            let v5 = ClaimEvent{
                address : v0,
                amount  : v4,
            };
            0x2::event::emit<ClaimEvent>(v5);
        } else {
            let v6 = 0x2::bag::borrow<address, u64>(&arg0.unclaim_members, v0);
            0x2::bag::add<address, u64>(&mut arg0.claim_members, v0, *v6);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.balance, *v6, arg2), v0);
            let v7 = ClaimEvent{
                address : v0,
                amount  : *v6,
            };
            0x2::event::emit<ClaimEvent>(v7);
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
        assert!(arg2 > arg0.start_time, 1005);
        arg0.end_time = arg2;
        let v0 = ChangeEndTimeEvent{
            claim_id : 0x2::object::id<Claim<T0>>(arg0),
            end_time : arg2,
        };
        0x2::event::emit<ChangeEndTimeEvent>(v0);
    }

    public entry fun change_start_time<T0>(arg0: &mut Claim<T0>, arg1: &ManageCap<T0>, arg2: u64) {
        assert!(0x2::object::id<Claim<T0>>(arg0) == arg1.claim_id, 1000);
        assert!(arg0.end_time > arg2, 1005);
        arg0.start_time = arg2;
        let v0 = ChangeStartTimeEvent{
            claim_id   : 0x2::object::id<Claim<T0>>(arg0),
            start_time : arg2,
        };
        0x2::event::emit<ChangeStartTimeEvent>(v0);
    }

    public entry fun check_claim_info<T0>(arg0: &mut Claim<T0>, arg1: address) {
        let v0 = 0;
        let v1 = 0;
        if (0x2::bag::contains<address>(&arg0.unclaim_members, arg1)) {
            v0 = *0x2::bag::borrow<address, u64>(&arg0.unclaim_members, arg1);
        };
        if (0x2::bag::contains<address>(&arg0.claim_members, arg1)) {
            v1 = *0x2::bag::borrow<address, u64>(&arg0.claim_members, arg1);
        };
        let v2 = CheckClaimInfoEvent{
            address        : arg1,
            amount         : v0,
            claimed_amount : v1,
        };
        0x2::event::emit<CheckClaimInfoEvent>(v2);
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

    public entry fun emergency_withdraw_v2<T0>(arg0: &mut Claim<T0>, arg1: &ManageCap<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Claim<T0>>(arg0) == arg1.claim_id, 1000);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.balance, 0x2::coin::value<T0>(&arg0.balance), arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

