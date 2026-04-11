module 0x784ec3a442369d969a09b217190115c48f9174e53e4f9e5bfeea2e825910ee44::ssui {
    struct SSUI has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct TokenRegistry has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<SSUI>,
        total_minted: u64,
        total_burned: u64,
        metadata_id: 0x2::object::ID,
        contract_supply_balance: 0x2::balance::Balance<SSUI>,
        authorized_minters: vector<address>,
        transfer_fee_bps: u64,
        fee_recipient: address,
        is_paused: bool,
        total_fees_collected: u64,
    }

    struct TransferAllowlist has store, key {
        id: 0x2::object::UID,
        enabled: bool,
        allowlist: vector<address>,
        admin_cap_id: 0x2::object::ID,
    }

    struct KioskListing has store, key {
        id: 0x2::object::UID,
        kiosk_id: 0x2::object::ID,
        listing_count: u64,
    }

    struct DisplayConfig has store, key {
        id: 0x2::object::UID,
        display_id: 0x2::object::ID,
    }

    struct MultisigConfig has store, key {
        id: 0x2::object::UID,
        signers: vector<address>,
        threshold: u64,
        nonce: u64,
    }

    struct PendingAction has store, key {
        id: 0x2::object::UID,
        action_type: u8,
        target_address: address,
        amount: u64,
        execute_after: u64,
        signatures: vector<address>,
        created_at: u64,
    }

    struct TimelockedAction has store, key {
        id: 0x2::object::UID,
        action_type: u8,
        target_address: address,
        amount: u64,
        execute_after: u64,
        created_at: u64,
        executed: bool,
    }

    struct BurnEvent has copy, drop {
        account: address,
        amount: u64,
    }

    struct TransferEvent has copy, drop {
        from: address,
        to: address,
        amount: u64,
        fee: u64,
    }

    struct FeeCollectedEvent has copy, drop {
        recipient: address,
        amount: u64,
    }

    struct PauseEvent has copy, drop {
        paused: bool,
        reason: 0x1::string::String,
    }

    struct MetadataCreatedEvent has copy, drop {
        metadata_id: 0x2::object::ID,
        symbol: 0x1::ascii::String,
        name: 0x1::string::String,
        decimals: u8,
        logo_url: vector<u8>,
    }

    struct AllowlistUpdatedEvent has copy, drop {
        action: 0x1::string::String,
        address: address,
        enabled: bool,
    }

    struct KioskListedEvent has copy, drop {
        kiosk_id: 0x2::object::ID,
        amount: u64,
        price: u64,
    }

    struct DisplayConfiguredEvent has copy, drop {
        display_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        project_url: 0x1::string::String,
    }

    struct MultisigActionCreatedEvent has copy, drop {
        action_id: 0x2::object::ID,
        action_type: u8,
        target_address: address,
        amount: u64,
        execute_after: u64,
    }

    struct MultisigActionSignedEvent has copy, drop {
        action_id: 0x2::object::ID,
        signer: address,
        signature_count: u64,
        threshold: u64,
    }

    struct MultisigActionExecutedEvent has copy, drop {
        action_id: 0x2::object::ID,
        action_type: u8,
        executed_by: address,
    }

    struct TimelockCreatedEvent has copy, drop {
        action_id: 0x2::object::ID,
        action_type: u8,
        execute_after: u64,
    }

    struct TimelockExecutedEvent has copy, drop {
        action_id: 0x2::object::ID,
        action_type: u8,
        executed_by: address,
    }

    struct MultisigActionCancelledEvent has copy, drop {
        action_id: 0x2::object::ID,
        cancelled_by: address,
    }

    struct TimelockCancelledEvent has copy, drop {
        action_id: 0x2::object::ID,
        cancelled_by: address,
    }

    struct OwnershipTransferredEvent has copy, drop {
        old_owner: address,
        new_owner: address,
    }

    struct MultisigSignerAddedEvent has copy, drop {
        signer: address,
    }

    struct MultisigSignerRemovedEvent has copy, drop {
        signer: address,
    }

    struct TransferFeeUpdatedEvent has copy, drop {
        old_fee_bps: u64,
        new_fee_bps: u64,
    }

    struct FeeRecipientUpdatedEvent has copy, drop {
        old_recipient: address,
        new_recipient: address,
    }

    struct ContractTokensDistributedEvent has copy, drop {
        recipient: address,
        amount: u64,
    }

    struct SSUIDisplay has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        symbol: 0x1::ascii::String,
        decimals: u8,
        icon_url: 0x2::url::Url,
        project_url: 0x2::url::Url,
    }

    public entry fun join(arg0: &mut 0x2::coin::Coin<SSUI>, arg1: 0x2::coin::Coin<SSUI>) {
        0x2::coin::join<SSUI>(arg0, arg1);
    }

    public entry fun split(arg0: &mut 0x2::coin::Coin<SSUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SSUI>>(0x2::coin::split<SSUI>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun burn(arg0: &mut TokenRegistry, arg1: 0x2::coin::Coin<SSUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<SSUI>(&arg1);
        assert!(v0 > 0, 2);
        0x2::coin::burn<SSUI>(&mut arg0.treasury_cap, arg1);
        arg0.total_burned = arg0.total_burned + v0;
        let v1 = BurnEvent{
            account : 0x2::tx_context::sender(arg2),
            amount  : v0,
        };
        0x2::event::emit<BurnEvent>(v1);
    }

    public entry fun transfer(arg0: &mut TokenRegistry, arg1: 0x2::coin::Coin<SSUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 14);
        assert!(arg2 != @0x0, 3);
        let v0 = 0x2::coin::value<SSUI>(&arg1);
        let v1 = if (arg0.transfer_fee_bps > 0) {
            (((v0 as u128) * (arg0.transfer_fee_bps as u128) / 10000) as u64)
        } else {
            0
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SSUI>>(0x2::coin::split<SSUI>(&mut arg1, v1, arg3), arg0.fee_recipient);
            arg0.total_fees_collected = arg0.total_fees_collected + v1;
            let v2 = FeeCollectedEvent{
                recipient : arg0.fee_recipient,
                amount    : v1,
            };
            0x2::event::emit<FeeCollectedEvent>(v2);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<SSUI>>(arg1, arg2);
        let v3 = TransferEvent{
            from   : 0x2::tx_context::sender(arg3),
            to     : arg2,
            amount : v0,
            fee    : v1,
        };
        0x2::event::emit<TransferEvent>(v3);
    }

    public entry fun add_authorized_minter(arg0: &mut TokenRegistry, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 1);
        assert!(arg2 != @0x0, 3);
        let v0 = 0;
        let v1 = 0x1::vector::length<address>(&arg0.authorized_minters);
        let v2 = false;
        while (v0 < v1) {
            if (*0x1::vector::borrow<address>(&arg0.authorized_minters, v0) == arg2) {
                v2 = true;
                break
            };
            v0 = v0 + 1;
        };
        if (!v2) {
            assert!(v1 < 50, 21);
            0x1::vector::push_back<address>(&mut arg0.authorized_minters, arg2);
        };
    }

    public entry fun add_multisig_signer(arg0: &mut MultisigConfig, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 1);
        assert!(arg2 != @0x0, 3);
        assert!(!is_multisig_signer(arg0, arg2), 12);
        assert!(0x1::vector::length<address>(&arg0.signers) < 10, 11);
        0x1::vector::push_back<address>(&mut arg0.signers, arg2);
        let v0 = MultisigSignerAddedEvent{signer: arg2};
        0x2::event::emit<MultisigSignerAddedEvent>(v0);
    }

    public entry fun add_to_allowlist(arg0: &mut TransferAllowlist, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 1);
        assert!(arg0.admin_cap_id == 0x2::object::id<AdminCap>(arg1), 17);
        assert!(arg2 != @0x0, 3);
        let v0 = 0;
        let v1 = 0x1::vector::length<address>(&arg0.allowlist);
        while (v0 < v1) {
            if (*0x1::vector::borrow<address>(&arg0.allowlist, v0) == arg2) {
                abort 7
            };
            v0 = v0 + 1;
        };
        assert!(v1 < 500, 22);
        0x1::vector::push_back<address>(&mut arg0.allowlist, arg2);
        let v2 = AllowlistUpdatedEvent{
            action  : 0x1::string::utf8(b"add"),
            address : arg2,
            enabled : arg0.enabled,
        };
        0x2::event::emit<AllowlistUpdatedEvent>(v2);
    }

    public entry fun batch_transfer(arg0: &mut TokenRegistry, arg1: 0x2::coin::Coin<SSUI>, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 14);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 18);
        assert!(0x1::vector::length<address>(&arg2) > 0, 18);
        assert!(0x1::vector::length<address>(&arg2) <= 200, 20);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg2)) {
            let v2 = *0x1::vector::borrow<address>(&arg2, v1);
            let v3 = *0x1::vector::borrow<u64>(&arg3, v1);
            assert!(v2 != @0x0, 3);
            assert!(v3 > 0, 2);
            assert!(0x2::coin::value<SSUI>(&arg1) >= v3, 2);
            let v4 = 0x2::coin::split<SSUI>(&mut arg1, v3, arg4);
            let v5 = if (arg0.transfer_fee_bps > 0) {
                (((v3 as u128) * (arg0.transfer_fee_bps as u128) / 10000) as u64)
            } else {
                0
            };
            if (v5 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<SSUI>>(0x2::coin::split<SSUI>(&mut v4, v5, arg4), arg0.fee_recipient);
                arg0.total_fees_collected = arg0.total_fees_collected + v5;
                let v6 = FeeCollectedEvent{
                    recipient : arg0.fee_recipient,
                    amount    : v5,
                };
                0x2::event::emit<FeeCollectedEvent>(v6);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<SSUI>>(v4, v2);
            let v7 = TransferEvent{
                from   : v0,
                to     : v2,
                amount : v3,
                fee    : v5,
            };
            0x2::event::emit<TransferEvent>(v7);
            v1 = v1 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<SSUI>>(arg1, v0);
    }

    public fun calculate_transfer_fee(arg0: &TokenRegistry, arg1: u64) : u64 {
        if (arg0.transfer_fee_bps > 0) {
            (((arg1 as u128) * (arg0.transfer_fee_bps as u128) / 10000) as u64)
        } else {
            0
        }
    }

    public entry fun cancel_multisig_action(arg0: &AdminCap, arg1: PendingAction, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.owner == v0, 1);
        let PendingAction {
            id             : v1,
            action_type    : _,
            target_address : _,
            amount         : _,
            execute_after  : _,
            signatures     : _,
            created_at     : _,
        } = arg1;
        0x2::object::delete(v1);
        let v8 = MultisigActionCancelledEvent{
            action_id    : 0x2::object::id<PendingAction>(&arg1),
            cancelled_by : v0,
        };
        0x2::event::emit<MultisigActionCancelledEvent>(v8);
    }

    public entry fun cancel_timelocked_action(arg0: &AdminCap, arg1: TimelockedAction, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        assert!(!arg1.executed, 10);
        let TimelockedAction {
            id             : v0,
            action_type    : _,
            target_address : _,
            amount         : _,
            execute_after  : _,
            created_at     : _,
            executed       : _,
        } = arg1;
        0x2::object::delete(v0);
        let v7 = TimelockCancelledEvent{
            action_id    : 0x2::object::id<TimelockedAction>(&arg1),
            cancelled_by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<TimelockCancelledEvent>(v7);
    }

    public entry fun create_kiosk_listing(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 1);
        let (v0, v1) = 0x2::kiosk::new(arg1);
        let v2 = v0;
        let v3 = 0x2::object::id<0x2::kiosk::Kiosk>(&v2);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, 0x2::tx_context::sender(arg1));
        let v4 = KioskListing{
            id            : 0x2::object::new(arg1),
            kiosk_id      : v3,
            listing_count : 0,
        };
        0x2::transfer::public_share_object<KioskListing>(v4);
        let v5 = KioskListedEvent{
            kiosk_id : v3,
            amount   : 0,
            price    : 0,
        };
        0x2::event::emit<KioskListedEvent>(v5);
    }

    public entry fun create_multisig_action(arg0: &mut MultisigConfig, arg1: u8, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(is_multisig_signer(arg0, v0), 13);
        assert!(arg1 >= 1 && arg1 <= 3, 19);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg4);
        let v2 = v1 + 172800000;
        let v3 = PendingAction{
            id             : 0x2::object::new(arg4),
            action_type    : arg1,
            target_address : arg2,
            amount         : arg3,
            execute_after  : v2,
            signatures     : 0x1::vector::empty<address>(),
            created_at     : v1,
        };
        0x1::vector::push_back<address>(&mut v3.signatures, v0);
        arg0.nonce = arg0.nonce + 1;
        0x2::transfer::public_share_object<PendingAction>(v3);
        let v4 = MultisigActionCreatedEvent{
            action_id      : 0x2::object::id<PendingAction>(&v3),
            action_type    : arg1,
            target_address : arg2,
            amount         : arg3,
            execute_after  : v2,
        };
        0x2::event::emit<MultisigActionCreatedEvent>(v4);
    }

    public entry fun create_timelocked_action(arg0: &AdminCap, arg1: u8, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 1);
        assert!(arg1 >= 1 && arg1 <= 3, 19);
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg4);
        let v1 = v0 + 172800000;
        let v2 = TimelockedAction{
            id             : 0x2::object::new(arg4),
            action_type    : arg1,
            target_address : arg2,
            amount         : arg3,
            execute_after  : v1,
            created_at     : v0,
            executed       : false,
        };
        0x2::transfer::public_share_object<TimelockedAction>(v2);
        let v3 = TimelockCreatedEvent{
            action_id     : 0x2::object::id<TimelockedAction>(&v2),
            action_type   : arg1,
            execute_after : v1,
        };
        0x2::event::emit<TimelockCreatedEvent>(v3);
    }

    public entry fun creator_deposit_tokens(arg0: &mut TokenRegistry, arg1: &AdminCap, arg2: 0x2::coin::Coin<SSUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 1);
        assert!(0x2::coin::value<SSUI>(&arg2) > 0, 2);
        0x2::balance::join<SSUI>(&mut arg0.contract_supply_balance, 0x2::coin::into_balance<SSUI>(arg2));
    }

    public entry fun disable_allowlist(arg0: &mut TransferAllowlist, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 1);
        assert!(arg0.admin_cap_id == 0x2::object::id<AdminCap>(arg1), 17);
        assert!(arg0.enabled, 6);
        arg0.enabled = false;
        let v0 = AllowlistUpdatedEvent{
            action  : 0x1::string::utf8(b"disable"),
            address : @0x0,
            enabled : false,
        };
        0x2::event::emit<AllowlistUpdatedEvent>(v0);
    }

    public entry fun distribute_contract_tokens(arg0: &mut TokenRegistry, arg1: &AdminCap, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg4), 1);
        assert!(arg2 != @0x0, 3);
        assert!(arg3 > 0, 2);
        assert!(0x2::balance::value<SSUI>(&arg0.contract_supply_balance) >= arg3, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<SSUI>>(0x2::coin::from_balance<SSUI>(0x2::balance::split<SSUI>(&mut arg0.contract_supply_balance, arg3), arg4), arg2);
        let v0 = ContractTokensDistributedEvent{
            recipient : arg2,
            amount    : arg3,
        };
        0x2::event::emit<ContractTokensDistributedEvent>(v0);
    }

    public entry fun enable_allowlist(arg0: &mut TransferAllowlist, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 1);
        assert!(arg0.admin_cap_id == 0x2::object::id<AdminCap>(arg1), 17);
        assert!(!arg0.enabled, 5);
        arg0.enabled = true;
        let v0 = AllowlistUpdatedEvent{
            action  : 0x1::string::utf8(b"enable"),
            address : @0x0,
            enabled : true,
        };
        0x2::event::emit<AllowlistUpdatedEvent>(v0);
    }

    public entry fun execute_multisig_action(arg0: &MultisigConfig, arg1: PendingAction, arg2: &mut TokenRegistry, arg3: &AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg3.owner == v0 || is_multisig_signer(arg0, v0), 13);
        assert!(0x1::vector::length<address>(&arg1.signatures) >= arg0.threshold, 11);
        assert!(0x2::tx_context::epoch_timestamp_ms(arg4) >= arg1.execute_after, 9);
        let v1 = arg1.action_type;
        assert!(v1 != 1, 19);
        if (v1 == 2) {
            assert!(arg1.amount <= 1000, 16);
            arg2.transfer_fee_bps = arg1.amount;
            let v2 = TransferFeeUpdatedEvent{
                old_fee_bps : arg2.transfer_fee_bps,
                new_fee_bps : arg1.amount,
            };
            0x2::event::emit<TransferFeeUpdatedEvent>(v2);
        } else {
            assert!(v1 == 3, 19);
            arg2.is_paused = !arg2.is_paused;
            let v3 = PauseEvent{
                paused : arg2.is_paused,
                reason : 0x1::string::utf8(b"multisig action"),
            };
            0x2::event::emit<PauseEvent>(v3);
        };
        let PendingAction {
            id             : v4,
            action_type    : _,
            target_address : _,
            amount         : _,
            execute_after  : _,
            signatures     : _,
            created_at     : _,
        } = arg1;
        0x2::object::delete(v4);
        let v11 = MultisigActionExecutedEvent{
            action_id   : 0x2::object::id<PendingAction>(&arg1),
            action_type : v1,
            executed_by : v0,
        };
        0x2::event::emit<MultisigActionExecutedEvent>(v11);
    }

    public entry fun execute_multisig_ownership_transfer(arg0: &MultisigConfig, arg1: PendingAction, arg2: AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg2.owner == v0 || is_multisig_signer(arg0, v0), 13);
        assert!(0x1::vector::length<address>(&arg1.signatures) >= arg0.threshold, 11);
        assert!(0x2::tx_context::epoch_timestamp_ms(arg3) >= arg1.execute_after, 9);
        let v1 = arg1.action_type;
        assert!(v1 == 1, 19);
        let v2 = arg1.target_address;
        assert!(v2 != @0x0, 3);
        arg2.owner = v2;
        0x2::transfer::transfer<AdminCap>(arg2, v2);
        let PendingAction {
            id             : v3,
            action_type    : _,
            target_address : _,
            amount         : _,
            execute_after  : _,
            signatures     : _,
            created_at     : _,
        } = arg1;
        0x2::object::delete(v3);
        let v10 = MultisigActionExecutedEvent{
            action_id   : 0x2::object::id<PendingAction>(&arg1),
            action_type : v1,
            executed_by : v0,
        };
        0x2::event::emit<MultisigActionExecutedEvent>(v10);
        let v11 = OwnershipTransferredEvent{
            old_owner : arg2.owner,
            new_owner : v2,
        };
        0x2::event::emit<OwnershipTransferredEvent>(v11);
    }

    public entry fun execute_timelocked_action(arg0: &AdminCap, arg1: TimelockedAction, arg2: &mut TokenRegistry, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 1);
        assert!(!arg1.executed, 10);
        assert!(0x2::tx_context::epoch_timestamp_ms(arg3) >= arg1.execute_after, 9);
        let v0 = arg1.action_type;
        if (v0 == 1) {
            assert!(arg1.amount <= 1000, 16);
            arg2.transfer_fee_bps = arg1.amount;
            let v1 = TransferFeeUpdatedEvent{
                old_fee_bps : arg2.transfer_fee_bps,
                new_fee_bps : arg1.amount,
            };
            0x2::event::emit<TransferFeeUpdatedEvent>(v1);
        } else if (v0 == 2) {
            assert!(arg1.target_address != @0x0, 3);
            arg2.fee_recipient = arg1.target_address;
            let v2 = FeeRecipientUpdatedEvent{
                old_recipient : arg2.fee_recipient,
                new_recipient : arg1.target_address,
            };
            0x2::event::emit<FeeRecipientUpdatedEvent>(v2);
        } else {
            assert!(v0 == 3, 19);
            arg2.is_paused = !arg2.is_paused;
            let v3 = PauseEvent{
                paused : arg2.is_paused,
                reason : 0x1::string::utf8(b"timelock action"),
            };
            0x2::event::emit<PauseEvent>(v3);
        };
        let TimelockedAction {
            id             : v4,
            action_type    : _,
            target_address : _,
            amount         : _,
            execute_after  : _,
            created_at     : _,
            executed       : _,
        } = arg1;
        0x2::object::delete(v4);
        let v11 = TimelockExecutedEvent{
            action_id   : 0x2::object::id<TimelockedAction>(&arg1),
            action_type : v0,
            executed_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<TimelockExecutedEvent>(v11);
    }

    public fun get_allowlist_count(arg0: &TransferAllowlist) : u64 {
        0x1::vector::length<address>(&arg0.allowlist)
    }

    public fun get_authorized_minters(arg0: &TokenRegistry) : vector<address> {
        arg0.authorized_minters
    }

    public fun get_circulating_supply(arg0: &TokenRegistry) : u64 {
        arg0.total_minted - arg0.total_burned
    }

    public fun get_contract_supply() : u64 {
        0
    }

    public fun get_creator_supply() : u64 {
        1100000000000000000
    }

    public fun get_display_id(arg0: &DisplayConfig) : 0x2::object::ID {
        arg0.display_id
    }

    public fun get_display_info(arg0: &SSUIDisplay) : (0x1::string::String, 0x1::string::String, 0x1::ascii::String, u8) {
        (arg0.name, arg0.description, arg0.symbol, arg0.decimals)
    }

    public fun get_logo_url_constant() : vector<u8> {
        b"https://i.postimg.cc/RVMd9xh5/Super-SUI-token-logo.png"
    }

    public fun get_logo_url_string() : 0x1::string::String {
        0x1::string::utf8(b"https://i.postimg.cc/RVMd9xh5/Super-SUI-token-logo.png")
    }

    public fun get_metadata_id(arg0: &TokenRegistry) : 0x2::object::ID {
        arg0.metadata_id
    }

    public fun get_multisig_info(arg0: &MultisigConfig) : (vector<address>, u64, u64) {
        (arg0.signers, arg0.threshold, arg0.nonce)
    }

    public fun get_owner(arg0: &AdminCap) : address {
        arg0.owner
    }

    public fun get_pending_action_info(arg0: &PendingAction) : (u8, address, u64, u64, u64) {
        (arg0.action_type, arg0.target_address, arg0.amount, arg0.execute_after, 0x1::vector::length<address>(&arg0.signatures))
    }

    public fun get_remaining_contract_supply(arg0: &TokenRegistry) : u64 {
        0x2::balance::value<SSUI>(&arg0.contract_supply_balance)
    }

    public fun get_total_burned(arg0: &TokenRegistry) : u64 {
        arg0.total_burned
    }

    public fun get_total_fees_collected(arg0: &TokenRegistry) : u64 {
        arg0.total_fees_collected
    }

    public fun get_total_minted(arg0: &TokenRegistry) : u64 {
        arg0.total_minted
    }

    public fun get_total_supply() : u64 {
        1100000000000000000
    }

    public fun get_transfer_fee_info(arg0: &TokenRegistry) : (u64, address) {
        (arg0.transfer_fee_bps, arg0.fee_recipient)
    }

    fun init(arg0: SSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SSUI>(arg0, 9, b"SSUI", b"SSUI", b"SuperSui Token - The native token for the SuperSUI platform", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/RVMd9xh5/Super-SUI-token-logo.png")), arg1);
        let v3 = v2;
        let v4 = 0x2::object::id<0x2::coin::CoinMetadata<SSUI>>(&v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSUI>>(v3);
        let v5 = MetadataCreatedEvent{
            metadata_id : v4,
            symbol      : 0x2::coin::get_symbol<SSUI>(&v3),
            name        : 0x2::coin::get_name<SSUI>(&v3),
            decimals    : 0x2::coin::get_decimals<SSUI>(&v3),
            logo_url    : b"https://i.postimg.cc/RVMd9xh5/Super-SUI-token-logo.png",
        };
        0x2::event::emit<MetadataCreatedEvent>(v5);
        let v6 = TokenRegistry{
            id                      : 0x2::object::new(arg1),
            treasury_cap            : v1,
            total_minted            : 0,
            total_burned            : 0,
            metadata_id             : v4,
            contract_supply_balance : 0x2::balance::zero<SSUI>(),
            authorized_minters      : 0x1::vector::empty<address>(),
            transfer_fee_bps        : 0,
            fee_recipient           : v0,
            is_paused               : false,
            total_fees_collected    : 0,
        };
        0x2::coin::mint_and_transfer<SSUI>(&mut v6.treasury_cap, 1100000000000000000, v0, arg1);
        v6.total_minted = 1100000000000000000;
        let v7 = AdminCap{
            id    : 0x2::object::new(arg1),
            owner : v0,
        };
        0x2::transfer::transfer<AdminCap>(v7, v0);
        0x2::transfer::public_share_object<TokenRegistry>(v6);
    }

    public entry fun init_multisig(arg0: &AdminCap, arg1: vector<address>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 1);
        assert!(arg2 > 0, 11);
        assert!(0x1::vector::length<address>(&arg1) <= 10, 11);
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg1)) {
            let v2 = *0x1::vector::borrow<address>(&arg1, v1);
            assert!(v2 != @0x0, 3);
            let v3 = 0;
            let v4 = false;
            while (v3 < 0x1::vector::length<address>(&v0)) {
                if (*0x1::vector::borrow<address>(&v0, v3) == v2) {
                    v4 = true;
                    break
                };
                v3 = v3 + 1;
            };
            if (!v4) {
                0x1::vector::push_back<address>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        assert!(arg2 <= 0x1::vector::length<address>(&v0), 11);
        let v5 = MultisigConfig{
            id        : 0x2::object::new(arg3),
            signers   : v0,
            threshold : arg2,
            nonce     : 0,
        };
        0x2::transfer::public_share_object<MultisigConfig>(v5);
    }

    public entry fun init_transfer_allowlist(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 1);
        let v0 = TransferAllowlist{
            id           : 0x2::object::new(arg1),
            enabled      : false,
            allowlist    : 0x1::vector::empty<address>(),
            admin_cap_id : 0x2::object::id<AdminCap>(arg0),
        };
        0x2::transfer::public_share_object<TransferAllowlist>(v0);
    }

    public fun is_allowlist_enabled(arg0: &TransferAllowlist) : bool {
        arg0.enabled
    }

    public fun is_allowlisted(arg0: &TransferAllowlist, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.allowlist)) {
            if (*0x1::vector::borrow<address>(&arg0.allowlist, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_authorized_minter(arg0: &TokenRegistry, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.authorized_minters)) {
            if (*0x1::vector::borrow<address>(&arg0.authorized_minters, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_multisig_signer(arg0: &MultisigConfig, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.signers)) {
            if (*0x1::vector::borrow<address>(&arg0.signers, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_owner(arg0: &AdminCap, arg1: address) : bool {
        arg0.owner == arg1
    }

    public fun is_paused(arg0: &TokenRegistry) : bool {
        arg0.is_paused
    }

    public fun is_timelock_ready(arg0: &TimelockedAction, arg1: &0x2::tx_context::TxContext) : bool {
        0x2::tx_context::epoch_timestamp_ms(arg1) >= arg0.execute_after && !arg0.executed
    }

    public entry fun list_in_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut KioskListing, arg3: 0x2::coin::Coin<SSUI>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::kiosk::place<0x2::coin::Coin<SSUI>>(arg0, arg1, arg3);
        0x2::kiosk::list<0x2::coin::Coin<SSUI>>(arg0, arg1, 0x2::object::id<0x2::coin::Coin<SSUI>>(&arg3), arg4);
        arg2.listing_count = arg2.listing_count + 1;
        let v0 = KioskListedEvent{
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            amount   : 0x2::coin::value<SSUI>(&arg3),
            price    : arg4,
        };
        0x2::event::emit<KioskListedEvent>(v0);
    }

    public fun mint_from_contract(arg0: &mut TokenRegistry, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 14);
        assert!(arg1 != @0x0, 3);
        assert!(arg2 > 0, 2);
        assert!(0x2::balance::value<SSUI>(&arg0.contract_supply_balance) >= arg2, 2);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0;
        let v2 = false;
        while (v1 < 0x1::vector::length<address>(&arg0.authorized_minters)) {
            if (*0x1::vector::borrow<address>(&arg0.authorized_minters, v1) == v0) {
                v2 = true;
                break
            };
            v1 = v1 + 1;
        };
        assert!(v2, 15);
        0x2::transfer::public_transfer<0x2::coin::Coin<SSUI>>(0x2::coin::from_balance<SSUI>(0x2::balance::split<SSUI>(&mut arg0.contract_supply_balance, arg2), arg3), arg1);
        let v3 = TransferEvent{
            from   : v0,
            to     : arg1,
            amount : arg2,
            fee    : 0,
        };
        0x2::event::emit<TransferEvent>(v3);
    }

    public entry fun mint_with_fee(arg0: &mut TokenRegistry, arg1: address, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 14);
        assert!(arg1 != @0x0, 3);
        assert!(arg2 > 0, 2);
        assert!(arg3 <= 1000, 16);
        if (arg3 > 0) {
            assert!(arg4 != @0x0, 3);
        };
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<address>(&arg0.authorized_minters)) {
            if (*0x1::vector::borrow<address>(&arg0.authorized_minters, v0) == 0x2::tx_context::sender(arg5)) {
                v1 = true;
                break
            };
            v0 = v0 + 1;
        };
        assert!(v1, 15);
        let v2 = if (arg3 > 0) {
            (((arg2 as u128) * (arg3 as u128) / 10000) as u64)
        } else {
            0
        };
        let v3 = arg2 - v2;
        assert!(0x2::balance::value<SSUI>(&arg0.contract_supply_balance) >= v3 + v2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<SSUI>>(0x2::coin::from_balance<SSUI>(0x2::balance::split<SSUI>(&mut arg0.contract_supply_balance, v3), arg5), arg1);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SSUI>>(0x2::coin::from_balance<SSUI>(0x2::balance::split<SSUI>(&mut arg0.contract_supply_balance, v2), arg5), arg4);
            arg0.total_fees_collected = arg0.total_fees_collected + v2;
            let v4 = FeeCollectedEvent{
                recipient : arg4,
                amount    : v2,
            };
            0x2::event::emit<FeeCollectedEvent>(v4);
        };
    }

    public entry fun remove_authorized_minter(arg0: &mut TokenRegistry, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 1);
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<address>(&arg0.authorized_minters)) {
            if (*0x1::vector::borrow<address>(&arg0.authorized_minters, v0) == arg2) {
                0x1::vector::remove<address>(&mut arg0.authorized_minters, v0);
                v1 = true;
                break
            };
            v0 = v0 + 1;
        };
        assert!(v1, 23);
    }

    public entry fun remove_from_allowlist(arg0: &mut TransferAllowlist, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 1);
        assert!(arg0.admin_cap_id == 0x2::object::id<AdminCap>(arg1), 17);
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<address>(&arg0.allowlist)) {
            if (*0x1::vector::borrow<address>(&arg0.allowlist, v0) == arg2) {
                0x1::vector::remove<address>(&mut arg0.allowlist, v0);
                v1 = true;
                break
            };
            v0 = v0 + 1;
        };
        assert!(v1, 8);
        let v2 = AllowlistUpdatedEvent{
            action  : 0x1::string::utf8(b"remove"),
            address : arg2,
            enabled : arg0.enabled,
        };
        0x2::event::emit<AllowlistUpdatedEvent>(v2);
    }

    public entry fun remove_multisig_signer(arg0: &mut MultisigConfig, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 1);
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x1::vector::length<address>(&arg0.signers)) {
            if (*0x1::vector::borrow<address>(&arg0.signers, v0) == arg2) {
                0x1::vector::remove<address>(&mut arg0.signers, v0);
                v1 = true;
                break
            };
            v0 = v0 + 1;
        };
        assert!(v1, 13);
        assert!(arg0.threshold <= 0x1::vector::length<address>(&arg0.signers), 11);
        let v2 = MultisigSignerRemovedEvent{signer: arg2};
        0x2::event::emit<MultisigSignerRemovedEvent>(v2);
    }

    public entry fun set_fee_recipient(arg0: &mut TokenRegistry, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 1);
        assert!(arg2 != @0x0, 3);
        arg0.fee_recipient = arg2;
        let v0 = FeeRecipientUpdatedEvent{
            old_recipient : arg0.fee_recipient,
            new_recipient : arg2,
        };
        0x2::event::emit<FeeRecipientUpdatedEvent>(v0);
    }

    public entry fun set_pause(arg0: &mut TokenRegistry, arg1: &AdminCap, arg2: bool, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg4), 1);
        arg0.is_paused = arg2;
        let v0 = PauseEvent{
            paused : arg2,
            reason : arg3,
        };
        0x2::event::emit<PauseEvent>(v0);
    }

    public entry fun set_transfer_fee(arg0: &mut TokenRegistry, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 1);
        assert!(arg2 <= 1000, 16);
        arg0.transfer_fee_bps = arg2;
        let v0 = TransferFeeUpdatedEvent{
            old_fee_bps : arg0.transfer_fee_bps,
            new_fee_bps : arg2,
        };
        0x2::event::emit<TransferFeeUpdatedEvent>(v0);
    }

    public entry fun setup_display(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 1);
        let v0 = SSUIDisplay{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"SuperSui Token"),
            description : 0x1::string::utf8(b"The native token for the SuperSUI platform - Powering the future of decentralized applications on Sui"),
            symbol      : 0x1::ascii::string(b"SSUI"),
            decimals    : 9,
            icon_url    : 0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/RVMd9xh5/Super-SUI-token-logo.png"),
            project_url : 0x2::url::new_unsafe_from_bytes(b"https://supersui.io"),
        };
        let v1 = 0x2::object::id<SSUIDisplay>(&v0);
        0x2::transfer::public_share_object<SSUIDisplay>(v0);
        let v2 = DisplayConfig{
            id         : 0x2::object::new(arg1),
            display_id : v1,
        };
        0x2::transfer::public_share_object<DisplayConfig>(v2);
        let v3 = DisplayConfiguredEvent{
            display_id  : v1,
            name        : 0x1::string::utf8(b"SuperSui Token"),
            description : 0x1::string::utf8(b"The native token for the SuperSUI platform"),
            project_url : 0x1::string::utf8(b"https://supersui.io"),
        };
        0x2::event::emit<DisplayConfiguredEvent>(v3);
    }

    public entry fun sign_multisig_action(arg0: &MultisigConfig, arg1: &mut PendingAction, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_multisig_signer(arg0, v0), 13);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg1.signatures)) {
            if (*0x1::vector::borrow<address>(&arg1.signatures, v1) == v0) {
                abort 12
            };
            v1 = v1 + 1;
        };
        0x1::vector::push_back<address>(&mut arg1.signatures, v0);
        let v2 = MultisigActionSignedEvent{
            action_id       : 0x2::object::id<PendingAction>(arg1),
            signer          : v0,
            signature_count : 0x1::vector::length<address>(&arg1.signatures),
            threshold       : arg0.threshold,
        };
        0x2::event::emit<MultisigActionSignedEvent>(v2);
    }

    public fun transfer_from_contract(arg0: &mut TokenRegistry, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 14);
        assert!(arg1 != @0x0, 3);
        assert!(arg2 > 0, 2);
        assert!(0x2::balance::value<SSUI>(&arg0.contract_supply_balance) >= arg2, 2);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0;
        let v2 = false;
        while (v1 < 0x1::vector::length<address>(&arg0.authorized_minters)) {
            if (*0x1::vector::borrow<address>(&arg0.authorized_minters, v1) == v0) {
                v2 = true;
                break
            };
            v1 = v1 + 1;
        };
        assert!(v2, 15);
        0x2::transfer::public_transfer<0x2::coin::Coin<SSUI>>(0x2::coin::from_balance<SSUI>(0x2::balance::split<SSUI>(&mut arg0.contract_supply_balance, arg2), arg3), arg1);
        let v3 = TransferEvent{
            from   : v0,
            to     : arg1,
            amount : arg2,
            fee    : 0,
        };
        0x2::event::emit<TransferEvent>(v3);
    }

    public entry fun transfer_from_contract_admin(arg0: &mut TokenRegistry, arg1: &AdminCap, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg4), 1);
        assert!(arg2 != @0x0, 3);
        assert!(arg3 > 0, 2);
        assert!(0x2::balance::value<SSUI>(&arg0.contract_supply_balance) >= arg3, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<SSUI>>(0x2::coin::from_balance<SSUI>(0x2::balance::split<SSUI>(&mut arg0.contract_supply_balance, arg3), arg4), arg2);
        let v0 = TransferEvent{
            from   : 0x2::tx_context::sender(arg4),
            to     : arg2,
            amount : arg3,
            fee    : 0,
        };
        0x2::event::emit<TransferEvent>(v0);
    }

    public entry fun transfer_ownership(arg0: AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        assert!(arg1 != @0x0, 3);
        arg0.owner = arg1;
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
        let v0 = OwnershipTransferredEvent{
            old_owner : arg0.owner,
            new_owner : arg1,
        };
        0x2::event::emit<OwnershipTransferredEvent>(v0);
    }

    public entry fun transfer_with_allowlist_check(arg0: &mut TokenRegistry, arg1: &TransferAllowlist, arg2: 0x2::coin::Coin<SSUI>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 14);
        assert!(arg3 != @0x0, 3);
        if (arg1.enabled) {
            assert!(is_allowlisted(arg1, arg3), 4);
        };
        let v0 = 0x2::coin::value<SSUI>(&arg2);
        let v1 = if (arg0.transfer_fee_bps > 0) {
            (((v0 as u128) * (arg0.transfer_fee_bps as u128) / 10000) as u64)
        } else {
            0
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SSUI>>(0x2::coin::split<SSUI>(&mut arg2, v1, arg4), arg0.fee_recipient);
            arg0.total_fees_collected = arg0.total_fees_collected + v1;
            let v2 = FeeCollectedEvent{
                recipient : arg0.fee_recipient,
                amount    : v1,
            };
            0x2::event::emit<FeeCollectedEvent>(v2);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<SSUI>>(arg2, arg3);
        let v3 = TransferEvent{
            from   : 0x2::tx_context::sender(arg4),
            to     : arg3,
            amount : v0,
            fee    : v1,
        };
        0x2::event::emit<TransferEvent>(v3);
    }

    public entry fun transfer_with_fee(arg0: &mut TokenRegistry, arg1: 0x2::coin::Coin<SSUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 14);
        assert!(arg2 != @0x0, 3);
        let v0 = 0x2::coin::value<SSUI>(&arg1);
        let v1 = if (arg0.transfer_fee_bps > 0) {
            (((v0 as u128) * (arg0.transfer_fee_bps as u128) / 10000) as u64)
        } else {
            0
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SSUI>>(0x2::coin::split<SSUI>(&mut arg1, v1, arg3), arg0.fee_recipient);
            arg0.total_fees_collected = arg0.total_fees_collected + v1;
            let v2 = FeeCollectedEvent{
                recipient : arg0.fee_recipient,
                amount    : v1,
            };
            0x2::event::emit<FeeCollectedEvent>(v2);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<SSUI>>(arg1, arg2);
        let v3 = TransferEvent{
            from   : 0x2::tx_context::sender(arg3),
            to     : arg2,
            amount : v0,
            fee    : v1,
        };
        0x2::event::emit<TransferEvent>(v3);
    }

    public entry fun update_display(arg0: &mut SSUIDisplay, arg1: &AdminCap, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg5), 1);
        arg0.name = 0x1::string::utf8(arg2);
        arg0.description = 0x1::string::utf8(arg3);
        arg0.project_url = 0x2::url::new_unsafe_from_bytes(arg4);
    }

    public entry fun update_multisig_threshold(arg0: &mut MultisigConfig, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 1);
        assert!(arg2 > 0, 11);
        assert!(arg2 <= 0x1::vector::length<address>(&arg0.signers), 11);
        arg0.threshold = arg2;
    }

    // decompiled from Move bytecode v6
}

