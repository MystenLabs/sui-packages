module 0x7b34e53aad7ed35364de4b5e97c1652bdba220a59f716063b7491898d6c59f8b::registry {
    struct PositionRegistry has store, key {
        id: 0x2::object::UID,
        registry_increment_id: u64,
        bag: 0x2::bag::Bag,
    }

    struct PositionInfo<T0> has store {
        position: 0x1::option::Option<T0>,
        owner: address,
    }

    public fun is_some<T0: store>(arg0: &PositionRegistry, arg1: u64) : bool {
        0x1::option::is_some<T0>(&0x2::bag::borrow<u64, PositionInfo<T0>>(&arg0.bag, arg1).position)
    }

    public fun add_position<T0: store>(arg0: &mut PositionRegistry, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = PositionInfo<T0>{
            position : 0x1::option::some<T0>(arg1),
            owner    : 0x2::tx_context::sender(arg2),
        };
        0x2::bag::add<u64, PositionInfo<T0>>(&mut arg0.bag, arg0.registry_increment_id, v0);
        arg0.registry_increment_id = arg0.registry_increment_id + 1;
        arg0.registry_increment_id
    }

    public fun borrow_position_by_id<T0: store>(arg0: &PositionRegistry, arg1: u64) : &T0 {
        let v0 = 0x2::bag::borrow<u64, PositionInfo<T0>>(&arg0.bag, arg1);
        if (0x1::option::is_none<T0>(&v0.position)) {
            abort 0
        };
        0x1::option::borrow<T0>(&v0.position)
    }

    public(friend) fun get_position_by_id<T0: store>(arg0: &mut PositionRegistry, arg1: u64) : T0 {
        let v0 = 0x2::bag::borrow_mut<u64, PositionInfo<T0>>(&mut arg0.bag, arg1);
        if (0x1::option::is_none<T0>(&v0.position)) {
            abort 0
        };
        0x1::option::extract<T0>(&mut v0.position)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<PositionRegistry>(new_registry(arg0));
    }

    public(friend) fun mut_borrow_position_by_id<T0: store>(arg0: &mut PositionRegistry, arg1: u64) : &mut T0 {
        let v0 = 0x2::bag::borrow_mut<u64, PositionInfo<T0>>(&mut arg0.bag, arg1);
        if (0x1::option::is_none<T0>(&v0.position)) {
            abort 0
        };
        0x1::option::borrow_mut<T0>(&mut v0.position)
    }

    fun new_registry(arg0: &mut 0x2::tx_context::TxContext) : PositionRegistry {
        PositionRegistry{
            id                    : 0x2::object::new(arg0),
            registry_increment_id : 0,
            bag                   : 0x2::bag::new(arg0),
        }
    }

    public fun owner<T0: store>(arg0: &PositionRegistry, arg1: u64) : address {
        0x2::bag::borrow<u64, PositionInfo<T0>>(&arg0.bag, arg1).owner
    }

    public fun remove_position<T0: store>(arg0: &mut PositionRegistry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        let v0 = 0x2::bag::borrow_mut<u64, PositionInfo<T0>>(&mut arg0.bag, arg1);
        if (0x1::option::is_none<T0>(&v0.position)) {
            abort 0
        };
        if (v0.owner != 0x2::tx_context::sender(arg2)) {
            abort 1
        };
        0x1::option::extract<T0>(&mut v0.position)
    }

    public fun return_position<T0: store>(arg0: &mut PositionRegistry, arg1: T0, arg2: u64) {
        let v0 = 0x2::bag::borrow_mut<u64, PositionInfo<T0>>(&mut arg0.bag, arg2);
        if (0x1::option::is_some<T0>(&v0.position)) {
            abort 2
        };
        0x1::option::fill<T0>(&mut v0.position, arg1);
    }

    // decompiled from Move bytecode v6
}

