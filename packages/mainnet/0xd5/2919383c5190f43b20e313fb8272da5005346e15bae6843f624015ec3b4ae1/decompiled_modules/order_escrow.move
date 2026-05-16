module 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::order_escrow {
    struct OrderEscrowBindingKey has copy, drop, store {
        order_ref: vector<u8>,
        buyer: address,
        seller: address,
    }

    struct OrderEscrow<phantom T0> has key {
        id: 0x2::object::UID,
        order_ref: vector<u8>,
        buyer: address,
        seller: address,
        amount: u64,
        created_ms: u64,
        deadline_ms: u64,
        funds: 0x2::balance::Balance<T0>,
        fee_amount: u64,
        fee_recipient: address,
        status: u8,
        disputed_at_ms: u64,
        cancel_approved_by_buyer: bool,
        cancel_approved_by_seller: bool,
        delete_approved_by_buyer: bool,
        delete_approved_by_seller: bool,
    }

    struct EscrowCreated has copy, drop {
        escrow_id: address,
        order_ref: vector<u8>,
        buyer: address,
        seller: address,
        amount: u64,
        created_ms: u64,
        deadline_ms: u64,
        fee_amount: u64,
        fee_recipient: address,
    }

    struct EscrowStateChanged has copy, drop {
        escrow_id: address,
        order_ref: vector<u8>,
        actor: address,
        next_status: u8,
    }

    struct EscrowSettlement has copy, drop {
        escrow_id: address,
        order_ref: vector<u8>,
        actor: address,
        settlement_path: u8,
        total_amount: u64,
        fee_paid: u64,
        seller_paid: u64,
        buyer_paid: u64,
    }

    struct EscrowMutualCancelApproved has copy, drop {
        escrow_id: address,
        order_ref: vector<u8>,
        actor: address,
    }

    public(friend) fun open_milestone_dispute_case<T0>(arg0: 0x1::string::String, arg1: &OrderEscrow<T0>, arg2: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::DisputeQuorumConfig, arg3: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::OrderDisputeBond, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::MilestoneDisputeCase {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg1.status == 3, 6);
        assert!(v0 == arg1.buyer || v0 == arg1.seller, 10);
        assert_matching_dispute_bond<T0>(arg1, arg3);
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::open_milestone_dispute_case(arg0, escrow_id<T0>(arg1), arg2, arg3, arg4, arg5)
    }

    public(friend) fun open_milestone_dispute_case_typed<T0, T1>(arg0: 0x1::string::String, arg1: &OrderEscrow<T0>, arg2: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::DisputeQuorumConfig, arg3: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::OrderDisputeBondTyped<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::MilestoneDisputeCase {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg1.status == 3, 6);
        assert!(v0 == arg1.buyer || v0 == arg1.seller, 10);
        assert_matching_typed_dispute_bond<T0, T1>(arg1, arg3);
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::open_milestone_dispute_case_typed<T1>(arg0, escrow_id<T0>(arg1), arg2, arg3, arg4, arg5)
    }

    public(friend) fun open_milestone_dispute_case_with_invites<T0>(arg0: 0x1::string::String, arg1: vector<address>, arg2: &OrderEscrow<T0>, arg3: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::DisputeQuorumConfig, arg4: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::OrderDisputeBond, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::MilestoneDisputeCase {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(arg2.status == 3, 6);
        assert!(v0 == arg2.buyer || v0 == arg2.seller, 10);
        assert_matching_dispute_bond<T0>(arg2, arg4);
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::open_milestone_dispute_case_with_invites(arg0, escrow_id<T0>(arg2), arg1, arg3, arg4, arg5, arg6)
    }

    public(friend) fun open_milestone_dispute_case_with_invites_typed<T0, T1>(arg0: 0x1::string::String, arg1: vector<address>, arg2: &OrderEscrow<T0>, arg3: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::DisputeQuorumConfig, arg4: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::OrderDisputeBondTyped<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::MilestoneDisputeCase {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(arg2.status == 3, 6);
        assert!(v0 == arg2.buyer || v0 == arg2.seller, 10);
        assert_matching_typed_dispute_bond<T0, T1>(arg2, arg4);
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::open_milestone_dispute_case_with_invites_typed<T1>(arg0, escrow_id<T0>(arg2), arg1, arg3, arg4, arg5, arg6)
    }

    public fun amount<T0>(arg0: &OrderEscrow<T0>) : u64 {
        arg0.amount
    }

    public(friend) fun apply_deadline_extension<T0>(arg0: &mut OrderEscrow<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg0.status == 1, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        assert!(arg1 > arg0.deadline_ms, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_deadline());
        assert!(0x2::clock::timestamp_ms(arg2) < arg1, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_deadline());
        assert!((arg1 as u128) <= (arg0.created_ms as u128) + (15552000000 as u128), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_deadline_exceeded());
        arg0.deadline_ms = arg1;
    }

    public(friend) entry fun approve_mutual_cancel<T0>(arg0: &mut OrderEscrow<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        approve_mutual_cancel_internal<T0>(arg0, 0x2::tx_context::sender(arg1));
    }

    fun approve_mutual_cancel_internal<T0>(arg0: &mut OrderEscrow<T0>, arg1: address) {
        assert!(arg0.status == 1, 6);
        if (arg1 == arg0.buyer) {
            if (!arg0.cancel_approved_by_buyer) {
                arg0.cancel_approved_by_buyer = true;
                emit_mutual_cancel_approved<T0>(arg0, arg1);
            };
        } else {
            assert!(arg1 == arg0.seller, 10);
            if (!arg0.cancel_approved_by_seller) {
                arg0.cancel_approved_by_seller = true;
                emit_mutual_cancel_approved<T0>(arg0, arg1);
            };
        };
    }

    public(friend) entry fun approve_settled_escrow_deletion<T0>(arg0: &mut OrderEscrow<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 2 || arg0.status == 4, 6);
        let v0 = 0x2::tx_context::sender(arg1);
        if (v0 == arg0.buyer) {
            arg0.delete_approved_by_buyer = true;
        } else {
            assert!(v0 == arg0.seller, 10);
            arg0.delete_approved_by_seller = true;
        };
    }

    fun assert_direct_dispute_resolution_allowed<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::DisputeQuorumConfig, arg1: &OrderEscrow<T0>) {
        assert!(arg1.status == 3, 6);
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::assert_no_escrow_dispute_binding(arg0, escrow_id<T0>(arg1));
    }

    public(friend) fun assert_matches_deadline_extension<T0>(arg0: &OrderEscrow<T0>, arg1: address, arg2: address, arg3: address, arg4: u64) {
        assert!(arg0.status == 1, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        assert!(escrow_id<T0>(arg0) == arg1, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        assert!(arg0.buyer == arg2, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        assert!(arg0.seller == arg3, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        assert!(arg0.deadline_ms == arg4, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
    }

    fun assert_matching_dispute_bond<T0>(arg0: &OrderEscrow<T0>, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::OrderDisputeBond) {
        let v0 = 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::bond_order_id(arg1);
        assert!(&arg0.order_ref == 0x1::string::as_bytes(&v0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_input());
        assert!(arg0.buyer == 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::bond_buyer(arg1), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_input());
        assert!(arg0.seller == 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::bond_seller(arg1), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_input());
    }

    fun assert_matching_typed_dispute_bond<T0, T1>(arg0: &OrderEscrow<T0>, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::OrderDisputeBondTyped<T1>) {
        let v0 = 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::typed_bond_order_id<T1>(arg1);
        assert!(&arg0.order_ref == 0x1::string::as_bytes(&v0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_input());
        assert!(arg0.buyer == 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::typed_bond_buyer<T1>(arg1), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_input());
        assert!(arg0.seller == 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::typed_bond_seller<T1>(arg1), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_input());
        assert!(0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::typed_fee_policy::order_payment_fee_asset_matches_order_asset<T0, T1>(), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dq_invalid_policy());
    }

    fun assert_timeout_fallback_allowed_guarded<T0>(arg0: &0x2::clock::Clock, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::DisputeQuorumConfig, arg2: &OrderEscrow<T0>) {
        assert!(arg2.status == 3, 6);
        let v0 = 0x2::clock::timestamp_ms(arg0);
        assert!(v0 >= arg2.disputed_at_ms, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        assert!(v0 - arg2.disputed_at_ms >= 604800000, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_dispute_timeout_not_reached());
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::assert_no_escrow_dispute_binding(arg1, escrow_id<T0>(arg2));
    }

    public(friend) fun assert_typed_order_payment_fee_policy<T0, T1>() {
        assert!(typed_non_sui_order_escrow_exact_fee_policy_ready<T0, T1>(), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_fee_config());
    }

    public fun bound_escrow_id_for_view<T0>(arg0: &OrderEscrow<T0>) : (bool, address) {
        (true, escrow_id<T0>(arg0))
    }

    public fun buyer<T0>(arg0: &OrderEscrow<T0>) : address {
        arg0.buyer
    }

    public fun buyer_rescue_grace_ms() : u64 {
        604800000
    }

    public(friend) fun claim_after_deadline<T0>(arg0: &mut OrderEscrow<T0>, arg1: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::ReputationFeeConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.seller, 9);
        assert!(arg0.status == 1, 6);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.deadline_ms, 11);
        settle_to_seller<T0>(arg0, v0, 2, arg3);
        record_seller_claim_after_buyer_inactivity<T0>(arg2, arg1, arg0);
    }

    public(friend) entry fun claim_after_deadline_sui_entry(arg0: &mut OrderEscrow<0x2::sui::SUI>, arg1: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::ReputationFeeConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        claim_after_deadline<0x2::sui::SUI>(arg0, arg1, arg2, arg3);
    }

    public(friend) entry fun claim_after_deadline_to_buyer_guarded<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg1: &mut OrderEscrow<T0>, arg2: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::ReputationFeeConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg1.buyer, 7);
        assert!(arg1.status == 1, 6);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg1.deadline_ms + 604800000, 11);
        settle_to_buyer<T0>(arg1, v0, 2, arg4);
        record_buyer_rescue_after_seller_deadline<T0>(arg3, arg2, arg1);
    }

    public(friend) fun claim_after_deadline_typed_coin<T0>(arg0: &mut OrderEscrow<T0>, arg1: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::ReputationFeeConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::typed_fee_policy::order_payment_fee_policy_kind<T0>() == 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::typed_fee_policy::fee_policy_exact_typed_order_asset(), 3);
        claim_after_deadline<T0>(arg0, arg1, arg2, arg3);
    }

    public(friend) entry fun claim_after_deadline_typed_order_asset_entry<T0>(arg0: &mut OrderEscrow<T0>, arg1: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::ReputationFeeConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        claim_after_deadline_typed_coin<T0>(arg0, arg1, arg2, arg3);
    }

    public(friend) entry fun claim_after_deadline_with_dispute_bond<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::ReputationFeeConfig, arg2: &mut OrderEscrow<T0>, arg3: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::OrderDisputeBond, arg4: &mut 0x2::tx_context::TxContext) {
        assert_matching_dispute_bond<T0>(arg2, arg3);
        claim_after_deadline<T0>(arg2, arg1, arg0, arg4);
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::release_active_order_dispute_bond_without_case(arg3, arg4);
    }

    public(friend) entry fun claim_after_deadline_with_typed_dispute_bond<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::ReputationFeeConfig, arg2: &mut OrderEscrow<T0>, arg3: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::OrderDisputeBondTyped<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_matching_typed_dispute_bond<T0, T1>(arg2, arg3);
        claim_after_deadline<T0>(arg2, arg1, arg0, arg4);
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::release_active_order_dispute_typed_bond_without_case<T1>(arg3, arg4);
    }

    fun clear_cancel_approvals<T0>(arg0: &mut OrderEscrow<T0>) {
        arg0.cancel_approved_by_buyer = false;
        arg0.cancel_approved_by_seller = false;
    }

    fun clear_delete_approvals<T0>(arg0: &mut OrderEscrow<T0>) {
        arg0.delete_approved_by_buyer = false;
        arg0.delete_approved_by_seller = false;
    }

    fun compute_fee(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    fun create_order_escrow_from_coin<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg1: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::FeeConfig, arg2: vector<u8>, arg3: address, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : OrderEscrow<T0> {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg0);
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(arg3 != v0, 2);
        assert!(arg3 != @0x0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_address());
        let v1 = 0x1::vector::length<u8>(&arg2);
        assert!(v1 > 0 && v1 <= 128, 4);
        let v2 = 0x2::clock::timestamp_ms(arg8);
        assert!(arg5 > v2, 5);
        assert!((arg5 as u128) <= (v2 as u128) + (15552000000 as u128), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_deadline_exceeded());
        let v3 = 0x2::coin::value<T0>(&arg4);
        assert!(v3 > 0, 1);
        assert!(arg6 <= v3, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_fee_config());
        if (arg6 > 0) {
            assert!(arg7 != @0x0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_fee_config());
        };
        let v4 = OrderEscrow<T0>{
            id                        : 0x2::object::new(arg9),
            order_ref                 : arg2,
            buyer                     : v0,
            seller                    : arg3,
            amount                    : v3,
            created_ms                : v2,
            deadline_ms               : arg5,
            funds                     : 0x2::coin::into_balance<T0>(arg4),
            fee_amount                : arg6,
            fee_recipient             : arg7,
            status                    : 1,
            disputed_at_ms            : 0,
            cancel_approved_by_buyer  : false,
            cancel_approved_by_seller : false,
            delete_approved_by_buyer  : false,
            delete_approved_by_seller : false,
        };
        emit_created<T0>(&v4);
        record_order_escrow_binding(arg1, &v4.order_ref, v4.buyer, v4.seller, escrow_id<T0>(&v4));
        v4
    }

    public(friend) entry fun create_order_escrow_sui_entry(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg1: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::FeeConfig, arg2: vector<u8>, arg3: address, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<OrderEscrow<0x2::sui::SUI>>(create_order_escrow_sui_with_config(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7));
    }

    public(friend) fun create_order_escrow_sui_with_config(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg1: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::FeeConfig, arg2: vector<u8>, arg3: address, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : OrderEscrow<0x2::sui::SUI> {
        assert!(0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::order_payment_assets::is_supported_order_payment_sui_type<0x2::sui::SUI>(), 3);
        let v0 = compute_fee(0x2::coin::value<0x2::sui::SUI>(&arg4), 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::sui_fee_bps(arg1));
        let v1 = 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::sui_fee_recipient(arg1);
        create_order_escrow_from_coin<0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4, arg5, v0, v1, arg6, arg7)
    }

    public(friend) fun create_order_escrow_typed_coin_with_config<T0, T1>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg1: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::FeeConfig, arg2: vector<u8>, arg3: address, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : OrderEscrow<T1> {
        assert!(0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::payment_core_asset_lanes::typed_order_escrow_create_enabled<T1>(arg1), 3);
        assert_typed_order_payment_fee_policy<T0, T1>();
        let v0 = compute_fee(0x2::coin::value<T1>(&arg4), 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::sui_fee_bps(arg1));
        let v1 = 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::sui_fee_recipient(arg1);
        create_order_escrow_from_coin<T1>(arg0, arg1, arg2, arg3, arg4, arg5, v0, v1, arg6, arg7)
    }

    public(friend) entry fun create_order_escrow_typed_order_asset_entry<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg1: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::FeeConfig, arg2: vector<u8>, arg3: address, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<OrderEscrow<T0>>(create_order_escrow_typed_coin_with_config<T0, T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7));
    }

    public fun created_ms<T0>(arg0: &OrderEscrow<T0>) : u64 {
        arg0.created_ms
    }

    public(friend) fun deadline_extension_snapshot<T0>(arg0: &OrderEscrow<T0>) : (vector<u8>, address, address, address, u64) {
        assert!(arg0.status == 1, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        (arg0.order_ref, escrow_id<T0>(arg0), arg0.buyer, arg0.seller, arg0.deadline_ms)
    }

    public fun deadline_ms<T0>(arg0: &OrderEscrow<T0>) : u64 {
        arg0.deadline_ms
    }

    public(friend) entry fun delete_settled_escrow_guarded<T0>(arg0: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::FeeConfig, arg1: OrderEscrow<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg1.buyer || v0 == arg1.seller, 10);
        assert!(arg1.status == 2 || arg1.status == 4, 6);
        assert!(arg1.delete_approved_by_buyer && arg1.delete_approved_by_seller, 6);
        remove_order_escrow_binding_if_current<T0>(arg0, &arg1);
        let OrderEscrow {
            id                        : v1,
            order_ref                 : _,
            buyer                     : _,
            seller                    : _,
            amount                    : _,
            created_ms                : _,
            deadline_ms               : _,
            funds                     : v8,
            fee_amount                : _,
            fee_recipient             : _,
            status                    : _,
            disputed_at_ms            : _,
            cancel_approved_by_buyer  : _,
            cancel_approved_by_seller : _,
            delete_approved_by_buyer  : _,
            delete_approved_by_seller : _,
        } = arg1;
        0x2::object::delete(v1);
        0x2::balance::destroy_zero<T0>(v8);
    }

    public(friend) fun dispute_buyer<T0>(arg0: &OrderEscrow<T0>) : address {
        arg0.buyer
    }

    public(friend) fun dispute_order_id<T0>(arg0: &OrderEscrow<T0>) : 0x1::string::String {
        0x1::string::utf8(arg0.order_ref)
    }

    public(friend) fun dispute_seller<T0>(arg0: &OrderEscrow<T0>) : address {
        arg0.seller
    }

    public fun dispute_timeout_ms() : u64 {
        604800000
    }

    public fun disputed_state() : u8 {
        3
    }

    fun emit_created<T0>(arg0: &OrderEscrow<T0>) {
        let v0 = EscrowCreated{
            escrow_id     : escrow_id<T0>(arg0),
            order_ref     : arg0.order_ref,
            buyer         : arg0.buyer,
            seller        : arg0.seller,
            amount        : arg0.amount,
            created_ms    : arg0.created_ms,
            deadline_ms   : arg0.deadline_ms,
            fee_amount    : arg0.fee_amount,
            fee_recipient : arg0.fee_recipient,
        };
        0x2::event::emit<EscrowCreated>(v0);
    }

    fun emit_mutual_cancel_approved<T0>(arg0: &OrderEscrow<T0>, arg1: address) {
        let v0 = EscrowMutualCancelApproved{
            escrow_id : escrow_id<T0>(arg0),
            order_ref : arg0.order_ref,
            actor     : arg1,
        };
        0x2::event::emit<EscrowMutualCancelApproved>(v0);
    }

    fun emit_settlement<T0>(arg0: &OrderEscrow<T0>, arg1: address, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = EscrowSettlement{
            escrow_id       : escrow_id<T0>(arg0),
            order_ref       : arg0.order_ref,
            actor           : arg1,
            settlement_path : arg2,
            total_amount    : arg3,
            fee_paid        : arg4,
            seller_paid     : arg5,
            buyer_paid      : arg6,
        };
        0x2::event::emit<EscrowSettlement>(v0);
    }

    fun emit_state_changed<T0>(arg0: &OrderEscrow<T0>, arg1: address) {
        let v0 = EscrowStateChanged{
            escrow_id   : escrow_id<T0>(arg0),
            order_ref   : arg0.order_ref,
            actor       : arg1,
            next_status : arg0.status,
        };
        0x2::event::emit<EscrowStateChanged>(v0);
    }

    fun escrow_id<T0>(arg0: &OrderEscrow<T0>) : address {
        let v0 = 0x2::object::id<OrderEscrow<T0>>(arg0);
        0x2::object::id_to_address(&v0)
    }

    public(friend) fun escrow_id_for_dispute<T0>(arg0: &OrderEscrow<T0>) : address {
        escrow_id<T0>(arg0)
    }

    public(friend) fun escrow_id_for_review<T0>(arg0: &OrderEscrow<T0>) : address {
        escrow_id<T0>(arg0)
    }

    public fun fee_amount<T0>(arg0: &OrderEscrow<T0>) : u64 {
        arg0.fee_amount
    }

    public fun fee_recipient<T0>(arg0: &OrderEscrow<T0>) : address {
        arg0.fee_recipient
    }

    public fun locked_amount<T0>(arg0: &OrderEscrow<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    public fun max_escrow_duration_ms() : u64 {
        15552000000
    }

    public(friend) entry fun mutual_cancel<T0>(arg0: &mut OrderEscrow<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.buyer || v0 == arg0.seller, 10);
        assert!(arg0.status == 1, 6);
        assert!(arg0.cancel_approved_by_buyer && arg0.cancel_approved_by_seller, 6);
        settle_to_buyer<T0>(arg0, v0, 2, arg1);
    }

    public(friend) entry fun open_dispute_guarded<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg1: &mut OrderEscrow<T0>, arg2: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::ReputationFeeConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg1.buyer || v0 == arg1.seller, 10);
        assert!(arg1.status == 1, 6);
        assert!(0x2::clock::timestamp_ms(arg3) < arg1.deadline_ms, 12);
        arg1.status = 3;
        arg1.disputed_at_ms = 0x2::clock::timestamp_ms(arg3);
        clear_cancel_approvals<T0>(arg1);
        emit_state_changed<T0>(arg1, v0);
        record_order_disputed<T0>(arg3, arg2, arg1, v0);
    }

    public(friend) entry fun open_milestone_dispute_case_entry<T0>(arg0: 0x1::string::String, arg1: &OrderEscrow<T0>, arg2: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::DisputeQuorumConfig, arg3: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::OrderDisputeBond, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::share_milestone_dispute_case(open_milestone_dispute_case<T0>(arg0, arg1, arg2, arg3, arg4, arg5));
    }

    public(friend) entry fun open_milestone_dispute_case_entry_typed<T0, T1>(arg0: 0x1::string::String, arg1: &OrderEscrow<T0>, arg2: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::DisputeQuorumConfig, arg3: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::OrderDisputeBondTyped<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::share_milestone_dispute_case(open_milestone_dispute_case_typed<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5));
    }

    public(friend) entry fun open_milestone_dispute_case_entry_with_invites<T0>(arg0: 0x1::string::String, arg1: vector<address>, arg2: &OrderEscrow<T0>, arg3: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::DisputeQuorumConfig, arg4: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::OrderDisputeBond, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::share_milestone_dispute_case(open_milestone_dispute_case_with_invites<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6));
    }

    public(friend) entry fun open_milestone_dispute_case_entry_with_invites_typed<T0, T1>(arg0: 0x1::string::String, arg1: vector<address>, arg2: &OrderEscrow<T0>, arg3: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::DisputeQuorumConfig, arg4: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::OrderDisputeBondTyped<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::share_milestone_dispute_case(open_milestone_dispute_case_with_invites_typed<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6));
    }

    public fun open_state() : u8 {
        1
    }

    fun order_escrow_binding_key(arg0: &vector<u8>, arg1: address, arg2: address) : OrderEscrowBindingKey {
        OrderEscrowBindingKey{
            order_ref : *arg0,
            buyer     : arg1,
            seller    : arg2,
        }
    }

    public fun order_ref<T0>(arg0: &OrderEscrow<T0>) : vector<u8> {
        arg0.order_ref
    }

    fun payout_split_with_fee<T0>(arg0: &mut OrderEscrow<T0>, arg1: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64) {
        let v0 = 0;
        if (arg0.fee_amount > 0) {
            let v1 = 0x2::balance::value<T0>(&arg0.funds);
            let v2 = if (arg0.fee_amount > v1) {
                v1
            } else {
                arg0.fee_amount
            };
            if (v2 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.funds, v2), arg1), arg0.fee_recipient);
                v0 = v2;
            };
        };
        let v3 = 0x2::balance::value<T0>(&arg0.funds);
        let v4 = v3 / 2;
        let v5 = v3 - v4;
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.funds, v4), arg1), arg0.buyer);
        };
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.funds, v5), arg1), arg0.seller);
        };
        (0x2::balance::value<T0>(&arg0.funds), v0, v5, v4)
    }

    fun payout_to_seller_with_fee<T0>(arg0: &mut OrderEscrow<T0>, arg1: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = 0;
        if (arg0.fee_amount > 0) {
            let v1 = 0x2::balance::value<T0>(&arg0.funds);
            let v2 = if (arg0.fee_amount > v1) {
                v1
            } else {
                arg0.fee_amount
            };
            if (v2 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.funds, v2), arg1), arg0.fee_recipient);
                v0 = v2;
            };
        };
        let v3 = &mut arg0.funds;
        (0x2::balance::value<T0>(&arg0.funds), v0, transfer_all_to<T0>(v3, arg0.seller, arg1))
    }

    fun record_buyer_rescue_after_seller_deadline<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::ReputationFeeConfig, arg2: &OrderEscrow<T0>) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::record_seller_deadline_miss_for(arg1, arg2.seller, arg0);
    }

    fun record_order_disputed<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::ReputationFeeConfig, arg2: &OrderEscrow<T0>, arg3: address) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::record_seller_disputed_order_for(arg1, arg2.seller, arg0);
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::record_buyer_disputed_order_for(arg1, arg2.buyer, arg0);
        if (arg3 == arg2.buyer) {
            0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::record_buyer_manual_review_action_for(arg1, arg2.buyer, arg0);
        };
    }

    fun record_order_escrow_binding(arg0: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::FeeConfig, arg1: &vector<u8>, arg2: address, arg3: address, arg4: address) {
        assert!(!0x2::dynamic_field::exists_<OrderEscrowBindingKey>(0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::fee_config_uid(arg0), order_escrow_binding_key(arg1, arg2, arg3)), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_order_escrow_already_bound());
        0x2::dynamic_field::add<OrderEscrowBindingKey, address>(0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::fee_config_uid_mut(arg0), order_escrow_binding_key(arg1, arg2, arg3), arg4);
    }

    fun record_seller_claim_after_buyer_inactivity<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::ReputationFeeConfig, arg2: &OrderEscrow<T0>) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::record_seller_completed_order_for(arg1, arg2.seller, arg0);
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::record_buyer_completed_order_for(arg1, arg2.buyer, arg0);
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::record_buyer_auto_release_miss_for(arg1, arg2.buyer, arg0);
    }

    fun record_undisputed_completion<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::ReputationFeeConfig, arg2: &OrderEscrow<T0>) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::record_seller_completed_order_for(arg1, arg2.seller, arg0);
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::record_buyer_completed_order_for(arg1, arg2.buyer, arg0);
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::record_buyer_manual_review_action_for(arg1, arg2.buyer, arg0);
    }

    public(friend) fun release<T0>(arg0: &mut OrderEscrow<T0>, arg1: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::ReputationFeeConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        release_order_escrow_funds<T0>(arg0, arg1, arg2, arg3);
    }

    fun release_order_escrow_funds<T0>(arg0: &mut OrderEscrow<T0>, arg1: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::ReputationFeeConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.buyer, 7);
        assert!(arg0.status == 1, 6);
        assert!(0x2::balance::value<T0>(&arg0.funds) > 0, 8);
        let (v1, v2, v3) = payout_to_seller_with_fee<T0>(arg0, arg3);
        arg0.status = 2;
        clear_cancel_approvals<T0>(arg0);
        emit_settlement<T0>(arg0, v0, 0, v1, v2, v3, 0);
        emit_state_changed<T0>(arg0, v0);
        record_undisputed_completion<T0>(arg2, arg1, arg0);
    }

    public(friend) entry fun release_order_escrow_sui_entry(arg0: &mut OrderEscrow<0x2::sui::SUI>, arg1: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::ReputationFeeConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        release_order_escrow_funds<0x2::sui::SUI>(arg0, arg1, arg2, arg3);
    }

    public(friend) fun release_order_escrow_typed_coin<T0>(arg0: &mut OrderEscrow<T0>, arg1: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::ReputationFeeConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::typed_fee_policy::order_payment_fee_policy_kind<T0>() == 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::typed_fee_policy::fee_policy_exact_typed_order_asset(), 3);
        release_order_escrow_funds<T0>(arg0, arg1, arg2, arg3);
    }

    public(friend) entry fun release_order_escrow_typed_order_asset_entry<T0>(arg0: &mut OrderEscrow<T0>, arg1: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::ReputationFeeConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        release_order_escrow_typed_coin<T0>(arg0, arg1, arg2, arg3);
    }

    public(friend) entry fun release_unused_dispute_bond_after_release<T0>(arg0: &OrderEscrow<T0>, arg1: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::OrderDisputeBond, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.buyer || v0 == arg0.seller, 10);
        assert!(arg0.status == 2, 6);
        assert_matching_dispute_bond<T0>(arg0, arg1);
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::release_active_order_dispute_bond_without_case(arg1, arg2);
    }

    public(friend) entry fun release_unused_typed_dispute_bond_after_release<T0, T1>(arg0: &OrderEscrow<T0>, arg1: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::OrderDisputeBondTyped<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.buyer || v0 == arg0.seller, 10);
        assert!(arg0.status == 2, 6);
        assert_matching_typed_dispute_bond<T0, T1>(arg0, arg1);
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::release_active_order_dispute_typed_bond_without_case<T1>(arg1, arg2);
    }

    public(friend) entry fun release_with_dispute_bond<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::ReputationFeeConfig, arg2: &mut OrderEscrow<T0>, arg3: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::OrderDisputeBond, arg4: &mut 0x2::tx_context::TxContext) {
        assert_matching_dispute_bond<T0>(arg2, arg3);
        release_order_escrow_funds<T0>(arg2, arg1, arg0, arg4);
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::release_active_order_dispute_bond_without_case(arg3, arg4);
    }

    public(friend) entry fun release_with_typed_dispute_bond<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation::ReputationFeeConfig, arg2: &mut OrderEscrow<T0>, arg3: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::OrderDisputeBondTyped<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_matching_typed_dispute_bond<T0, T1>(arg2, arg3);
        release_order_escrow_funds<T0>(arg2, arg1, arg0, arg4);
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::release_active_order_dispute_typed_bond_without_case<T1>(arg3, arg4);
    }

    public fun released_state() : u8 {
        2
    }

    fun remove_order_escrow_binding_if_current<T0>(arg0: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::FeeConfig, arg1: &OrderEscrow<T0>) {
        assert!(0x2::dynamic_field::exists_<OrderEscrowBindingKey>(0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::fee_config_uid(arg0), order_escrow_binding_key(&arg1.order_ref, arg1.buyer, arg1.seller)), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        assert!(*0x2::dynamic_field::borrow<OrderEscrowBindingKey, address>(0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::fee_config_uid(arg0), order_escrow_binding_key(&arg1.order_ref, arg1.buyer, arg1.seller)) == escrow_id<T0>(arg1), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        0x2::dynamic_field::remove<OrderEscrowBindingKey, address>(0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::fee_config_uid_mut(arg0), order_escrow_binding_key(&arg1.order_ref, arg1.buyer, arg1.seller));
    }

    public(friend) entry fun resolve_dispute_after_timeout_split_guarded<T0>(arg0: &0x2::clock::Clock, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::DisputeQuorumConfig, arg2: &mut OrderEscrow<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_timeout_fallback_allowed_guarded<T0>(arg0, arg1, arg2);
        let v0 = 0x2::tx_context::sender(arg3);
        settle_split<T0>(arg2, v0, 4, arg3);
    }

    public(friend) entry fun resolve_dispute_after_timeout_to_seller_guarded<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::ArbCap, arg1: &0x2::clock::Clock, arg2: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::DisputeQuorumConfig, arg3: &mut OrderEscrow<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_timeout_fallback_allowed_guarded<T0>(arg1, arg2, arg3);
        let v0 = 0x2::tx_context::sender(arg4);
        settle_to_seller<T0>(arg3, v0, 4, arg4);
    }

    public(friend) entry fun resolve_dispute_split_guarded<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::ArbCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::DisputeQuorumConfig, arg2: &mut OrderEscrow<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_direct_dispute_resolution_allowed<T0>(arg1, arg2);
        let v0 = 0x2::tx_context::sender(arg3);
        settle_split<T0>(arg2, v0, 4, arg3);
    }

    public(friend) entry fun resolve_dispute_to_buyer_guarded<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::ArbCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::DisputeQuorumConfig, arg2: &mut OrderEscrow<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_direct_dispute_resolution_allowed<T0>(arg1, arg2);
        let v0 = 0x2::tx_context::sender(arg3);
        settle_to_buyer<T0>(arg2, v0, 4, arg3);
    }

    public(friend) entry fun resolve_dispute_to_seller_guarded<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::ArbCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::DisputeQuorumConfig, arg2: &mut OrderEscrow<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_direct_dispute_resolution_allowed<T0>(arg1, arg2);
        let v0 = 0x2::tx_context::sender(arg3);
        settle_to_seller<T0>(arg2, v0, 4, arg3);
    }

    public(friend) entry fun resolve_dispute_with_binding<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::DisputeQuorumConfig, arg1: &mut OrderEscrow<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 3, 6);
        let v0 = 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::finalized_escrow_binding_settlement_path(arg0, escrow_id<T0>(arg1));
        if (v0 == 0) {
            let v1 = 0x2::tx_context::sender(arg2);
            settle_to_seller<T0>(arg1, v1, 4, arg2);
        } else if (v0 == 1) {
            let v2 = 0x2::tx_context::sender(arg2);
            settle_to_buyer<T0>(arg1, v2, 4, arg2);
        } else {
            assert!(v0 == 2, 13);
            let v3 = 0x2::tx_context::sender(arg2);
            settle_split<T0>(arg1, v3, 4, arg2);
        };
    }

    public(friend) entry fun resolve_dispute_with_path_guarded<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::ArbCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::dispute_quorum::DisputeQuorumConfig, arg2: &mut OrderEscrow<T0>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg3 == 0) {
            resolve_dispute_to_seller_guarded<T0>(arg0, arg1, arg2, arg4);
        } else if (arg3 == 1) {
            resolve_dispute_to_buyer_guarded<T0>(arg0, arg1, arg2, arg4);
        } else {
            assert!(arg3 == 2, 13);
            resolve_dispute_split_guarded<T0>(arg0, arg1, arg2, arg4);
        };
    }

    public fun resolved_state() : u8 {
        4
    }

    public(friend) fun review_buyer<T0>(arg0: &OrderEscrow<T0>) : address {
        arg0.buyer
    }

    public(friend) fun review_is_terminal<T0>(arg0: &OrderEscrow<T0>) : bool {
        arg0.status == 2 || arg0.status == 4
    }

    public(friend) fun review_order_id<T0>(arg0: &OrderEscrow<T0>) : 0x1::string::String {
        0x1::string::utf8(arg0.order_ref)
    }

    public(friend) fun review_order_ref<T0>(arg0: &OrderEscrow<T0>) : vector<u8> {
        arg0.order_ref
    }

    public(friend) fun review_seller<T0>(arg0: &OrderEscrow<T0>) : address {
        arg0.seller
    }

    public fun seller<T0>(arg0: &OrderEscrow<T0>) : address {
        arg0.seller
    }

    fun settle_split<T0>(arg0: &mut OrderEscrow<T0>, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = payout_split_with_fee<T0>(arg0, arg3);
        arg0.status = arg2;
        clear_cancel_approvals<T0>(arg0);
        clear_delete_approvals<T0>(arg0);
        emit_settlement<T0>(arg0, arg1, 2, v0, v1, v2, v3);
        emit_state_changed<T0>(arg0, arg1);
    }

    fun settle_to_buyer<T0>(arg0: &mut OrderEscrow<T0>, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.funds;
        let v1 = transfer_all_to<T0>(v0, arg0.buyer, arg3);
        arg0.status = arg2;
        clear_cancel_approvals<T0>(arg0);
        clear_delete_approvals<T0>(arg0);
        emit_settlement<T0>(arg0, arg1, 1, v1, 0, 0, v1);
        emit_state_changed<T0>(arg0, arg1);
    }

    fun settle_to_seller<T0>(arg0: &mut OrderEscrow<T0>, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = payout_to_seller_with_fee<T0>(arg0, arg3);
        arg0.status = arg2;
        clear_cancel_approvals<T0>(arg0);
        clear_delete_approvals<T0>(arg0);
        emit_settlement<T0>(arg0, arg1, 0, v0, v1, v2, 0);
        emit_state_changed<T0>(arg0, arg1);
    }

    public fun settlement_split_path() : u8 {
        2
    }

    public fun settlement_to_buyer_path() : u8 {
        1
    }

    public fun settlement_to_seller_path() : u8 {
        0
    }

    public fun state<T0>(arg0: &OrderEscrow<T0>) : u8 {
        arg0.status
    }

    fun transfer_all_to<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::balance::value<T0>(arg0);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg0, v0), arg2), arg1);
        };
        v0
    }

    public(friend) fun typed_non_sui_order_escrow_exact_fee_policy_ready<T0, T1>() : bool {
        0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::typed_fee_policy::order_payment_fee_asset_matches_order_asset<T0, T1>() && 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::typed_fee_policy::order_payment_fee_policy_kind<T1>() == 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::typed_fee_policy::fee_policy_exact_typed_order_asset()
    }

    public(friend) fun typed_non_sui_order_escrow_requires_enabled_lane<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::FeeConfig) : bool {
        0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::order_payment_assets::is_supported_order_payment_typed_coin_type<T0>() && !0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::payment_core_asset_lanes::typed_order_escrow_create_enabled<T0>(arg0)
    }

    // decompiled from Move bytecode v7
}

