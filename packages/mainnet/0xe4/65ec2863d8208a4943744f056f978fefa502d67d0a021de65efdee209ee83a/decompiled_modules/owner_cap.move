module 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::owner_cap {
    struct CloneableOwnerCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        what_for: 0x2::object::ID,
        inner: OwnerCap<T0>,
    }

    struct OwnerCap<phantom T0> has drop, store {
        unique: 0x2::object::ID,
    }

    public fun id<T0>(arg0: &OwnerCap<T0>) : 0x2::object::ID {
        arg0.unique
    }

    public fun as_ref<T0>(arg0: &CloneableOwnerCap<T0>) : &OwnerCap<T0> {
        &arg0.inner
    }

    public fun clone<T0>(arg0: &CloneableOwnerCap<T0>, arg1: &mut 0x2::tx_context::TxContext) : CloneableOwnerCap<T0> {
        let v0 = OwnerCap<T0>{unique: arg0.inner.unique};
        CloneableOwnerCap<T0>{
            id       : 0x2::object::new(arg1),
            what_for : arg0.what_for,
            inner    : v0,
        }
    }

    public fun clone_for_receiver<T0>(arg0: &CloneableOwnerCap<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<CloneableOwnerCap<T0>>(clone<T0>(arg0, arg2), arg1);
    }

    public fun clone_n<T0>(arg0: &CloneableOwnerCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : vector<CloneableOwnerCap<T0>> {
        let v0 = 0x1::vector::empty<CloneableOwnerCap<T0>>();
        let v1 = 0;
        while (v1 < arg1) {
            0x1::vector::push_back<CloneableOwnerCap<T0>>(&mut v0, clone<T0>(arg0, arg2));
            v1 = v1 + 1;
        };
        v0
    }

    public fun destroy<T0>(arg0: CloneableOwnerCap<T0>) {
        let CloneableOwnerCap {
            id       : v0,
            what_for : _,
            inner    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun is_for<T0, T1: key>(arg0: &CloneableOwnerCap<T0>, arg1: &T1) : bool {
        arg0.what_for == 0x2::object::id<T1>(arg1)
    }

    public fun is_for_id<T0>(arg0: &CloneableOwnerCap<T0>, arg1: 0x2::object::ID) : bool {
        arg0.what_for == arg1
    }

    public fun new_cloneable_drop<T0: drop>(arg0: T0, arg1: &0x2::object::UID, arg2: &mut 0x2::tx_context::TxContext) : CloneableOwnerCap<T0> {
        let v0 = 0x2::object::new(arg2);
        CloneableOwnerCap<T0>{
            id       : v0,
            what_for : 0x2::object::uid_to_inner(arg1),
            inner    : new_uncloneable<T0>(&arg0, arg2),
        }
    }

    public fun new_cloneable_key<T0: key>(arg0: &T0, arg1: &0x2::object::UID, arg2: &mut 0x2::tx_context::TxContext) : CloneableOwnerCap<T0> {
        assert!(0x2::object::id<T0>(arg0) == 0x2::object::uid_to_inner(arg1), 13906834496465928193);
        let v0 = 0x2::object::new(arg2);
        CloneableOwnerCap<T0>{
            id       : v0,
            what_for : 0x2::object::id<T0>(arg0),
            inner    : new_uncloneable<T0>(arg0, arg2),
        }
    }

    public fun new_uncloneable<T0>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : OwnerCap<T0> {
        let v0 = 0x2::object::new(arg1);
        0x2::object::delete(v0);
        OwnerCap<T0>{unique: 0x2::object::uid_to_inner(&v0)}
    }

    public fun what_for<T0>(arg0: &CloneableOwnerCap<T0>) : 0x2::object::ID {
        arg0.what_for
    }

    // decompiled from Move bytecode v6
}

