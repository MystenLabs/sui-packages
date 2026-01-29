module 0xd1156d997bfd16640974bd94edc2d179fa3b349cb5e9640f43f4518fd25d4d02::allocator {
    struct AllocationPool has key {
        id: 0x2::object::UID,
        slots: 0x2::table::Table<0x1::ascii::String, QuotaConfig>,
        version: u8,
    }

    struct QuotaConfig has store {
        owner: address,
        manager: address,
        status: u8,
        primary_pool: address,
        overflow_pool: address,
        allocation_rate: u8,
        slots: 0x2::table::Table<0x2::object::ID, ResourceSlot>,
    }

    struct ResourceSlot has copy, drop, store {
        resource_class: 0x1::ascii::String,
        quota: u64,
        allocated: bool,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x1::ascii::String,
        owner: address,
    }

    struct SlotReserved has copy, drop {
        pool_id: 0x1::ascii::String,
        slot_id: 0x2::object::ID,
        resource_class: 0x1::ascii::String,
        quota: u64,
    }

    struct AllocationCompleted has copy, drop {
        pool_id: 0x1::ascii::String,
        slot_id: 0x2::object::ID,
        result_quota: u64,
    }

    public entry fun activate_pool(arg0: &mut AllocationPool, arg1: 0x1::ascii::String, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, QuotaConfig>(&arg0.slots, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, QuotaConfig>(&mut arg0.slots, arg1);
        assert!(0x2::tx_context::sender(arg3) == v0.owner, 100);
        if (arg2) {
            v0.status = v0.status | 1;
        } else {
            v0.status = v0.status & (255 ^ 1);
        };
    }

    public fun allocate_batch<T0>(arg0: &mut AllocationPool, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, QuotaConfig>(&arg0.slots, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, QuotaConfig>(&mut arg0.slots, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.manager, 100);
        let v2 = 0x2::coin::value<T0>(&arg3);
        if (v2 == 0 || !(v0.status & 1 != 0)) {
            if (v2 == 0) {
                0x2::coin::destroy_zero<T0>(arg3);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v1);
            };
            return
        };
        if (0x2::table::contains<0x2::object::ID, ResourceSlot>(&v0.slots, arg2)) {
            0x2::table::borrow_mut<0x2::object::ID, ResourceSlot>(&mut v0.slots, arg2).allocated = true;
        };
        let v3 = v2 * (v0.allocation_rate as u64) / 100;
        if (v3 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.overflow_pool);
        } else if (v3 == v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.primary_pool);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v3, arg4), v0.primary_pool);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.overflow_pool);
        };
        let v4 = AllocationCompleted{
            pool_id      : arg1,
            slot_id      : arg2,
            result_quota : v2,
        };
        0x2::event::emit<AllocationCompleted>(v4);
    }

    public fun assign_resource<T0: store + key>(arg0: &mut AllocationPool, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, QuotaConfig>(&arg0.slots, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, QuotaConfig>(&mut arg0.slots, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.manager, 100);
        if (!(v0.status & 1 != 0)) {
            0x2::transfer::public_transfer<T0>(arg3, v1);
            return
        };
        let v2 = if (0x2::table::contains<0x2::object::ID, ResourceSlot>(&v0.slots, arg2)) {
            let v3 = 0x2::table::borrow<0x2::object::ID, ResourceSlot>(&v0.slots, arg2);
            !v3.allocated && v3.quota > 0
        } else {
            false
        };
        if (!v2) {
            0x2::transfer::public_transfer<T0>(arg3, v1);
            return
        };
        if (0x2::table::contains<0x2::object::ID, ResourceSlot>(&v0.slots, arg2)) {
            0x2::table::borrow_mut<0x2::object::ID, ResourceSlot>(&mut v0.slots, arg2).allocated = true;
        };
        0x2::transfer::public_transfer<T0>(arg3, v0.primary_pool);
        let v4 = AllocationCompleted{
            pool_id      : arg1,
            slot_id      : arg2,
            result_quota : 1,
        };
        0x2::event::emit<AllocationCompleted>(v4);
    }

    public entry fun create_pool(arg0: &mut AllocationPool, arg1: 0x1::ascii::String, arg2: address, arg3: address, arg4: address, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 <= 100, 106);
        let v0 = QuotaConfig{
            owner           : 0x2::tx_context::sender(arg6),
            manager         : arg2,
            status          : 0,
            primary_pool    : arg3,
            overflow_pool   : arg4,
            allocation_rate : arg5,
            slots           : 0x2::table::new<0x2::object::ID, ResourceSlot>(arg6),
        };
        0x2::table::add<0x1::ascii::String, QuotaConfig>(&mut arg0.slots, arg1, v0);
        let v1 = PoolCreated{
            pool_id : arg1,
            owner   : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<PoolCreated>(v1);
    }

    public fun get_pool_info(arg0: &AllocationPool, arg1: 0x1::ascii::String) : (address, address, bool, address, address, u8) {
        assert!(0x2::table::contains<0x1::ascii::String, QuotaConfig>(&arg0.slots, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, QuotaConfig>(&arg0.slots, arg1);
        (v0.owner, v0.manager, v0.status & 1 != 0, v0.primary_pool, v0.overflow_pool, v0.allocation_rate)
    }

    public fun get_slot_info(arg0: &AllocationPool, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : (0x1::ascii::String, u64, bool) {
        assert!(0x2::table::contains<0x1::ascii::String, QuotaConfig>(&arg0.slots, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, QuotaConfig>(&arg0.slots, arg1);
        assert!(0x2::table::contains<0x2::object::ID, ResourceSlot>(&v0.slots, arg2), 102);
        let v1 = 0x2::table::borrow<0x2::object::ID, ResourceSlot>(&v0.slots, arg2);
        (v1.resource_class, v1.quota, v1.allocated)
    }

    public fun get_slot_quota(arg0: &AllocationPool, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : u64 {
        assert!(0x2::table::contains<0x1::ascii::String, QuotaConfig>(&arg0.slots, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, QuotaConfig>(&arg0.slots, arg1);
        if (v0.status & 1 == 0) {
            return 0
        };
        if (!0x2::table::contains<0x2::object::ID, ResourceSlot>(&v0.slots, arg2)) {
            return 0
        };
        let v1 = 0x2::table::borrow<0x2::object::ID, ResourceSlot>(&v0.slots, arg2);
        if (v1.allocated) {
            return 0
        };
        v1.quota
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AllocationPool{
            id      : 0x2::object::new(arg0),
            slots   : 0x2::table::new<0x1::ascii::String, QuotaConfig>(arg0),
            version : 1,
        };
        0x2::transfer::share_object<AllocationPool>(v0);
    }

    public fun release_slot(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut AllocationPool, arg2: 0x1::ascii::String, arg3: 0x2::object::ID, arg4: 0x3::staking_pool::StakedSui, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, QuotaConfig>(&arg1.slots, arg2), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, QuotaConfig>(&mut arg1.slots, arg2);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v1 == v0.manager, 100);
        if (!(v0.status & 1 != 0)) {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg4, v1);
            return
        };
        let v2 = if (0x2::table::contains<0x2::object::ID, ResourceSlot>(&v0.slots, arg3)) {
            let v3 = 0x2::table::borrow<0x2::object::ID, ResourceSlot>(&v0.slots, arg3);
            !v3.allocated && v3.quota > 0
        } else {
            false
        };
        if (!v2) {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg4, v1);
            return
        };
        if (0x2::table::contains<0x2::object::ID, ResourceSlot>(&v0.slots, arg3)) {
            0x2::table::borrow_mut<0x2::object::ID, ResourceSlot>(&mut v0.slots, arg3).allocated = true;
        };
        let v4 = 0x2::coin::from_balance<0x2::sui::SUI>(0x3::sui_system::request_withdraw_stake_non_entry(arg0, arg4, arg5), arg5);
        let v5 = 0x2::coin::value<0x2::sui::SUI>(&v4);
        let v6 = v5 * (v0.allocation_rate as u64) / 100;
        if (v6 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.overflow_pool);
        } else if (v6 == v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.primary_pool);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v4, v6, arg5), v0.primary_pool);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.overflow_pool);
        };
        let v7 = AllocationCompleted{
            pool_id      : arg2,
            slot_id      : arg3,
            result_quota : v5,
        };
        0x2::event::emit<AllocationCompleted>(v7);
    }

    public entry fun reserve_slot(arg0: &mut AllocationPool, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: 0x1::ascii::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, QuotaConfig>(&arg0.slots, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, QuotaConfig>(&mut arg0.slots, arg1);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v1 == v0.owner || v1 == v0.manager, 100);
        let v2 = ResourceSlot{
            resource_class : arg3,
            quota          : arg4,
            allocated      : false,
        };
        if (0x2::table::contains<0x2::object::ID, ResourceSlot>(&v0.slots, arg2)) {
            *0x2::table::borrow_mut<0x2::object::ID, ResourceSlot>(&mut v0.slots, arg2) = v2;
        } else {
            0x2::table::add<0x2::object::ID, ResourceSlot>(&mut v0.slots, arg2, v2);
        };
        let v3 = SlotReserved{
            pool_id        : arg1,
            slot_id        : arg2,
            resource_class : arg3,
            quota          : arg4,
        };
        0x2::event::emit<SlotReserved>(v3);
    }

    public fun should_allocate(arg0: &AllocationPool, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : bool {
        get_slot_quota(arg0, arg1, arg2) > 0
    }

    public entry fun update_quota(arg0: &mut AllocationPool, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, QuotaConfig>(&arg0.slots, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, QuotaConfig>(&mut arg0.slots, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.owner || v1 == v0.manager, 100);
        assert!(0x2::table::contains<0x2::object::ID, ResourceSlot>(&v0.slots, arg2), 102);
        0x2::table::borrow_mut<0x2::object::ID, ResourceSlot>(&mut v0.slots, arg2).quota = arg3;
    }

    // decompiled from Move bytecode v6
}

