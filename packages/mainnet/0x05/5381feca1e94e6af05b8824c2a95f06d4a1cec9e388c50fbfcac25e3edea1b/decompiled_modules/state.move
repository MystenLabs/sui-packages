module 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state {
    struct Storage has store, key {
        id: 0x2::object::UID,
        global: 0x2::vec_map::VecMap<0x1::string::String, u256>,
        local: 0x2::table::Table<address, 0x2::vec_map::VecMap<0x1::string::String, u256>>,
    }

    public(friend) fun decrement_global_value(arg0: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg1: 0x1::string::String, arg2: u256) {
        let v0 = 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::get_value<Storage>(arg0, storage_bag_index());
        if (!0x2::vec_map::contains<0x1::string::String, u256>(&v0.global, &arg1)) {
            0x2::vec_map::insert<0x1::string::String, u256>(&mut v0.global, arg1, 0);
        };
        let v1 = 0x2::vec_map::get_mut<0x1::string::String, u256>(&mut v0.global, &arg1);
        *v1 = *v1 - arg2;
    }

    public(friend) fun decrement_local_value(arg0: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg1: address, arg2: 0x1::string::String, arg3: u256) {
        let v0 = 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::get_value<Storage>(arg0, storage_bag_index());
        if (!0x2::table::contains<address, 0x2::vec_map::VecMap<0x1::string::String, u256>>(&v0.local, arg1)) {
            0x2::table::add<address, 0x2::vec_map::VecMap<0x1::string::String, u256>>(&mut v0.local, arg1, 0x2::vec_map::empty<0x1::string::String, u256>());
        };
        if (!0x2::vec_map::contains<0x1::string::String, u256>(0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<0x1::string::String, u256>>(&mut v0.local, arg1), &arg2)) {
            0x2::vec_map::insert<0x1::string::String, u256>(0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<0x1::string::String, u256>>(&mut v0.local, arg1), arg2, 0);
        };
        let v1 = 0x2::vec_map::get_mut<0x1::string::String, u256>(0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<0x1::string::String, u256>>(&mut v0.local, arg1), &arg2);
        *v1 = *v1 - arg3;
    }

    public(friend) fun get_global_value(arg0: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg1: 0x1::string::String) : u256 {
        let v0 = 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::get_value<Storage>(arg0, storage_bag_index());
        if (!0x2::vec_map::contains<0x1::string::String, u256>(&v0.global, &arg1)) {
            0x2::vec_map::insert<0x1::string::String, u256>(&mut v0.global, arg1, 0);
        };
        *0x2::vec_map::get<0x1::string::String, u256>(&v0.global, &arg1)
    }

    public(friend) fun get_local_value(arg0: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg1: address, arg2: 0x1::string::String) : u256 {
        let v0 = 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::get_value<Storage>(arg0, storage_bag_index());
        if (!0x2::table::contains<address, 0x2::vec_map::VecMap<0x1::string::String, u256>>(&v0.local, arg1)) {
            0x2::table::add<address, 0x2::vec_map::VecMap<0x1::string::String, u256>>(&mut v0.local, arg1, 0x2::vec_map::empty<0x1::string::String, u256>());
        };
        if (!0x2::vec_map::contains<0x1::string::String, u256>(0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<0x1::string::String, u256>>(&mut v0.local, arg1), &arg2)) {
            0x2::vec_map::insert<0x1::string::String, u256>(0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<0x1::string::String, u256>>(&mut v0.local, arg1), arg2, 0);
        };
        *0x2::vec_map::get<0x1::string::String, u256>(0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<0x1::string::String, u256>>(&mut v0.local, arg1), &arg2)
    }

    entry fun global(arg0: address, arg1: 0x1::string::String, arg2: u256, arg3: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::tx_context::sender(arg4), 13906834324667236351);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::validate_admin(arg3, arg0);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::validate_version(arg3);
        set_global_value(arg3, arg1, arg2);
    }

    public(friend) fun increment_global_value(arg0: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg1: 0x1::string::String, arg2: u256) {
        let v0 = 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::get_value<Storage>(arg0, storage_bag_index());
        if (!0x2::vec_map::contains<0x1::string::String, u256>(&v0.global, &arg1)) {
            0x2::vec_map::insert<0x1::string::String, u256>(&mut v0.global, arg1, 0);
        };
        let v1 = 0x2::vec_map::get_mut<0x1::string::String, u256>(&mut v0.global, &arg1);
        *v1 = *v1 + arg2;
    }

    public(friend) fun increment_local_value(arg0: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg1: address, arg2: 0x1::string::String, arg3: u256) {
        let v0 = 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::get_value<Storage>(arg0, storage_bag_index());
        if (!0x2::table::contains<address, 0x2::vec_map::VecMap<0x1::string::String, u256>>(&v0.local, arg1)) {
            0x2::table::add<address, 0x2::vec_map::VecMap<0x1::string::String, u256>>(&mut v0.local, arg1, 0x2::vec_map::empty<0x1::string::String, u256>());
        };
        if (!0x2::vec_map::contains<0x1::string::String, u256>(0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<0x1::string::String, u256>>(&mut v0.local, arg1), &arg2)) {
            0x2::vec_map::insert<0x1::string::String, u256>(0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<0x1::string::String, u256>>(&mut v0.local, arg1), arg2, 0);
        };
        let v1 = 0x2::vec_map::get_mut<0x1::string::String, u256>(0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<0x1::string::String, u256>>(&mut v0.local, arg1), &arg2);
        *v1 = *v1 + arg3;
    }

    entry fun local(arg0: address, arg1: address, arg2: 0x1::string::String, arg3: u256, arg4: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::tx_context::sender(arg5), 13906834359026974719);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::validate_admin(arg4, arg0);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::validate_version(arg4);
        set_local_value(arg4, arg1, arg2, arg3);
    }

    public(friend) fun set_global_value(arg0: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg1: 0x1::string::String, arg2: u256) {
        let v0 = 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::get_value<Storage>(arg0, storage_bag_index());
        if (!0x2::vec_map::contains<0x1::string::String, u256>(&v0.global, &arg1)) {
            0x2::vec_map::insert<0x1::string::String, u256>(&mut v0.global, arg1, 0);
        };
        *0x2::vec_map::get_mut<0x1::string::String, u256>(&mut v0.global, &arg1) = arg2;
    }

    public(friend) fun set_local_value(arg0: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg1: address, arg2: 0x1::string::String, arg3: u256) {
        let v0 = 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::get_value<Storage>(arg0, storage_bag_index());
        if (!0x2::table::contains<address, 0x2::vec_map::VecMap<0x1::string::String, u256>>(&v0.local, arg1)) {
            0x2::table::add<address, 0x2::vec_map::VecMap<0x1::string::String, u256>>(&mut v0.local, arg1, 0x2::vec_map::empty<0x1::string::String, u256>());
        };
        if (!0x2::vec_map::contains<0x1::string::String, u256>(0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<0x1::string::String, u256>>(&mut v0.local, arg1), &arg2)) {
            0x2::vec_map::insert<0x1::string::String, u256>(0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<0x1::string::String, u256>>(&mut v0.local, arg1), arg2, 0);
        };
        *0x2::vec_map::get_mut<0x1::string::String, u256>(0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<0x1::string::String, u256>>(&mut v0.local, arg1), &arg2) = arg3;
    }

    entry fun setup(arg0: address, arg1: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::tx_context::sender(arg2), 13906834251652792319);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::validate_admin(arg1, arg0);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::validate_version(arg1);
        if (!0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::has_value(arg1, storage_bag_index())) {
            let v0 = Storage{
                id     : 0x2::object::new(arg2),
                global : 0x2::vec_map::empty<0x1::string::String, u256>(),
                local  : 0x2::table::new<address, 0x2::vec_map::VecMap<0x1::string::String, u256>>(arg2),
            };
            0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::add_value<Storage>(arg1, storage_bag_index(), v0);
        };
    }

    public(friend) fun setup_storage(arg0: &mut 0x2::tx_context::TxContext) : Storage {
        Storage{
            id     : 0x2::object::new(arg0),
            global : 0x2::vec_map::empty<0x1::string::String, u256>(),
            local  : 0x2::table::new<address, 0x2::vec_map::VecMap<0x1::string::String, u256>>(arg0),
        }
    }

    fun storage_bag_index() : 0x1::string::String {
        0x1::string::utf8(b"state_storage")
    }

    // decompiled from Move bytecode v6
}

