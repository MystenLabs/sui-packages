module 0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::config {
    struct CutoffKey has copy, drop, store {
        pos0: u8,
    }

    struct SeedKey has copy, drop, store {
        pos0: u8,
    }

    struct FeedKey has copy, drop, store {
        pos0: 0x1::string::String,
    }

    public(friend) fun add_feed(arg0: &mut 0x2::object::UID, arg1: 0x1::string::String, arg2: vector<u8>) {
        let v0 = FeedKey{pos0: arg1};
        0x2::dynamic_field::add<FeedKey, vector<u8>>(arg0, v0, arg2);
    }

    public(friend) fun get_cutoff(arg0: &0x2::object::UID, arg1: u8) : u64 {
        let v0 = CutoffKey{pos0: arg1};
        *0x2::dynamic_field::borrow<CutoffKey, u64>(arg0, v0)
    }

    public(friend) fun get_feed(arg0: &0x2::object::UID, arg1: &0x1::string::String) : &vector<u8> {
        let v0 = FeedKey{pos0: *arg1};
        0x2::dynamic_field::borrow<FeedKey, vector<u8>>(arg0, v0)
    }

    public(friend) fun get_seed(arg0: &0x2::object::UID, arg1: u8) : u64 {
        let v0 = SeedKey{pos0: arg1};
        *0x2::dynamic_field::borrow<SeedKey, u64>(arg0, v0)
    }

    public(friend) fun has_feed(arg0: &0x2::object::UID, arg1: &0x1::string::String) : bool {
        let v0 = FeedKey{pos0: *arg1};
        0x2::dynamic_field::exists_<FeedKey>(arg0, v0)
    }

    public(friend) fun init_cutoffs(arg0: &mut 0x2::object::UID) {
        let v0 = CutoffKey{pos0: 0};
        0x2::dynamic_field::add<CutoffKey, u64>(arg0, v0, 180000);
        let v1 = CutoffKey{pos0: 1};
        0x2::dynamic_field::add<CutoffKey, u64>(arg0, v1, 420000);
        let v2 = CutoffKey{pos0: 2};
        0x2::dynamic_field::add<CutoffKey, u64>(arg0, v2, 600000);
        let v3 = CutoffKey{pos0: 3};
        0x2::dynamic_field::add<CutoffKey, u64>(arg0, v3, 1800000);
        let v4 = CutoffKey{pos0: 4};
        0x2::dynamic_field::add<CutoffKey, u64>(arg0, v4, 3600000);
    }

    public(friend) fun init_seeds(arg0: &mut 0x2::object::UID) {
        let v0 = 200000000;
        let v1 = SeedKey{pos0: 0};
        0x2::dynamic_field::add<SeedKey, u64>(arg0, v1, v0);
        let v2 = SeedKey{pos0: 1};
        0x2::dynamic_field::add<SeedKey, u64>(arg0, v2, v0);
        let v3 = SeedKey{pos0: 2};
        0x2::dynamic_field::add<SeedKey, u64>(arg0, v3, v0);
        let v4 = SeedKey{pos0: 3};
        0x2::dynamic_field::add<SeedKey, u64>(arg0, v4, v0);
        let v5 = SeedKey{pos0: 4};
        0x2::dynamic_field::add<SeedKey, u64>(arg0, v5, v0);
    }

    public(friend) fun oracle_tolerance_ms(arg0: u8) : u64 {
        if (arg0 == 0) {
            120000
        } else if (arg0 == 1) {
            180000
        } else {
            300000
        }
    }

    public(friend) fun remove_feed(arg0: &mut 0x2::object::UID, arg1: 0x1::string::String) : vector<u8> {
        let v0 = FeedKey{pos0: arg1};
        0x2::dynamic_field::remove<FeedKey, vector<u8>>(arg0, v0)
    }

    public(friend) fun set_cutoff(arg0: &mut 0x2::object::UID, arg1: u8, arg2: u64) {
        let v0 = CutoffKey{pos0: arg1};
        *0x2::dynamic_field::borrow_mut<CutoffKey, u64>(arg0, v0) = arg2;
    }

    public(friend) fun set_seed(arg0: &mut 0x2::object::UID, arg1: u8, arg2: u64) {
        let v0 = SeedKey{pos0: arg1};
        *0x2::dynamic_field::borrow_mut<SeedKey, u64>(arg0, v0) = arg2;
    }

    // decompiled from Move bytecode v6
}

