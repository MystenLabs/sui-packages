module 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::lock {
    struct LockedNFT<T0: store + key> has key {
        id: 0x2::object::UID,
        nft: T0,
        locked_time: u64,
        end_lock_time: u64,
    }

    struct LockNFTEvent has copy, drop, store {
        lock_nft_id: 0x2::object::ID,
        nft_type_name: 0x1::type_name::TypeName,
        recipient: address,
        locked_time: u64,
        end_lock_time: u64,
    }

    struct UnLockNFTEvent has copy, drop, store {
        lock_nft_id: 0x2::object::ID,
        recipient: address,
        locked_time: u64,
        unlock_time: u64,
    }

    public entry fun lock_nft_to<T0: store + key>(arg0: T0, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg4);
        let v1 = 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::utils::current_time(arg3);
        let v2 = v1 + arg2;
        let v3 = LockedNFT<T0>{
            id            : v0,
            nft           : arg0,
            locked_time   : v1,
            end_lock_time : v2,
        };
        0x2::transfer::transfer<LockedNFT<T0>>(v3, arg1);
        let v4 = LockNFTEvent{
            lock_nft_id   : 0x2::object::uid_to_inner(&v0),
            nft_type_name : 0x1::type_name::get<T0>(),
            recipient     : arg1,
            locked_time   : v1,
            end_lock_time : v2,
        };
        0x2::event::emit<LockNFTEvent>(v4);
    }

    public entry fun unlock_nft<T0: store + key>(arg0: LockedNFT<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let LockedNFT {
            id            : v0,
            nft           : v1,
            locked_time   : v2,
            end_lock_time : v3,
        } = arg0;
        let v4 = v0;
        let v5 = 0x2::tx_context::sender(arg2);
        let v6 = 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::utils::current_time(arg1);
        assert!(v6 >= v3, 1);
        0x2::object::delete(v4);
        0x2::transfer::public_transfer<T0>(v1, v5);
        let v7 = UnLockNFTEvent{
            lock_nft_id : 0x2::object::uid_to_inner(&v4),
            recipient   : v5,
            locked_time : v2,
            unlock_time : v6,
        };
        0x2::event::emit<UnLockNFTEvent>(v7);
    }

    // decompiled from Move bytecode v6
}

