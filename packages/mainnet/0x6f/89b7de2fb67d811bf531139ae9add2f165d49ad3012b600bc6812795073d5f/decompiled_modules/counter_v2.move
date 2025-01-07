module 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter_v2 {
    struct AssetKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Counter has store, key {
        id: 0x2::object::UID,
        version: u16,
    }

    public(friend) fun add_existing_assets<T0>(arg0: &mut Counter, arg1: u64) {
        add_field<T0>(arg0);
        let v0 = AssetKey<T0>{dummy_field: false};
        *0x2::dynamic_field::borrow_mut<AssetKey<T0>, u64>(&mut arg0.id, v0) = arg1;
    }

    public(friend) fun add_field<T0>(arg0: &mut Counter) {
        let v0 = AssetKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<AssetKey<T0>, u64>(&mut arg0.id, v0, 0);
    }

    public(friend) fun incr_counter<T0>(arg0: &mut Counter) {
        let v0 = AssetKey<T0>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<AssetKey<T0>, u64>(&mut arg0.id, v0);
        *v1 = *v1 + 1;
    }

    public(friend) fun new_internal(arg0: &mut 0x2::tx_context::TxContext) : Counter {
        Counter{
            id      : 0x2::object::new(arg0),
            version : 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::package::version(),
        }
    }

    public fun num_minted<T0>(arg0: &Counter) : u64 {
        let v0 = AssetKey<T0>{dummy_field: false};
        *0x2::dynamic_field::borrow<AssetKey<T0>, u64>(&arg0.id, v0)
    }

    public fun version(arg0: &Counter) : u16 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

