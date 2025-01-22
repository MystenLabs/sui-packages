module 0x13d0f9713b4b615f7234c470d8dfa851b7fecb11528319fbd5e618849dd064f::operators {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct Operators has key {
        id: 0x2::object::UID,
        operators: 0x2::vec_set::VecSet<address>,
        caps: 0x2::bag::Bag,
    }

    struct Borrow {
        id: 0x2::object::ID,
    }

    struct OperatorAdded has copy, drop {
        operator: address,
    }

    struct OperatorRemoved has copy, drop {
        operator: address,
    }

    struct CapabilityStored has copy, drop {
        cap_id: 0x2::object::ID,
        cap_name: 0x1::ascii::String,
    }

    struct CapabilityRemoved has copy, drop {
        cap_id: 0x2::object::ID,
        cap_name: 0x1::ascii::String,
    }

    public fun add_operator(arg0: &mut Operators, arg1: &OwnerCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg3)};
        0x2::transfer::transfer<OperatorCap>(v0, arg2);
        0x2::vec_set::insert<address>(&mut arg0.operators, arg2);
        let v1 = OperatorAdded{operator: arg2};
        0x2::event::emit<OperatorAdded>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Operators{
            id        : 0x2::object::new(arg0),
            operators : 0x2::vec_set::empty<address>(),
            caps      : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<Operators>(v0);
        let v1 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun loan_cap<T0: store + key>(arg0: &mut Operators, arg1: &OperatorCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : (T0, Borrow) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_set::contains<address>(&arg0.operators, &v0), 9223372715459608577);
        assert!(0x2::bag::contains<0x2::object::ID>(&arg0.caps, arg2), 9223372719754706947);
        let v1 = 0x2::bag::remove<0x2::object::ID, T0>(&mut arg0.caps, arg2);
        let v2 = Borrow{id: 0x2::object::id<T0>(&v1)};
        (v1, v2)
    }

    public fun remove_cap<T0: store + key>(arg0: &mut Operators, arg1: &OwnerCap, arg2: 0x2::object::ID) : T0 {
        let v0 = CapabilityRemoved{
            cap_id   : arg2,
            cap_name : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
        };
        0x2::event::emit<CapabilityRemoved>(v0);
        0x2::bag::remove<0x2::object::ID, T0>(&mut arg0.caps, arg2)
    }

    public fun remove_operator(arg0: &mut Operators, arg1: &OwnerCap, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg0.operators, &arg2);
        let v0 = OperatorRemoved{operator: arg2};
        0x2::event::emit<OperatorRemoved>(v0);
    }

    public fun restore_cap<T0: store + key>(arg0: &mut Operators, arg1: &OperatorCap, arg2: T0, arg3: Borrow) {
        let v0 = 0x2::object::id<T0>(&arg2);
        let Borrow { id: v1 } = arg3;
        assert!(v1 == v0, 9223372848603856901);
        0x2::bag::add<0x2::object::ID, T0>(&mut arg0.caps, v0, arg2);
    }

    public fun store_cap<T0: store + key>(arg0: &mut Operators, arg1: &OwnerCap, arg2: T0) {
        let v0 = 0x2::object::id<T0>(&arg2);
        0x2::bag::add<0x2::object::ID, T0>(&mut arg0.caps, v0, arg2);
        let v1 = CapabilityStored{
            cap_id   : v0,
            cap_name : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
        };
        0x2::event::emit<CapabilityStored>(v1);
    }

    // decompiled from Move bytecode v6
}

