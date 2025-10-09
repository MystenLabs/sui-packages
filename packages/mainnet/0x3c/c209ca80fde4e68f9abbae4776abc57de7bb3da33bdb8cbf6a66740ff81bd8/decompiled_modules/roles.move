module 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::roles {
    struct Roles<phantom T0> has store {
        data: 0x2::bag::Bag,
    }

    struct OwnerKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PauserKey has copy, drop, store {
        dummy_field: bool,
    }

    struct OwnerChanged<phantom T0> has copy, drop {
        old_owner: address,
        new_owner: address,
    }

    struct PauserChanged<phantom T0> has copy, drop {
        old_pauser: address,
        new_pauser: address,
    }

    public(friend) fun new<T0>(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : Roles<T0> {
        let v0 = 0x2::bag::new(arg2);
        let v1 = OwnerKey{dummy_field: false};
        0x2::bag::add<OwnerKey, address>(&mut v0, v1, arg0);
        let v2 = PauserKey{dummy_field: false};
        0x2::bag::add<PauserKey, address>(&mut v0, v2, arg1);
        Roles<T0>{data: v0}
    }

    public fun is_owner<T0>(arg0: &Roles<T0>, arg1: address) : bool {
        master_owner<T0>(arg0) == arg1
    }

    public fun is_pauser<T0>(arg0: &Roles<T0>, arg1: address) : bool {
        pauser<T0>(arg0) == arg1 || master_owner<T0>(arg0) == arg1
    }

    public fun master_owner<T0>(arg0: &Roles<T0>) : address {
        let v0 = OwnerKey{dummy_field: false};
        *0x2::bag::borrow<OwnerKey, address>(&arg0.data, v0)
    }

    public fun pauser<T0>(arg0: &Roles<T0>) : address {
        let v0 = PauserKey{dummy_field: false};
        *0x2::bag::borrow<PauserKey, address>(&arg0.data, v0)
    }

    fun update_address<T0, T1: copy + drop + store>(arg0: &mut Roles<T0>, arg1: T1, arg2: address) : address {
        0x2::bag::add<T1, address>(&mut arg0.data, arg1, arg2);
        0x2::bag::remove<T1, address>(&mut arg0.data, arg1)
    }

    public(friend) fun update_owner<T0>(arg0: &mut Roles<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(is_owner<T0>(arg0, 0x2::tx_context::sender(arg2)), 1);
        let v0 = OwnerKey{dummy_field: false};
        let v1 = OwnerChanged<T0>{
            old_owner : update_address<T0, OwnerKey>(arg0, v0, arg1),
            new_owner : arg1,
        };
        0x2::event::emit<OwnerChanged<T0>>(v1);
    }

    public(friend) fun update_pauser<T0>(arg0: &mut Roles<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(is_owner<T0>(arg0, 0x2::tx_context::sender(arg2)), 1);
        let v0 = PauserKey{dummy_field: false};
        let v1 = PauserChanged<T0>{
            old_pauser : update_address<T0, PauserKey>(arg0, v0, arg1),
            new_pauser : arg1,
        };
        0x2::event::emit<PauserChanged<T0>>(v1);
    }

    // decompiled from Move bytecode v6
}

