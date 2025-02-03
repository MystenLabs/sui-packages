module 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::tier_registry {
    struct TierRegistry has store, key {
        id: 0x2::object::UID,
        registry: 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::table_keys::TableKeys<0x2::object::ID, 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::tier::Tier>,
    }

    public(friend) fun add_tier(arg0: &mut TierRegistry, arg1: 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::tier::Tier) {
        0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::table_keys::add_key_value_pair<0x2::object::ID, 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::tier::Tier>(&mut arg0.registry, 0x2::object::id<0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::tier::Tier>(&arg1), arg1);
    }

    public(friend) fun borrow_mut_tier(arg0: &mut TierRegistry, arg1: 0x2::object::ID) : &mut 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::tier::Tier {
        0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::table_keys::borrow_mut_table<0x2::object::ID, 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::tier::Tier>(&mut arg0.registry, arg1)
    }

    public fun borrow_tier(arg0: &TierRegistry, arg1: 0x2::object::ID) : &0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::tier::Tier {
        0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::table_keys::borrow_table<0x2::object::ID, 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::tier::Tier>(&arg0.registry, arg1)
    }

    public(friend) fun initialize(arg0: &mut 0x2::tx_context::TxContext) : TierRegistry {
        TierRegistry{
            id       : 0x2::object::new(arg0),
            registry : 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::table_keys::new<0x2::object::ID, 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::tier::Tier>(arg0),
        }
    }

    public fun tier_exists(arg0: &TierRegistry, arg1: 0x2::object::ID) : bool {
        0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::table_keys::is_present<0x2::object::ID, 0xcaf3074df34e92af55fa51b962fd76c525e22294abbb260586725149fbe8c7df::tier::Tier>(&arg0.registry, arg1)
    }

    // decompiled from Move bytecode v6
}

