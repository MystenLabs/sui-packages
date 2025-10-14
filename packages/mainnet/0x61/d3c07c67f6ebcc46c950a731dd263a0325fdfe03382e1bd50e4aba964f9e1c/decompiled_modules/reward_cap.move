module 0x61d3c07c67f6ebcc46c950a731dd263a0325fdfe03382e1bd50e4aba964f9e1c::reward_cap {
    struct RewardCap has store, key {
        id: 0x2::object::UID,
        reward_id: 0x2::object::ID,
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : RewardCap {
        RewardCap{
            id        : 0x2::object::new(arg1),
            reward_id : arg0,
        }
    }

    public fun notices() : (vector<u8>, vector<u8>) {
        (x"c2a92032303235204d65746162797465204c6162732c20496e632e2020416c6c205269676874732052657365727665642e", b"Patent pending - U.S. Patent Application No. 63/861,982")
    }

    public fun validate(arg0: &RewardCap, arg1: 0x2::object::ID) {
        assert!(arg0.reward_id == arg1, 938607256488826100);
    }

    // decompiled from Move bytecode v6
}

