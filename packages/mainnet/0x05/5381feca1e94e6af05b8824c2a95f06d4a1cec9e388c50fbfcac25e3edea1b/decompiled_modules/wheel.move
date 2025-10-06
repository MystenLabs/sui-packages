module 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::wheel {
    struct Histogram has store, key {
        id: 0x2::object::UID,
        values: 0x2::vec_map::VecMap<u256, u256>,
    }

    public(friend) fun get_random(arg0: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) : u256 {
        let v0 = 0x2::random::new_generator(arg1, arg2);
        let v1 = 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::to_u256(0x2::random::generate_u64_in_range(&mut v0, 0, 99));
        let v2 = 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::get_value<Histogram>(arg0, histogram_bag_index());
        if (!0x2::vec_map::contains<u256, u256>(&v2.values, &v1)) {
            0x2::vec_map::insert<u256, u256>(&mut v2.values, v1, 0);
        };
        let v3 = 0x2::vec_map::get_mut<u256, u256>(&mut v2.values, &v1);
        *v3 = *v3 + 1;
        v1
    }

    fun histogram_bag_index() : 0x1::string::String {
        0x1::string::utf8(b"wheel_histogram")
    }

    public(friend) fun random_max() : u256 {
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::to_u256(99)
    }

    public(friend) fun random_min() : u256 {
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::to_u256(0)
    }

    entry fun setup(arg0: address, arg1: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::tx_context::sender(arg2), 13906834264537694207);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::validate_admin(arg1, arg0);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::validate_version(arg1);
        if (!0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::has_value(arg1, histogram_bag_index())) {
            let v0 = Histogram{
                id     : 0x2::object::new(arg2),
                values : 0x2::vec_map::empty<u256, u256>(),
            };
            0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::add_value<Histogram>(arg1, histogram_bag_index(), v0);
        };
    }

    // decompiled from Move bytecode v6
}

