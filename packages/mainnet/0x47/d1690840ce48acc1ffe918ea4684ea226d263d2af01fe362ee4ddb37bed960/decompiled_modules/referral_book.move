module 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::referral_book {
    struct ReferralBookKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ReferralBook has store, key {
        id: 0x2::object::UID,
        referrer_of: 0x2::table::Table<address, address>,
        referee_count: 0x2::table::Table<address, u64>,
        total_earned: 0x2::table::Table<address, u64>,
        pending: 0x2::table::Table<address, u64>,
    }

    public fun add_earned(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut 0x2::object::UID, arg2: address, arg3: u64) {
        let v0 = book_mut(arg1);
        if (!0x2::table::contains<address, u64>(&v0.total_earned, arg2)) {
            0x2::table::add<address, u64>(&mut v0.total_earned, arg2, arg3);
        } else {
            let v1 = 0x2::table::borrow_mut<address, u64>(&mut v0.total_earned, arg2);
            *v1 = *v1 + arg3;
        };
    }

    public fun add_pending(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut 0x2::object::UID, arg2: address, arg3: u64) {
        let v0 = book_mut(arg1);
        if (!0x2::table::contains<address, u64>(&v0.pending, arg2)) {
            0x2::table::add<address, u64>(&mut v0.pending, arg2, arg3);
        } else {
            let v1 = 0x2::table::borrow_mut<address, u64>(&mut v0.pending, arg2);
            *v1 = *v1 + arg3;
        };
    }

    public(friend) fun attach(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ReferralBookKey{dummy_field: false};
        let v1 = ReferralBook{
            id            : 0x2::object::new(arg1),
            referrer_of   : 0x2::table::new<address, address>(arg1),
            referee_count : 0x2::table::new<address, u64>(arg1),
            total_earned  : 0x2::table::new<address, u64>(arg1),
            pending       : 0x2::table::new<address, u64>(arg1),
        };
        0x2::dynamic_object_field::add<ReferralBookKey, ReferralBook>(arg0, v0, v1);
    }

    fun book(arg0: &0x2::object::UID) : &ReferralBook {
        let v0 = ReferralBookKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<ReferralBookKey, ReferralBook>(arg0, v0)
    }

    fun book_mut(arg0: &mut 0x2::object::UID) : &mut ReferralBook {
        let v0 = ReferralBookKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<ReferralBookKey, ReferralBook>(arg0, v0)
    }

    fun cell(arg0: &0x2::table::Table<address, u64>, arg1: address) : u64 {
        if (!0x2::table::contains<address, u64>(arg0, arg1)) {
            0
        } else {
            *0x2::table::borrow<address, u64>(arg0, arg1)
        }
    }

    public fun cycle_status(arg0: &0x2::object::UID, arg1: address, arg2: address) : u8 {
        let v0 = book(arg0);
        let v1 = 0;
        while (0x2::table::contains<address, address>(&v0.referrer_of, arg2)) {
            let v2 = *0x2::table::borrow<address, address>(&v0.referrer_of, arg2);
            arg2 = v2;
            if (v2 == arg1) {
                return 2
            };
            let v3 = v1 + 1;
            v1 = v3;
            if (v3 > 64) {
                return 3
            };
        };
        0
    }

    public fun insert_bind<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut 0x2::object::UID, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::Account<T0>, arg3: address) {
        let v0 = book_mut(arg1);
        0x2::table::add<address, address>(&mut v0.referrer_of, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::account::owner<T0>(arg2), arg3);
        if (!0x2::table::contains<address, u64>(&v0.referee_count, arg3)) {
            0x2::table::add<address, u64>(&mut v0.referee_count, arg3, 1);
        } else {
            let v1 = 0x2::table::borrow_mut<address, u64>(&mut v0.referee_count, arg3);
            *v1 = *v1 + 1;
        };
    }

    public fun is_bound(arg0: &0x2::object::UID, arg1: address) : bool {
        0x2::table::contains<address, address>(&book(arg0).referrer_of, arg1)
    }

    public fun payout_targets(arg0: &0x2::object::UID, arg1: address) : (bool, address, bool, address) {
        let v0 = book(arg0);
        if (!0x2::table::contains<address, address>(&v0.referrer_of, arg1)) {
            return (false, @0x0, false, @0x0)
        };
        let v1 = *0x2::table::borrow<address, address>(&v0.referrer_of, arg1);
        let (v2, v3, v4) = if (!0x2::table::contains<address, address>(&v0.referrer_of, v1)) {
            (true, false, @0x0)
        } else {
            (true, true, *0x2::table::borrow<address, address>(&v0.referrer_of, v1))
        };
        (v2, v1, v3, v4)
    }

    public fun pending(arg0: &0x2::object::UID, arg1: address) : u64 {
        cell(&book(arg0).pending, arg1)
    }

    public fun referee_count(arg0: &0x2::object::UID, arg1: address) : u64 {
        cell(&book(arg0).referee_count, arg1)
    }

    public fun referrer_of(arg0: &0x2::object::UID, arg1: address) : 0x1::option::Option<address> {
        let v0 = book(arg0);
        if (!0x2::table::contains<address, address>(&v0.referrer_of, arg1)) {
            0x1::option::none<address>()
        } else {
            0x1::option::some<address>(*0x2::table::borrow<address, address>(&v0.referrer_of, arg1))
        }
    }

    public fun take_pending(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut 0x2::object::UID, arg2: address) : u64 {
        let v0 = book_mut(arg1);
        if (!0x2::table::contains<address, u64>(&v0.pending, arg2)) {
            return 0
        };
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut v0.pending, arg2);
        *v1 = 0;
        *v1
    }

    public fun total_earned(arg0: &0x2::object::UID, arg1: address) : u64 {
        cell(&book(arg0).total_earned, arg1)
    }

    // decompiled from Move bytecode v7
}

