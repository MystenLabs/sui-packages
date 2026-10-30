module 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::policies {
    struct PolicyLock has key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
    }

    struct AvatarCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CardCapKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun create_and_lock<T0, T1>(arg0: 0x2::package::Publisher, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<PolicyLock>(&arg0), 900);
        let (v0, v1) = 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::royalty::new_policy<0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::Avatar<T0>, T1>(&arg0, arg1, arg3);
        let (v2, v3) = 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::royalty::new_policy<0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::MemoryCard, T1>(&arg0, arg2, arg3);
        let v4 = PolicyLock{
            id        : 0x2::object::new(arg3),
            publisher : arg0,
        };
        let v5 = AvatarCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<AvatarCapKey, 0x2::transfer_policy::TransferPolicyCap<0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::Avatar<T0>>>(&mut v4.id, v5, v1);
        let v6 = CardCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<CardCapKey, 0x2::transfer_policy::TransferPolicyCap<0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::MemoryCard>>(&mut v4.id, v6, v3);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::Avatar<T0>>>(v0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::avatar::MemoryCard>>(v2);
        0x2::transfer::freeze_object<PolicyLock>(v4);
    }

    // decompiled from Move bytecode v7
}

