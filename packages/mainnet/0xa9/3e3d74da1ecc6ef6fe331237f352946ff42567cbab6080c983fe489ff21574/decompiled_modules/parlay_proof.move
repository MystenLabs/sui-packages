module 0xa93e3d74da1ecc6ef6fe331237f352946ff42567cbab6080c983fe489ff21574::parlay_proof {
    struct Proof has key {
        id: 0x2::object::UID,
        creator: address,
        data_hash: vector<u8>,
        created_at: u64,
    }

    public entry fun create_proof(arg0: vector<u8>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 1);
        let v0 = Proof{
            id         : 0x2::object::new(arg2),
            creator    : 0x2::tx_context::sender(arg2),
            data_hash  : arg0,
            created_at : arg1,
        };
        0x2::transfer::freeze_object<Proof>(v0);
    }

    // decompiled from Move bytecode v6
}

