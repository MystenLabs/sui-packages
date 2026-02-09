module 0x37f25bfdea5fbbd29614c89151dce789f5823db74c38c95e45b15d0f68967bd::main {
    struct Feed has store, key {
        id: 0x2::object::UID,
    }

    public fun give_for_god(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, arg1: &mut 0x2::tx_context::TxContext) : Feed {
        let v0 = 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(arg0);
        assert!(0x2::object::id_to_address(&v0) == @0xf1c5a414deca15acd1bfb7e75b0c59a9aa63a90502f7af3ade3f3790435db1a2, 0);
        Feed{id: 0x2::object::new(arg1)}
    }

    // decompiled from Move bytecode v6
}

