module 0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::revenue {
    struct Ledger<phantom T0> has store {
        root: 0x2::object::ID,
        revision: u64,
        funds: 0x2::balance::Balance<T0>,
        collected: u128,
        withdrawn: u128,
        requests: 0x2::table::Table<Request, Receipt>,
    }

    struct Request has copy, drop, store {
        actor: address,
        attempt: vector<u8>,
    }

    struct Receipt has copy, drop, store {
        root: 0x2::object::ID,
        actor: address,
        attempt: vector<u8>,
        recipient: address,
        amount: u64,
        before_revision: u64,
        after_revision: u64,
        balance: u64,
        total_collected: u128,
        total_withdrawn: u128,
    }

    struct Withdrawn has copy, drop {
        receipt: Receipt,
    }

    struct Snapshot has copy, drop, store {
        root: 0x2::object::ID,
        revision: u64,
        balance: u64,
        collected: u128,
        withdrawn: u128,
    }

    public fun balance<T0>(arg0: &Ledger<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    public fun new<T0>(arg0: &0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : Ledger<T0> {
        Ledger<T0>{
            root      : 0x2::object::uid_to_inner(arg0),
            revision  : 0,
            funds     : 0x2::balance::zero<T0>(),
            collected : 0,
            withdrawn : 0,
            requests  : 0x2::table::new<Request, Receipt>(arg1),
        }
    }

    public fun collected<T0>(arg0: &Ledger<T0>) : u128 {
        arg0.collected
    }

    public fun deposit<T0>(arg0: &0x2::object::UID, arg1: &mut Ledger<T0>, arg2: 0x2::coin::Coin<T0>) {
        assert!(0x2::object::uid_to_inner(arg0) == arg1.root, 4);
        let v0 = 0x2::coin::value<T0>(&arg2);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T0>(arg2);
            return
        };
        0x2::coin::put<T0>(&mut arg1.funds, arg2);
        arg1.collected = arg1.collected + (v0 as u128);
        arg1.revision = arg1.revision + 1;
    }

    public fun receipt<T0>(arg0: &Ledger<T0>, arg1: address, arg2: vector<u8>) : 0x1::option::Option<Receipt> {
        let v0 = Request{
            actor   : arg1,
            attempt : arg2,
        };
        if (0x2::table::contains<Request, Receipt>(&arg0.requests, v0)) {
            0x1::option::some<Receipt>(*0x2::table::borrow<Request, Receipt>(&arg0.requests, v0))
        } else {
            0x1::option::none<Receipt>()
        }
    }

    public fun receipt_actor(arg0: &Receipt) : address {
        arg0.actor
    }

    public fun receipt_amount(arg0: &Receipt) : u64 {
        arg0.amount
    }

    public fun receipt_balance(arg0: &Receipt) : u64 {
        arg0.balance
    }

    public fun receipt_recipient(arg0: &Receipt) : address {
        arg0.recipient
    }

    public fun receipt_revision(arg0: &Receipt) : u64 {
        arg0.after_revision
    }

    public fun receipt_root(arg0: &Receipt) : 0x2::object::ID {
        arg0.root
    }

    public fun revision<T0>(arg0: &Ledger<T0>) : u64 {
        arg0.revision
    }

    public fun root<T0>(arg0: &Ledger<T0>) : 0x2::object::ID {
        arg0.root
    }

    public fun snapshot<T0>(arg0: &Ledger<T0>) : Snapshot {
        Snapshot{
            root      : arg0.root,
            revision  : arg0.revision,
            balance   : 0x2::balance::value<T0>(&arg0.funds),
            collected : arg0.collected,
            withdrawn : arg0.withdrawn,
        }
    }

    public fun withdraw<T0>(arg0: &0x2::object::UID, arg1: &mut Ledger<T0>, arg2: u64, arg3: u64, arg4: address, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::uid_to_inner(arg0) == arg1.root, 4);
        assert!(arg1.revision == arg2, 2);
        let v0 = if (arg3 > 0) {
            if (arg3 <= 0x2::balance::value<T0>(&arg1.funds)) {
                arg4 != @0x0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        if (0x1::vector::length<u8>(&arg5) == 32) {
            let v1 = &arg5;
            let v2 = 0;
            let v3;
            while (v2 < 0x1::vector::length<u8>(v1)) {
                let v4 = 0;
                if (0x1::vector::borrow<u8>(v1, v2) != &v4) {
                    v3 = true;
                    /* label 20 */
                    /* label 21 */
                    assert!(v3, 3);
                    let v5 = Request{
                        actor   : 0x2::tx_context::sender(arg6),
                        attempt : arg5,
                    };
                    assert!(!0x2::table::contains<Request, Receipt>(&arg1.requests, v5), 3);
                    arg1.withdrawn = arg1.withdrawn + (arg3 as u128);
                    arg1.revision = arg1.revision + 1;
                    let v6 = Receipt{
                        root            : arg1.root,
                        actor           : 0x2::tx_context::sender(arg6),
                        attempt         : arg5,
                        recipient       : arg4,
                        amount          : arg3,
                        before_revision : arg2,
                        after_revision  : arg1.revision,
                        balance         : 0x2::balance::value<T0>(&arg1.funds),
                        total_collected : arg1.collected,
                        total_withdrawn : arg1.withdrawn,
                    };
                    0x2::table::add<Request, Receipt>(&mut arg1.requests, v5, v6);
                    let v7 = Withdrawn{receipt: v6};
                    0x2::event::emit<Withdrawn>(v7);
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.funds, arg3, arg6), arg4);
                    return
                };
                v2 = v2 + 1;
            };
            v3 = false;
            /* goto 20 */
        } else {
            /* goto 21 */
        };
    }

    public fun withdrawn<T0>(arg0: &Ledger<T0>) : u128 {
        arg0.withdrawn
    }

    // decompiled from Move bytecode v7
}

