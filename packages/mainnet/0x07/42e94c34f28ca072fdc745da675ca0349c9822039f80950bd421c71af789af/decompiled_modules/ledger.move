module 0x742e94c34f28ca072fdc745da675ca0349c9822039f80950bd421c71af789af::ledger {
    struct Ledger has key {
        id: 0x2::object::UID,
        owner: address,
        account_id: u64,
        orders: 0x2::table::Table<u64, u128>,
        tombstones: 0x2::table::Table<u64, bool>,
    }

    struct Created has copy, drop {
        ledger: 0x2::object::ID,
        owner: address,
        account_id: u64,
    }

    struct Tracked has copy, drop {
        ledger: 0x2::object::ID,
        cloid: u64,
        order_id: u128,
    }

    struct Skipped has copy, drop {
        ledger: 0x2::object::ID,
        cloid: u64,
    }

    struct Tombstoned has copy, drop {
        ledger: 0x2::object::ID,
        cloid: u64,
    }

    struct Resolved has copy, drop {
        ledger: 0x2::object::ID,
        cloid: u64,
        order_id: u128,
        cancelled: bool,
    }

    public fun account_id(arg0: &Ledger) : u64 {
        arg0.account_id
    }

    fun assert_owner(arg0: &Ledger, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
    }

    public fun cancel<T0, T1>(arg0: &mut Ledger, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::authority::ACCOUNT, T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg4: vector<u64>, arg5: &0x2::tx_context::TxContext) : vector<bool> {
        assert_owner(arg0, arg5);
        let (v0, v1) = resolve(arg0, arg4);
        let v2 = v1;
        let v3 = v0;
        if (0x1::vector::is_empty<u128>(&v2)) {
            return vector[]
        };
        let v4 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::try_cancel_orders<T0, T1>(arg1, arg2, arg3, &v2);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u128>(&v2)) {
            let v6 = Resolved{
                ledger    : 0x2::object::id<Ledger>(arg0),
                cloid     : *0x1::vector::borrow<u64>(&v3, v5),
                order_id  : *0x1::vector::borrow<u128>(&v2, v5),
                cancelled : *0x1::vector::borrow<bool>(&v4, v5),
            };
            0x2::event::emit<Resolved>(v6);
            v5 = v5 + 1;
        };
        v4
    }

    public fun clear_tombstones(arg0: &mut Ledger, arg1: vector<u64>, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1)) {
            if (0x2::table::contains<u64, bool>(&arg0.tombstones, *0x1::vector::borrow<u64>(&arg1, v0))) {
                0x2::table::remove<u64, bool>(&mut arg0.tombstones, *0x1::vector::borrow<u64>(&arg1, v0));
            };
            v0 = v0 + 1;
        };
    }

    fun consume_tombstone(arg0: &mut Ledger, arg1: u64) : bool {
        if (!0x2::table::contains<u64, bool>(&arg0.tombstones, arg1)) {
            return false
        };
        0x2::table::remove<u64, bool>(&mut arg0.tombstones, arg1);
        let v0 = Skipped{
            ledger : 0x2::object::id<Ledger>(arg0),
            cloid  : arg1,
        };
        0x2::event::emit<Skipped>(v0);
        true
    }

    public fun create(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Ledger{
            id         : 0x2::object::new(arg1),
            owner      : 0x2::tx_context::sender(arg1),
            account_id : arg0,
            orders     : 0x2::table::new<u64, u128>(arg1),
            tombstones : 0x2::table::new<u64, bool>(arg1),
        };
        let v1 = Created{
            ledger     : 0x2::object::id<Ledger>(&v0),
            owner      : v0.owner,
            account_id : arg0,
        };
        0x2::event::emit<Created>(v1);
        0x2::transfer::share_object<Ledger>(v0);
    }

    public fun forget(arg0: &mut Ledger, arg1: vector<u64>, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1)) {
            if (0x2::table::contains<u64, u128>(&arg0.orders, *0x1::vector::borrow<u64>(&arg1, v0))) {
                0x2::table::remove<u64, u128>(&mut arg0.orders, *0x1::vector::borrow<u64>(&arg1, v0));
            };
            v0 = v0 + 1;
        };
    }

    public fun is_tombstoned(arg0: &Ledger, arg1: u64) : bool {
        0x2::table::contains<u64, bool>(&arg0.tombstones, arg1)
    }

    public fun order_id(arg0: &Ledger, arg1: u64) : 0x1::option::Option<u128> {
        if (0x2::table::contains<u64, u128>(&arg0.orders, arg1)) {
            0x1::option::some<u128>(*0x2::table::borrow<u64, u128>(&arg0.orders, arg1))
        } else {
            0x1::option::none<u128>()
        }
    }

    public fun owner(arg0: &Ledger) : address {
        arg0.owner
    }

    public fun place<T0>(arg0: &mut Ledger, arg1: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::SessionHotPotato<T0>, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: 0x1::option::Option<u64>, arg9: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg9);
        assert!(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::account_id<T0>(arg1) == arg0.account_id, 2);
        if (consume_tombstone(arg0, arg6)) {
            return
        };
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::place_limit_order<T0>(arg1, arg2, arg3, arg4, arg5, 0x1::option::some<u64>(arg6), arg7, arg8);
        if (0x1::option::is_some<u128>(&v0)) {
            track(arg0, arg6, *0x1::option::borrow<u128>(&v0));
        };
    }

    fun resolve(arg0: &mut Ledger, arg1: vector<u64>) : (vector<u64>, vector<u128>) {
        let v0 = vector[];
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg1)) {
            let v3 = *0x1::vector::borrow<u64>(&arg1, v2);
            if (0x2::table::contains<u64, u128>(&arg0.orders, v3)) {
                0x1::vector::push_back<u128>(&mut v1, 0x2::table::remove<u64, u128>(&mut arg0.orders, v3));
                0x1::vector::push_back<u64>(&mut v0, v3);
            } else if (!0x2::table::contains<u64, bool>(&arg0.tombstones, v3)) {
                0x2::table::add<u64, bool>(&mut arg0.tombstones, v3, true);
                let v4 = Tombstoned{
                    ledger : 0x2::object::id<Ledger>(arg0),
                    cloid  : v3,
                };
                0x2::event::emit<Tombstoned>(v4);
            };
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun tombstone_count(arg0: &Ledger) : u64 {
        0x2::table::length<u64, bool>(&arg0.tombstones)
    }

    fun track(arg0: &mut Ledger, arg1: u64, arg2: u128) {
        if (0x2::table::contains<u64, u128>(&arg0.orders, arg1)) {
            *0x2::table::borrow_mut<u64, u128>(&mut arg0.orders, arg1) = arg2;
        } else {
            0x2::table::add<u64, u128>(&mut arg0.orders, arg1, arg2);
        };
        let v0 = Tracked{
            ledger   : 0x2::object::id<Ledger>(arg0),
            cloid    : arg1,
            order_id : arg2,
        };
        0x2::event::emit<Tracked>(v0);
    }

    public fun tracked_count(arg0: &Ledger) : u64 {
        0x2::table::length<u64, u128>(&arg0.orders)
    }

    // decompiled from Move bytecode v7
}

