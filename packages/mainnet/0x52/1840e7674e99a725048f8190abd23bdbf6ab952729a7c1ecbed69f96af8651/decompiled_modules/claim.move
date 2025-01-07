module 0xeac275e5b487ef06d08be20a08621827f8713d29c06b584aad113edf94e4ab5d::claim {
    struct ManageCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        claim_id: 0x2::object::ID,
    }

    struct ClaimInfo has copy, drop, store {
        total_amount: u64,
        claimed_amount: u64,
        revoked: bool,
    }

    struct ChangeCliffTimeEvent has copy, drop {
        claim_id: 0x2::object::ID,
        cliff_time: u64,
    }

    struct Claim<phantom T0> has store, key {
        id: 0x2::object::UID,
        emergency: bool,
        start_time: u64,
        end_time: u64,
        balance: 0x2::coin::Coin<T0>,
        members: 0x2::bag::Bag,
        cliff: u64,
        duration: u64,
        slice_period_seconds: u64,
        init_release_percentage: u64,
        revocable: bool,
    }

    struct ClaimEvent has copy, drop {
        address: address,
        amount: u64,
    }

    struct ChangeClaimInfoEvent has copy, drop {
        claim_id: 0x2::object::ID,
        address: address,
        total_amount: u64,
        claimed_amount: u64,
        revoked: bool,
    }

    struct ChangeStartTimeEvent has copy, drop {
        claim_id: 0x2::object::ID,
        start_time: u64,
    }

    struct ChangeEndTimeEvent has copy, drop {
        claim_id: 0x2::object::ID,
        end_time: u64,
    }

    struct RevokedEvent has copy, drop {
        claim_id: 0x2::object::ID,
        address: address,
        revoke: bool,
    }

    struct RecoveryRevokedEvent has copy, drop {
        claim_id: 0x2::object::ID,
        address: address,
        revoke: bool,
    }

    public entry fun claim<T0>(arg0: &mut Claim<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(claim_with_return<T0>(arg0, arg1, arg2), v0);
    }

    public entry fun add_wait_claim_list<T0>(arg0: &mut Claim<T0>, arg1: &ManageCap<T0>, arg2: vector<address>, arg3: vector<u64>) {
        assert!(0x2::object::id<Claim<T0>>(arg0) == arg1.claim_id, 1000);
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 1003);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::pop_back<address>(&mut arg2);
            if (0x2::bag::contains<address>(&arg0.members, v2)) {
                0x2::bag::borrow_mut<address, ClaimInfo>(&mut arg0.members, v2).total_amount = 0x1::vector::pop_back<u64>(&mut arg3);
            } else {
                let v3 = ClaimInfo{
                    total_amount   : 0x1::vector::pop_back<u64>(&mut arg3),
                    claimed_amount : 0,
                    revoked        : false,
                };
                0x2::bag::add<address, ClaimInfo>(&mut arg0.members, v2, v3);
            };
            v1 = v1 + 1;
        };
    }

    public entry fun change_claim_info<T0>(arg0: &mut Claim<T0>, arg1: &ManageCap<T0>, arg2: address, arg3: u64, arg4: u64, arg5: bool) {
        assert!(0x2::object::id<Claim<T0>>(arg0) == arg1.claim_id, 1000);
        let v0 = 0x2::bag::borrow_mut<address, ClaimInfo>(&mut arg0.members, arg2);
        v0.revoked = arg5;
        v0.total_amount = arg3;
        v0.claimed_amount = arg4;
        let v1 = ChangeClaimInfoEvent{
            claim_id       : 0x2::object::id<Claim<T0>>(arg0),
            address        : arg2,
            total_amount   : arg3,
            claimed_amount : arg4,
            revoked        : arg5,
        };
        0x2::event::emit<ChangeClaimInfoEvent>(v1);
    }

    public entry fun change_cliff_time<T0>(arg0: &mut Claim<T0>, arg1: &ManageCap<T0>, arg2: u64) {
        assert!(0x2::object::id<Claim<T0>>(arg0) == arg1.claim_id, 1000);
        assert!(arg2 >= arg0.start_time, 1005);
        arg0.cliff = arg2;
        let v0 = ChangeCliffTimeEvent{
            claim_id   : 0x2::object::id<Claim<T0>>(arg0),
            cliff_time : arg2,
        };
        0x2::event::emit<ChangeCliffTimeEvent>(v0);
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

    public fun check_claim_info<T0>(arg0: &Claim<T0>, arg1: address, arg2: &0x2::clock::Clock) : (u64, u64, u64) {
        if (!0x2::bag::contains<address>(&arg0.members, arg1)) {
            return (0, 0, 0)
        };
        let v0 = 0x2::bag::borrow<address, ClaimInfo>(&arg0.members, arg1);
        (v0.total_amount, v0.claimed_amount, compute_released_amount<T0>(arg0, arg1, arg2) - v0.claimed_amount)
    }

    public fun claim_with_return<T0>(arg0: &mut Claim<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.emergency, 1001);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::bag::contains<address>(&arg0.members, v0), 1002);
        let v1 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(v1 >= arg0.start_time && v1 <= arg0.end_time, 1004);
        let v2 = compute_released_amount<T0>(arg0, v0, arg1);
        let v3 = 0x2::bag::borrow_mut<address, ClaimInfo>(&mut arg0.members, v0);
        assert!(v2 <= v3.total_amount, 1008);
        let v4 = v2 - v3.claimed_amount;
        assert!(v4 > 0, 1002);
        v3.claimed_amount = v2;
        let v5 = ClaimEvent{
            address : v0,
            amount  : v4,
        };
        0x2::event::emit<ClaimEvent>(v5);
        0x2::coin::split<T0>(&mut arg0.balance, v4, arg2)
    }

    public fun compute_released_amount<T0>(arg0: &Claim<T0>, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v1 = 0x2::bag::borrow<address, ClaimInfo>(&arg0.members, arg1);
        if (v0 < arg0.start_time || v1.revoked == true) {
            return 0
        };
        let v2 = 0;
        let v3 = 0;
        if (v0 >= arg0.start_time && arg0.init_release_percentage > 0) {
            v3 = mul_div_ceil(v1.total_amount, arg0.init_release_percentage, 1000000);
        };
        if (v0 >= arg0.cliff + arg0.duration) {
            v2 = v1.total_amount - v3;
        } else if (v0 >= arg0.cliff) {
            v2 = mul_div_ceil(v1.total_amount - v3, (v0 - arg0.cliff) / arg0.slice_period_seconds * arg0.slice_period_seconds, arg0.duration);
        };
        v2 + v3
    }

    public entry fun create_claim<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_claim_with_return<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<ManageCap<T0>>(v1, 0x2::tx_context::sender(arg8));
        0x2::transfer::public_share_object<Claim<T0>>(v0);
    }

    public fun create_claim_with_return<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) : (Claim<T0>, ManageCap<T0>) {
        assert!(arg6 < 1000000, 1007);
        let v0 = Claim<T0>{
            id                      : 0x2::object::new(arg8),
            emergency               : false,
            start_time              : arg1,
            end_time                : arg2,
            balance                 : arg0,
            members                 : 0x2::bag::new(arg8),
            cliff                   : arg3,
            duration                : arg4,
            slice_period_seconds    : arg5,
            init_release_percentage : arg6,
            revocable               : arg7,
        };
        let v1 = ManageCap<T0>{
            id       : 0x2::object::new(arg8),
            claim_id : 0x2::object::id<Claim<T0>>(&v0),
        };
        (v0, v1)
    }

    public entry fun emergency_deposit<T0>(arg0: &mut Claim<T0>, arg1: &ManageCap<T0>, arg2: 0x2::coin::Coin<T0>) {
        assert!(0x2::object::id<Claim<T0>>(arg0) == arg1.claim_id, 1000);
        0x2::coin::join<T0>(&mut arg0.balance, arg2);
    }

    public entry fun emergency_switch<T0>(arg0: &mut Claim<T0>, arg1: &ManageCap<T0>) {
        assert!(0x2::object::id<Claim<T0>>(arg0) == arg1.claim_id, 1000);
        arg0.emergency = !arg0.emergency;
    }

    public entry fun emergency_withdraw<T0>(arg0: &mut Claim<T0>, arg1: &ManageCap<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Claim<T0>>(arg0) == arg1.claim_id, 1000);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.balance, 0x2::coin::value<T0>(&arg0.balance), arg3), arg2);
    }

    public fun full_mul(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) * (arg1 as u128)
    }

    public fun mul_div_ceil(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((full_mul(arg0, arg1) + (arg2 as u128) - 1) / (arg2 as u128)) as u64)
    }

    public entry fun recovery_revoke<T0>(arg0: &mut Claim<T0>, arg1: &ManageCap<T0>, arg2: address) {
        assert!(0x2::object::id<Claim<T0>>(arg0) == arg1.claim_id, 1000);
        assert!(arg0.revocable, 1006);
        0x2::bag::borrow_mut<address, ClaimInfo>(&mut arg0.members, arg2).revoked = false;
        let v0 = RecoveryRevokedEvent{
            claim_id : 0x2::object::id<Claim<T0>>(arg0),
            address  : arg2,
            revoke   : false,
        };
        0x2::event::emit<RecoveryRevokedEvent>(v0);
    }

    public entry fun revoke<T0>(arg0: &mut Claim<T0>, arg1: &ManageCap<T0>, arg2: address) {
        assert!(0x2::object::id<Claim<T0>>(arg0) == arg1.claim_id, 1000);
        assert!(arg0.revocable, 1006);
        0x2::bag::borrow_mut<address, ClaimInfo>(&mut arg0.members, arg2).revoked = true;
        let v0 = RevokedEvent{
            claim_id : 0x2::object::id<Claim<T0>>(arg0),
            address  : arg2,
            revoke   : true,
        };
        0x2::event::emit<RevokedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

