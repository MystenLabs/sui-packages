module 0x7f3ee192a0827f0c5da0cde5641f92c4a42ea36023ba90a1d7812c8d0a14f4c::addresses_sub_obj {
    struct AddressesSubObj has store, key {
        id: 0x2::object::UID,
        addresses: vector<address>,
    }

    public(friend) fun append(arg0: &mut AddressesSubObj, arg1: vector<address>) {
        0x1::vector::append<address>(&mut arg0.addresses, arg1);
    }

    public(friend) fun create(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) : AddressesSubObj {
        AddressesSubObj{
            id        : 0x2::object::new(arg1),
            addresses : arg0,
        }
    }

    public(friend) fun destroy(arg0: AddressesSubObj) {
        let AddressesSubObj {
            id        : v0,
            addresses : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun get_addresses(arg0: &AddressesSubObj) : &vector<address> {
        &arg0.addresses
    }

    public(friend) fun get_addresses_mut(arg0: &mut AddressesSubObj) : &mut vector<address> {
        &mut arg0.addresses
    }

    public(friend) fun size(arg0: &AddressesSubObj) : u64 {
        0x1::vector::length<address>(&arg0.addresses)
    }

    public(friend) fun table_keys_clear(arg0: &mut 0x2::object_table::ObjectTable<0x2::object::ID, AddressesSubObj>, arg1: &mut vector<0x2::object::ID>) : vector<address> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg1)) {
            destroy(0x2::object_table::remove<0x2::object::ID, AddressesSubObj>(arg0, 0x1::vector::remove<0x2::object::ID>(arg1, v0)));
            v0 = v0 + 1;
        };
        0x1::vector::empty<address>()
    }

    public(friend) fun table_keys_create(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::object_table::ObjectTable<0x2::object::ID, AddressesSubObj>, vector<0x2::object::ID>) {
        let v0 = 0x2::object_table::new<0x2::object::ID, AddressesSubObj>(arg1);
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = create(arg0, arg1);
        let v3 = 0x2::object::id<AddressesSubObj>(&v2);
        0x2::object_table::add<0x2::object::ID, AddressesSubObj>(&mut v0, v3, v2);
        0x1::vector::push_back<0x2::object::ID>(&mut v1, v3);
        (v0, v1)
    }

    public(friend) fun table_keys_get_all_addresses(arg0: &0x2::object_table::ObjectTable<0x2::object::ID, AddressesSubObj>, arg1: &vector<0x2::object::ID>) : vector<address> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<address>();
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg1)) {
            let v2 = get_addresses(0x2::object_table::borrow<0x2::object::ID, AddressesSubObj>(arg0, *0x1::vector::borrow<0x2::object::ID>(arg1, v0)));
            let v3 = 0;
            while (v3 < 0x1::vector::length<address>(v2)) {
                0x1::vector::push_back<address>(&mut v1, *0x1::vector::borrow<address>(v2, v3));
                v3 = v3 + 1;
            };
            v0 = v0 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

