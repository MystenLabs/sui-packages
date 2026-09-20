module 0xf1739bcbc89a6954e031b6a1ef31809800e1e76d4ec914311bfa9eefefa042c4::drops {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        fee: u64,
    }

    struct Drop<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        title: 0x1::string::String,
        salt: address,
        root: vector<u8>,
        leaves_blob: 0x1::string::String,
        balance: 0x2::balance::Balance<T0>,
        deposited: u64,
        declared_total: u64,
        paid_total: u64,
        surplus_taken: u64,
        claim_deadline_ms: u64,
        recipients: u64,
        claimed: 0x2::table::Table<address, u64>,
        cliff_ts_ms: u64,
        cliff_bps: u64,
        linear_start_ms: u64,
        linear_end_ms: u64,
        created_at_ms: u64,
    }

    struct DropCreated has copy, drop {
        drop: address,
        creator: address,
        coin_type: 0x1::ascii::String,
        title: 0x1::string::String,
        salt: address,
        root: vector<u8>,
        leaves_blob: 0x1::string::String,
        deposited: u64,
        declared_total: u64,
        recipients: u64,
        cliff_ts_ms: u64,
        cliff_bps: u64,
        linear_start_ms: u64,
        linear_end_ms: u64,
        claim_deadline_ms: u64,
        created_at_ms: u64,
    }

    struct DropClaimed has copy, drop {
        drop: address,
        who: address,
        amount: u64,
        cumulative_paid: u64,
        allocation: u64,
    }

    struct SurplusWithdrawn has copy, drop {
        drop: address,
        amount: u64,
    }

    struct ToppedUp has copy, drop {
        drop: address,
        from: address,
        amount: u64,
        pot: u64,
    }

    struct Reclaimed has copy, drop {
        drop: address,
        amount: u64,
    }

    struct FeeUpdated has copy, drop {
        old_fee: u64,
        new_fee: u64,
    }

    public fun claim<T0>(arg0: &mut Drop<T0>, arg1: u64, arg2: vector<vector<u8>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(verify(&arg0.root, &arg2, arg0.salt, v0, arg1), 7);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        if (arg0.claim_deadline_ms > 0) {
            assert!(v1 < arg0.claim_deadline_ms, 13);
        };
        let v2 = compute_vested_total(arg1, arg0.cliff_ts_ms, arg0.cliff_bps, arg0.linear_start_ms, arg0.linear_end_ms, v1);
        let v3 = if (0x2::table::contains<address, u64>(&arg0.claimed, v0)) {
            *0x2::table::borrow<address, u64>(&arg0.claimed, v0)
        } else {
            0
        };
        assert!(v2 > v3, 8);
        let v4 = v2 - v3;
        let v5 = v4;
        let v6 = 0x2::balance::value<T0>(&arg0.balance);
        if (v4 > v6) {
            v5 = v6;
        };
        assert!(v5 > 0, 8);
        if (0x2::table::contains<address, u64>(&arg0.claimed, v0)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.claimed, v0) = v3 + v5;
        } else {
            0x2::table::add<address, u64>(&mut arg0.claimed, v0, v5);
        };
        arg0.paid_total = arg0.paid_total + v5;
        let v7 = DropClaimed{
            drop            : 0x2::object::uid_to_address(&arg0.id),
            who             : v0,
            amount          : v5,
            cumulative_paid : v3 + v5,
            allocation      : arg1,
        };
        0x2::event::emit<DropClaimed>(v7);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v5), arg4)
    }

    public fun claim_and_transfer<T0>(arg0: &mut Drop<T0>, arg1: u64, arg2: vector<vector<u8>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = claim<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun claim_deadline_ms<T0>(arg0: &Drop<T0>) : u64 {
        arg0.claim_deadline_ms
    }

    public fun claimable<T0>(arg0: &Drop<T0>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        let v0 = compute_vested_total(arg2, arg0.cliff_ts_ms, arg0.cliff_bps, arg0.linear_start_ms, arg0.linear_end_ms, 0x2::clock::timestamp_ms(arg3));
        let v1 = claimed_of<T0>(arg0, arg1);
        if (v0 > v1) {
            v0 - v1
        } else {
            0
        }
    }

    public fun claimed_of<T0>(arg0: &Drop<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.claimed, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.claimed, arg1)
        } else {
            0
        }
    }

    fun compute_vested_total(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        let v0 = 0;
        let v1 = v0;
        let v2 = (((arg0 as u128) * (arg2 as u128) / (10000 as u128)) as u64);
        let v3 = if (v2 > 0) {
            if (arg1 > 0) {
                arg5 >= arg1
            } else {
                false
            }
        } else {
            false
        };
        if (v3) {
            v1 = v0 + v2;
        };
        let v4 = arg0 - v2;
        if (v4 > 0) {
            if (arg3 == arg4) {
                if (arg5 >= arg3) {
                    v1 = v1 + v4;
                };
            } else if (arg5 >= arg4) {
                v1 = v1 + v4;
            } else if (arg5 > arg3) {
                v1 = v1 + (((v4 as u128) * ((arg5 - arg3) as u128) / ((arg4 - arg3) as u128)) as u64);
            };
        };
        if (v1 > arg0) {
            arg0
        } else {
            v1
        }
    }

    public fun create<T0>(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::coin::Coin<T0>, arg3: 0x1::string::String, arg4: address, arg5: vector<u8>, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.fee, 0);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg0.fee));
        if (0x2::balance::value<0x2::sui::SUI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg15), 0x2::tx_context::sender(arg15));
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
        };
        assert!(0x1::vector::length<u8>(&arg5) == 32, 1);
        assert!(arg7 > 0, 2);
        assert!(arg8 > 0, 4);
        assert!(0x1::string::length(&arg3) <= 64, 11);
        assert!(0x1::string::length(&arg6) <= 128, 12);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 >= arg7, 3);
        assert!(arg10 <= 10000, 4);
        assert!(arg12 >= arg11, 5);
        if (arg10 > 0) {
            assert!(arg9 > 0, 4);
        };
        if (arg9 > 0 && arg10 < 10000) {
            assert!(arg11 >= arg9, 5);
        };
        let v2 = 0x2::clock::timestamp_ms(arg14);
        let v3 = if (arg10 == 10000) {
            arg9
        } else {
            arg12
        };
        assert!(v3 > v2, 6);
        if (arg13 > 0) {
            assert!(arg13 > v3, 5);
        };
        let v4 = 0x2::object::new(arg15);
        let v5 = 0x2::tx_context::sender(arg15);
        let v6 = DropCreated{
            drop              : 0x2::object::uid_to_address(&v4),
            creator           : v5,
            coin_type         : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            title             : arg3,
            salt              : arg4,
            root              : arg5,
            leaves_blob       : arg6,
            deposited         : v1,
            declared_total    : arg7,
            recipients        : arg8,
            cliff_ts_ms       : arg9,
            cliff_bps         : arg10,
            linear_start_ms   : arg11,
            linear_end_ms     : arg12,
            claim_deadline_ms : arg13,
            created_at_ms     : v2,
        };
        0x2::event::emit<DropCreated>(v6);
        let v7 = Drop<T0>{
            id                : v4,
            creator           : v5,
            title             : arg3,
            salt              : arg4,
            root              : arg5,
            leaves_blob       : arg6,
            balance           : 0x2::coin::into_balance<T0>(arg2),
            deposited         : v1,
            declared_total    : arg7,
            paid_total        : 0,
            surplus_taken     : 0,
            claim_deadline_ms : arg13,
            recipients        : arg8,
            claimed           : 0x2::table::new<address, u64>(arg15),
            cliff_ts_ms       : arg9,
            cliff_bps         : arg10,
            linear_start_ms   : arg11,
            linear_end_ms     : arg12,
            created_at_ms     : v2,
        };
        0x2::transfer::share_object<Drop<T0>>(v7);
    }

    public fun creator<T0>(arg0: &Drop<T0>) : address {
        arg0.creator
    }

    public fun declared_total<T0>(arg0: &Drop<T0>) : u64 {
        arg0.declared_total
    }

    public fun deposited<T0>(arg0: &Drop<T0>) : u64 {
        arg0.deposited
    }

    public fun fee(arg0: &Treasury) : u64 {
        arg0.fee
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Treasury{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            fee     : 10000000000,
        };
        0x2::transfer::share_object<Treasury>(v1);
    }

    public fun leaf_hash(arg0: address, arg1: address, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x2::hash::blake2b256(&v0)
    }

    public fun leaves_blob<T0>(arg0: &Drop<T0>) : 0x1::string::String {
        arg0.leaves_blob
    }

    fun lte(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            let v1 = *0x1::vector::borrow<u8>(arg0, v0);
            let v2 = *0x1::vector::borrow<u8>(arg1, v0);
            if (v1 < v2) {
                return true
            };
            if (v1 > v2) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    fun node_hash(arg0: &vector<u8>, arg1: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 1);
        if (lte(arg0, arg1)) {
            0x1::vector::append<u8>(&mut v0, *arg0);
            0x1::vector::append<u8>(&mut v0, *arg1);
        } else {
            0x1::vector::append<u8>(&mut v0, *arg1);
            0x1::vector::append<u8>(&mut v0, *arg0);
        };
        0x2::hash::blake2b256(&v0)
    }

    public fun paid_total<T0>(arg0: &Drop<T0>) : u64 {
        arg0.paid_total
    }

    public fun pot<T0>(arg0: &Drop<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun recipients<T0>(arg0: &Drop<T0>) : u64 {
        arg0.recipients
    }

    public fun reclaim_expired<T0>(arg0: &mut Drop<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 9);
        assert!(arg0.claim_deadline_ms > 0, 14);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.claim_deadline_ms, 14);
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        assert!(v0 > 0, 2);
        let v1 = Reclaimed{
            drop   : 0x2::object::uid_to_address(&arg0.id),
            amount : v0,
        };
        0x2::event::emit<Reclaimed>(v1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v0), arg2)
    }

    public fun reclaim_expired_and_transfer<T0>(arg0: &mut Drop<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = reclaim_expired<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun root<T0>(arg0: &Drop<T0>) : vector<u8> {
        arg0.root
    }

    public fun salt<T0>(arg0: &Drop<T0>) : address {
        arg0.salt
    }

    public fun schedule<T0>(arg0: &Drop<T0>) : (u64, u64, u64, u64) {
        (arg0.cliff_ts_ms, arg0.cliff_bps, arg0.linear_start_ms, arg0.linear_end_ms)
    }

    public fun top_up<T0>(arg0: &mut Drop<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v1 = ToppedUp{
            drop   : 0x2::object::uid_to_address(&arg0.id),
            from   : 0x2::tx_context::sender(arg2),
            amount : v0,
            pot    : 0x2::balance::value<T0>(&arg0.balance),
        };
        0x2::event::emit<ToppedUp>(v1);
    }

    public fun update_fee(arg0: &AdminCap, arg1: &mut Treasury, arg2: u64) {
        arg1.fee = arg2;
        let v0 = FeeUpdated{
            old_fee : arg1.fee,
            new_fee : arg2,
        };
        0x2::event::emit<FeeUpdated>(v0);
    }

    public fun verify(arg0: &vector<u8>, arg1: &vector<vector<u8>>, arg2: address, arg3: address, arg4: u64) : bool {
        let v0 = 0x1::vector::length<vector<u8>>(arg1);
        let v1 = 0;
        while (v1 < v0) {
            if (0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(arg1, v1)) != 32) {
                return false
            };
            v1 = v1 + 1;
        };
        let v2 = leaf_hash(arg2, arg3, arg4);
        v1 = 0;
        while (v1 < v0) {
            let v3 = &v2;
            v2 = node_hash(v3, 0x1::vector::borrow<vector<u8>>(arg1, v1));
            v1 = v1 + 1;
        };
        v2 == *arg0
    }

    public fun withdraw_fees(arg0: &AdminCap, arg1: &mut Treasury, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.balance);
        assert!(v0 > 0, 2);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v0), arg2)
    }

    public fun withdraw_surplus<T0>(arg0: &mut Drop<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 9);
        let v0 = arg0.deposited - arg0.declared_total - arg0.surplus_taken;
        let v1 = 0x2::balance::value<T0>(&arg0.balance);
        let v2 = if (v0 > v1) {
            v1
        } else {
            v0
        };
        assert!(v2 > 0, 10);
        arg0.surplus_taken = arg0.surplus_taken + v2;
        let v3 = SurplusWithdrawn{
            drop   : 0x2::object::uid_to_address(&arg0.id),
            amount : v2,
        };
        0x2::event::emit<SurplusWithdrawn>(v3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v2), arg1)
    }

    public fun withdraw_surplus_and_transfer<T0>(arg0: &mut Drop<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_surplus<T0>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

