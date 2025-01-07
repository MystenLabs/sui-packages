module 0x5ccc4f8e12c2014f0246d35cc7ee5993f2fdfc86161478ff135e59fad9ef4cfa::allocator {
    struct Pool_info has store {
        rewards: 0x2::bag::Bag,
        weights: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct Allocator has store, key {
        id: 0x2::object::UID,
        total_weights: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        members: 0x2::vec_map::VecMap<0x2::object::ID, Pool_info>,
        rewards: 0x2::bag::Bag,
        last_update_time: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    // decompiled from Move bytecode v6
}

