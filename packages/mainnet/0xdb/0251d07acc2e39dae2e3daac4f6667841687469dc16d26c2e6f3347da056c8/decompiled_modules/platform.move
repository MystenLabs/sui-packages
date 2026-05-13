module 0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::platform {
    struct PLATFORM has drop {
        dummy_field: bool,
    }

    struct FeeUpdated has copy, drop {
        old_bps: u64,
        new_bps: u64,
        admin: address,
        timestamp_ms: u64,
    }

    struct TreasuryAddressUpdated has copy, drop {
        old_address: address,
        new_address: address,
        admin: address,
        timestamp_ms: u64,
    }

    struct PlatformPaused has copy, drop {
        admin: address,
        timestamp_ms: u64,
    }

    struct PlatformUnpaused has copy, drop {
        admin: address,
        timestamp_ms: u64,
    }

    struct PlatformFeesWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
        admin: address,
        remaining_balance: u64,
        timestamp_ms: u64,
    }

    struct AdminTransferred has copy, drop {
        old_admin: address,
        new_admin: address,
        timestamp_ms: u64,
    }

    struct Platform has key {
        id: 0x2::object::UID,
        fee_bps: u64,
        treasury_address: address,
        fee_treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        paused: bool,
        total_projects: u64,
    }

    struct PlatformAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun assert_not_paused(arg0: &Platform) {
        assert!(!arg0.paused, 1);
    }

    public(friend) fun bump_project_counter(arg0: &mut Platform) : u64 {
        arg0.total_projects = arg0.total_projects + 1;
        arg0.total_projects
    }

    public(friend) fun deposit_fee(arg0: &mut Platform, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_treasury, arg1);
    }

    public fun fee_bps(arg0: &Platform) : u64 {
        arg0.fee_bps
    }

    public(friend) fun fee_bps_internal(arg0: &Platform) : u64 {
        arg0.fee_bps
    }

    public fun fee_treasury_balance(arg0: &Platform) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.fee_treasury)
    }

    fun init(arg0: PLATFORM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = Platform{
            id               : 0x2::object::new(arg1),
            fee_bps          : 500,
            treasury_address : v0,
            fee_treasury     : 0x2::balance::zero<0x2::sui::SUI>(),
            paused           : false,
            total_projects   : 0,
        };
        0x2::transfer::share_object<Platform>(v1);
        let v2 = PlatformAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<PlatformAdminCap>(v2, v0);
    }

    public fun is_paused(arg0: &Platform) : bool {
        arg0.paused
    }

    public fun pause(arg0: &PlatformAdminCap, arg1: &mut Platform, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 6);
        arg1.paused = true;
        let v0 = PlatformPaused{
            admin        : 0x2::tx_context::sender(arg3),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PlatformPaused>(v0);
    }

    public fun set_treasury_address(arg0: &PlatformAdminCap, arg1: &mut Platform, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0, 5);
        arg1.treasury_address = arg2;
        let v0 = TreasuryAddressUpdated{
            old_address  : arg1.treasury_address,
            new_address  : arg2,
            admin        : 0x2::tx_context::sender(arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TreasuryAddressUpdated>(v0);
    }

    public fun total_projects(arg0: &Platform) : u64 {
        arg0.total_projects
    }

    public fun transfer_admin(arg0: PlatformAdminCap, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 8);
        let v0 = AdminTransferred{
            old_admin    : 0x2::tx_context::sender(arg3),
            new_admin    : arg1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<AdminTransferred>(v0);
        0x2::transfer::public_transfer<PlatformAdminCap>(arg0, arg1);
    }

    public fun treasury_address(arg0: &Platform) : address {
        arg0.treasury_address
    }

    public(friend) fun treasury_address_internal(arg0: &Platform) : address {
        arg0.treasury_address
    }

    public fun unpause(arg0: &PlatformAdminCap, arg1: &mut Platform, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.paused, 7);
        arg1.paused = false;
        let v0 = PlatformUnpaused{
            admin        : 0x2::tx_context::sender(arg3),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PlatformUnpaused>(v0);
    }

    public fun update_fee_bps(arg0: &PlatformAdminCap, arg1: &mut Platform, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg2 <= 10000, 2);
        arg1.fee_bps = arg2;
        let v0 = FeeUpdated{
            old_bps      : arg1.fee_bps,
            new_bps      : arg2,
            admin        : 0x2::tx_context::sender(arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<FeeUpdated>(v0);
    }

    public fun withdraw_platform_fees(arg0: &PlatformAdminCap, arg1: &mut Platform, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.fee_treasury) >= arg2, 4);
        let v0 = arg1.treasury_address;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.fee_treasury, arg2), arg4), v0);
        let v1 = PlatformFeesWithdrawn{
            amount            : arg2,
            recipient         : v0,
            admin             : 0x2::tx_context::sender(arg4),
            remaining_balance : 0x2::balance::value<0x2::sui::SUI>(&arg1.fee_treasury),
            timestamp_ms      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PlatformFeesWithdrawn>(v1);
    }

    // decompiled from Move bytecode v7
}

