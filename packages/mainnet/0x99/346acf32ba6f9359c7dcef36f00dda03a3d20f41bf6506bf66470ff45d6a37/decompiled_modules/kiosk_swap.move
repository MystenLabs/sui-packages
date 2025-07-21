module 0x99346acf32ba6f9359c7dcef36f00dda03a3d20f41bf6506bf66470ff45d6a37::kiosk_swap {
    struct KIOSK_SWAP has drop {
        dummy_field: bool,
    }

    struct SwapAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ProtocolConfig has key {
        id: 0x2::object::UID,
        protocol_fee: u64,
        fee_recipient: address,
        total_fees_collected: u64,
    }

    struct ProtocolTreasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct SwapProposal has store, key {
        id: 0x2::object::UID,
        proposer: address,
        counterparty: 0x1::option::Option<address>,
        proposer_nft_ids: vector<0x2::object::ID>,
        counterparty_nft_ids: vector<0x2::object::ID>,
        proposer_sui_amount: u64,
        counterparty_sui_amount: u64,
        protocol_fee_paid: u64,
        expires_at: u64,
        state: u8,
    }

    struct SwapEscrow has key {
        id: 0x2::object::UID,
        proposal_id: 0x2::object::ID,
        proposer_kiosk_id: 0x2::object::ID,
        proposer_kiosk_cap: 0x1::option::Option<0x2::kiosk::KioskOwnerCap>,
        proposer_sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        counterparty_kiosk_id: 0x1::option::Option<0x2::object::ID>,
        counterparty_kiosk_cap: 0x1::option::Option<0x2::kiosk::KioskOwnerCap>,
        counterparty_sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        protocol_fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct SwapProposed has copy, drop {
        proposal_id: 0x2::object::ID,
        proposer: address,
        counterparty: 0x1::option::Option<address>,
        proposer_nft_ids: vector<0x2::object::ID>,
        counterparty_nft_ids: vector<0x2::object::ID>,
        proposer_sui_amount: u64,
        counterparty_sui_amount: u64,
        protocol_fee_paid: u64,
        expires_at: u64,
    }

    struct ProposerKioskDeposited has copy, drop {
        proposal_id: 0x2::object::ID,
        proposer: address,
        kiosk_id: 0x2::object::ID,
        nft_ids: vector<0x2::object::ID>,
    }

    struct ProposerSUIDeposited has copy, drop {
        proposal_id: 0x2::object::ID,
        proposer: address,
        amount: u64,
    }

    struct CounterpartyKioskDeposited has copy, drop {
        proposal_id: 0x2::object::ID,
        counterparty: address,
        kiosk_id: 0x2::object::ID,
        nft_ids: vector<0x2::object::ID>,
    }

    struct CounterpartySUIDeposited has copy, drop {
        proposal_id: 0x2::object::ID,
        counterparty: address,
        amount: u64,
    }

    struct SwapExecuted has copy, drop {
        proposal_id: 0x2::object::ID,
        proposer: address,
        counterparty: address,
        proposer_nft_ids: vector<0x2::object::ID>,
        counterparty_nft_ids: vector<0x2::object::ID>,
        proposer_sui_amount: u64,
        counterparty_sui_amount: u64,
        protocol_fee_paid: u64,
        proposer_kiosk_id: 0x2::object::ID,
        counterparty_kiosk_id: 0x2::object::ID,
        proposer_kiosk_cap_id: 0x2::object::ID,
        counterparty_kiosk_cap_id: 0x2::object::ID,
    }

    struct SwapCancelled has copy, drop {
        proposal_id: 0x2::object::ID,
        cancelled_by: address,
        protocol_fee_refunded: u64,
    }

    struct TransferEvent has copy, drop {
        receiver: address,
        sender: address,
        nft_id: 0x2::object::ID,
    }

    struct ProtocolFeeUpdated has copy, drop {
        old_fee: u64,
        new_fee: u64,
        updated_by: address,
    }

    struct ProtocolFeesWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
        withdrawn_by: address,
    }

    fun assert_no_listed_items(arg0: &0x2::kiosk::Kiosk, arg1: &vector<0x2::object::ID>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg1)) {
            let v1 = *0x1::vector::borrow<0x2::object::ID>(arg1, v0);
            assert!(!0x2::kiosk::is_listed(arg0, v1), 5);
            assert!(!0x2::kiosk::is_listed_exclusively(arg0, v1), 5);
            v0 = v0 + 1;
        };
    }

    public fun cancel_swap(arg0: &mut SwapProposal, arg1: &mut SwapEscrow, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.expires_at || v0 == arg0.proposer || v0 == *0x1::option::borrow<address>(&arg0.counterparty), 2);
        assert!(arg0.state != 3, 5);
        assert!(arg0.state != 4, 5);
        assert!(arg1.proposal_id == 0x2::object::id<SwapProposal>(arg0), 6);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg1.protocol_fee_balance);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.protocol_fee_balance, v1, arg3), arg0.proposer);
        };
        if (0x1::option::is_some<0x2::kiosk::KioskOwnerCap>(&arg1.proposer_kiosk_cap)) {
            0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(0x1::option::extract<0x2::kiosk::KioskOwnerCap>(&mut arg1.proposer_kiosk_cap), arg0.proposer);
        };
        if (0x1::option::is_some<0x2::kiosk::KioskOwnerCap>(&arg1.counterparty_kiosk_cap)) {
            0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(0x1::option::extract<0x2::kiosk::KioskOwnerCap>(&mut arg1.counterparty_kiosk_cap), *0x1::option::borrow<address>(&arg0.counterparty));
        };
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg1.proposer_sui_balance);
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&arg1.counterparty_sui_balance);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.proposer_sui_balance, v2, arg3), arg0.proposer);
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.counterparty_sui_balance, v3, arg3), *0x1::option::borrow<address>(&arg0.counterparty));
        };
        arg0.state = 4;
        let v4 = SwapCancelled{
            proposal_id           : 0x2::object::id<SwapProposal>(arg0),
            cancelled_by          : v0,
            protocol_fee_refunded : v1,
        };
        0x2::event::emit<SwapCancelled>(v4);
    }

    public fun create_proposal_and_deposit(arg0: vector<0x2::object::ID>, arg1: vector<0x2::object::ID>, arg2: u64, arg3: u64, arg4: address, arg5: &0x2::kiosk::Kiosk, arg6: 0x2::kiosk::KioskOwnerCap, arg7: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &ProtocolConfig, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        validate_kiosk_contents(arg5, &arg0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg8);
        assert!(v0 >= arg9.protocol_fee, 9);
        if (arg2 > 0) {
            assert!(0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&arg7), 8);
            assert!(0x2::coin::value<0x2::sui::SUI>(0x1::option::borrow<0x2::coin::Coin<0x2::sui::SUI>>(&arg7)) == arg2, 8);
        } else {
            assert!(0x1::option::is_none<0x2::coin::Coin<0x2::sui::SUI>>(&arg7), 8);
        };
        let v1 = 0x2::tx_context::sender(arg11);
        let v2 = 0x2::object::id<0x2::kiosk::Kiosk>(arg5);
        let v3 = SwapProposal{
            id                      : 0x2::object::new(arg11),
            proposer                : v1,
            counterparty            : 0x1::option::some<address>(arg4),
            proposer_nft_ids        : arg0,
            counterparty_nft_ids    : arg1,
            proposer_sui_amount     : arg2,
            counterparty_sui_amount : arg3,
            protocol_fee_paid       : v0,
            expires_at              : 0x2::clock::timestamp_ms(arg10) + 86400000,
            state                   : 1,
        };
        let v4 = 0x2::object::id<SwapProposal>(&v3);
        let v5 = 0x2::balance::zero<0x2::sui::SUI>();
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&arg7)) {
            0x2::balance::join<0x2::sui::SUI>(&mut v5, 0x2::coin::into_balance<0x2::sui::SUI>(0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg7)));
        };
        0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(arg7);
        let v6 = SwapEscrow{
            id                       : 0x2::object::new(arg11),
            proposal_id              : v4,
            proposer_kiosk_id        : v2,
            proposer_kiosk_cap       : 0x1::option::some<0x2::kiosk::KioskOwnerCap>(arg6),
            proposer_sui_balance     : v5,
            counterparty_kiosk_id    : 0x1::option::none<0x2::object::ID>(),
            counterparty_kiosk_cap   : 0x1::option::none<0x2::kiosk::KioskOwnerCap>(),
            counterparty_sui_balance : 0x2::balance::zero<0x2::sui::SUI>(),
            protocol_fee_balance     : 0x2::coin::into_balance<0x2::sui::SUI>(arg8),
        };
        let v7 = SwapProposed{
            proposal_id             : v4,
            proposer                : v1,
            counterparty            : 0x1::option::some<address>(arg4),
            proposer_nft_ids        : arg0,
            counterparty_nft_ids    : arg1,
            proposer_sui_amount     : arg2,
            counterparty_sui_amount : arg3,
            protocol_fee_paid       : v0,
            expires_at              : v3.expires_at,
        };
        0x2::event::emit<SwapProposed>(v7);
        let v8 = ProposerKioskDeposited{
            proposal_id : v4,
            proposer    : v1,
            kiosk_id    : v2,
            nft_ids     : arg0,
        };
        0x2::event::emit<ProposerKioskDeposited>(v8);
        if (arg2 > 0) {
            let v9 = ProposerSUIDeposited{
                proposal_id : v4,
                proposer    : v1,
                amount      : arg2,
            };
            0x2::event::emit<ProposerSUIDeposited>(v9);
        };
        0x2::transfer::share_object<SwapEscrow>(v6);
        0x2::transfer::share_object<SwapProposal>(v3);
    }

    public fun deposit_counterparty(arg0: &mut SwapProposal, arg1: &mut SwapEscrow, arg2: &0x2::kiosk::Kiosk, arg3: 0x2::kiosk::KioskOwnerCap, arg4: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(v0 == *0x1::option::borrow<address>(&arg0.counterparty), 2);
        assert!(arg0.state == 1, 5);
        assert!(0x2::clock::timestamp_ms(arg5) < arg0.expires_at, 4);
        assert!(arg1.proposal_id == 0x2::object::id<SwapProposal>(arg0), 6);
        validate_kiosk_contents(arg2, &arg0.counterparty_nft_ids);
        if (arg0.counterparty_sui_amount > 0) {
            assert!(0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&arg4), 8);
            assert!(0x2::coin::value<0x2::sui::SUI>(0x1::option::borrow<0x2::coin::Coin<0x2::sui::SUI>>(&arg4)) == arg0.counterparty_sui_amount, 8);
        } else {
            assert!(0x1::option::is_none<0x2::coin::Coin<0x2::sui::SUI>>(&arg4), 8);
        };
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg2);
        arg1.counterparty_kiosk_id = 0x1::option::some<0x2::object::ID>(v1);
        0x1::option::fill<0x2::kiosk::KioskOwnerCap>(&mut arg1.counterparty_kiosk_cap, arg3);
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&arg4)) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.counterparty_sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg4)));
        };
        0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(arg4);
        arg0.state = 2;
        let v2 = CounterpartyKioskDeposited{
            proposal_id  : 0x2::object::id<SwapProposal>(arg0),
            counterparty : v0,
            kiosk_id     : v1,
            nft_ids      : arg0.counterparty_nft_ids,
        };
        0x2::event::emit<CounterpartyKioskDeposited>(v2);
        if (arg0.counterparty_sui_amount > 0) {
            let v3 = CounterpartySUIDeposited{
                proposal_id  : 0x2::object::id<SwapProposal>(arg0),
                counterparty : v0,
                amount       : arg0.counterparty_sui_amount,
            };
            0x2::event::emit<CounterpartySUIDeposited>(v3);
        };
    }

    fun emit_standard_transfer_events(arg0: vector<0x2::object::ID>, arg1: address, arg2: address) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg0)) {
            let v1 = TransferEvent{
                receiver : arg2,
                sender   : arg1,
                nft_id   : *0x1::vector::borrow<0x2::object::ID>(&arg0, v0),
            };
            0x2::event::emit<TransferEvent>(v1);
            v0 = v0 + 1;
        };
    }

    public fun execute_swap(arg0: &mut SwapProposal, arg1: &mut SwapEscrow, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut ProtocolConfig, arg5: &mut ProtocolTreasury, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(v0 == arg0.proposer || v0 == *0x1::option::borrow<address>(&arg0.counterparty), 2);
        assert!(arg0.state == 2, 5);
        assert!(0x2::clock::timestamp_ms(arg6) < arg0.expires_at, 4);
        assert!(arg1.proposal_id == 0x2::object::id<SwapProposal>(arg0), 6);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == arg1.proposer_kiosk_id, 6);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg3) == *0x1::option::borrow<0x2::object::ID>(&arg1.counterparty_kiosk_id), 6);
        let v1 = *0x1::option::borrow<address>(&arg0.counterparty);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg1.protocol_fee_balance);
        if (v2 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg5.balance, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.protocol_fee_balance));
            arg4.total_fees_collected = arg4.total_fees_collected + v2;
        };
        let v3 = 0x1::option::extract<0x2::kiosk::KioskOwnerCap>(&mut arg1.proposer_kiosk_cap);
        let v4 = 0x1::option::extract<0x2::kiosk::KioskOwnerCap>(&mut arg1.counterparty_kiosk_cap);
        0x2::kiosk::set_owner_custom(arg2, &v3, v1);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, v1);
        0x2::kiosk::set_owner_custom(arg3, &v4, arg0.proposer);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v4, arg0.proposer);
        let v5 = 0x2::balance::value<0x2::sui::SUI>(&arg1.proposer_sui_balance);
        let v6 = 0x2::balance::value<0x2::sui::SUI>(&arg1.counterparty_sui_balance);
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.proposer_sui_balance, v5, arg7), v1);
        };
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.counterparty_sui_balance, v6, arg7), arg0.proposer);
        };
        arg0.state = 3;
        emit_standard_transfer_events(arg0.proposer_nft_ids, arg0.proposer, v1);
        emit_standard_transfer_events(arg0.counterparty_nft_ids, v1, arg0.proposer);
        let v7 = SwapExecuted{
            proposal_id               : 0x2::object::id<SwapProposal>(arg0),
            proposer                  : arg0.proposer,
            counterparty              : v1,
            proposer_nft_ids          : arg0.proposer_nft_ids,
            counterparty_nft_ids      : arg0.counterparty_nft_ids,
            proposer_sui_amount       : v5,
            counterparty_sui_amount   : v6,
            protocol_fee_paid         : arg0.protocol_fee_paid,
            proposer_kiosk_id         : arg1.proposer_kiosk_id,
            counterparty_kiosk_id     : *0x1::option::borrow<0x2::object::ID>(&arg1.counterparty_kiosk_id),
            proposer_kiosk_cap_id     : 0x2::object::id<0x2::kiosk::KioskOwnerCap>(&v3),
            counterparty_kiosk_cap_id : 0x2::object::id<0x2::kiosk::KioskOwnerCap>(&v4),
        };
        0x2::event::emit<SwapExecuted>(v7);
    }

    public fun get_fee_recipient(arg0: &ProtocolConfig) : address {
        arg0.fee_recipient
    }

    public fun get_proposal_details(arg0: &SwapProposal) : (address, 0x1::option::Option<address>, vector<0x2::object::ID>, vector<0x2::object::ID>, u64, u64, u64) {
        (arg0.proposer, arg0.counterparty, arg0.proposer_nft_ids, arg0.counterparty_nft_ids, arg0.proposer_sui_amount, arg0.counterparty_sui_amount, arg0.protocol_fee_paid)
    }

    public fun get_proposal_state(arg0: &SwapProposal) : u8 {
        arg0.state
    }

    public fun get_protocol_fee(arg0: &ProtocolConfig) : u64 {
        arg0.protocol_fee
    }

    public fun get_total_fees_collected(arg0: &ProtocolConfig) : u64 {
        arg0.total_fees_collected
    }

    public fun get_treasury_balance(arg0: &ProtocolTreasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    fun init(arg0: KIOSK_SWAP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SwapAdminCap{id: 0x2::object::new(arg1)};
        let v1 = ProtocolConfig{
            id                   : 0x2::object::new(arg1),
            protocol_fee         : 1000000000,
            fee_recipient        : 0x2::tx_context::sender(arg1),
            total_fees_collected : 0,
        };
        let v2 = ProtocolTreasury{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::transfer<SwapAdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<ProtocolConfig>(v1);
        0x2::transfer::share_object<ProtocolTreasury>(v2);
    }

    public fun is_expired(arg0: &SwapProposal, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.expires_at
    }

    public fun is_ready_for_execution(arg0: &SwapProposal) : bool {
        arg0.state == 2
    }

    public fun refresh_kiosk_ownership_display(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0x2::tx_context::TxContext) {
        0x2::kiosk::set_owner(arg0, arg1, arg2);
    }

    public fun update_fee_recipient(arg0: &SwapAdminCap, arg1: &mut ProtocolConfig, arg2: address) {
        arg1.fee_recipient = arg2;
    }

    public fun update_protocol_fee(arg0: &SwapAdminCap, arg1: &mut ProtocolConfig, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        arg1.protocol_fee = arg2;
        let v0 = ProtocolFeeUpdated{
            old_fee    : arg1.protocol_fee,
            new_fee    : arg2,
            updated_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ProtocolFeeUpdated>(v0);
    }

    fun validate_kiosk_contents(arg0: &0x2::kiosk::Kiosk, arg1: &vector<0x2::object::ID>) {
        let v0 = 0x1::vector::length<0x2::object::ID>(arg1);
        assert!((0x2::kiosk::item_count(arg0) as u64) == v0, 0);
        let v1 = 0;
        while (v1 < v0) {
            assert!(0x2::kiosk::has_item(arg0, *0x1::vector::borrow<0x2::object::ID>(arg1, v1)), 1);
            v1 = v1 + 1;
        };
        assert_no_listed_items(arg0, arg1);
    }

    public fun withdraw_protocol_fees(arg0: &SwapAdminCap, arg1: &ProtocolConfig, arg2: &mut ProtocolTreasury, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg2.balance);
        let v1 = if (arg3 == 0 || arg3 > v0) {
            v0
        } else {
            arg3
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg2.balance, v1, arg4), arg1.fee_recipient);
            let v2 = ProtocolFeesWithdrawn{
                amount       : v1,
                recipient    : arg1.fee_recipient,
                withdrawn_by : 0x2::tx_context::sender(arg4),
            };
            0x2::event::emit<ProtocolFeesWithdrawn>(v2);
        };
    }

    // decompiled from Move bytecode v6
}

