module 0x3f3d8e7c5048f10fcecb3c3004760e91c25499b4ab87569f496c3f0050c48d2b::walrus_context {
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

