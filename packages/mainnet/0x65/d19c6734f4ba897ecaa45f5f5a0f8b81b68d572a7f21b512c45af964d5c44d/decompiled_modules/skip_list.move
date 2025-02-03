module 0x65d19c6734f4ba897ecaa45f5f5a0f8b81b68d572a7f21b512c45af964d5c44d::skip_list {
    struct SkipList<phantom T0: store> has store, key {
        id: 0x2::object::UID,
        head: vector<0x65d19c6734f4ba897ecaa45f5f5a0f8b81b68d572a7f21b512c45af964d5c44d::option_u64::OptionU64>,
        tail: 0x65d19c6734f4ba897ecaa45f5f5a0f8b81b68d572a7f21b512c45af964d5c44d::option_u64::OptionU64,
        level: u64,
        max_level: u64,
        list_p: u64,
        size: u64,
        random: 0x65d19c6734f4ba897ecaa45f5f5a0f8b81b68d572a7f21b512c45af964d5c44d::random::Random,
    }

    // decompiled from Move bytecode v6
}

