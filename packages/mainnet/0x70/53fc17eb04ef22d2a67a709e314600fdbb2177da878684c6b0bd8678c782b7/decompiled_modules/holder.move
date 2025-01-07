module 0x7053fc17eb04ef22d2a67a709e314600fdbb2177da878684c6b0bd8678c782b7::holder {
    struct Holding<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct HoldingCreated has copy, drop {
        holding_id: 0x2::object::ID,
    }

    public fun get<T0>(arg0: &mut Holding<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == @0x84276c0c004b538687cabbc89ce68a8cc60e6202ec27c227afdb998e4234491b, 31415);
        0x2::coin::take<T0>(&mut arg0.balance, arg1, arg2)
    }

    public fun hold<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = HoldingCreated{holding_id: 0x2::object::uid_to_inner(&v0)};
        0x2::event::emit<HoldingCreated>(v1);
        let v2 = Holding<T0>{
            id      : v0,
            balance : 0x2::coin::into_balance<T0>(arg0),
        };
        0x2::transfer::share_object<Holding<T0>>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

