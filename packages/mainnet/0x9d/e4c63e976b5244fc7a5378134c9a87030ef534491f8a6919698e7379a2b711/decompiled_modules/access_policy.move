module 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::access_policy {
    struct SealAccessGranted has copy, drop {
        pack_id: 0x2::object::ID,
        walrus_blob_id: 0x2::object::ID,
        caller: address,
    }

    public fun seal_approve_for_blob(arg0: &0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::MemoryPack, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::memwal_delegate(arg0), 1);
        let v0 = SealAccessGranted{
            pack_id        : 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::id(arg0),
            walrus_blob_id : arg1,
            caller         : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<SealAccessGranted>(v0);
    }

    // decompiled from Move bytecode v7
}

