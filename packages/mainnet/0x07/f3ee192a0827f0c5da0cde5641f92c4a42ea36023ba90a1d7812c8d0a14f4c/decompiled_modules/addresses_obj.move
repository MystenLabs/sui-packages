module 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_obj {
    struct AddressesObj<phantom T0> has store, key {
        id: 0x2::object::UID,
        addressesSubObjs_table: 0x2::object_table::ObjectTable<0x2::object::ID, 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_sub_obj::AddressesSubObj>,
        addressesSubObjs_keys: vector<0x2::object::ID>,
        creator: address,
        fee: u64,
    }

    public entry fun add_addresses<T0>(arg0: &mut AddressesObj<T0>, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_sub_obj::AddressesSubObj>(&mut arg0.addressesSubObjs_table, *0x1::vector::borrow<0x2::object::ID>(&arg0.addressesSubObjs_keys, 0x1::vector::length<0x2::object::ID>(&arg0.addressesSubObjs_keys) - 1));
        if (0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_sub_obj::size(v0) + 0x1::vector::length<address>(&arg1) > 7600) {
            let v1 = 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_sub_obj::create(arg1, arg2);
            let v2 = 0x2::object::id<0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_sub_obj::AddressesSubObj>(&v1);
            0x2::object_table::add<0x2::object::ID, 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_sub_obj::AddressesSubObj>(&mut arg0.addressesSubObjs_table, v2, v1);
            0x1::vector::push_back<0x2::object::ID>(&mut arg0.addressesSubObjs_keys, v2);
        } else {
            0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_sub_obj::append(v0, arg1);
        };
    }

    public(friend) fun clear<T0>(arg0: &mut AddressesObj<T0>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg0.addressesSubObjs_keys)) {
            0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_sub_obj::destroy(0x2::object_table::remove<0x2::object::ID, 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_sub_obj::AddressesSubObj>(&mut arg0.addressesSubObjs_table, *0x1::vector::borrow<0x2::object::ID>(&arg0.addressesSubObjs_keys, v0)));
            v0 = v0 + 1;
        };
        arg0.addressesSubObjs_keys = 0x1::vector::empty<0x2::object::ID>();
    }

    public entry fun clearByCreator<T0>(arg0: &mut AddressesObj<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg1), 1);
        clear<T0>(arg0);
    }

    public entry fun create<T0>(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = internal_create<T0>(arg0, arg1);
        0x2::transfer::transfer<AddressesObj<T0>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun destroy<T0>(arg0: AddressesObj<T0>) {
        assert!(arg0.fee == 0, 0);
        let AddressesObj {
            id                     : v0,
            addressesSubObjs_table : v1,
            addressesSubObjs_keys  : v2,
            creator                : _,
            fee                    : _,
        } = arg0;
        let v5 = v2;
        let v6 = v1;
        0x2::object::delete(v0);
        0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_sub_obj::table_keys_clear(&mut v6, &mut v5);
        0x2::object_table::destroy_empty<0x2::object::ID, 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_sub_obj::AddressesSubObj>(v6);
        0x1::vector::destroy_empty<0x2::object::ID>(v5);
    }

    public entry fun finalize<T0>(arg0: AddressesObj<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        let v0 = &mut arg0;
        setFee<T0>(v0, arg1);
        let AddressesObj {
            id                     : v1,
            addressesSubObjs_table : v2,
            addressesSubObjs_keys  : v3,
            creator                : v4,
            fee                    : v5,
        } = arg0;
        0x2::object::delete(v1);
        let v6 = AddressesObj<T0>{
            id                     : 0x2::object::new(arg2),
            addressesSubObjs_table : v2,
            addressesSubObjs_keys  : v3,
            creator                : v4,
            fee                    : v5,
        };
        0x2::transfer::public_share_object<AddressesObj<T0>>(v6);
    }

    public fun getAddresses<T0>(arg0: &AddressesObj<T0>) : vector<address> {
        0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_sub_obj::table_keys_get_all_addresses(&arg0.addressesSubObjs_table, &arg0.addressesSubObjs_keys)
    }

    public fun getCreator<T0>(arg0: &AddressesObj<T0>) : address {
        arg0.creator
    }

    public fun getFee<T0>(arg0: &AddressesObj<T0>) : u64 {
        arg0.fee
    }

    public(friend) fun internal_create<T0>(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) : AddressesObj<T0> {
        let (v0, v1) = 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_sub_obj::table_keys_create(arg0, arg1);
        AddressesObj<T0>{
            id                     : 0x2::object::new(arg1),
            addressesSubObjs_table : v0,
            addressesSubObjs_keys  : v1,
            creator                : 0x2::tx_context::sender(arg1),
            fee                    : 0,
        }
    }

    public(friend) fun pop_all<T0>(arg0: &mut AddressesObj<T0>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::object_table::ObjectTable<0x2::object::ID, 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_sub_obj::AddressesSubObj>, vector<0x2::object::ID>) {
        let v0 = 0x2::object_table::new<0x2::object::ID, 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_sub_obj::AddressesSubObj>(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg0.addressesSubObjs_keys)) {
            let v2 = 0x1::vector::borrow<0x2::object::ID>(&arg0.addressesSubObjs_keys, v1);
            0x2::object_table::add<0x2::object::ID, 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_sub_obj::AddressesSubObj>(&mut v0, *v2, 0x2::object_table::remove<0x2::object::ID, 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_sub_obj::AddressesSubObj>(&mut arg0.addressesSubObjs_table, *v2));
            v1 = v1 + 1;
        };
        arg0.addressesSubObjs_keys = 0x1::vector::empty<0x2::object::ID>();
        (v0, arg0.addressesSubObjs_keys)
    }

    public(friend) fun setFee<T0>(arg0: &mut AddressesObj<T0>, arg1: u64) {
        arg0.fee = arg1;
    }

    // decompiled from Move bytecode v6
}

