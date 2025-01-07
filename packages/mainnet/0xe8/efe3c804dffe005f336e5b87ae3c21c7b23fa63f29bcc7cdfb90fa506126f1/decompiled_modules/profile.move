module 0xe8efe3c804dffe005f336e5b87ae3c21c7b23fa63f29bcc7cdfb90fa506126f1::profile {
    struct ProfileManager has store, key {
        id: 0x2::object::UID,
        profiles: 0x2::object_table::ObjectTable<address, Profile>,
    }

    struct Profile has store, key {
        id: 0x2::object::UID,
        address: address,
        linked_addresses: vector<address>,
        name: 0x1::string::String,
        avatar_url: 0x1::string::String,
        title: 0x1::string::String,
        bio: 0x1::string::String,
        links: vector<Links>,
        created_at: u64,
        updated_at: u64,
    }

    struct Links has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        icon: 0x1::string::String,
        url: 0x1::string::String,
    }

    // decompiled from Move bytecode v6
}

