module 0xcae9635a379e716252e079942475ec7f8020f33a7a15a9291a990e6568e709e::blockbolt_coin {
    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct CombinedStorage has store, key {
        id: 0x2::object::UID,
        entries: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public entry fun add_update_entry(arg0: &OwnerCap, arg1: &mut CombinedStorage, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg1.entries, &arg2)) {
            *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg1.entries, &arg2) = arg3;
        } else {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg1.entries, arg2, arg3);
        };
    }

    public fun contains_entry(arg0: &CombinedStorage, arg1: &0x1::string::String) : bool {
        0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.entries, arg1)
    }

    public fun get_all_keys(arg0: &CombinedStorage) : vector<0x1::string::String> {
        0x2::vec_map::keys<0x1::string::String, 0x1::string::String>(&arg0.entries)
    }

    public fun get_entry(arg0: &CombinedStorage, arg1: 0x1::string::String) : 0x1::string::String {
        assert!(0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.entries, &arg1), 1);
        *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg0.entries, &arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = CombinedStorage{
            id      : 0x2::object::new(arg0),
            entries : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        };
        0x2::transfer::share_object<CombinedStorage>(v1);
    }

    public entry fun remove_entry(arg0: &OwnerCap, arg1: &mut CombinedStorage, arg2: 0x1::string::String) {
        assert!(0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg1.entries, &arg2), 1);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg1.entries, &arg2);
    }

    // decompiled from Move bytecode v6
}

