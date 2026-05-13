module 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::delegate_bridge {
    struct DelegateRotated has copy, drop {
        pack_id: 0x2::object::ID,
        new_delegate: address,
        rotated_by: address,
    }

    public fun rotate_memwal_delegate(arg0: &mut 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::MemoryPack, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::set_memwal_delegate(arg0, arg1);
        let v0 = DelegateRotated{
            pack_id      : 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_nft::id(arg0),
            new_delegate : arg1,
            rotated_by   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<DelegateRotated>(v0);
    }

    // decompiled from Move bytecode v7
}

