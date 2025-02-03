module 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::tier_registry {
    struct TierRegistry has store, key {
        id: 0x2::object::UID,
        registry: 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::TableKeys<0x2::object::ID, 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::tier::Tier>,
    }

    public(friend) fun add_tier(arg0: &mut TierRegistry, arg1: 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::tier::Tier) {
        0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::add_key_value_pair<0x2::object::ID, 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::tier::Tier>(&mut arg0.registry, 0x2::object::id<0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::tier::Tier>(&arg1), arg1);
    }

    public(friend) fun borrow_mut_tier(arg0: &mut TierRegistry, arg1: 0x2::object::ID) : &mut 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::tier::Tier {
        0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::borrow_mut_table<0x2::object::ID, 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::tier::Tier>(&mut arg0.registry, arg1)
    }

    public fun borrow_tier(arg0: &TierRegistry, arg1: 0x2::object::ID) : &0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::tier::Tier {
        0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::borrow_table<0x2::object::ID, 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::tier::Tier>(&arg0.registry, arg1)
    }

    public(friend) fun initialize(arg0: &mut 0x2::tx_context::TxContext) : TierRegistry {
        TierRegistry{
            id       : 0x2::object::new(arg0),
            registry : 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::new<0x2::object::ID, 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::tier::Tier>(arg0),
        }
    }

    public fun tier_exists(arg0: &TierRegistry, arg1: 0x2::object::ID) : bool {
        0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::is_present<0x2::object::ID, 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::tier::Tier>(&arg0.registry, arg1)
    }

    // decompiled from Move bytecode v6
}

