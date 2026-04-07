module 0x188dd79e6d9f6f9fabbe7ea25782f777a6e86c6a2f8abb7ecf68b3c694ce595e::vesting {
    struct VestingVault has key {
        id: 0x2::object::UID,
        vault: 0x2::balance::Balance<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>,
        total_allocated: u64,
        allocations: 0x2::table::Table<address, VestingAllocation>,
        admins: vector<address>,
    }

    struct VestingAllocation has store {
        total_amount: u64,
        claimed_amount: u64,
        start_time: u64,
        cliff_end: u64,
        vest_end: u64,
        halted: bool,
        cancelled: bool,
        halt_time: u64,
        total_halted_duration: u64,
    }

    struct AllocationReceipt has store, key {
        id: 0x2::object::UID,
        recipient: address,
    }

    struct AdminAdded has copy, drop {
        new_admin: address,
        by: address,
    }

    struct AdminRemoved has copy, drop {
        removed_admin: address,
        by: address,
    }

    struct VaultDeposited has copy, drop {
        amount: u64,
        by: address,
    }

    struct AllocationCreated has copy, drop {
        recipient: address,
        amount: u64,
        cliff_end: u64,
        vest_end: u64,
        by: address,
    }

    struct AllocationHalted has copy, drop {
        recipient: address,
        halt_time: u64,
        by: address,
    }

    struct AllocationResumed has copy, drop {
        recipient: address,
        halted_duration_added: u64,
        by: address,
    }

    struct AllocationCancelledEvent has copy, drop {
        recipient: address,
        unclaimed_returned: u64,
        by: address,
    }

    struct UnallocatedWithdrawn has copy, drop {
        amount: u64,
        to: address,
    }

    struct VestedClaimed has copy, drop {
        recipient: address,
        amount: u64,
        timestamp: u64,
    }

    public entry fun add_admin(arg0: &mut VestingVault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_root_admin(arg2);
        assert!(!0x1::vector::contains<address>(&arg0.admins, &arg1), 113);
        0x1::vector::push_back<address>(&mut arg0.admins, arg1);
        let v0 = AdminAdded{
            new_admin : arg1,
            by        : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AdminAdded>(v0);
    }

    fun assert_admin(arg0: &VestingVault, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.admins, &v0), 111);
    }

    fun assert_root_admin(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x450a68aff3718ab9667356953a2110b91458b0fbdcc8fb8c4e1dcce9fe0615aa, 112);
    }

    public entry fun cancel_allocation(arg0: &mut VestingVault, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        assert!(0x2::table::contains<address, VestingAllocation>(&arg0.allocations, arg1), 110);
        let v0 = 0x2::table::borrow_mut<address, VestingAllocation>(&mut arg0.allocations, arg1);
        assert!(!v0.cancelled, 102);
        if (v0.halted) {
            v0.total_halted_duration = v0.total_halted_duration + 0x2::clock::timestamp_ms(arg2) - v0.halt_time;
            v0.halted = false;
            v0.halt_time = 0;
        };
        v0.cancelled = true;
        let v1 = v0.total_amount - v0.claimed_amount;
        arg0.total_allocated = arg0.total_allocated - v1;
        let v2 = AllocationCancelledEvent{
            recipient          : arg1,
            unclaimed_returned : v1,
            by                 : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<AllocationCancelledEvent>(v2);
    }

    public entry fun claim_vested(arg0: &mut VestingVault, arg1: &AllocationReceipt, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg1.recipient, 106);
        let v1 = 0x2::table::borrow_mut<address, VestingAllocation>(&mut arg0.allocations, arg1.recipient);
        assert!(!v1.cancelled, 102);
        assert!(!v1.halted, 101);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v2 >= v1.cliff_end, 100);
        let v3 = compute_claimable(v1, v2);
        assert!(v3 > 0, 103);
        v1.claimed_amount = v1.claimed_amount + v3;
        arg0.total_allocated = arg0.total_allocated - v3;
        assert!(0x2::balance::value<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&arg0.vault) >= v3, 107);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>>(0x2::coin::from_balance<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(0x2::balance::split<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&mut arg0.vault, v3), arg3), v0);
        let v4 = VestedClaimed{
            recipient : v0,
            amount    : v3,
            timestamp : v2,
        };
        0x2::event::emit<VestedClaimed>(v4);
    }

    fun compute_claimable(arg0: &VestingAllocation, arg1: u64) : u64 {
        if (arg1 < arg0.cliff_end) {
            return 0
        };
        if (arg1 >= arg0.vest_end + arg0.total_halted_duration) {
            return arg0.total_amount - arg0.claimed_amount
        };
        let v0 = arg1 - arg0.total_halted_duration;
        if (v0 <= arg0.cliff_end) {
            return 0
        };
        let v1 = (((arg0.total_amount as u128) * ((v0 - arg0.cliff_end) as u128) / (12960000000 as u128)) as u64);
        if (v1 > arg0.claimed_amount) {
            v1 - arg0.claimed_amount
        } else {
            0
        }
    }

    public entry fun create_allocation(arg0: &mut VestingVault, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg4);
        assert!(arg2 > 0, 108);
        assert!(!0x2::table::contains<address, VestingAllocation>(&arg0.allocations, arg1), 109);
        assert!(0x2::balance::value<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&arg0.vault) - arg0.total_allocated >= arg2, 107);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = VestingAllocation{
            total_amount          : arg2,
            claimed_amount        : 0,
            start_time            : v0,
            cliff_end             : v0 + 2592000000,
            vest_end              : v0 + 2592000000 + 12960000000,
            halted                : false,
            cancelled             : false,
            halt_time             : 0,
            total_halted_duration : 0,
        };
        0x2::table::add<address, VestingAllocation>(&mut arg0.allocations, arg1, v1);
        arg0.total_allocated = arg0.total_allocated + arg2;
        let v2 = AllocationCreated{
            recipient : arg1,
            amount    : arg2,
            cliff_end : v0 + 2592000000,
            vest_end  : v0 + 2592000000 + 12960000000,
            by        : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<AllocationCreated>(v2);
        let v3 = AllocationReceipt{
            id        : 0x2::object::new(arg4),
            recipient : arg1,
        };
        0x2::transfer::transfer<AllocationReceipt>(v3, arg1);
    }

    public entry fun deposit_to_vault(arg0: &mut VestingVault, arg1: 0x2::coin::Coin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert!(0x2::coin::value<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&arg1) > 0, 108);
        0x2::balance::join<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&mut arg0.vault, 0x2::coin::into_balance<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(arg1));
        let v0 = VaultDeposited{
            amount : 0x2::coin::value<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&arg1),
            by     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<VaultDeposited>(v0);
    }

    public fun get_allocation_cancelled(arg0: &VestingVault, arg1: address) : bool {
        0x2::table::borrow<address, VestingAllocation>(&arg0.allocations, arg1).cancelled
    }

    public fun get_allocation_claimed(arg0: &VestingVault, arg1: address) : u64 {
        0x2::table::borrow<address, VestingAllocation>(&arg0.allocations, arg1).claimed_amount
    }

    public fun get_allocation_cliff_end(arg0: &VestingVault, arg1: address) : u64 {
        0x2::table::borrow<address, VestingAllocation>(&arg0.allocations, arg1).cliff_end
    }

    public fun get_allocation_halted(arg0: &VestingVault, arg1: address) : bool {
        0x2::table::borrow<address, VestingAllocation>(&arg0.allocations, arg1).halted
    }

    public fun get_allocation_total(arg0: &VestingVault, arg1: address) : u64 {
        0x2::table::borrow<address, VestingAllocation>(&arg0.allocations, arg1).total_amount
    }

    public fun get_allocation_vest_end(arg0: &VestingVault, arg1: address) : u64 {
        0x2::table::borrow<address, VestingAllocation>(&arg0.allocations, arg1).vest_end
    }

    public fun get_claimable(arg0: &VestingVault, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        if (!0x2::table::contains<address, VestingAllocation>(&arg0.allocations, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, VestingAllocation>(&arg0.allocations, arg1);
        if (v0.cancelled || v0.halted) {
            return 0
        };
        compute_claimable(v0, 0x2::clock::timestamp_ms(arg2))
    }

    public fun get_receipt_recipient(arg0: &AllocationReceipt) : address {
        arg0.recipient
    }

    public fun get_vault_balance(arg0: &VestingVault) : u64 {
        0x2::balance::value<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&arg0.vault)
    }

    public fun get_vault_free_balance(arg0: &VestingVault) : u64 {
        0x2::balance::value<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&arg0.vault) - arg0.total_allocated
    }

    public fun get_vault_total_allocated(arg0: &VestingVault) : u64 {
        arg0.total_allocated
    }

    public entry fun halt_allocation(arg0: &mut VestingVault, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        assert!(0x2::table::contains<address, VestingAllocation>(&arg0.allocations, arg1), 110);
        let v0 = 0x2::table::borrow_mut<address, VestingAllocation>(&mut arg0.allocations, arg1);
        assert!(!v0.cancelled, 102);
        assert!(!v0.halted, 104);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        v0.halted = true;
        v0.halt_time = v1;
        let v2 = AllocationHalted{
            recipient : arg1,
            halt_time : v1,
            by        : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<AllocationHalted>(v2);
    }

    public fun has_allocation(arg0: &VestingVault, arg1: address) : bool {
        0x2::table::contains<address, VestingAllocation>(&arg0.allocations, arg1)
    }

    public entry fun init_vault_entry(arg0: &mut 0x2::tx_context::TxContext) {
        assert_root_admin(arg0);
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, @0x450a68aff3718ab9667356953a2110b91458b0fbdcc8fb8c4e1dcce9fe0615aa);
        let v1 = VestingVault{
            id              : 0x2::object::new(arg0),
            vault           : 0x2::balance::zero<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(),
            total_allocated : 0,
            allocations     : 0x2::table::new<address, VestingAllocation>(arg0),
            admins          : v0,
        };
        0x2::transfer::share_object<VestingVault>(v1);
    }

    public fun is_admin(arg0: &VestingVault, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.admins, &arg1)
    }

    public entry fun remove_admin(arg0: &mut VestingVault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_root_admin(arg2);
        assert!(arg1 != @0x450a68aff3718ab9667356953a2110b91458b0fbdcc8fb8c4e1dcce9fe0615aa, 115);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.admins, &arg1);
        assert!(v0, 114);
        0x1::vector::remove<address>(&mut arg0.admins, v1);
        let v2 = AdminRemoved{
            removed_admin : arg1,
            by            : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AdminRemoved>(v2);
    }

    public entry fun resume_allocation(arg0: &mut VestingVault, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        assert!(0x2::table::contains<address, VestingAllocation>(&arg0.allocations, arg1), 110);
        let v0 = 0x2::table::borrow_mut<address, VestingAllocation>(&mut arg0.allocations, arg1);
        assert!(!v0.cancelled, 102);
        assert!(v0.halted, 105);
        let v1 = 0x2::clock::timestamp_ms(arg2) - v0.halt_time;
        v0.total_halted_duration = v0.total_halted_duration + v1;
        v0.halted = false;
        v0.halt_time = 0;
        let v2 = AllocationResumed{
            recipient             : arg1,
            halted_duration_added : v1,
            by                    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<AllocationResumed>(v2);
    }

    public entry fun withdraw_unallocated(arg0: &mut VestingVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert!(arg1 > 0, 108);
        assert!(arg1 <= 0x2::balance::value<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&arg0.vault) - arg0.total_allocated, 107);
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>>(0x2::coin::from_balance<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(0x2::balance::split<0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::td2::TD2>(&mut arg0.vault, arg1), arg2), v0);
        let v1 = UnallocatedWithdrawn{
            amount : arg1,
            to     : v0,
        };
        0x2::event::emit<UnallocatedWithdrawn>(v1);
    }

    // decompiled from Move bytecode v6
}

