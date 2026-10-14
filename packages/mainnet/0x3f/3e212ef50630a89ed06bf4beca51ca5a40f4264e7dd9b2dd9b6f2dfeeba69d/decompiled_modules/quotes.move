module 0x3f3e212ef50630a89ed06bf4beca51ca5a40f4264e7dd9b2dd9b6f2dfeeba69d::quotes {
    struct Desk has key {
        id: 0x2::object::UID,
        admin: address,
        account_id: u64,
        held: 0x2::table::Table<u64, u128>,
        reserved_tags: 0x2::table::Table<u64, u64>,
    }

    struct Released has copy, drop {
        desk: 0x2::object::ID,
        tag: u64,
        oid: u128,
        done: bool,
    }

    struct Reserved has copy, drop {
        desk: 0x2::object::ID,
        tag: u64,
        since: u64,
    }

    struct Opened has copy, drop {
        desk: 0x2::object::ID,
        admin: address,
        account_id: u64,
    }

    struct Bound has copy, drop {
        desk: 0x2::object::ID,
        tag: u64,
        oid: u128,
    }

    struct Dropped has copy, drop {
        desk: 0x2::object::ID,
        tag: u64,
    }

    public fun account_id(arg0: &Desk) : u64 {
        arg0.account_id
    }

    public fun admin(arg0: &Desk) : address {
        arg0.admin
    }

    fun bind(arg0: &mut Desk, arg1: u64, arg2: u128) {
        if (0x2::table::contains<u64, u128>(&arg0.held, arg1)) {
            *0x2::table::borrow_mut<u64, u128>(&mut arg0.held, arg1) = arg2;
        } else {
            0x2::table::add<u64, u128>(&mut arg0.held, arg1, arg2);
        };
        let v0 = Bound{
            desk : 0x2::object::id<Desk>(arg0),
            tag  : arg1,
            oid  : arg2,
        };
        0x2::event::emit<Bound>(v0);
    }

    public fun bound_count(arg0: &Desk) : u64 {
        0x2::table::length<u64, u128>(&arg0.held)
    }

    fun check_admin(arg0: &Desk, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 11);
    }

    public fun is_reserved(arg0: &Desk, arg1: u64) : bool {
        0x2::table::contains<u64, u64>(&arg0.reserved_tags, arg1)
    }

    fun lookup_all(arg0: &mut Desk, arg1: vector<u64>, arg2: &vector<bool>, arg3: u64) : (vector<u64>, vector<u128>) {
        let v0 = vector[];
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg1)) {
            let v3 = *0x1::vector::borrow<u64>(&arg1, v2);
            if (0x2::table::contains<u64, u128>(&arg0.held, v3)) {
                0x1::vector::push_back<u128>(&mut v1, 0x2::table::remove<u64, u128>(&mut arg0.held, v3));
                0x1::vector::push_back<u64>(&mut v0, v3);
            } else if (*0x1::vector::borrow<bool>(arg2, v2) && !0x2::table::contains<u64, u64>(&arg0.reserved_tags, v3)) {
                0x2::table::add<u64, u64>(&mut arg0.reserved_tags, v3, arg3);
                let v4 = Reserved{
                    desk  : 0x2::object::id<Desk>(arg0),
                    tag   : v3,
                    since : arg3,
                };
                0x2::event::emit<Reserved>(v4);
            };
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun oid(arg0: &Desk, arg1: u64) : 0x1::option::Option<u128> {
        if (0x2::table::contains<u64, u128>(&arg0.held, arg1)) {
            0x1::option::some<u128>(*0x2::table::borrow<u64, u128>(&arg0.held, arg1))
        } else {
            0x1::option::none<u128>()
        }
    }

    public fun open(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Desk{
            id            : 0x2::object::new(arg1),
            admin         : 0x2::tx_context::sender(arg1),
            account_id    : arg0,
            held          : 0x2::table::new<u64, u128>(arg1),
            reserved_tags : 0x2::table::new<u64, u64>(arg1),
        };
        let v1 = Opened{
            desk       : 0x2::object::id<Desk>(&v0),
            admin      : v0.admin,
            account_id : arg0,
        };
        0x2::event::emit<Opened>(v1);
        0x2::transfer::share_object<Desk>(v0);
    }

    public fun prune(arg0: &mut Desk, arg1: vector<u64>, arg2: &0x2::tx_context::TxContext) {
        check_admin(arg0, arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1)) {
            if (0x2::table::contains<u64, u128>(&arg0.held, *0x1::vector::borrow<u64>(&arg1, v0))) {
                0x2::table::remove<u64, u128>(&mut arg0.held, *0x1::vector::borrow<u64>(&arg1, v0));
            };
            v0 = v0 + 1;
        };
    }

    public fun pull<T0, T1>(arg0: &mut Desk, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg4: vector<u64>, arg5: vector<bool>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : vector<bool> {
        check_admin(arg0, arg7);
        pull_into<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::clock::timestamp_ms(arg6))
    }

    fun pull_into<T0, T1>(arg0: &mut Desk, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg4: vector<u64>, arg5: vector<bool>, arg6: u64) : vector<bool> {
        assert!(0x1::vector::length<bool>(&arg5) == 0x1::vector::length<u64>(&arg4), 14);
        let (v0, v1) = lookup_all(arg0, arg4, &arg5, arg6);
        let v2 = v1;
        let v3 = v0;
        if (0x1::vector::is_empty<u128>(&v2)) {
            return vector[]
        };
        let v4 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::try_cancel_orders<T0, T1>(arg1, arg2, arg3, &v2);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u128>(&v2)) {
            let v6 = Released{
                desk : 0x2::object::id<Desk>(arg0),
                tag  : *0x1::vector::borrow<u64>(&v3, v5),
                oid  : *0x1::vector::borrow<u128>(&v2, v5),
                done : *0x1::vector::borrow<bool>(&v4, v5),
            };
            0x2::event::emit<Released>(v6);
            v5 = v5 + 1;
        };
        v4
    }

    public fun refresh<T0, T1>(arg0: &mut Desk, arg1: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg6: &0x2::clock::Clock, arg7: vector<u64>, arg8: vector<bool>, arg9: vector<bool>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: vector<u64>, arg14: vector<bool>, arg15: vector<0x1::option::Option<u64>>, arg16: bool, arg17: &0x2::tx_context::TxContext) : vector<bool> {
        check_admin(arg0, arg17);
        assert!(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg3) == arg0.account_id, 12);
        let v0 = 0x1::vector::length<u64>(&arg13);
        let v1 = if (0x1::vector::length<bool>(&arg9) == v0) {
            if (0x1::vector::length<u64>(&arg10) == v0) {
                if (0x1::vector::length<u64>(&arg11) == v0) {
                    if (0x1::vector::length<u64>(&arg12) == v0) {
                        if (0x1::vector::length<bool>(&arg14) == v0) {
                            0x1::vector::length<0x1::option::Option<u64>>(&arg15) == v0
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 13);
        let v2 = &mut arg1;
        let v3 = pull_into<T0, T1>(arg0, v2, arg2, arg3, arg7, arg8, 0x2::clock::timestamp_ms(arg6));
        let v4 = take_reservations(arg0, &arg13);
        if (!some_true(&v4)) {
            0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T0>(arg1);
            return v3
        };
        let v5 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::start_session<T0, T1>(arg1, arg2, arg3, arg4, arg5, 0x1::option::none<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::IntegratorInfo>(), arg6, arg17);
        let v6 = 0;
        while (v6 < v0) {
            if (*0x1::vector::borrow<bool>(&v4, v6)) {
                let v7 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::place_limit_order<T0>(&mut v5, *0x1::vector::borrow<bool>(&arg9, v6), *0x1::vector::borrow<u64>(&arg10, v6), *0x1::vector::borrow<u64>(&arg11, v6), *0x1::vector::borrow<u64>(&arg12, v6), 0x1::option::some<u64>(*0x1::vector::borrow<u64>(&arg13, v6)), *0x1::vector::borrow<bool>(&arg14, v6), *0x1::vector::borrow<0x1::option::Option<u64>>(&arg15, v6));
                if (0x1::option::is_some<u128>(&v7)) {
                    bind(arg0, *0x1::vector::borrow<u64>(&arg13, v6), *0x1::option::borrow<u128>(&v7));
                };
            };
            v6 = v6 + 1;
        };
        let (v8, _) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::end_session<T0, T1>(v5, arg2, arg3, true, arg16);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T0>(v8);
        v3
    }

    public fun reserved_at(arg0: &Desk, arg1: u64) : 0x1::option::Option<u64> {
        if (0x2::table::contains<u64, u64>(&arg0.reserved_tags, arg1)) {
            0x1::option::some<u64>(*0x2::table::borrow<u64, u64>(&arg0.reserved_tags, arg1))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun reserved_count(arg0: &Desk) : u64 {
        0x2::table::length<u64, u64>(&arg0.reserved_tags)
    }

    fun some_true(arg0: &vector<bool>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<bool>(arg0)) {
            if (*0x1::vector::borrow<bool>(arg0, v0)) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun submit<T0>(arg0: &mut Desk, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::SessionHotPotato<T0>, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: 0x1::option::Option<u64>, arg9: &0x2::tx_context::TxContext) {
        check_admin(arg0, arg9);
        assert!(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::account_id<T0>(arg1) == arg0.account_id, 12);
        if (take_reservation(arg0, arg6)) {
            return
        };
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::place_limit_order<T0>(arg1, arg2, arg3, arg4, arg5, 0x1::option::some<u64>(arg6), arg7, arg8);
        if (0x1::option::is_some<u128>(&v0)) {
            bind(arg0, arg6, *0x1::option::borrow<u128>(&v0));
        };
    }

    fun take_reservation(arg0: &mut Desk, arg1: u64) : bool {
        if (!0x2::table::contains<u64, u64>(&arg0.reserved_tags, arg1)) {
            return false
        };
        0x2::table::remove<u64, u64>(&mut arg0.reserved_tags, arg1);
        let v0 = Dropped{
            desk : 0x2::object::id<Desk>(arg0),
            tag  : arg1,
        };
        0x2::event::emit<Dropped>(v0);
        true
    }

    fun take_reservations(arg0: &mut Desk, arg1: &vector<u64>) : vector<bool> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg1)) {
            0x1::vector::push_back<bool>(&mut v0, !take_reservation(arg0, *0x1::vector::borrow<u64>(arg1, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun unreserve(arg0: &mut Desk, arg1: vector<u64>, arg2: &0x2::tx_context::TxContext) {
        check_admin(arg0, arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1)) {
            if (0x2::table::contains<u64, u64>(&arg0.reserved_tags, *0x1::vector::borrow<u64>(&arg1, v0))) {
                0x2::table::remove<u64, u64>(&mut arg0.reserved_tags, *0x1::vector::borrow<u64>(&arg1, v0));
            };
            v0 = v0 + 1;
        };
    }

    public fun unreserve_stale(arg0: &mut Desk, arg1: &0x2::clock::Clock, arg2: u64, arg3: vector<u64>, arg4: &0x2::tx_context::TxContext) {
        check_admin(arg0, arg4);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg3)) {
            let v1 = *0x1::vector::borrow<u64>(&arg3, v0);
            if (0x2::table::contains<u64, u64>(&arg0.reserved_tags, v1) && 0x2::clock::timestamp_ms(arg1) >= *0x2::table::borrow<u64, u64>(&arg0.reserved_tags, v1) + arg2) {
                0x2::table::remove<u64, u64>(&mut arg0.reserved_tags, v1);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v7
}

