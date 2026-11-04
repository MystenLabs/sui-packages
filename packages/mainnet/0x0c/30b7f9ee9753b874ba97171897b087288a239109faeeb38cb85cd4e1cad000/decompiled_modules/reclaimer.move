module 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::reclaimer {
    struct Reclaimer<phantom T0> has key {
        id: 0x2::object::UID,
        addr: address,
    }

    struct SetReclaimerAbility has drop {
        dummy_field: bool,
    }

    struct ReclaimerAdded<phantom T0> has copy, drop {
        reclaimer_id: 0x2::object::ID,
        reclaimer_addr: address,
        sender: address,
    }

    struct ReclaimerEdited<phantom T0> has copy, drop {
        reclaimer_id: 0x2::object::ID,
        old_addr: address,
        new_addr: address,
        sender: address,
    }

    struct ReclaimerDeleted<phantom T0> has copy, drop {
        reclaimer_id: 0x2::object::ID,
        reclaimer_addr: address,
        sender: address,
    }

    public fun delete<T0>(arg0: Reclaimer<T0>, arg1: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>, arg2: &0x2::tx_context::TxContext) : address {
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, SetReclaimerAbility>(arg1), 0);
        let Reclaimer {
            id   : v0,
            addr : v1,
        } = arg0;
        let v2 = v0;
        let v3 = ReclaimerDeleted<T0>{
            reclaimer_id   : 0x2::object::uid_to_inner(&v2),
            reclaimer_addr : v1,
            sender         : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ReclaimerDeleted<T0>>(v3);
        0x2::object::delete(v2);
        v1
    }

    public fun new<T0>(arg0: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : Reclaimer<T0> {
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, SetReclaimerAbility>(arg0), 0);
        let v0 = 0x2::object::new(arg2);
        let v1 = ReclaimerAdded<T0>{
            reclaimer_id   : 0x2::object::uid_to_inner(&v0),
            reclaimer_addr : arg1,
            sender         : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ReclaimerAdded<T0>>(v1);
        Reclaimer<T0>{
            id   : v0,
            addr : arg1,
        }
    }

    public fun addr<T0>(arg0: &Reclaimer<T0>) : address {
        arg0.addr
    }

    public fun set_addr<T0>(arg0: &mut Reclaimer<T0>, arg1: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, SetReclaimerAbility>(arg1), 0);
        let v0 = ReclaimerEdited<T0>{
            reclaimer_id : 0x2::object::id<Reclaimer<T0>>(arg0),
            old_addr     : arg0.addr,
            new_addr     : arg2,
            sender       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ReclaimerEdited<T0>>(v0);
        arg0.addr = arg2;
    }

    public fun share<T0>(arg0: Reclaimer<T0>) {
        0x2::transfer::share_object<Reclaimer<T0>>(arg0);
    }

    // decompiled from Move bytecode v7
}

