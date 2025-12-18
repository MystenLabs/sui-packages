module 0x5d04ee59a9c77c1338d90d034bdeb75c4fe4563aada13ff10af7b0032ac87ffa::test {
    struct TestCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
    }

    struct Event has copy, drop {
        str: 0x1::ascii::String,
    }

    public fun test<T0: store + key>() {
        let v0 = Event{str: 0x1::type_name::into_string(0x1::type_name::get<T0>())};
        0x2::event::emit<Event>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        test<TestCap<0x2::sui::SUI, 0x2::sui::SUI>>();
    }

    // decompiled from Move bytecode v6
}

