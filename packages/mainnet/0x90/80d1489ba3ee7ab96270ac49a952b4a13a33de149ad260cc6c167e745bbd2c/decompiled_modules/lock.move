module 0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::lock {
    struct LockedNFT<T0: store + key> has key {
        id: 0x2::object::UID,
        nft: T0,
        locked_at: u64,
        lock_duration: u64,
    }

    struct LockNFTEvent has copy, drop {
        lock_nft_id: 0x2::object::ID,
        nft_type_name: 0x1::type_name::TypeName,
        recipient: address,
        locked_at: u64,
        lock_duration: u64,
    }

    struct UnLockNFTEvent has copy, drop {
        lock_nft_id: 0x2::object::ID,
        nft_type_name: 0x1::type_name::TypeName,
        recipient: address,
        locked_at: u64,
        lock_duration: u64,
        unlocked_at: u64,
    }

    public entry fun lock_nft_to<T0: store + key>(arg0: T0, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v1 = LockedNFT<T0>{
            id            : 0x2::object::new(arg4),
            nft           : arg0,
            locked_at     : v0,
            lock_duration : arg2,
        };
        let v2 = LockNFTEvent{
            lock_nft_id   : 0x2::object::id<LockedNFT<T0>>(&v1),
            nft_type_name : 0x1::type_name::get<T0>(),
            recipient     : arg1,
            locked_at     : v0,
            lock_duration : arg2,
        };
        0x2::transfer::transfer<LockedNFT<T0>>(v1, arg1);
        0x2::event::emit<LockNFTEvent>(v2);
    }

    public entry fun unlock_nft<T0: store + key>(arg0: LockedNFT<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(v0 - arg0.locked_at >= arg0.lock_duration, 1);
        let v1 = UnLockNFTEvent{
            lock_nft_id   : 0x2::object::id<LockedNFT<T0>>(&arg0),
            nft_type_name : 0x1::type_name::get<T0>(),
            recipient     : 0x2::tx_context::sender(arg2),
            locked_at     : arg0.locked_at,
            lock_duration : arg0.lock_duration,
            unlocked_at   : v0,
        };
        0x2::event::emit<UnLockNFTEvent>(v1);
        let LockedNFT {
            id            : v2,
            nft           : v3,
            locked_at     : _,
            lock_duration : _,
        } = arg0;
        0x2::transfer::public_transfer<T0>(v3, 0x2::tx_context::sender(arg2));
        0x2::object::delete(v2);
    }

    // decompiled from Move bytecode v6
}

