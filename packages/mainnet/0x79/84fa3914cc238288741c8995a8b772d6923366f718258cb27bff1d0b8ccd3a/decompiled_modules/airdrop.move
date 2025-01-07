module 0x7984fa3914cc238288741c8995a8b772d6923366f718258cb27bff1d0b8ccd3a::airdrop {
    struct ManageCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        claim_id: 0x2::object::ID,
    }

    struct Claim<phantom T0> has store, key {
        id: 0x2::object::UID,
        emergency: bool,
        balance: 0x2::coin::Coin<T0>,
        claim_members: 0x2::bag::Bag,
        unclaim_members: 0x2::bag::Bag,
    }

    struct ClaimEvent has copy, drop {
        address: address,
        amount: u64,
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

    public fun claim<T0>(arg0: &Claim<T0>, arg1: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = if (0x2::bag::contains<address>(&arg0.unclaim_members, v0)) {
            *0x2::bag::borrow<address, u64>(&arg0.unclaim_members, v0)
        } else {
            0
        };
        let v2 = if (0x2::bag::contains<address>(&arg0.claim_members, v0)) {
            *0x2::bag::borrow<address, u64>(&arg0.claim_members, v0)
        } else {
            0
        };
        (v1, v2)
    }

    public entry fun claim_entry<T0>(arg0: &mut Claim<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!arg0.emergency, 1001);
        assert!(0x2::bag::contains<address>(&arg0.unclaim_members, v0), 1002);
        assert!(!0x2::bag::contains<address>(&arg0.claim_members, v0), 1005);
        let v1 = 0x2::bag::borrow<address, u64>(&arg0.unclaim_members, v0);
        let v2 = ClaimEvent{
            address : v0,
            amount  : *v1,
        };
        0x2::event::emit<ClaimEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.balance, *v1, arg1), v0);
        0x2::bag::add<address, u64>(&mut arg0.claim_members, 0x2::tx_context::sender(arg1), *v1);
    }

    public entry fun create_claim<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Claim<T0>{
            id              : 0x2::object::new(arg1),
            emergency       : false,
            balance         : arg0,
            claim_members   : 0x2::bag::new(arg1),
            unclaim_members : 0x2::bag::new(arg1),
        };
        let v1 = ManageCap<T0>{
            id       : 0x2::object::new(arg1),
            claim_id : 0x2::object::id<Claim<T0>>(&v0),
        };
        0x2::transfer::public_transfer<ManageCap<T0>>(v1, 0x2::tx_context::sender(arg1));
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

