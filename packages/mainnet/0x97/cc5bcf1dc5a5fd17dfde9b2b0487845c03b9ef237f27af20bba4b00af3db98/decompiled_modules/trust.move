module 0x97cc5bcf1dc5a5fd17dfde9b2b0487845c03b9ef237f27af20bba4b00af3db98::trust {
    struct Trust has key {
        id: 0x2::object::UID,
    }

    struct SettlorCap has key {
        id: 0x2::object::UID,
        trust_id: 0x2::object::ID,
    }

    struct TrusteeCap has key {
        id: 0x2::object::UID,
        trust_id: 0x2::object::ID,
    }

    public(friend) fun borrow<T0: copy + drop + store, T1: store>(arg0: &mut Trust, arg1: &TrusteeCap, arg2: T0) : 0x1::option::Option<T1> {
        is_trustee_cap_correct(arg0, arg1);
        0x2::dynamic_field::remove_if_exists<T0, T1>(&mut arg0.id, arg2)
    }

    public(friend) fun exists_<T0: copy + drop + store>(arg0: &Trust, arg1: T0) : bool {
        0x2::dynamic_field::exists_<T0>(&arg0.id, arg1)
    }

    public entry fun assign(arg0: &Trust, arg1: &SettlorCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        is_settlor_cap_correct(arg0, arg1);
        let v0 = TrusteeCap{
            id       : 0x2::object::new(arg3),
            trust_id : 0x2::object::id<Trust>(arg0),
        };
        0x2::transfer::transfer<TrusteeCap>(v0, arg2);
    }

    public(friend) fun borrow_mut_ref<T0: copy + drop + store, T1: store>(arg0: &mut Trust, arg1: &TrusteeCap, arg2: T0) : &mut T1 {
        is_trustee_cap_correct(arg0, arg1);
        0x2::dynamic_field::borrow_mut<T0, T1>(&mut arg0.id, arg2)
    }

    public entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Trust{id: 0x2::object::new(arg0)};
        let v1 = SettlorCap{
            id       : 0x2::object::new(arg0),
            trust_id : 0x2::object::id<Trust>(&v0),
        };
        0x2::transfer::share_object<Trust>(v0);
        0x2::transfer::transfer<SettlorCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun entrust<T0: copy + drop + store, T1: store>(arg0: &mut Trust, arg1: &SettlorCap, arg2: T0, arg3: T1) {
        is_settlor_cap_correct(arg0, arg1);
        0x2::dynamic_field::add<T0, T1>(&mut arg0.id, arg2, arg3);
    }

    public fun is_settlor_cap_correct(arg0: &Trust, arg1: &SettlorCap) {
        assert!(0x2::object::id<Trust>(arg0) == arg1.trust_id, 0);
    }

    public fun is_trustee_cap_correct(arg0: &Trust, arg1: &TrusteeCap) {
        assert!(0x2::object::id<Trust>(arg0) == arg1.trust_id, 0);
    }

    public(friend) fun query<T0: copy + drop + store, T1: store>(arg0: &Trust, arg1: T0) : &T1 {
        0x2::dynamic_field::borrow<T0, T1>(&arg0.id, arg1)
    }

    public fun repay<T0: copy + drop + store, T1: store>(arg0: &mut Trust, arg1: &TrusteeCap, arg2: T0, arg3: T1) {
        is_trustee_cap_correct(arg0, arg1);
        0x2::dynamic_field::add<T0, T1>(&mut arg0.id, arg2, arg3);
    }

    public entry fun resign(arg0: TrusteeCap) {
        let TrusteeCap {
            id       : v0,
            trust_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun revoke(arg0: Trust, arg1: SettlorCap) {
        let Trust { id: v0 } = arg0;
        0x2::object::delete(v0);
        let SettlorCap {
            id       : v1,
            trust_id : _,
        } = arg1;
        0x2::object::delete(v1);
    }

    public fun withdraw<T0: copy + drop + store, T1: store>(arg0: &mut Trust, arg1: &SettlorCap, arg2: T0) : 0x1::option::Option<T1> {
        is_settlor_cap_correct(arg0, arg1);
        0x2::dynamic_field::remove_if_exists<T0, T1>(&mut arg0.id, arg2)
    }

    public entry fun withdraw_entry<T0: copy + drop + store, T1: store + key>(arg0: &mut Trust, arg1: &SettlorCap, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T1>(0x1::option::destroy_some<T1>(withdraw<T0, T1>(arg0, arg1, arg2)), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

