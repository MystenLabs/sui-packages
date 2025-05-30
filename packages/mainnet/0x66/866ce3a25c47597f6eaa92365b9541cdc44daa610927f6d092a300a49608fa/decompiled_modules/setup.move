module 0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::setup {
    struct DeployerCap has store, key {
        id: 0x2::object::UID,
    }

    public fun complete(arg0: DeployerCap, arg1: 0x2::package::UpgradeCap, arg2: u16, arg3: vector<u8>, arg4: u32, arg5: vector<vector<u8>>, arg6: u32, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::package_utils::assert_package_upgrade_cap<DeployerCap>(&arg1, 0x2::package::compatible_policy(), 1);
        let DeployerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        let v1 = 0x1::vector::empty<0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::guardian::Guardian>();
        let v2 = 0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::cursor::new<vector<u8>>(arg5);
        while (!0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::cursor::is_empty<vector<u8>>(&v2)) {
            0x1::vector::push_back<0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::guardian::Guardian>(&mut v1, 0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::guardian::new(0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::cursor::poke<vector<u8>>(&mut v2)));
        };
        0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::cursor::destroy_empty<vector<u8>>(v2);
        0x2::transfer::public_share_object<0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::state::State>(0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::state::new(arg1, arg2, 0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::external_address::new_nonzero(0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::bytes32::from_bytes(arg3)), arg4, v1, arg6, arg7, arg8));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeployerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DeployerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

