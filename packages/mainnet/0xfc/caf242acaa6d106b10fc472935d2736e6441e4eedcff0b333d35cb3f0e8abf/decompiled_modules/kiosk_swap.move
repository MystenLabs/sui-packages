module 0xfccaf242acaa6d106b10fc472935d2736e6441e4eedcff0b333d35cb3f0e8abf::kiosk_swap {
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
        proposer_kiosk: 0x1::option::Option<0x2::kiosk::Kiosk>,
        proposer_kiosk_cap: 0x1::option::Option<0x2::kiosk::KioskOwnerCap>,
        proposer_sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        counterparty_kiosk: 0x1::option::Option<0x2::kiosk::Kiosk>,
        counterparty_kiosk_cap: 0x1::option::Option<0x2::kiosk::KioskOwnerCap>,
        counterparty_sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct SharedKioskSwapEscrow has key {
        id: 0x2::object::UID,
        proposal_id: 0x2::object::ID,
        proposer_shared_kiosk_id: 0x2::object::ID,
        proposer_kiosk_cap: 0x1::option::Option<0x2::kiosk::KioskOwnerCap>,
        proposer_sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        counterparty_shared_kiosk_id: 0x1::option::Option<0x2::object::ID>,
        counterparty_kiosk_cap: 0x1::option::Option<0x2::kiosk::KioskOwnerCap>,
        counterparty_sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
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

    struct CounterpattySUIDeposited has copy, drop {
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
    }

    struct SwapCancelled has copy, drop {
        proposal_id: 0x2::object::ID,
        cancelled_by: address,
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

    public fun cancel_shared_kiosk_swap(arg0: &mut SwapProposal, arg1: &mut SharedKioskSwapEscrow, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = if (0x2::clock::timestamp_ms(arg2) >= arg0.expires_at) {
            true
        } else {
            let v2 = v0 == arg0.proposer;
            let v1 = v2;
            if (0x1::option::is_some<address>(&arg0.counterparty)) {
                let v3 = v2 || v0 == *0x1::option::borrow<address>(&arg0.counterparty);
                v1 = v3;
            };
            v1
        };
        assert!(v1, 2);
        assert!(arg0.state != 3, 5);
        assert!(arg0.state != 4, 5);
        assert!(arg1.proposal_id == 0x2::object::id<SwapProposal>(arg0), 6);
        if (0x1::option::is_some<0x2::kiosk::KioskOwnerCap>(&arg1.proposer_kiosk_cap)) {
            0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(0x1::option::extract<0x2::kiosk::KioskOwnerCap>(&mut arg1.proposer_kiosk_cap), arg0.proposer);
        };
        if (0x1::option::is_some<0x2::kiosk::KioskOwnerCap>(&arg1.counterparty_kiosk_cap)) {
            0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(0x1::option::extract<0x2::kiosk::KioskOwnerCap>(&mut arg1.counterparty_kiosk_cap), *0x1::option::borrow<address>(&arg0.counterparty));
        };
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&arg1.proposer_sui_balance);
        let v5 = 0x2::balance::value<0x2::sui::SUI>(&arg1.counterparty_sui_balance);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.proposer_sui_balance, v4, arg3), arg0.proposer);
        };
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.counterparty_sui_balance, v5, arg3), *0x1::option::borrow<address>(&arg0.counterparty));
        };
        arg0.state = 4;
        let v6 = SwapCancelled{
            proposal_id  : 0x2::object::id<SwapProposal>(arg0),
            cancelled_by : v0,
        };
        0x2::event::emit<SwapCancelled>(v6);
    }

    public fun cancel_swap(arg0: &mut SwapProposal, arg1: &mut SwapEscrow, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = if (0x2::clock::timestamp_ms(arg2) >= arg0.expires_at) {
            true
        } else {
            let v2 = v0 == arg0.proposer;
            let v1 = v2;
            if (0x1::option::is_some<address>(&arg0.counterparty)) {
                let v3 = v2 || v0 == *0x1::option::borrow<address>(&arg0.counterparty);
                v1 = v3;
            };
            v1
        };
        assert!(v1, 2);
        assert!(arg0.state != 3, 5);
        assert!(arg0.state != 4, 5);
        assert!(arg1.proposal_id == 0x2::object::id<SwapProposal>(arg0), 6);
        if (0x1::option::is_some<0x2::kiosk::Kiosk>(&arg1.proposer_kiosk)) {
            let v4 = 0x1::option::extract<0x2::kiosk::Kiosk>(&mut arg1.proposer_kiosk);
            let v5 = 0x1::option::extract<0x2::kiosk::KioskOwnerCap>(&mut arg1.proposer_kiosk_cap);
            let v6 = 0x2::kiosk::withdraw(&mut v4, &v5, 0x1::option::none<u64>(), arg3);
            if (0x2::coin::value<0x2::sui::SUI>(&v6) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v6, arg0.proposer);
            } else {
                0x2::coin::destroy_zero<0x2::sui::SUI>(v6);
            };
            0x2::transfer::public_transfer<0x2::kiosk::Kiosk>(v4, arg0.proposer);
            0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v5, arg0.proposer);
        };
        if (0x1::option::is_some<0x2::kiosk::Kiosk>(&arg1.counterparty_kiosk)) {
            let v7 = 0x1::option::extract<0x2::kiosk::Kiosk>(&mut arg1.counterparty_kiosk);
            let v8 = 0x1::option::extract<0x2::kiosk::KioskOwnerCap>(&mut arg1.counterparty_kiosk_cap);
            let v9 = *0x1::option::borrow<address>(&arg0.counterparty);
            let v10 = 0x2::kiosk::withdraw(&mut v7, &v8, 0x1::option::none<u64>(), arg3);
            if (0x2::coin::value<0x2::sui::SUI>(&v10) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v10, v9);
            } else {
                0x2::coin::destroy_zero<0x2::sui::SUI>(v10);
            };
            0x2::transfer::public_transfer<0x2::kiosk::Kiosk>(v7, v9);
            0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v8, v9);
        };
        let v11 = 0x2::balance::value<0x2::sui::SUI>(&arg1.proposer_sui_balance);
        let v12 = 0x2::balance::value<0x2::sui::SUI>(&arg1.counterparty_sui_balance);
        if (v11 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.proposer_sui_balance, v11, arg3), arg0.proposer);
        };
        if (v12 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.counterparty_sui_balance, v12, arg3), *0x1::option::borrow<address>(&arg0.counterparty));
        };
        arg0.state = 4;
        let v13 = SwapCancelled{
            proposal_id  : 0x2::object::id<SwapProposal>(arg0),
            cancelled_by : v0,
        };
        0x2::event::emit<SwapCancelled>(v13);
    }

    public fun create_proposal(arg0: vector<0x2::object::ID>, arg1: vector<0x2::object::ID>, arg2: u64, arg3: u64, arg4: 0x1::option::Option<address>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut ProtocolConfig, arg7: &mut ProtocolTreasury, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg5);
        assert!(v0 >= arg6.protocol_fee, 9);
        0x2::balance::join<0x2::sui::SUI>(&mut arg7.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg5));
        arg6.total_fees_collected = arg6.total_fees_collected + v0;
        let v1 = SwapProposal{
            id                      : 0x2::object::new(arg9),
            proposer                : 0x2::tx_context::sender(arg9),
            counterparty            : arg4,
            proposer_nft_ids        : arg0,
            counterparty_nft_ids    : arg1,
            proposer_sui_amount     : arg2,
            counterparty_sui_amount : arg3,
            protocol_fee_paid       : v0,
            expires_at              : 0x2::clock::timestamp_ms(arg8) + 86400000,
            state                   : 0,
        };
        let v2 = 0x2::object::id<SwapProposal>(&v1);
        let v3 = SwapEscrow{
            id                       : 0x2::object::new(arg9),
            proposal_id              : v2,
            proposer_kiosk           : 0x1::option::none<0x2::kiosk::Kiosk>(),
            proposer_kiosk_cap       : 0x1::option::none<0x2::kiosk::KioskOwnerCap>(),
            proposer_sui_balance     : 0x2::balance::zero<0x2::sui::SUI>(),
            counterparty_kiosk       : 0x1::option::none<0x2::kiosk::Kiosk>(),
            counterparty_kiosk_cap   : 0x1::option::none<0x2::kiosk::KioskOwnerCap>(),
            counterparty_sui_balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v4 = SwapProposed{
            proposal_id             : v2,
            proposer                : v1.proposer,
            counterparty            : v1.counterparty,
            proposer_nft_ids        : v1.proposer_nft_ids,
            counterparty_nft_ids    : v1.counterparty_nft_ids,
            proposer_sui_amount     : arg2,
            counterparty_sui_amount : arg3,
            protocol_fee_paid       : v0,
            expires_at              : v1.expires_at,
        };
        0x2::event::emit<SwapProposed>(v4);
        0x2::transfer::share_object<SwapEscrow>(v3);
        0x2::transfer::share_object<SwapProposal>(v1);
    }

    public fun create_proposal_and_deposit_all(arg0: vector<0x2::object::ID>, arg1: vector<0x2::object::ID>, arg2: u64, arg3: u64, arg4: 0x1::option::Option<address>, arg5: 0x2::kiosk::Kiosk, arg6: 0x2::kiosk::KioskOwnerCap, arg7: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut ProtocolConfig, arg10: &mut ProtocolTreasury, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        validate_kiosk_contents(&arg5, &arg0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg8);
        assert!(v0 >= arg9.protocol_fee, 9);
        if (arg2 > 0) {
            assert!(0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&arg7), 8);
            assert!(0x2::coin::value<0x2::sui::SUI>(0x1::option::borrow<0x2::coin::Coin<0x2::sui::SUI>>(&arg7)) == arg2, 8);
        } else {
            assert!(0x1::option::is_none<0x2::coin::Coin<0x2::sui::SUI>>(&arg7), 8);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg10.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg8));
        arg9.total_fees_collected = arg9.total_fees_collected + v0;
        let v1 = 0x2::tx_context::sender(arg12);
        let v2 = SwapProposal{
            id                      : 0x2::object::new(arg12),
            proposer                : v1,
            counterparty            : arg4,
            proposer_nft_ids        : arg0,
            counterparty_nft_ids    : arg1,
            proposer_sui_amount     : arg2,
            counterparty_sui_amount : arg3,
            protocol_fee_paid       : v0,
            expires_at              : 0x2::clock::timestamp_ms(arg11) + 86400000,
            state                   : 1,
        };
        let v3 = 0x2::object::id<SwapProposal>(&v2);
        let v4 = 0x2::balance::zero<0x2::sui::SUI>();
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&arg7)) {
            0x2::balance::join<0x2::sui::SUI>(&mut v4, 0x2::coin::into_balance<0x2::sui::SUI>(0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg7)));
        };
        0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(arg7);
        let v5 = SwapEscrow{
            id                       : 0x2::object::new(arg12),
            proposal_id              : v3,
            proposer_kiosk           : 0x1::option::some<0x2::kiosk::Kiosk>(arg5),
            proposer_kiosk_cap       : 0x1::option::some<0x2::kiosk::KioskOwnerCap>(arg6),
            proposer_sui_balance     : v4,
            counterparty_kiosk       : 0x1::option::none<0x2::kiosk::Kiosk>(),
            counterparty_kiosk_cap   : 0x1::option::none<0x2::kiosk::KioskOwnerCap>(),
            counterparty_sui_balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v6 = SwapProposed{
            proposal_id             : v3,
            proposer                : v1,
            counterparty            : arg4,
            proposer_nft_ids        : arg0,
            counterparty_nft_ids    : arg1,
            proposer_sui_amount     : arg2,
            counterparty_sui_amount : arg3,
            protocol_fee_paid       : v0,
            expires_at              : v2.expires_at,
        };
        0x2::event::emit<SwapProposed>(v6);
        let v7 = ProposerKioskDeposited{
            proposal_id : v3,
            proposer    : v1,
            kiosk_id    : 0x2::object::id<0x2::kiosk::Kiosk>(&arg5),
            nft_ids     : arg0,
        };
        0x2::event::emit<ProposerKioskDeposited>(v7);
        if (arg2 > 0) {
            let v8 = ProposerSUIDeposited{
                proposal_id : v3,
                proposer    : v1,
                amount      : arg2,
            };
            0x2::event::emit<ProposerSUIDeposited>(v8);
        };
        0x2::transfer::share_object<SwapEscrow>(v5);
        0x2::transfer::share_object<SwapProposal>(v2);
    }

    public fun create_proposal_and_deposit_shared_kiosk_cap(arg0: vector<0x2::object::ID>, arg1: vector<0x2::object::ID>, arg2: u64, arg3: u64, arg4: 0x1::option::Option<address>, arg5: &0x2::kiosk::Kiosk, arg6: 0x2::kiosk::KioskOwnerCap, arg7: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut ProtocolConfig, arg10: &mut ProtocolTreasury, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        validate_kiosk_contents(arg5, &arg0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg8);
        assert!(v0 >= arg9.protocol_fee, 9);
        if (arg2 > 0) {
            assert!(0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&arg7), 8);
            assert!(0x2::coin::value<0x2::sui::SUI>(0x1::option::borrow<0x2::coin::Coin<0x2::sui::SUI>>(&arg7)) == arg2, 8);
        } else {
            assert!(0x1::option::is_none<0x2::coin::Coin<0x2::sui::SUI>>(&arg7), 8);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg10.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg8));
        arg9.total_fees_collected = arg9.total_fees_collected + v0;
        let v1 = 0x2::tx_context::sender(arg12);
        let v2 = 0x2::object::id<0x2::kiosk::Kiosk>(arg5);
        let v3 = SwapProposal{
            id                      : 0x2::object::new(arg12),
            proposer                : v1,
            counterparty            : arg4,
            proposer_nft_ids        : arg0,
            counterparty_nft_ids    : arg1,
            proposer_sui_amount     : arg2,
            counterparty_sui_amount : arg3,
            protocol_fee_paid       : v0,
            expires_at              : 0x2::clock::timestamp_ms(arg11) + 86400000,
            state                   : 1,
        };
        let v4 = 0x2::object::id<SwapProposal>(&v3);
        let v5 = 0x2::balance::zero<0x2::sui::SUI>();
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&arg7)) {
            0x2::balance::join<0x2::sui::SUI>(&mut v5, 0x2::coin::into_balance<0x2::sui::SUI>(0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg7)));
        };
        0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(arg7);
        let v6 = SharedKioskSwapEscrow{
            id                           : 0x2::object::new(arg12),
            proposal_id                  : v4,
            proposer_shared_kiosk_id     : v2,
            proposer_kiosk_cap           : 0x1::option::some<0x2::kiosk::KioskOwnerCap>(arg6),
            proposer_sui_balance         : v5,
            counterparty_shared_kiosk_id : 0x1::option::none<0x2::object::ID>(),
            counterparty_kiosk_cap       : 0x1::option::none<0x2::kiosk::KioskOwnerCap>(),
            counterparty_sui_balance     : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v7 = SwapProposed{
            proposal_id             : v4,
            proposer                : v1,
            counterparty            : arg4,
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
        0x2::transfer::share_object<SharedKioskSwapEscrow>(v6);
        0x2::transfer::share_object<SwapProposal>(v3);
    }

    public fun deposit_counterparty_kiosk(arg0: &mut SwapProposal, arg1: &mut SwapEscrow, arg2: 0x2::kiosk::Kiosk, arg3: 0x2::kiosk::KioskOwnerCap, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        if (0x1::option::is_some<address>(&arg0.counterparty)) {
            assert!(v0 == *0x1::option::borrow<address>(&arg0.counterparty), 2);
        };
        assert!(arg0.state == 1, 5);
        assert!(0x2::clock::timestamp_ms(arg4) < arg0.expires_at, 4);
        assert!(arg1.proposal_id == 0x2::object::id<SwapProposal>(arg0), 6);
        assert!(0x1::option::is_none<0x2::kiosk::Kiosk>(&arg1.counterparty_kiosk), 5);
        validate_kiosk_contents(&arg2, &arg0.counterparty_nft_ids);
        0x1::option::fill<0x2::kiosk::Kiosk>(&mut arg1.counterparty_kiosk, arg2);
        0x1::option::fill<0x2::kiosk::KioskOwnerCap>(&mut arg1.counterparty_kiosk_cap, arg3);
        arg0.state = 2;
        if (0x1::option::is_none<address>(&arg0.counterparty)) {
            0x1::option::fill<address>(&mut arg0.counterparty, v0);
        };
        let v1 = CounterpartyKioskDeposited{
            proposal_id  : 0x2::object::id<SwapProposal>(arg0),
            counterparty : v0,
            kiosk_id     : 0x2::object::id<0x2::kiosk::Kiosk>(&arg2),
            nft_ids      : arg0.counterparty_nft_ids,
        };
        0x2::event::emit<CounterpartyKioskDeposited>(v1);
    }

    public fun deposit_counterparty_shared_kiosk_cap_and_execute(arg0: &mut SwapProposal, arg1: &mut SharedKioskSwapEscrow, arg2: &0x2::kiosk::Kiosk, arg3: 0x2::kiosk::KioskOwnerCap, arg4: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        if (0x1::option::is_some<address>(&arg0.counterparty)) {
            assert!(v0 == *0x1::option::borrow<address>(&arg0.counterparty), 2);
        };
        assert!(arg0.state == 1, 5);
        assert!(0x2::clock::timestamp_ms(arg5) < arg0.expires_at, 4);
        assert!(arg1.proposal_id == 0x2::object::id<SwapProposal>(arg0), 6);
        validate_kiosk_contents(arg2, &arg0.counterparty_nft_ids);
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg2);
        if (arg0.counterparty_sui_amount > 0) {
            assert!(0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&arg4), 8);
            let v2 = 0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(arg4);
            assert!(0x2::coin::value<0x2::sui::SUI>(&v2) == arg0.counterparty_sui_amount, 8);
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.counterparty_sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(v2));
        } else {
            assert!(0x1::option::is_none<0x2::coin::Coin<0x2::sui::SUI>>(&arg4), 8);
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(arg4);
        };
        if (0x1::option::is_none<address>(&arg0.counterparty)) {
            0x1::option::fill<address>(&mut arg0.counterparty, v0);
        };
        0x1::option::fill<0x2::object::ID>(&mut arg1.counterparty_shared_kiosk_id, v1);
        0x1::option::fill<0x2::kiosk::KioskOwnerCap>(&mut arg1.counterparty_kiosk_cap, arg3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(0x1::option::extract<0x2::kiosk::KioskOwnerCap>(&mut arg1.proposer_kiosk_cap), v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(0x1::option::extract<0x2::kiosk::KioskOwnerCap>(&mut arg1.counterparty_kiosk_cap), arg0.proposer);
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&arg1.proposer_sui_balance);
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&arg1.counterparty_sui_balance);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.proposer_sui_balance, v3, arg6), v0);
        };
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.counterparty_sui_balance, v4, arg6), arg0.proposer);
        };
        arg0.state = 3;
        let v5 = CounterpartyKioskDeposited{
            proposal_id  : 0x2::object::id<SwapProposal>(arg0),
            counterparty : v0,
            kiosk_id     : v1,
            nft_ids      : arg0.counterparty_nft_ids,
        };
        0x2::event::emit<CounterpartyKioskDeposited>(v5);
        if (arg0.counterparty_sui_amount > 0) {
            let v6 = CounterpattySUIDeposited{
                proposal_id  : 0x2::object::id<SwapProposal>(arg0),
                counterparty : v0,
                amount       : arg0.counterparty_sui_amount,
            };
            0x2::event::emit<CounterpattySUIDeposited>(v6);
        };
        let v7 = SwapExecuted{
            proposal_id             : 0x2::object::id<SwapProposal>(arg0),
            proposer                : arg0.proposer,
            counterparty            : v0,
            proposer_nft_ids        : arg0.proposer_nft_ids,
            counterparty_nft_ids    : arg0.counterparty_nft_ids,
            proposer_sui_amount     : v3,
            counterparty_sui_amount : v4,
            protocol_fee_paid       : arg0.protocol_fee_paid,
        };
        0x2::event::emit<SwapExecuted>(v7);
    }

    public fun deposit_counterparty_sui(arg0: &mut SwapProposal, arg1: &mut SwapEscrow, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        if (0x1::option::is_some<address>(&arg0.counterparty)) {
            assert!(v0 == *0x1::option::borrow<address>(&arg0.counterparty), 2);
        };
        assert!(arg0.state == 1 || arg0.state == 2, 5);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.expires_at, 4);
        assert!(arg1.proposal_id == 0x2::object::id<SwapProposal>(arg0), 6);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v1 == arg0.counterparty_sui_amount, 8);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.counterparty_sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        if (0x1::option::is_none<address>(&arg0.counterparty)) {
            0x1::option::fill<address>(&mut arg0.counterparty, v0);
        };
        let v2 = CounterpattySUIDeposited{
            proposal_id  : 0x2::object::id<SwapProposal>(arg0),
            counterparty : v0,
            amount       : v1,
        };
        0x2::event::emit<CounterpattySUIDeposited>(v2);
    }

    public fun deposit_proposer_kiosk(arg0: &mut SwapProposal, arg1: &mut SwapEscrow, arg2: 0x2::kiosk::Kiosk, arg3: 0x2::kiosk::KioskOwnerCap, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.proposer, 2);
        assert!(arg0.state == 0, 5);
        assert!(0x2::clock::timestamp_ms(arg4) < arg0.expires_at, 4);
        assert!(arg1.proposal_id == 0x2::object::id<SwapProposal>(arg0), 6);
        assert!(0x1::option::is_none<0x2::kiosk::Kiosk>(&arg1.proposer_kiosk), 5);
        validate_kiosk_contents(&arg2, &arg0.proposer_nft_ids);
        0x1::option::fill<0x2::kiosk::Kiosk>(&mut arg1.proposer_kiosk, arg2);
        0x1::option::fill<0x2::kiosk::KioskOwnerCap>(&mut arg1.proposer_kiosk_cap, arg3);
        arg0.state = 1;
        let v0 = ProposerKioskDeposited{
            proposal_id : 0x2::object::id<SwapProposal>(arg0),
            proposer    : arg0.proposer,
            kiosk_id    : 0x2::object::id<0x2::kiosk::Kiosk>(&arg2),
            nft_ids     : arg0.proposer_nft_ids,
        };
        0x2::event::emit<ProposerKioskDeposited>(v0);
    }

    public fun deposit_proposer_sui(arg0: &mut SwapProposal, arg1: &mut SwapEscrow, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.proposer, 2);
        assert!(arg0.state == 0 || arg0.state == 1, 5);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.expires_at, 4);
        assert!(arg1.proposal_id == 0x2::object::id<SwapProposal>(arg0), 6);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 == arg0.proposer_sui_amount, 8);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.proposer_sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v1 = ProposerSUIDeposited{
            proposal_id : 0x2::object::id<SwapProposal>(arg0),
            proposer    : arg0.proposer,
            amount      : v0,
        };
        0x2::event::emit<ProposerSUIDeposited>(v1);
    }

    public fun execute_swap(arg0: &mut SwapProposal, arg1: &mut SwapEscrow, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = v0 == arg0.proposer;
        let v2 = v1;
        if (0x1::option::is_some<address>(&arg0.counterparty)) {
            let v3 = v1 || v0 == *0x1::option::borrow<address>(&arg0.counterparty);
            v2 = v3;
        };
        assert!(v2, 2);
        assert!(arg0.state == 2, 5);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.expires_at, 4);
        assert!(arg1.proposal_id == 0x2::object::id<SwapProposal>(arg0), 6);
        let v4 = *0x1::option::borrow<address>(&arg0.counterparty);
        if (0x1::option::is_some<0x2::kiosk::Kiosk>(&arg1.proposer_kiosk)) {
            let v5 = 0x1::option::extract<0x2::kiosk::Kiosk>(&mut arg1.proposer_kiosk);
            let v6 = 0x1::option::extract<0x2::kiosk::KioskOwnerCap>(&mut arg1.proposer_kiosk_cap);
            let v7 = 0x2::kiosk::withdraw(&mut v5, &v6, 0x1::option::none<u64>(), arg3);
            if (0x2::coin::value<0x2::sui::SUI>(&v7) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v7, v4);
            } else {
                0x2::coin::destroy_zero<0x2::sui::SUI>(v7);
            };
            0x2::transfer::public_transfer<0x2::kiosk::Kiosk>(v5, v4);
            0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v6, v4);
        };
        if (0x1::option::is_some<0x2::kiosk::Kiosk>(&arg1.counterparty_kiosk)) {
            let v8 = 0x1::option::extract<0x2::kiosk::Kiosk>(&mut arg1.counterparty_kiosk);
            let v9 = 0x1::option::extract<0x2::kiosk::KioskOwnerCap>(&mut arg1.counterparty_kiosk_cap);
            let v10 = 0x2::kiosk::withdraw(&mut v8, &v9, 0x1::option::none<u64>(), arg3);
            if (0x2::coin::value<0x2::sui::SUI>(&v10) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v10, arg0.proposer);
            } else {
                0x2::coin::destroy_zero<0x2::sui::SUI>(v10);
            };
            0x2::transfer::public_transfer<0x2::kiosk::Kiosk>(v8, arg0.proposer);
            0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v9, arg0.proposer);
        };
        let v11 = 0x2::balance::value<0x2::sui::SUI>(&arg1.proposer_sui_balance);
        let v12 = 0x2::balance::value<0x2::sui::SUI>(&arg1.counterparty_sui_balance);
        if (v11 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.proposer_sui_balance, v11, arg3), v4);
        };
        if (v12 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.counterparty_sui_balance, v12, arg3), arg0.proposer);
        };
        arg0.state = 3;
        let v13 = SwapExecuted{
            proposal_id             : 0x2::object::id<SwapProposal>(arg0),
            proposer                : arg0.proposer,
            counterparty            : v4,
            proposer_nft_ids        : arg0.proposer_nft_ids,
            counterparty_nft_ids    : arg0.counterparty_nft_ids,
            proposer_sui_amount     : v11,
            counterparty_sui_amount : v12,
            protocol_fee_paid       : arg0.protocol_fee_paid,
        };
        0x2::event::emit<SwapExecuted>(v13);
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

