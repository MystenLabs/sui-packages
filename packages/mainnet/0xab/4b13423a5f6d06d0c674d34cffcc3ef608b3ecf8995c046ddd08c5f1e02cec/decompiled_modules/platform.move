module 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::platform {
    struct FeeConfig has key {
        id: 0x2::object::UID,
        version: u64,
        fee_bps: u64,
        treasury: address,
        paused: bool,
        pending_cap_transfer: 0x1::option::Option<PendingCapTransfer>,
    }

    struct FeeConfigCap has key {
        id: 0x2::object::UID,
        config: 0x2::object::ID,
    }

    struct PendingCapTransfer has drop, store {
        to: address,
        accepted: bool,
    }

    struct FeeConfigCreated has copy, drop {
        config: 0x2::object::ID,
        fee_bps: u64,
        treasury: address,
    }

    struct FeeChanged has copy, drop {
        config: 0x2::object::ID,
        fee_bps: u64,
    }

    struct TreasuryChanged has copy, drop {
        config: 0x2::object::ID,
        treasury: address,
    }

    struct PauseChanged has copy, drop {
        config: 0x2::object::ID,
        paused: bool,
    }

    struct CapTransferProposed has copy, drop {
        config: 0x2::object::ID,
        to: address,
    }

    struct CapTransferAccepted has copy, drop {
        config: 0x2::object::ID,
        to: address,
    }

    struct CapTransferExecuted has copy, drop {
        config: 0x2::object::ID,
        to: address,
    }

    struct CapTransferCanceled has copy, drop {
        config: 0x2::object::ID,
    }

    public(friend) fun new(arg0: u64, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 <= 500, 0);
        let v0 = FeeConfig{
            id                   : 0x2::object::new(arg2),
            version              : 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version(),
            fee_bps              : arg0,
            treasury             : arg1,
            paused               : false,
            pending_cap_transfer : 0x1::option::none<PendingCapTransfer>(),
        };
        let v1 = FeeConfigCap{
            id     : 0x2::object::new(arg2),
            config : 0x2::object::id<FeeConfig>(&v0),
        };
        let v2 = FeeConfigCreated{
            config   : 0x2::object::id<FeeConfig>(&v0),
            fee_bps  : arg0,
            treasury : arg1,
        };
        0x2::event::emit<FeeConfigCreated>(v2);
        0x2::transfer::share_object<FeeConfig>(v0);
        0x2::transfer::transfer<FeeConfigCap>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun accept_cap_transfer(arg0: &mut FeeConfig, arg1: &0x2::tx_context::TxContext) {
        accept_internal(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun accept_cap_transfer_as_object(arg0: &mut FeeConfig, arg1: &mut 0x2::object::UID) {
        accept_internal(arg0, 0x2::object::uid_to_address(arg1));
    }

    fun accept_internal(arg0: &mut FeeConfig, arg1: address) {
        assert!(0x1::option::is_some<PendingCapTransfer>(&arg0.pending_cap_transfer), 6);
        let v0 = 0x1::option::borrow_mut<PendingCapTransfer>(&mut arg0.pending_cap_transfer);
        assert!(arg1 == v0.to, 7);
        v0.accepted = true;
        let v1 = CapTransferAccepted{
            config : 0x2::object::id<FeeConfig>(arg0),
            to     : arg1,
        };
        0x2::event::emit<CapTransferAccepted>(v1);
    }

    fun assert_cap(arg0: &FeeConfig, arg1: &FeeConfigCap) {
        assert!(arg1.config == 0x2::object::id<FeeConfig>(arg0), 1);
    }

    fun assert_version(arg0: &FeeConfig) {
        assert!(arg0.version == 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version(), 3);
    }

    public fun cancel_cap_transfer(arg0: &mut FeeConfig, arg1: &FeeConfigCap) {
        assert_cap(arg0, arg1);
        assert!(0x1::option::is_some<PendingCapTransfer>(&arg0.pending_cap_transfer), 6);
        arg0.pending_cap_transfer = 0x1::option::none<PendingCapTransfer>();
        let v0 = CapTransferCanceled{config: 0x2::object::id<FeeConfig>(arg0)};
        0x2::event::emit<CapTransferCanceled>(v0);
    }

    public fun collect<T0>(arg0: &FeeConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(!arg0.paused, 5);
        if (arg2 == 0) {
            return 0
        };
        assert!(0x2::coin::value<T0>(arg1) >= arg2, 2);
        let v0 = (((arg2 as u128) * (arg0.fee_bps as u128) / (10000 as u128)) as u64);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg1, v0, arg4), arg0.treasury);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg1, arg2 - v0, arg4), arg3);
        v0
    }

    public fun compute_fee(arg0: &FeeConfig, arg1: u64) : u64 {
        (((arg1 as u128) * (arg0.fee_bps as u128) / (10000 as u128)) as u64)
    }

    public fun execute_cap_transfer(arg0: &mut FeeConfig, arg1: FeeConfigCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.config == 0x2::object::id<FeeConfig>(arg0), 1);
        assert!(0x1::option::is_some<PendingCapTransfer>(&arg0.pending_cap_transfer), 6);
        let PendingCapTransfer {
            to       : v0,
            accepted : v1,
        } = 0x1::option::extract<PendingCapTransfer>(&mut arg0.pending_cap_transfer);
        assert!(v1, 8);
        0x2::transfer::transfer<FeeConfigCap>(arg1, v0);
        let v2 = CapTransferExecuted{
            config : 0x2::object::id<FeeConfig>(arg0),
            to     : v0,
        };
        0x2::event::emit<CapTransferExecuted>(v2);
    }

    public fun fee_bps(arg0: &FeeConfig) : u64 {
        arg0.fee_bps
    }

    public fun is_paused(arg0: &FeeConfig) : bool {
        arg0.paused
    }

    public fun max_fee_bps() : u64 {
        500
    }

    public fun migrate(arg0: &mut FeeConfig, arg1: &FeeConfigCap) {
        assert_cap(arg0, arg1);
        assert!(arg0.version < 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version(), 4);
        arg0.version = 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version();
    }

    public fun pending_cap_transfer_accepted(arg0: &FeeConfig) : 0x1::option::Option<bool> {
        let v0 = &arg0.pending_cap_transfer;
        if (0x1::option::is_some<PendingCapTransfer>(v0)) {
            0x1::option::some<bool>(0x1::option::borrow<PendingCapTransfer>(v0).accepted)
        } else {
            0x1::option::none<bool>()
        }
    }

    public fun pending_cap_transfer_to(arg0: &FeeConfig) : 0x1::option::Option<address> {
        let v0 = &arg0.pending_cap_transfer;
        if (0x1::option::is_some<PendingCapTransfer>(v0)) {
            0x1::option::some<address>(0x1::option::borrow<PendingCapTransfer>(v0).to)
        } else {
            0x1::option::none<address>()
        }
    }

    public fun propose_cap_transfer(arg0: &mut FeeConfig, arg1: &FeeConfigCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_cap(arg0, arg1);
        assert!(arg2 != 0x2::tx_context::sender(arg3), 9);
        let v0 = PendingCapTransfer{
            to       : arg2,
            accepted : false,
        };
        arg0.pending_cap_transfer = 0x1::option::some<PendingCapTransfer>(v0);
        let v1 = CapTransferProposed{
            config : 0x2::object::id<FeeConfig>(arg0),
            to     : arg2,
        };
        0x2::event::emit<CapTransferProposed>(v1);
    }

    public fun set_fee_bps(arg0: &mut FeeConfig, arg1: &FeeConfigCap, arg2: u64) {
        assert_version(arg0);
        assert_cap(arg0, arg1);
        assert!(arg2 <= 500, 0);
        arg0.fee_bps = arg2;
        let v0 = FeeChanged{
            config  : 0x2::object::id<FeeConfig>(arg0),
            fee_bps : arg2,
        };
        0x2::event::emit<FeeChanged>(v0);
    }

    public fun set_paused(arg0: &mut FeeConfig, arg1: &FeeConfigCap, arg2: bool) {
        assert_cap(arg0, arg1);
        arg0.paused = arg2;
        let v0 = PauseChanged{
            config : 0x2::object::id<FeeConfig>(arg0),
            paused : arg2,
        };
        0x2::event::emit<PauseChanged>(v0);
    }

    public fun set_treasury(arg0: &mut FeeConfig, arg1: &FeeConfigCap, arg2: address) {
        assert_version(arg0);
        assert_cap(arg0, arg1);
        arg0.treasury = arg2;
        let v0 = TreasuryChanged{
            config   : 0x2::object::id<FeeConfig>(arg0),
            treasury : arg2,
        };
        0x2::event::emit<TreasuryChanged>(v0);
    }

    public fun treasury(arg0: &FeeConfig) : address {
        arg0.treasury
    }

    public fun version(arg0: &FeeConfig) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

