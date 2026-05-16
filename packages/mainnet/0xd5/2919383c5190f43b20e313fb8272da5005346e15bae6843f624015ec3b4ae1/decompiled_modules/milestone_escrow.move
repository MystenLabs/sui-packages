module 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::milestone_escrow {
    struct MilestoneSlot has copy, drop, store {
        amount: u64,
        deadline_ms: u64,
        state: u8,
        disputed_at_ms: u64,
    }

    struct MilestoneEscrow<phantom T0> has key {
        id: 0x2::object::UID,
        order_id: 0x1::string::String,
        buyer: address,
        seller: address,
        milestones: vector<MilestoneSlot>,
        milestone_count: u64,
        next_milestone_idx: u64,
        locked: 0x2::balance::Balance<T0>,
        total_deposited: u64,
        total_released: u64,
        fee_bps: u64,
        fee_recipient: address,
        total_fee_paid: u64,
        order_state: u8,
        created_at_ms: u64,
        delete_approved_by_buyer: bool,
        delete_approved_by_seller: bool,
    }

    struct MilestoneEscrowCreated has copy, drop {
        escrow_id: address,
        order_id: 0x1::string::String,
        buyer: address,
        seller: address,
        milestone_count: u64,
        total_deposited: u64,
        fee_bps: u64,
        fee_recipient: address,
    }

    struct MilestoneSubmitted has copy, drop {
        escrow_id: address,
        order_id: 0x1::string::String,
        milestone_idx: u64,
        actor: address,
    }

    struct MilestoneApproved has copy, drop {
        escrow_id: address,
        order_id: 0x1::string::String,
        milestone_idx: u64,
        actor: address,
        amount_released: u64,
        fee_paid: u64,
    }

    struct MilestoneDisputed has copy, drop {
        escrow_id: address,
        order_id: 0x1::string::String,
        milestone_idx: u64,
        actor: address,
    }

    struct MilestoneResolved has copy, drop {
        escrow_id: address,
        order_id: 0x1::string::String,
        milestone_idx: u64,
        actor: address,
        seller_paid: u64,
        buyer_refunded: u64,
        fee_paid: u64,
    }

    struct MilestoneOrderCompleted has copy, drop {
        escrow_id: address,
        order_id: 0x1::string::String,
        total_released: u64,
        total_fee_paid: u64,
    }

    struct MilestoneOrderCanceled has copy, drop {
        escrow_id: address,
        order_id: 0x1::string::String,
        actor: address,
        buyer_refunded: u64,
    }

    struct MilestoneDisputeForceResolved has copy, drop {
        escrow_id: address,
        order_id: 0x1::string::String,
        milestone_idx: u64,
        actor: address,
        buyer_refunded: u64,
    }

    public(friend) entry fun approve_milestone(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg1: &mut MilestoneEscrow<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        approve_milestone_typed<0x2::sui::SUI>(arg0, arg1, arg2, arg3);
    }

    public(friend) entry fun approve_milestone_escrow_deletion<T0>(arg0: &mut MilestoneEscrow<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.order_state == 1 || arg0.order_state == 2, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_invalid_state());
        let v0 = 0x2::tx_context::sender(arg1);
        if (v0 == arg0.buyer) {
            arg0.delete_approved_by_buyer = true;
        } else {
            assert!(v0 == arg0.seller, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_not_authorized());
            arg0.delete_approved_by_seller = true;
        };
    }

    public(friend) entry fun approve_milestone_typed<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg1: &mut MilestoneEscrow<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg1.buyer, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_not_authorized());
        assert!(arg1.order_state == 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_invalid_state());
        assert!(arg2 < arg1.milestone_count, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_index_oob());
        let v1 = 0x1::vector::borrow_mut<MilestoneSlot>(&mut arg1.milestones, arg2);
        assert!(v1.state == 1, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_invalid_state());
        v1.state = 2;
        let v2 = v1.amount;
        let v3 = compute_fee(v2, arg1.fee_bps);
        let v4 = v2 - v3;
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.locked, v3), arg3), arg1.fee_recipient);
            arg1.total_fee_paid = arg1.total_fee_paid + v3;
        };
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.locked, v4), arg3), arg1.seller);
        };
        arg1.total_released = arg1.total_released + v2;
        arg1.next_milestone_idx = arg1.next_milestone_idx + 1;
        let v5 = MilestoneApproved{
            escrow_id       : escrow_id<T0>(arg1),
            order_id        : arg1.order_id,
            milestone_idx   : arg2,
            actor           : v0,
            amount_released : v2,
            fee_paid        : v3,
        };
        0x2::event::emit<MilestoneApproved>(v5);
        complete_if_done<T0>(arg1);
    }

    fun assert_non_empty_with_max(arg0: &0x1::string::String, arg1: u64) {
        let v0 = 0x1::string::length(arg0);
        assert!(v0 > 0 && v0 <= arg1, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_invalid_input());
    }

    fun assert_submission_deadline_open(arg0: &MilestoneSlot, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.deadline_ms, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_deadline_passed());
    }

    fun assert_typed_order_payment_fee_policy<T0, T1>() {
        assert!(0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::typed_fee_policy::order_payment_fee_asset_matches_order_asset<T0, T1>() && 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::typed_fee_policy::order_payment_fee_policy_kind<T1>() == 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::typed_fee_policy::fee_policy_exact_typed_order_asset(), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_fee_config());
    }

    public(friend) entry fun cancel_order(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &mut MilestoneEscrow<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        cancel_order_typed<0x2::sui::SUI>(arg0, arg1, arg2);
    }

    public(friend) entry fun cancel_order_typed<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &mut MilestoneEscrow<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.order_state == 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_invalid_state());
        let v0 = 0x2::balance::value<T0>(&arg1.locked);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.locked, v0), arg2), arg1.buyer);
        };
        arg1.order_state = 2;
        let v1 = MilestoneOrderCanceled{
            escrow_id      : escrow_id<T0>(arg1),
            order_id       : arg1.order_id,
            actor          : 0x2::tx_context::sender(arg2),
            buyer_refunded : v0,
        };
        0x2::event::emit<MilestoneOrderCanceled>(v1);
    }

    fun complete_if_done<T0>(arg0: &mut MilestoneEscrow<T0>) {
        if (arg0.next_milestone_idx == arg0.milestone_count) {
            arg0.order_state = 1;
            let v0 = MilestoneOrderCompleted{
                escrow_id      : escrow_id<T0>(arg0),
                order_id       : arg0.order_id,
                total_released : arg0.total_released,
                total_fee_paid : arg0.total_fee_paid,
            };
            0x2::event::emit<MilestoneOrderCompleted>(v0);
        };
    }

    fun compute_fee(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public(friend) entry fun create_milestone_escrow(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::FeeConfig, arg2: 0x1::string::String, arg3: address, arg4: vector<u64>, arg5: vector<u64>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        create_milestone_escrow_sui_entry(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    fun create_milestone_escrow_from_coin<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::FeeConfig, arg2: 0x1::string::String, arg3: address, arg4: vector<u64>, arg5: vector<u64>, arg6: 0x2::coin::Coin<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : MilestoneEscrow<T0> {
        create_milestone_escrow_from_coin_inner<T0>(arg0, arg2, arg3, arg4, arg5, arg6, 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::sui_fee_bps(arg1), 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::sui_fee_recipient(arg1), arg7, arg8)
    }

    fun create_milestone_escrow_from_coin_inner<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg1: 0x1::string::String, arg2: address, arg3: vector<u64>, arg4: vector<u64>, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : MilestoneEscrow<T0> {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg0);
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(v0 != arg2, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_invalid_input());
        assert!(arg2 != @0x0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_invalid_input());
        assert_non_empty_with_max(&arg1, 128);
        assert!(arg6 <= 10000, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_fee_config());
        if (arg6 > 0) {
            assert!(arg7 != @0x0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_fee_config());
        };
        let v1 = 0x1::vector::length<u64>(&arg3);
        assert!(v1 > 0 && v1 <= 20, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_invalid_input());
        assert!(0x1::vector::length<u64>(&arg4) == v1, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_invalid_input());
        let v2 = 0x1::vector::empty<MilestoneSlot>();
        let v3 = 0;
        let v4 = 0x2::clock::timestamp_ms(arg8);
        let v5 = 0;
        while (v5 < v1) {
            let v6 = *0x1::vector::borrow<u64>(&arg3, v5);
            let v7 = *0x1::vector::borrow<u64>(&arg4, v5);
            assert!(v6 > 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_invalid_input());
            assert!(v7 > v4, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_invalid_input());
            assert!((v7 as u128) <= (v4 as u128) + (31536000000 as u128), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_deadline_exceeded());
            assert!(v7 >= v4, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_invalid_input());
            let v8 = v3 + (v6 as u128);
            v3 = v8;
            assert!(v8 <= 18446744073709551615, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_invalid_input());
            let v9 = MilestoneSlot{
                amount         : v6,
                deadline_ms    : v7,
                state          : 0,
                disputed_at_ms : 0,
            };
            0x1::vector::push_back<MilestoneSlot>(&mut v2, v9);
            v5 = v5 + 1;
        };
        let v10 = 0x2::coin::value<T0>(&arg5);
        assert!(v10 == (v3 as u64), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_invalid_input());
        let v11 = MilestoneEscrow<T0>{
            id                        : 0x2::object::new(arg9),
            order_id                  : arg1,
            buyer                     : v0,
            seller                    : arg2,
            milestones                : v2,
            milestone_count           : v1,
            next_milestone_idx        : 0,
            locked                    : 0x2::coin::into_balance<T0>(arg5),
            total_deposited           : v10,
            total_released            : 0,
            fee_bps                   : arg6,
            fee_recipient             : arg7,
            total_fee_paid            : 0,
            order_state               : 0,
            created_at_ms             : v4,
            delete_approved_by_buyer  : false,
            delete_approved_by_seller : false,
        };
        let v12 = MilestoneEscrowCreated{
            escrow_id       : escrow_id<T0>(&v11),
            order_id        : v11.order_id,
            buyer           : v0,
            seller          : arg2,
            milestone_count : v1,
            total_deposited : v10,
            fee_bps         : arg6,
            fee_recipient   : arg7,
        };
        0x2::event::emit<MilestoneEscrowCreated>(v12);
        v11
    }

    public(friend) entry fun create_milestone_escrow_sui_entry(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::FeeConfig, arg2: 0x1::string::String, arg3: address, arg4: vector<u64>, arg5: vector<u64>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<MilestoneEscrow<0x2::sui::SUI>>(create_milestone_escrow_sui_with_config(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8));
    }

    public(friend) fun create_milestone_escrow_sui_with_config(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::FeeConfig, arg2: 0x1::string::String, arg3: address, arg4: vector<u64>, arg5: vector<u64>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : MilestoneEscrow<0x2::sui::SUI> {
        assert!(0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::order_payment_assets::is_supported_order_payment_sui_type<0x2::sui::SUI>(), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_kind());
        create_milestone_escrow_from_coin<0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public(friend) fun create_milestone_escrow_typed_coin_with_config<T0, T1>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::FeeConfig, arg2: 0x1::string::String, arg3: address, arg4: vector<u64>, arg5: vector<u64>, arg6: 0x2::coin::Coin<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : MilestoneEscrow<T1> {
        assert!(0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::payment_core_asset_lanes::typed_order_escrow_create_enabled<T1>(arg1), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_kind());
        assert_typed_order_payment_fee_policy<T0, T1>();
        create_milestone_escrow_from_coin<T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public(friend) entry fun create_milestone_escrow_typed_order_asset_entry<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::FeeConfig, arg2: 0x1::string::String, arg3: address, arg4: vector<u64>, arg5: vector<u64>, arg6: 0x2::coin::Coin<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<MilestoneEscrow<T0>>(create_milestone_escrow_typed_coin_with_config<T0, T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8));
    }

    public(friend) entry fun delete_milestone_escrow<T0>(arg0: MilestoneEscrow<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.buyer || v0 == arg0.seller, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_not_authorized());
        assert!(arg0.order_state == 1 || arg0.order_state == 2, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_invalid_state());
        assert!(arg0.delete_approved_by_buyer && arg0.delete_approved_by_seller, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_invalid_state());
        let MilestoneEscrow {
            id                        : v1,
            order_id                  : _,
            buyer                     : _,
            seller                    : _,
            milestones                : _,
            milestone_count           : _,
            next_milestone_idx        : _,
            locked                    : v8,
            total_deposited           : _,
            total_released            : _,
            fee_bps                   : _,
            fee_recipient             : _,
            total_fee_paid            : _,
            order_state               : _,
            created_at_ms             : _,
            delete_approved_by_buyer  : _,
            delete_approved_by_seller : _,
        } = arg0;
        0x2::balance::destroy_zero<T0>(v8);
        0x2::object::delete(v1);
    }

    public(friend) entry fun dispute_milestone(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg1: &mut MilestoneEscrow<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        dispute_milestone_typed<0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4);
    }

    public(friend) entry fun dispute_milestone_typed<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg1: &mut MilestoneEscrow<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg1.buyer || v0 == arg1.seller, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_not_authorized());
        assert!(arg1.order_state == 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_invalid_state());
        assert!(arg2 < arg1.milestone_count, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_index_oob());
        let v1 = 0x1::vector::borrow_mut<MilestoneSlot>(&mut arg1.milestones, arg2);
        assert!(v1.state == 1, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_invalid_state());
        v1.state = 3;
        v1.disputed_at_ms = 0x2::clock::timestamp_ms(arg3);
        let v2 = MilestoneDisputed{
            escrow_id     : escrow_id<T0>(arg1),
            order_id      : arg1.order_id,
            milestone_idx : arg2,
            actor         : v0,
        };
        0x2::event::emit<MilestoneDisputed>(v2);
    }

    fun escrow_id<T0>(arg0: &MilestoneEscrow<T0>) : address {
        let v0 = 0x2::object::id<MilestoneEscrow<T0>>(arg0);
        0x2::object::id_to_address(&v0)
    }

    public(friend) fun escrow_id_for_review<T0>(arg0: &MilestoneEscrow<T0>) : address {
        escrow_id<T0>(arg0)
    }

    public(friend) entry fun force_resolve_expired_milestone(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &mut MilestoneEscrow<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        resolve_expired_milestone_after_timeout_typed<0x2::sui::SUI>(arg1, arg2, arg3, arg4);
    }

    public fun ms_approved() : u8 {
        2
    }

    public fun ms_disputed() : u8 {
        3
    }

    public fun ms_pending() : u8 {
        0
    }

    public fun ms_resolved() : u8 {
        4
    }

    public fun ms_submitted() : u8 {
        1
    }

    public fun order_active() : u8 {
        0
    }

    public fun order_canceled() : u8 {
        2
    }

    public fun order_completed() : u8 {
        1
    }

    public(friend) entry fun resolve_expired_milestone_after_timeout(arg0: &mut MilestoneEscrow<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        resolve_expired_milestone_after_timeout_typed<0x2::sui::SUI>(arg0, arg1, arg2, arg3);
    }

    public(friend) entry fun resolve_expired_milestone_after_timeout_typed<T0>(arg0: &mut MilestoneEscrow<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.order_state == 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_invalid_state());
        assert!(arg1 < arg0.milestone_count, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_index_oob());
        let v0 = 0x1::vector::borrow_mut<MilestoneSlot>(&mut arg0.milestones, arg1);
        assert!(v0.state == 3, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_invalid_state());
        assert!(v0.disputed_at_ms > 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_invalid_state());
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 >= v0.disputed_at_ms, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_invalid_state());
        assert!(v1 - v0.disputed_at_ms >= 2592000000, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_dispute_not_expired());
        v0.state = 4;
        let v2 = v0.amount;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.locked, v2), arg3), arg0.buyer);
        arg0.total_released = arg0.total_released + v2;
        arg0.next_milestone_idx = arg0.next_milestone_idx + 1;
        let v3 = MilestoneDisputeForceResolved{
            escrow_id      : escrow_id<T0>(arg0),
            order_id       : arg0.order_id,
            milestone_idx  : arg1,
            actor          : 0x2::tx_context::sender(arg3),
            buyer_refunded : v2,
        };
        0x2::event::emit<MilestoneDisputeForceResolved>(v3);
        complete_if_done<T0>(arg0);
    }

    public(friend) entry fun resolve_milestone(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::ArbCap, arg2: &mut MilestoneEscrow<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        resolve_milestone_typed<0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public(friend) entry fun resolve_milestone_typed<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::ArbCap, arg2: &mut MilestoneEscrow<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg0);
        assert!(arg4 <= 10000, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_invalid_input());
        assert!(arg2.order_state == 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_invalid_state());
        assert!(arg3 < arg2.milestone_count, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_index_oob());
        let v0 = 0x1::vector::borrow_mut<MilestoneSlot>(&mut arg2.milestones, arg3);
        assert!(v0.state == 3, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_invalid_state());
        v0.state = 4;
        let v1 = v0.amount;
        let v2 = compute_fee(v1, arg2.fee_bps);
        let v3 = v1 - v2;
        let v4 = (((v3 as u128) * (arg4 as u128) / (10000 as u128)) as u64);
        let v5 = v3 - v4;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.locked, v2), arg5), arg2.fee_recipient);
            arg2.total_fee_paid = arg2.total_fee_paid + v2;
        };
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.locked, v4), arg5), arg2.seller);
        };
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.locked, v5), arg5), arg2.buyer);
        };
        arg2.total_released = arg2.total_released + v1;
        arg2.next_milestone_idx = arg2.next_milestone_idx + 1;
        let v6 = MilestoneResolved{
            escrow_id      : escrow_id<T0>(arg2),
            order_id       : arg2.order_id,
            milestone_idx  : arg3,
            actor          : 0x2::tx_context::sender(arg5),
            seller_paid    : v4,
            buyer_refunded : v5,
            fee_paid       : v2,
        };
        0x2::event::emit<MilestoneResolved>(v6);
        complete_if_done<T0>(arg2);
    }

    public(friend) fun review_buyer<T0>(arg0: &MilestoneEscrow<T0>) : address {
        arg0.buyer
    }

    public(friend) fun review_is_terminal<T0>(arg0: &MilestoneEscrow<T0>) : bool {
        arg0.order_state == 1 || arg0.order_state == 2
    }

    public(friend) fun review_order_id<T0>(arg0: &MilestoneEscrow<T0>) : 0x1::string::String {
        arg0.order_id
    }

    public(friend) fun review_order_ref<T0>(arg0: &MilestoneEscrow<T0>) : vector<u8> {
        *0x1::string::as_bytes(&arg0.order_id)
    }

    public(friend) fun review_seller<T0>(arg0: &MilestoneEscrow<T0>) : address {
        arg0.seller
    }

    public(friend) entry fun submit_milestone(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg1: &mut MilestoneEscrow<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        submit_milestone_typed<0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4);
    }

    public(friend) entry fun submit_milestone_typed<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg1: &mut MilestoneEscrow<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg1.seller, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_not_authorized());
        assert!(arg1.order_state == 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_invalid_state());
        assert!(arg2 < arg1.milestone_count, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_index_oob());
        assert!(arg2 == arg1.next_milestone_idx, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_invalid_state());
        let v1 = 0x1::vector::borrow_mut<MilestoneSlot>(&mut arg1.milestones, arg2);
        assert!(v1.state == 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_milestone_invalid_state());
        assert_submission_deadline_open(v1, arg3);
        v1.state = 1;
        let v2 = MilestoneSubmitted{
            escrow_id     : escrow_id<T0>(arg1),
            order_id      : arg1.order_id,
            milestone_idx : arg2,
            actor         : v0,
        };
        0x2::event::emit<MilestoneSubmitted>(v2);
    }

    // decompiled from Move bytecode v7
}

