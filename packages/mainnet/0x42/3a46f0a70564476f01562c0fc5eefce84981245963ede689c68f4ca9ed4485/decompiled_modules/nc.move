module 0x423a46f0a70564476f01562c0fc5eefce84981245963ede689c68f4ca9ed4485::nc {
    public fun nc(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: address, arg2: vector<u8>) {
        let v0 = 0xa1357e2e9c28f90e76b085abb81f7ce3e59b699100687bbc3910c7e9f27bb7c8::getter::get_user_state(arg0, arg1);
        assert!(0x1::bcs::to_bytes<vector<0xa1357e2e9c28f90e76b085abb81f7ce3e59b699100687bbc3910c7e9f27bb7c8::getter::UserStateInfo>>(&v0) == arg2, 3);
    }

    // decompiled from Move bytecode v7
}

