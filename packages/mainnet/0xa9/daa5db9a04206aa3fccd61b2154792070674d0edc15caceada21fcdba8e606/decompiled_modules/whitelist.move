module 0xa9daa5db9a04206aa3fccd61b2154792070674d0edc15caceada21fcdba8e606::whitelist {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct WhitelistStorage has key {
        id: 0x2::object::UID,
        accounts: 0x2::vec_map::VecMap<address, bool>,
    }

    public entry fun add_whitelist(arg0: &AdminCap, arg1: &mut WhitelistStorage, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::vec_map::contains<address, bool>(&arg1.accounts, &arg2), 0);
        0x2::vec_map::insert<address, bool>(&mut arg1.accounts, arg2, true);
    }

    public entry fun hard_remove_whitelist(arg0: &AdminCap, arg1: &mut WhitelistStorage, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<address, bool>(&arg1.accounts, &arg2), 1);
        let (_, _) = 0x2::vec_map::remove<address, bool>(&mut arg1.accounts, &arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = WhitelistStorage{
            id       : 0x2::object::new(arg0),
            accounts : 0x2::vec_map::empty<address, bool>(),
        };
        0x2::transfer::share_object<WhitelistStorage>(v1);
    }

    public fun is_whitelist(arg0: &WhitelistStorage, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : bool {
        0x2::vec_map::contains<address, bool>(&arg0.accounts, &arg1) && *0x2::vec_map::get<address, bool>(&arg0.accounts, &arg1)
    }

    public entry fun soft_remove_whitelist(arg0: &AdminCap, arg1: &mut WhitelistStorage, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<address, bool>(&arg1.accounts, &arg2), 1);
        *0x2::vec_map::get_mut<address, bool>(&mut arg1.accounts, &arg2) = false;
    }

    // decompiled from Move bytecode v6
}

