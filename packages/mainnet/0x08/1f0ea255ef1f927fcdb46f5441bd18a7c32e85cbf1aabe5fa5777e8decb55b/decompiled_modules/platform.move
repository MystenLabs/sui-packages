module 0x81f0ea255ef1f927fcdb46f5441bd18a7c32e85cbf1aabe5fa5777e8decb55b::platform {
    struct PLATFORM has drop {
        dummy_field: bool,
    }

    struct FeeUpdated has copy, drop {
        old_fee_mist: u64,
        new_fee_mist: u64,
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

    struct FeesWithdrawn has copy, drop {
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

    struct AdminRenounced has copy, drop {
        old_admin: address,
        timestamp_ms: u64,
    }

    struct MaxRecipientsUpdated has copy, drop {
        old_max: u64,
        new_max: u64,
        admin: address,
        timestamp_ms: u64,
    }

    struct AirdropPlatform has key {
        id: 0x2::object::UID,
        fee_per_recipient_mist: u64,
        max_recipients: u64,
        treasury_address: address,
        fee_treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        paused: bool,
        total_airdrops: u64,
    }

    struct AirdropAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun assert_not_paused(arg0: &AirdropPlatform) {
        assert!(!arg0.paused, 1);
    }

    public(friend) fun bump_airdrop_counter(arg0: &mut AirdropPlatform) : u64 {
        arg0.total_airdrops = arg0.total_airdrops + 1;
        arg0.total_airdrops
    }

    public(friend) fun deposit_fee(arg0: &mut AirdropPlatform, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_treasury, arg1);
    }

    public(friend) fun fee_per_recipient_internal(arg0: &AirdropPlatform) : u64 {
        arg0.fee_per_recipient_mist
    }

    public fun fee_per_recipient_mist(arg0: &AirdropPlatform) : u64 {
        arg0.fee_per_recipient_mist
    }

    public fun fee_treasury_balance(arg0: &AirdropPlatform) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.fee_treasury)
    }

    fun init(arg0: PLATFORM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = AirdropPlatform{
            id                     : 0x2::object::new(arg1),
            fee_per_recipient_mist : 1000000,
            max_recipients         : 200,
            treasury_address       : v0,
            fee_treasury           : 0x2::balance::zero<0x2::sui::SUI>(),
            paused                 : false,
            total_airdrops         : 0,
        };
        0x2::transfer::share_object<AirdropPlatform>(v1);
        let v2 = AirdropAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AirdropAdminCap>(v2, v0);
    }

    public fun is_paused(arg0: &AirdropPlatform) : bool {
        arg0.paused
    }

    public fun max_recipients(arg0: &AirdropPlatform) : u64 {
        arg0.max_recipients
    }

    public(friend) fun max_recipients_internal(arg0: &AirdropPlatform) : u64 {
        arg0.max_recipients
    }

    public fun pause(arg0: &AirdropAdminCap, arg1: &mut AirdropPlatform, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 5);
        arg1.paused = true;
        let v0 = PlatformPaused{
            admin        : 0x2::tx_context::sender(arg3),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PlatformPaused>(v0);
    }

    public fun renounce_admin(arg0: AirdropAdminCap, arg1: &AirdropPlatform, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.fee_treasury) == 0, 8);
        let AirdropAdminCap { id: v0 } = arg0;
        let v1 = AdminRenounced{
            old_admin    : 0x2::tx_context::sender(arg3),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<AdminRenounced>(v1);
        0x2::object::delete(v0);
    }

    public fun set_treasury_address(arg0: &AirdropAdminCap, arg1: &mut AirdropPlatform, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0, 4);
        arg1.treasury_address = arg2;
        let v0 = TreasuryAddressUpdated{
            old_address  : arg1.treasury_address,
            new_address  : arg2,
            admin        : 0x2::tx_context::sender(arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TreasuryAddressUpdated>(v0);
    }

    public fun total_airdrops(arg0: &AirdropPlatform) : u64 {
        arg0.total_airdrops
    }

    public fun transfer_admin(arg0: AirdropAdminCap, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 7);
        let v0 = AdminTransferred{
            old_admin    : 0x2::tx_context::sender(arg3),
            new_admin    : arg1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<AdminTransferred>(v0);
        0x2::transfer::public_transfer<AirdropAdminCap>(arg0, arg1);
    }

    public fun treasury_address(arg0: &AirdropPlatform) : address {
        arg0.treasury_address
    }

    public fun unpause(arg0: &AirdropAdminCap, arg1: &mut AirdropPlatform, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.paused, 6);
        arg1.paused = false;
        let v0 = PlatformUnpaused{
            admin        : 0x2::tx_context::sender(arg3),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PlatformUnpaused>(v0);
    }

    public fun update_fee_per_recipient(arg0: &AirdropAdminCap, arg1: &mut AirdropPlatform, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        arg1.fee_per_recipient_mist = arg2;
        let v0 = FeeUpdated{
            old_fee_mist : arg1.fee_per_recipient_mist,
            new_fee_mist : arg2,
            admin        : 0x2::tx_context::sender(arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<FeeUpdated>(v0);
    }

    public fun update_max_recipients(arg0: &AirdropAdminCap, arg1: &mut AirdropPlatform, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 9);
        arg1.max_recipients = arg2;
        let v0 = MaxRecipientsUpdated{
            old_max      : arg1.max_recipients,
            new_max      : arg2,
            admin        : 0x2::tx_context::sender(arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MaxRecipientsUpdated>(v0);
    }

    public fun withdraw_fees(arg0: &AirdropAdminCap, arg1: &mut AirdropPlatform, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 2);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.fee_treasury) >= arg2, 3);
        let v0 = arg1.treasury_address;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.fee_treasury, arg2), arg4), v0);
        let v1 = FeesWithdrawn{
            amount            : arg2,
            recipient         : v0,
            admin             : 0x2::tx_context::sender(arg4),
            remaining_balance : 0x2::balance::value<0x2::sui::SUI>(&arg1.fee_treasury),
            timestamp_ms      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<FeesWithdrawn>(v1);
    }

    // decompiled from Move bytecode v7
}

