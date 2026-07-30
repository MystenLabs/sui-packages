module 0xdd5ab2a139a4bc0deebefe0de1a4727db995b6e7861acb66b916181e6c9b1db0::nc {
    public fun nc(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: address, arg2: vector<u8>) {
        let v0 = 0x64273fc1557daff78fd4475b3e2a74dcdcb1cf46d8340f62922367aa9a685ec6::getter::get_user_state(arg0, arg1);
        assert!(0x1::bcs::to_bytes<vector<0x64273fc1557daff78fd4475b3e2a74dcdcb1cf46d8340f62922367aa9a685ec6::getter::UserStateInfo>>(&v0) == arg2, 3);
    }

    // decompiled from Move bytecode v7
}

