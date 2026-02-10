module 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::walrus_context {
    struct WalrusContext has drop {
        epoch: u32,
        committee_selected: bool,
        committee: 0x2::vec_map::VecMap<0x2::object::ID, vector<u16>>,
    }

    public(friend) fun committee(arg0: &WalrusContext) : &0x2::vec_map::VecMap<0x2::object::ID, vector<u16>> {
        &arg0.committee
    }

    public(friend) fun committee_selected(arg0: &WalrusContext) : bool {
        arg0.committee_selected
    }

    public(friend) fun epoch(arg0: &WalrusContext) : u32 {
        arg0.epoch
    }

    public(friend) fun new(arg0: u32, arg1: bool, arg2: 0x2::vec_map::VecMap<0x2::object::ID, vector<u16>>) : WalrusContext {
        WalrusContext{
            epoch              : arg0,
            committee_selected : arg1,
            committee          : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

