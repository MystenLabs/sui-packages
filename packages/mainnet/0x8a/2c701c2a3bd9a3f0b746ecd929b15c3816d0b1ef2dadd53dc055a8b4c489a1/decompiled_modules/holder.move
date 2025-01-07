module 0x8a2c701c2a3bd9a3f0b746ecd929b15c3816d0b1ef2dadd53dc055a8b4c489a1::holder {
    struct Holding<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct HoldingCreated has copy, drop {
        holding_id: 0x2::object::ID,
    }

    public fun f(arg0: &0x4ee8d4e289f0b795274b71c03056b789ef021a098d7e5e848b6e610ba68419ea::my_module::Sword, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        0x4ee8d4e289f0b795274b71c03056b789ef021a098d7e5e848b6e610ba68419ea::my_module::magic(arg0)
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

