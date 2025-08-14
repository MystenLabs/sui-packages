module 0xb166d456b6d86e16aa4c2dc473ce94cf0f9a8a753878f8062b52fa654d3abfb4::fins_access {
    struct AccessRegistry has key {
        id: 0x2::object::UID,
        permissions: 0x2::table::Table<vector<u8>, 0x2::table::Table<address, bool>>,
        unlocked_content: 0x2::table::Table<address, vector<vector<u8>>>,
    }

    public fun has_access(arg0: &AccessRegistry, arg1: address, arg2: vector<u8>) : bool {
        if (!0x2::table::contains<address, vector<vector<u8>>>(&arg0.unlocked_content, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<address, vector<vector<u8>>>(&arg0.unlocked_content, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(v0)) {
            if (*0x1::vector::borrow<vector<u8>>(v0, v1) == arg2) {
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AccessRegistry{
            id               : 0x2::object::new(arg0),
            permissions      : 0x2::table::new<vector<u8>, 0x2::table::Table<address, bool>>(arg0),
            unlocked_content : 0x2::table::new<address, vector<vector<u8>>>(arg0),
        };
        0x2::transfer::share_object<AccessRegistry>(v0);
    }

    public entry fun seal_approve_access(arg0: vector<u8>, arg1: &mut AccessRegistry, arg2: &0xb166d456b6d86e16aa4c2dc473ce94cf0f9a8a753878f8062b52fa654d3abfb4::nft::AccessPass, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(valid(arg0), 2);
        assert!(verify_ownership(arg2, v0), 1);
        if (!0x2::table::contains<address, vector<vector<u8>>>(&arg1.unlocked_content, v0)) {
            0x2::table::add<address, vector<vector<u8>>>(&mut arg1.unlocked_content, v0, 0x1::vector::empty<vector<u8>>());
        };
        0x1::vector::push_back<vector<u8>>(0x2::table::borrow_mut<address, vector<vector<u8>>>(&mut arg1.unlocked_content, v0), arg0);
    }

    fun valid(arg0: vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(&arg0);
        v0 > 0 && v0 <= 128
    }

    fun verify_ownership(arg0: &0xb166d456b6d86e16aa4c2dc473ce94cf0f9a8a753878f8062b52fa654d3abfb4::nft::AccessPass, arg1: address) : bool {
        true
    }

    // decompiled from Move bytecode v6
}

