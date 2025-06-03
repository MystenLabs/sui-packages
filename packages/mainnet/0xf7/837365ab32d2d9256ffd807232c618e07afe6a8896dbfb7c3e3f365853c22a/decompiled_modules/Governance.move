module 0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::Governance {
    struct MintEvent has copy, drop {
        minter: address,
        amount: u64,
        timestamp: u64,
    }

    struct BurnEvent has copy, drop {
        burner: address,
        amount: u64,
        timestamp: u64,
    }

    struct AdminTransferEvent has copy, drop {
        previous_admin: address,
        new_admin: address,
        timestamp: u64,
    }

    struct TreasuryCapTransferEvent has copy, drop {
        from: address,
        to: address,
        timestamp: u64,
    }

    struct GovernanceCap has store, key {
        id: 0x2::object::UID,
    }

    struct GovernanceTransferRequest has store, key {
        id: 0x2::object::UID,
        from: address,
        to: address,
        timestamp: u64,
    }

    struct TreasuryCapTransferRequest has store, key {
        id: 0x2::object::UID,
        from: address,
        to: address,
        timestamp: u64,
    }

    public fun accept_governance_transfer(arg0: &0x2::coin::TreasuryCap<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>, arg1: &0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::AdminCap, arg2: GovernanceTransferRequest, arg3: &mut 0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::AdminRegistry, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg2.to, 4);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg4);
        assert!(v1 >= arg2.timestamp && v1 - arg2.timestamp < 86400000, 5);
        0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::change_admin(arg0, arg1, arg3, v0, arg4);
        let GovernanceTransferRequest {
            id        : v2,
            from      : _,
            to        : _,
            timestamp : _,
        } = arg2;
        0x2::object::delete(v2);
    }

    public entry fun accept_treasury_cap_transfer(arg0: 0x2::coin::TreasuryCap<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>, arg1: 0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::AdminCap, arg2: &mut 0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::AdminRegistry, arg3: TreasuryCapTransferRequest, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg3.to, 4);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg4);
        assert!(v1 >= arg3.timestamp && v1 - arg3.timestamp < 86400000, 5);
        0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::change_admin(&arg0, &arg1, arg2, v0, arg4);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>>(arg0, v0);
        0x2::transfer::public_transfer<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::AdminCap>(arg1, v0);
        let v2 = AdminTransferEvent{
            previous_admin : 0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::governance_admin(arg2),
            new_admin      : v0,
            timestamp      : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<AdminTransferEvent>(v2);
        let TreasuryCapTransferRequest {
            id        : v3,
            from      : _,
            to        : _,
            timestamp : _,
        } = arg3;
        0x2::object::delete(v3);
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>, arg1: &0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::AdminRegistry, arg2: &0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::EmergencyPauseState, arg3: 0x2::coin::Coin<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::is_paused(arg2), 6);
        assert!(v0 == 0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::governance_admin(arg1), 1);
        let v1 = 0x2::coin::value<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>(&arg3);
        assert!(v1 > 0, 7);
        0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::burn(arg0, arg2, arg3);
        let v2 = BurnEvent{
            burner    : v0,
            amount    : v1,
            timestamp : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<BurnEvent>(v2);
    }

    public entry fun change_admin(arg0: &0x2::coin::TreasuryCap<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>, arg1: &GovernanceCap, arg2: &mut 0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::AdminRegistry, arg3: &0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::AdminCap, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == 0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::governance_admin(arg2), 1);
        0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::change_admin(arg0, arg3, arg2, arg4, arg5);
    }

    public fun initiate_governance_transfer(arg0: &mut 0x2::coin::TreasuryCap<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>, arg1: &0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::AdminRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == 0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::governance_admin(arg1), 1);
        let v1 = GovernanceTransferRequest{
            id        : 0x2::object::new(arg3),
            from      : v0,
            to        : arg2,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::transfer::transfer<GovernanceTransferRequest>(v1, arg2);
    }

    public entry fun initiate_treasury_cap_transfer(arg0: &0x2::coin::TreasuryCap<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>, arg1: &0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::AdminRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == 0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::governance_admin(arg1), 1);
        let v1 = TreasuryCapTransferRequest{
            id        : 0x2::object::new(arg3),
            from      : v0,
            to        : arg2,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::transfer::transfer<TreasuryCapTransferRequest>(v1, arg2);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>, arg1: &0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::AdminRegistry, arg2: &0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::EmergencyPauseState, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN> {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == 0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::governance_admin(arg1), 1);
        assert!(arg3 > 0, 7);
        assert!(arg3 <= 100000000, 2);
        let v1 = MintEvent{
            minter    : v0,
            amount    : arg3,
            timestamp : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<MintEvent>(v1);
        0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::mint(arg0, arg3, arg1, arg2, arg4)
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>, arg1: &0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::AdminRegistry, arg2: &0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::EmergencyPauseState, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 == 0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::governance_admin(arg1), 1);
        assert!(arg4 != @0x0, 1);
        let v1 = mint(arg0, arg1, arg2, arg3, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>>(v1, arg4);
        let v2 = MintEvent{
            minter    : v0,
            amount    : arg3,
            timestamp : 0x2::tx_context::epoch(arg5),
        };
        0x2::event::emit<MintEvent>(v2);
    }

    public entry fun transfer_treasury_cap(arg0: 0x2::coin::TreasuryCap<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>, arg1: 0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::AdminCap, arg2: &0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::AdminRegistry, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == 0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::governance_admin(arg2), 1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::HETRACOIN>>(arg0, arg3);
        0x2::transfer::public_transfer<0xf7837365ab32d2d9256ffd807232c618e07afe6a8896dbfb7c3e3f365853c22a::HetraCoin::AdminCap>(arg1, arg3);
        let v1 = TreasuryCapTransferEvent{
            from      : v0,
            to        : arg3,
            timestamp : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<TreasuryCapTransferEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

