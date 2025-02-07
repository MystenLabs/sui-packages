module 0x1df31a5616e2b33135f685e0aecd4ed7cb563de253269ba7e808946c71b24d90::address_book {
    struct Address has store {
        name: 0x1::string::String,
        group_ids: 0x2::vec_set::VecSet<u16>,
        address_: vector<u8>,
        network_ids: 0x2::vec_set::VecSet<0x1::string::String>,
    }

    struct AddressGroup has store {
        name: 0x1::string::String,
        address_ids: 0x2::vec_set::VecSet<u16>,
    }

    struct AddressBook has store {
        addresses: 0x2::vec_map::VecMap<u16, Address>,
        address_groups: 0x2::vec_map::VecMap<u16, AddressGroup>,
        address_id_counter: u16,
    }

    public(friend) fun execute_config_address_book_add_address(arg0: &mut AddressBook, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<0x1::string::String>) {
        let v0 = Address{
            name        : arg1,
            group_ids   : 0x2::vec_set::empty<u16>(),
            address_    : arg2,
            network_ids : 0x2::vec_set::from_keys<0x1::string::String>(arg3),
        };
        0x2::vec_map::insert<u16, Address>(&mut arg0.addresses, arg0.address_id_counter, v0);
        arg0.address_id_counter = arg0.address_id_counter + 1;
    }

    public(friend) fun execute_config_address_book_add_group(arg0: &mut AddressBook, arg1: 0x1::string::String) {
        let v0 = AddressGroup{
            name        : arg1,
            address_ids : 0x2::vec_set::empty<u16>(),
        };
        0x2::vec_map::insert<u16, AddressGroup>(&mut arg0.address_groups, arg0.address_id_counter, v0);
        arg0.address_id_counter = arg0.address_id_counter + 1;
    }

    public(friend) fun execute_config_address_book_delete_address(arg0: &mut AddressBook, arg1: u16) {
        let (_, v1) = 0x2::vec_map::remove<u16, Address>(&mut arg0.addresses, &arg1);
        let Address {
            name        : _,
            group_ids   : _,
            address_    : _,
            network_ids : _,
        } = v1;
    }

    public(friend) fun execute_config_address_book_delete_group(arg0: &mut AddressBook, arg1: u16) {
        let (_, v1) = 0x2::vec_map::remove<u16, AddressGroup>(&mut arg0.address_groups, &arg1);
        let AddressGroup {
            name        : _,
            address_ids : v3,
        } = v1;
        let v4 = v3;
        assert!(0x2::vec_set::is_empty<u16>(&v4), 1);
    }

    public(friend) fun execute_config_address_book_edit_address(arg0: &mut AddressBook, arg1: u16, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::option::Option<vector<0x1::string::String>>) {
        let v0 = 0x2::vec_map::get_mut<u16, Address>(&mut arg0.addresses, &arg1);
        if (0x1::option::is_some<0x1::string::String>(&arg2)) {
            v0.name = *0x1::option::borrow<0x1::string::String>(&arg2);
        };
        if (0x1::option::is_some<vector<0x1::string::String>>(&arg3)) {
            v0.network_ids = 0x2::vec_set::from_keys<0x1::string::String>(*0x1::option::borrow<vector<0x1::string::String>>(&arg3));
        };
    }

    public(friend) fun execute_config_address_book_edit_group(arg0: &mut AddressBook, arg1: 0x1::option::Option<u16>, arg2: 0x1::option::Option<0x1::string::String>, arg3: vector<u16>, arg4: vector<u16>) {
        let v0 = 0x1::option::destroy_with_default<u16>(arg1, arg0.address_id_counter - 1);
        0x1::vector::reverse<u16>(&mut arg3);
        while (!0x1::vector::is_empty<u16>(&arg3)) {
            let v1 = 0x1::vector::pop_back<u16>(&mut arg3);
            assert!(!0x1::vector::contains<u16>(&arg4, &v1), 0);
        };
        0x1::vector::destroy_empty<u16>(arg3);
        let v2 = 0x2::vec_map::get_mut<u16, AddressGroup>(&mut arg0.address_groups, &v0);
        if (0x1::option::is_some<0x1::string::String>(&arg2)) {
            v2.name = *0x1::option::borrow<0x1::string::String>(&arg2);
        };
        0x1::vector::reverse<u16>(&mut arg3);
        while (!0x1::vector::is_empty<u16>(&arg3)) {
            let v3 = 0x1::vector::pop_back<u16>(&mut arg3);
            0x2::vec_set::insert<u16>(&mut v2.address_ids, v3);
            0x2::vec_set::insert<u16>(&mut 0x2::vec_map::get_mut<u16, Address>(&mut arg0.addresses, &v3).group_ids, v0);
        };
        0x1::vector::destroy_empty<u16>(arg3);
        0x1::vector::reverse<u16>(&mut arg4);
        while (!0x1::vector::is_empty<u16>(&arg4)) {
            let v4 = 0x1::vector::pop_back<u16>(&mut arg4);
            0x2::vec_set::remove<u16>(&mut v2.address_ids, &v4);
            0x2::vec_set::remove<u16>(&mut 0x2::vec_map::get_mut<u16, Address>(&mut arg0.addresses, &v4).group_ids, &v0);
        };
        0x1::vector::destroy_empty<u16>(arg4);
    }

    public fun get_address_book_fields(arg0: &AddressBook) : (&0x2::vec_map::VecMap<u16, Address>, &0x2::vec_map::VecMap<u16, AddressGroup>, u16) {
        (&arg0.addresses, &arg0.address_groups, arg0.address_id_counter)
    }

    public fun get_address_fields(arg0: &Address) : (0x1::string::String, 0x2::vec_set::VecSet<u16>, vector<u8>, 0x2::vec_set::VecSet<0x1::string::String>) {
        (arg0.name, arg0.group_ids, arg0.address_, arg0.network_ids)
    }

    public fun get_address_group_fields(arg0: &AddressGroup) : (0x1::string::String, 0x2::vec_set::VecSet<u16>) {
        (arg0.name, arg0.address_ids)
    }

    public(friend) fun get_address_group_ids(arg0: &AddressBook, arg1: u16) : vector<u16> {
        if (0x2::vec_map::contains<u16, Address>(&arg0.addresses, &arg1)) {
            return *0x2::vec_set::keys<u16>(&0x2::vec_map::get<u16, Address>(&arg0.addresses, &arg1).group_ids)
        };
        0x1::vector::empty<u16>()
    }

    public(friend) fun get_address_ids_by_address(arg0: &AddressBook, arg1: 0x1df31a5616e2b33135f685e0aecd4ed7cb563de253269ba7e808946c71b24d90::library::NetworkAddress) : vector<u16> {
        let v0 = 0x1::vector::empty<u16>();
        let v1 = 0x2::vec_map::keys<u16, Address>(&arg0.addresses);
        0x1::vector::reverse<u16>(&mut v1);
        while (!0x1::vector::is_empty<u16>(&v1)) {
            let v2 = 0x1::vector::pop_back<u16>(&mut v1);
            let v3 = 0x2::vec_map::get<u16, Address>(&arg0.addresses, &v2);
            let v4 = 0x1df31a5616e2b33135f685e0aecd4ed7cb563de253269ba7e808946c71b24d90::library::get_address_raw(&arg1);
            let v5 = v3.address_;
            let v6 = if (&v4 == &v5) {
                let v7 = 0x1df31a5616e2b33135f685e0aecd4ed7cb563de253269ba7e808946c71b24d90::library::get_network_id(&arg1);
                0x2::vec_set::contains<0x1::string::String>(&v3.network_ids, &v7)
            } else {
                false
            };
            if (v6) {
                0x1::vector::push_back<u16>(&mut v0, v2);
            };
        };
        0x1::vector::destroy_empty<u16>(v1);
        v0
    }

    public(friend) fun init_address_book() : AddressBook {
        AddressBook{
            addresses          : 0x2::vec_map::empty<u16, Address>(),
            address_groups     : 0x2::vec_map::empty<u16, AddressGroup>(),
            address_id_counter : 0,
        }
    }

    public(friend) fun is_address_group_in_address_book(arg0: &AddressBook, arg1: u16) : bool {
        0x2::vec_map::contains<u16, AddressGroup>(&arg0.address_groups, &arg1)
    }

    public(friend) fun is_address_in_address_book(arg0: &AddressBook, arg1: u16) : bool {
        0x2::vec_map::contains<u16, Address>(&arg0.addresses, &arg1)
    }

    public(friend) fun is_address_in_any_group(arg0: &AddressBook, arg1: u16) : bool {
        !0x2::vec_set::is_empty<u16>(&0x2::vec_map::get<u16, Address>(&arg0.addresses, &arg1).group_ids)
    }

    // decompiled from Move bytecode v6
}

