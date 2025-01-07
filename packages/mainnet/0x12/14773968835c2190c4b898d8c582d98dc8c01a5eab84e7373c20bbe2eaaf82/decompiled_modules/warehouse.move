module 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::warehouse {
    struct Warehouse<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        prizes: vector<0x2::object::ID>,
    }

    public fun is_empty<T0: store + key>(arg0: &Warehouse<T0>) : bool {
        0x1::vector::is_empty<0x2::object::ID>(&arg0.prizes)
    }

    public(friend) fun new<T0: store + key>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : Warehouse<T0> {
        let v0 = 0x2::object::new(arg1);
        0x2::dynamic_object_field::add<0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::utils::Marker<0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::pseudorandom::Counter>, 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::pseudorandom::Counter>(&mut v0, 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::utils::marker<0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::pseudorandom::Counter>(), 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::pseudorandom::create_counter(arg0, arg1));
        Warehouse<T0>{
            id     : v0,
            prizes : 0x1::vector::empty<0x2::object::ID>(),
        }
    }

    fun counter_mut<T0: store + key>(arg0: &mut Warehouse<T0>) : &mut 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::pseudorandom::Counter {
        0x2::dynamic_object_field::borrow_mut<0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::utils::Marker<0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::pseudorandom::Counter>, 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::pseudorandom::Counter>(&mut arg0.id, 0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::utils::marker<0x341b3c3b2cc3ce50451b0beac79adda76716f597c4f6daa30e2979aa8d561268::pseudorandom::Counter>())
    }

    public(friend) fun deposit_prize<T0: store + key>(arg0: &mut Warehouse<T0>, arg1: T0) {
        let v0 = 0x2::object::id<T0>(&arg1);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.prizes, v0);
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, v0, arg1);
    }

    public fun prizes<T0: store + key>(arg0: &Warehouse<T0>) : &vector<0x2::object::ID> {
        &arg0.prizes
    }

    public(friend) fun redeem_prize<T0: store + key>(arg0: &mut Warehouse<T0>) : T0 {
        let v0 = &mut arg0.prizes;
        assert!(!0x1::vector::is_empty<0x2::object::ID>(v0), 1);
        0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, 0x1::vector::pop_back<0x2::object::ID>(v0))
    }

    public fun supply<T0: store + key>(arg0: &Warehouse<T0>) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.prizes)
    }

    public(friend) fun withdraw_prize_by_id<T0: store + key>(arg0: &mut Warehouse<T0>, arg1: 0x2::object::ID) : T0 {
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg0.prizes, &arg1);
        assert!(v0, 2);
        0x1::vector::remove<0x2::object::ID>(&mut arg0.prizes, v1);
        0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg1)
    }

    // decompiled from Move bytecode v6
}

