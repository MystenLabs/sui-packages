module 0xc5350fc5994c884a77208c42b20790b31350679dc9fe2c5ef1b52cd87490ee1::nc {
    public fun nc(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: address, arg2: vector<u8>) {
        let v0 = 0x64273fc1557daff78fd4475b3e2a74dcdcb1cf46d8340f62922367aa9a685ec6::getter::get_user_state(arg0, arg1);
        assert!(0x1::bcs::to_bytes<vector<0x64273fc1557daff78fd4475b3e2a74dcdcb1cf46d8340f62922367aa9a685ec6::getter::UserStateInfo>>(&v0) == arg2, 3);
    }

    // decompiled from Move bytecode v7
}

