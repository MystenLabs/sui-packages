module 0x86f75540a632674fd21f5956eee8c3a00e340e4fbf4a0a4453ba3ebc6d712edc::allocator {
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

