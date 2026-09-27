module 0x24f1c2c1a8e223bc702122909fc2246216e8878ce51420e7b666f65c1697b943::popswap_v2 {
    struct POPSWAP_V2 has drop {
        dummy_field: bool,
    }

    struct SwapAdminCap has store, key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
    }

    struct ProtocolConfig has key {
        id: 0x2::object::UID,
        version: u64,
        admin_cap_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        enabled: bool,
        protocol_fee: u64,
        fee_recipient: address,
        total_fees_collected: u64,
        transfer_policy_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct ProtocolTreasury has key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct SwapProposal has key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        proposer: address,
        counterparty: address,
        proposer_item_ids: vector<0x2::object::ID>,
        counterparty_item_ids: vector<0x2::object::ID>,
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
        protocol_fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct SwapProposed<phantom T0: store + key> has copy, drop {
        proposal_id: 0x2::object::ID,
        escrow_id: 0x2::object::ID,
        proposer: address,
        counterparty: address,
        proposer_item_ids: vector<0x2::object::ID>,
        counterparty_item_ids: vector<0x2::object::ID>,
        proposer_sui_amount: u64,
        counterparty_sui_amount: u64,
        protocol_fee_paid: u64,
        expires_at: u64,
        proposer_kiosk_id: 0x2::object::ID,
    }

    struct SwapExecuted<phantom T0: store + key> has copy, drop {
        proposal_id: 0x2::object::ID,
        proposer: address,
        counterparty: address,
        proposer_item_ids: vector<0x2::object::ID>,
        counterparty_item_ids: vector<0x2::object::ID>,
        proposer_sui_amount: u64,
        counterparty_sui_amount: u64,
        protocol_fee_paid: u64,
        proposer_kiosk_id: 0x2::object::ID,
        counterparty_kiosk_id: 0x2::object::ID,
        proposer_kiosk_cap_id: 0x2::object::ID,
        counterparty_kiosk_cap_id: 0x2::object::ID,
    }

    struct TransferEvent<phantom T0: store + key> has copy, drop {
        proposal_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        sender: address,
        receiver: address,
        source_kiosk_id: 0x2::object::ID,
        destination_kiosk_id: 0x2::object::ID,
        destination_kiosk_cap_id: 0x2::object::ID,
    }

    struct SwapCancelled has copy, drop {
        proposal_id: 0x2::object::ID,
        cancelled_by: address,
        protocol_fee_refunded: u64,
    }

    struct ProtocolFeeUpdated has copy, drop {
        old_fee: u64,
        new_fee: u64,
        updated_by: address,
    }

    struct ProtocolEnabledUpdated has copy, drop {
        old_enabled: bool,
        new_enabled: bool,
        updated_by: address,
    }

    struct FeeRecipientUpdated has copy, drop {
        old_recipient: address,
        new_recipient: address,
        updated_by: address,
    }

    struct TransferPolicyBound has copy, drop {
        policy_id: 0x2::object::ID,
        updated_by: address,
    }

    struct ProtocolFeesWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    public fun accept<T0: store + key>(arg0: &mut SwapProposal, arg1: &mut SwapEscrow, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::kiosk::Kiosk, arg4: 0x2::kiosk::KioskOwnerCap, arg5: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg6: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg7: &mut ProtocolConfig, arg8: &mut ProtocolTreasury, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg3;
        let (v1, v2, v3, v4) = settle<T0>(arg0, arg1, arg2, v0, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        transfer_or_destroy(v3, arg0.proposer);
        transfer_or_destroy(v4, arg0.counterparty);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, arg0.proposer);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(arg3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, arg0.counterparty);
    }

    fun assert_bound_policy<T0: store + key>(arg0: &ProtocolConfig, arg1: &0x2::transfer_policy::TransferPolicy<T0>) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.transfer_policy_id), 20);
        let v0 = 0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg1);
        assert!(0x1::option::borrow<0x2::object::ID>(&arg0.transfer_policy_id) == &v0, 19);
    }

    fun assert_config_current(arg0: &ProtocolConfig) {
        assert!(arg0.version == 1, 17);
    }

    fun assert_royalty_free<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>) {
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg0, 0) == 0, 24);
    }

    public fun bind_transfer_policy<T0: store + key>(arg0: &SwapAdminCap, arg1: &mut ProtocolConfig, arg2: &0x2::transfer_policy::TransferPolicy<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        validate_admin(arg0, arg1);
        let v0 = 0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg2);
        arg1.transfer_policy_id = 0x1::option::some<0x2::object::ID>(v0);
        let v1 = TransferPolicyBound{
            policy_id  : v0,
            updated_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<TransferPolicyBound>(v1);
    }

    public fun cancel_swap(arg0: &mut SwapProposal, arg1: &mut SwapEscrow, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = cancel_swap_internal(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v0, arg0.proposer);
    }

    fun cancel_swap_internal(arg0: &mut SwapProposal, arg1: &mut SwapEscrow, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::kiosk::KioskOwnerCap {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.expires_at || v0 == arg0.proposer, 2);
        assert!(arg0.state == 1, 5);
        assert!(arg1.proposal_id == 0x2::object::id<SwapProposal>(arg0), 6);
        let v1 = &mut arg1.protocol_fee_balance;
        transfer_balance_if_nonzero(v1, arg0.proposer, arg3);
        let v2 = &mut arg1.proposer_sui_balance;
        transfer_balance_if_nonzero(v2, arg0.proposer, arg3);
        arg0.state = 4;
        let v3 = SwapCancelled{
            proposal_id           : 0x2::object::id<SwapProposal>(arg0),
            cancelled_by          : v0,
            protocol_fee_refunded : 0x2::balance::value<0x2::sui::SUI>(&arg1.protocol_fee_balance),
        };
        0x2::event::emit<SwapCancelled>(v3);
        0x1::option::extract<0x2::kiosk::KioskOwnerCap>(&mut arg1.proposer_kiosk_cap)
    }

    public fun create_proposal_and_deposit<T0: store + key>(arg0: vector<0x2::object::ID>, arg1: vector<0x2::object::ID>, arg2: u64, arg3: u64, arg4: address, arg5: 0x2::kiosk::Kiosk, arg6: 0x2::kiosk::KioskOwnerCap, arg7: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &0x2::transfer_policy::TransferPolicy<T0>, arg10: &ProtocolConfig, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg12);
        assert_config_current(arg10);
        assert!(arg10.enabled, 13);
        assert_bound_policy<T0>(arg10, arg9);
        assert_royalty_free<T0>(arg9);
        assert!(v0 != arg4, 11);
        assert!(arg4 != @0x0, 16);
        validate_manifest(&arg0);
        validate_manifest(&arg1);
        validate_disjoint_manifests(&arg0, &arg1);
        validate_kiosk_cap(&arg5, &arg6);
        validate_kiosk_contents<T0>(&arg5, &arg0);
        assert!(0x2::kiosk::profits_amount(&arg5) == 0, 18);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg8);
        assert!(v1 == arg10.protocol_fee, 8);
        let (v2, v3) = new_swap(0x2::object::id<ProtocolConfig>(arg10), v0, arg4, arg0, arg1, arg2, arg3, v1, 0x2::object::id<0x2::kiosk::Kiosk>(&arg5), arg6, take_exact_optional_payment(arg7, arg2), 0x2::coin::into_balance<0x2::sui::SUI>(arg8), 0x2::clock::timestamp_ms(arg11) + 86400000, arg12);
        let v4 = v3;
        let v5 = v2;
        let v6 = SwapProposed<T0>{
            proposal_id             : 0x2::object::id<SwapProposal>(&v5),
            escrow_id               : 0x2::object::id<SwapEscrow>(&v4),
            proposer                : v0,
            counterparty            : arg4,
            proposer_item_ids       : v5.proposer_item_ids,
            counterparty_item_ids   : v5.counterparty_item_ids,
            proposer_sui_amount     : arg2,
            counterparty_sui_amount : arg3,
            protocol_fee_paid       : v1,
            expires_at              : v5.expires_at,
            proposer_kiosk_id       : v4.proposer_kiosk_id,
        };
        0x2::event::emit<SwapProposed<T0>>(v6);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(arg5);
        0x2::transfer::share_object<SwapProposal>(v5);
        0x2::transfer::share_object<SwapEscrow>(v4);
    }

    fun emit_transfer_events<T0: store + key>(arg0: &vector<0x2::object::ID>, arg1: 0x2::object::ID, arg2: address, arg3: address, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: 0x2::object::ID) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            let v1 = TransferEvent<T0>{
                proposal_id              : arg1,
                nft_id                   : *0x1::vector::borrow<0x2::object::ID>(arg0, v0),
                sender                   : arg2,
                receiver                 : arg3,
                source_kiosk_id          : arg4,
                destination_kiosk_id     : arg5,
                destination_kiosk_cap_id : arg6,
            };
            0x2::event::emit<TransferEvent<T0>>(v1);
            v0 = v0 + 1;
        };
    }

    fun init(arg0: POPSWAP_V2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::new(arg1);
        let v2 = 0x2::object::new(arg1);
        let v3 = 0x2::object::uid_to_inner(&v1);
        let v4 = SwapAdminCap{
            id        : v0,
            config_id : v3,
        };
        let v5 = ProtocolConfig{
            id                   : v1,
            version              : 1,
            admin_cap_id         : 0x2::object::uid_to_inner(&v0),
            treasury_id          : 0x2::object::uid_to_inner(&v2),
            enabled              : false,
            protocol_fee         : 0,
            fee_recipient        : 0x2::tx_context::sender(arg1),
            total_fees_collected : 0,
            transfer_policy_id   : 0x1::option::none<0x2::object::ID>(),
        };
        let v6 = ProtocolTreasury{
            id        : v2,
            config_id : v3,
            balance   : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::transfer<SwapAdminCap>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<ProtocolConfig>(v5);
        0x2::transfer::share_object<ProtocolTreasury>(v6);
    }

    public fun max_items_per_side() : u64 {
        9
    }

    public fun migrate(arg0: &SwapAdminCap, arg1: &mut ProtocolConfig) {
        assert!(arg0.config_id == 0x2::object::id<ProtocolConfig>(arg1), 14);
        assert!(0x2::object::id<SwapAdminCap>(arg0) == arg1.admin_cap_id, 14);
        assert!(arg1.version < 1, 17);
        arg1.version = 1;
    }

    fun move_items<T0: store + key>(arg0: &vector<0x2::object::ID>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            let v1 = *0x1::vector::borrow<0x2::object::ID>(arg0, v0);
            let (v2, v3) = 0x2::kiosk::purchase_with_cap<T0>(arg1, 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, v1, 0, arg6), 0x2::coin::zero<0x2::sui::SUI>(arg6));
            let v4 = v3;
            0x2::kiosk::lock<T0>(arg3, arg4, arg5, v2);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v4, arg3);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg5, &mut v4, 0x2::coin::zero<0x2::sui::SUI>(arg6));
            let (v5, v6, _) = 0x2::transfer_policy::confirm_request<T0>(arg5, v4);
            assert!(v5 == v1 && v6 == 0, 6);
            v0 = v0 + 1;
        };
    }

    fun new_swap(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: vector<0x2::object::ID>, arg4: vector<0x2::object::ID>, arg5: u64, arg6: u64, arg7: u64, arg8: 0x2::object::ID, arg9: 0x2::kiosk::KioskOwnerCap, arg10: 0x2::balance::Balance<0x2::sui::SUI>, arg11: 0x2::balance::Balance<0x2::sui::SUI>, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) : (SwapProposal, SwapEscrow) {
        let v0 = SwapProposal{
            id                      : 0x2::object::new(arg13),
            config_id               : arg0,
            proposer                : arg1,
            counterparty            : arg2,
            proposer_item_ids       : arg3,
            counterparty_item_ids   : arg4,
            proposer_sui_amount     : arg5,
            counterparty_sui_amount : arg6,
            protocol_fee_paid       : arg7,
            expires_at              : arg12,
            state                   : 1,
        };
        let v1 = SwapEscrow{
            id                   : 0x2::object::new(arg13),
            proposal_id          : 0x2::object::id<SwapProposal>(&v0),
            proposer_kiosk_id    : arg8,
            proposer_kiosk_cap   : 0x1::option::some<0x2::kiosk::KioskOwnerCap>(arg9),
            proposer_sui_balance : arg10,
            protocol_fee_balance : arg11,
        };
        (v0, v1)
    }

    public fun proposal_manifests(arg0: &SwapProposal) : (vector<0x2::object::ID>, vector<0x2::object::ID>) {
        (arg0.proposer_item_ids, arg0.counterparty_item_ids)
    }

    public fun proposal_parties(arg0: &SwapProposal) : (address, address) {
        (arg0.proposer, arg0.counterparty)
    }

    public fun proposal_state(arg0: &SwapProposal) : u8 {
        arg0.state
    }

    public fun protocol_enabled(arg0: &ProtocolConfig) : bool {
        arg0.enabled
    }

    public fun protocol_fee(arg0: &ProtocolConfig) : u64 {
        arg0.protocol_fee
    }

    fun settle<T0: store + key>(arg0: &mut SwapProposal, arg1: &mut SwapEscrow, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: 0x2::kiosk::KioskOwnerCap, arg5: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg6: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg7: &mut ProtocolConfig, arg8: &mut ProtocolTreasury, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::kiosk::KioskOwnerCap, 0x2::kiosk::KioskOwnerCap, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert_config_current(arg7);
        assert!(arg7.enabled, 13);
        assert_bound_policy<T0>(arg7, arg6);
        assert_royalty_free<T0>(arg6);
        validate_treasury(arg7, arg8);
        assert!(arg0.config_id == 0x2::object::id<ProtocolConfig>(arg7), 14);
        assert!(0x2::tx_context::sender(arg10) == arg0.counterparty, 2);
        assert!(arg0.state == 1, 5);
        assert!(0x2::clock::timestamp_ms(arg9) < arg0.expires_at, 4);
        assert!(arg1.proposal_id == 0x2::object::id<SwapProposal>(arg0), 6);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == arg1.proposer_kiosk_id, 6);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) != 0x2::object::id<0x2::kiosk::Kiosk>(arg3), 12);
        validate_kiosk_cap(arg3, &arg4);
        validate_kiosk_contents<T0>(arg2, &arg0.proposer_item_ids);
        validate_kiosk_contents<T0>(arg3, &arg0.counterparty_item_ids);
        assert!(0x2::kiosk::profits_amount(arg2) == 0, 18);
        assert!(0x2::kiosk::profits_amount(arg3) == 0, 18);
        let v0 = 0x1::option::extract<0x2::kiosk::KioskOwnerCap>(&mut arg1.proposer_kiosk_cap);
        let v1 = 0x2::object::id<SwapProposal>(arg0);
        let v2 = 0x2::object::id<0x2::kiosk::Kiosk>(arg2);
        let v3 = 0x2::object::id<0x2::kiosk::Kiosk>(arg3);
        move_items<T0>(&arg0.proposer_item_ids, arg2, &v0, arg3, &arg4, arg6, arg10);
        move_items<T0>(&arg0.counterparty_item_ids, arg3, &arg4, arg2, &v0, arg6, arg10);
        validate_kiosk_contents<T0>(arg2, &arg0.counterparty_item_ids);
        validate_kiosk_contents<T0>(arg3, &arg0.proposer_item_ids);
        0x2::kiosk::set_owner_custom(arg2, &v0, arg0.proposer);
        0x2::kiosk::set_owner_custom(arg3, &arg4, arg0.counterparty);
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&arg1.protocol_fee_balance);
        if (v4 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg8.balance, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.protocol_fee_balance));
            arg7.total_fees_collected = arg7.total_fees_collected + v4;
        };
        let v5 = 0x2::object::id<0x2::kiosk::KioskOwnerCap>(&v0);
        let v6 = 0x2::object::id<0x2::kiosk::KioskOwnerCap>(&arg4);
        emit_transfer_events<T0>(&arg0.proposer_item_ids, v1, arg0.proposer, arg0.counterparty, v2, v3, v6);
        emit_transfer_events<T0>(&arg0.counterparty_item_ids, v1, arg0.counterparty, arg0.proposer, v3, v2, v5);
        arg0.state = 3;
        let v7 = SwapExecuted<T0>{
            proposal_id               : v1,
            proposer                  : arg0.proposer,
            counterparty              : arg0.counterparty,
            proposer_item_ids         : arg0.proposer_item_ids,
            counterparty_item_ids     : arg0.counterparty_item_ids,
            proposer_sui_amount       : arg0.proposer_sui_amount,
            counterparty_sui_amount   : arg0.counterparty_sui_amount,
            protocol_fee_paid         : v4,
            proposer_kiosk_id         : v2,
            counterparty_kiosk_id     : v3,
            proposer_kiosk_cap_id     : v5,
            counterparty_kiosk_cap_id : v6,
        };
        0x2::event::emit<SwapExecuted<T0>>(v7);
        (v0, arg4, 0x2::coin::from_balance<0x2::sui::SUI>(take_exact_optional_payment(arg5, arg0.counterparty_sui_amount), arg10), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.proposer_sui_balance), arg10))
    }

    fun take_exact_optional_payment(arg0: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg1: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        if (arg1 == 0) {
            assert!(0x1::option::is_none<0x2::coin::Coin<0x2::sui::SUI>>(&arg0), 7);
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(arg0);
            return 0x2::balance::zero<0x2::sui::SUI>()
        };
        assert!(0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&arg0), 7);
        let v0 = 0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v0) == arg1, 7);
        0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(arg0);
        0x2::coin::into_balance<0x2::sui::SUI>(v0)
    }

    public fun total_fees_collected(arg0: &ProtocolConfig) : u64 {
        arg0.total_fees_collected
    }

    fun transfer_balance_if_nonzero(arg0: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(arg0);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(arg0, v0, arg2), arg1);
        };
    }

    fun transfer_or_destroy(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address) {
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        };
    }

    public fun transfer_policy_id(arg0: &ProtocolConfig) : 0x1::option::Option<0x2::object::ID> {
        arg0.transfer_policy_id
    }

    public fun treasury_balance(arg0: &ProtocolTreasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun update_fee_recipient(arg0: &SwapAdminCap, arg1: &mut ProtocolConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        validate_admin(arg0, arg1);
        assert!(arg2 != @0x0, 16);
        arg1.fee_recipient = arg2;
        let v0 = FeeRecipientUpdated{
            old_recipient : arg1.fee_recipient,
            new_recipient : arg2,
            updated_by    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<FeeRecipientUpdated>(v0);
    }

    public fun update_protocol_enabled(arg0: &SwapAdminCap, arg1: &mut ProtocolConfig, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        validate_admin(arg0, arg1);
        assert!(!arg2 || 0x1::option::is_some<0x2::object::ID>(&arg1.transfer_policy_id), 20);
        arg1.enabled = arg2;
        let v0 = ProtocolEnabledUpdated{
            old_enabled : arg1.enabled,
            new_enabled : arg2,
            updated_by  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ProtocolEnabledUpdated>(v0);
    }

    public fun update_protocol_fee(arg0: &SwapAdminCap, arg1: &mut ProtocolConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        validate_admin(arg0, arg1);
        arg1.protocol_fee = arg2;
        let v0 = ProtocolFeeUpdated{
            old_fee    : arg1.protocol_fee,
            new_fee    : arg2,
            updated_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ProtocolFeeUpdated>(v0);
    }

    fun validate_admin(arg0: &SwapAdminCap, arg1: &ProtocolConfig) {
        assert_config_current(arg1);
        assert!(arg0.config_id == 0x2::object::id<ProtocolConfig>(arg1), 14);
        assert!(0x2::object::id<SwapAdminCap>(arg0) == arg1.admin_cap_id, 14);
    }

    fun validate_disjoint_manifests(arg0: &vector<0x2::object::ID>, arg1: &vector<0x2::object::ID>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            let v1 = 0;
            while (v1 < 0x1::vector::length<0x2::object::ID>(arg1)) {
                assert!(*0x1::vector::borrow<0x2::object::ID>(arg0, v0) != *0x1::vector::borrow<0x2::object::ID>(arg1, v1), 3);
                v1 = v1 + 1;
            };
            v0 = v0 + 1;
        };
    }

    fun validate_kiosk_cap(arg0: &0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap) {
        assert!(0x2::kiosk::kiosk_owner_cap_for(arg1) == 0x2::object::id<0x2::kiosk::Kiosk>(arg0), 6);
    }

    fun validate_kiosk_contents<T0: store + key>(arg0: &0x2::kiosk::Kiosk, arg1: &vector<0x2::object::ID>) {
        let v0 = 0x1::vector::length<0x2::object::ID>(arg1);
        assert!((0x2::kiosk::item_count(arg0) as u64) == v0, 0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<0x2::object::ID>(arg1, v1);
            assert!(0x2::kiosk::has_item_with_type<T0>(arg0, v2), 1);
            assert!(!0x2::kiosk::is_listed(arg0, v2), 5);
            assert!(!0x2::kiosk::is_listed_exclusively(arg0, v2), 5);
            v1 = v1 + 1;
        };
    }

    fun validate_manifest(arg0: &vector<0x2::object::ID>) {
        let v0 = 0x1::vector::length<0x2::object::ID>(arg0);
        assert!(v0 > 0, 9);
        assert!(v0 <= 9, 10);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = v1 + 1;
            while (v2 < v0) {
                assert!(*0x1::vector::borrow<0x2::object::ID>(arg0, v1) != *0x1::vector::borrow<0x2::object::ID>(arg0, v2), 3);
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
    }

    fun validate_treasury(arg0: &ProtocolConfig, arg1: &ProtocolTreasury) {
        assert!(0x2::object::id<ProtocolTreasury>(arg1) == arg0.treasury_id, 14);
        assert!(arg1.config_id == 0x2::object::id<ProtocolConfig>(arg0), 14);
    }

    public fun withdraw_protocol_fees(arg0: &SwapAdminCap, arg1: &ProtocolConfig, arg2: &mut ProtocolTreasury, arg3: &mut 0x2::tx_context::TxContext) {
        validate_admin(arg0, arg1);
        validate_treasury(arg1, arg2);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg2.balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg2.balance, v0, arg3), arg1.fee_recipient);
        };
        let v1 = ProtocolFeesWithdrawn{
            amount    : v0,
            recipient : arg1.fee_recipient,
        };
        0x2::event::emit<ProtocolFeesWithdrawn>(v1);
    }

    // decompiled from Move bytecode v7
}

