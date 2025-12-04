module 0x2::accumulator {
    struct AccumulatorRoot has key {
        id: 0x2::object::UID,
    }

    struct U128 has store {
        value: u128,
    }

    struct Key<phantom T0> has copy, drop, store {
        address: address,
    }

    public(friend) fun accumulator_address<T0>(arg0: address) : address {
        let v0 = Key<T0>{address: arg0};
        0x2::dynamic_field::hash_type_and_key<Key<T0>>(0x2::object::sui_accumulator_root_address(), v0)
    }

    public(friend) fun accumulator_key<T0>(arg0: address) : Key<T0> {
        Key<T0>{address: arg0}
    }

    fun create(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x0, 0);
        let v0 = AccumulatorRoot{id: 0x2::object::sui_accumulator_root_object_id()};
        0x2::transfer::share_object<AccumulatorRoot>(v0);
    }

    public(friend) fun create_u128(arg0: u128) : U128 {
        U128{value: arg0}
    }

    public(friend) fun destroy_u128(arg0: U128) {
        let U128 {  } = arg0;
    }

    native public(friend) fun emit_deposit_event<T0>(arg0: address, arg1: address, arg2: u64);
    native public(friend) fun emit_withdraw_event<T0>(arg0: address, arg1: address, arg2: u64);
    public(friend) fun is_zero_u128(arg0: &U128) : bool {
        arg0.value == 0
    }

    public(friend) fun root_add_accumulator<T0, T1: store>(arg0: &mut AccumulatorRoot, arg1: Key<T0>, arg2: T1) {
        0x2::dynamic_field::add<Key<T0>, T1>(&mut arg0.id, arg1, arg2);
    }

    public(friend) fun root_borrow_accumulator_mut<T0, T1: store>(arg0: &mut AccumulatorRoot, arg1: Key<T0>) : &mut T1 {
        0x2::dynamic_field::borrow_mut<Key<T0>, T1>(&mut arg0.id, arg1)
    }

    public(friend) fun root_has_accumulator<T0, T1: store>(arg0: &AccumulatorRoot, arg1: Key<T0>) : bool {
        0x2::dynamic_field::exists_with_type<Key<T0>, T1>(&arg0.id, arg1)
    }

    public(friend) fun root_id(arg0: &AccumulatorRoot) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun root_id_mut(arg0: &mut AccumulatorRoot) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun root_remove_accumulator<T0, T1: store>(arg0: &mut AccumulatorRoot, arg1: Key<T0>) : T1 {
        0x2::dynamic_field::remove<Key<T0>, T1>(&mut arg0.id, arg1)
    }

    public(friend) fun update_u128(arg0: &mut U128, arg1: u128, arg2: u128) {
        arg0.value = arg0.value + arg1 - arg2;
    }

    // decompiled from Move bytecode v6
}

