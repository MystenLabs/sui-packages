module 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing_and_fee_manager {
    struct PricingAndFeeManager has store {
        current: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::PricingInfo,
        default: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::PricingInfo,
        validator_votes: 0x2::table::Table<0x2::object::ID, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::PricingInfo>,
        pricing_calculation_votes: 0x1::option::Option<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::PricingInfoCalculationVotes>,
        gas_fee_reimbursement_sui_system_call_value: u64,
        gas_fee_reimbursement_sui_system_call_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        fee_charged_ika: 0x2::balance::Balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>,
    }

    public(friend) fun advance_epoch(arg0: &mut PricingAndFeeManager) : 0x2::balance::Balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA> {
        assert!(0x1::option::is_none<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::PricingInfoCalculationVotes>(&arg0.pricing_calculation_votes), 3);
        0x2::balance::withdraw_all<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.fee_charged_ika)
    }

    public(friend) fun calculate_pricing_votes(arg0: &mut PricingAndFeeManager, arg1: u32, arg2: 0x1::option::Option<u32>, arg3: u32) {
        assert!(0x1::option::is_some<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::PricingInfoCalculationVotes>(&arg0.pricing_calculation_votes), 2);
        let v0 = 0x1::option::borrow_mut<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::PricingInfoCalculationVotes>(&mut arg0.pricing_calculation_votes);
        let v1 = 0x1::vector::empty<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::PricingInfo>();
        let v2 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::committee_members_for_pricing_calculation_votes(v0);
        0x1::vector::reverse<0x2::object::ID>(&mut v2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x2::object::ID>(&v2)) {
            let v4 = 0x1::vector::pop_back<0x2::object::ID>(&mut v2);
            let v5 = if (0x2::table::contains<0x2::object::ID, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::PricingInfo>(&arg0.validator_votes, v4)) {
                *0x2::table::borrow<0x2::object::ID, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::PricingInfo>(&arg0.validator_votes, v4)
            } else {
                arg0.default
            };
            0x1::vector::push_back<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::PricingInfo>(&mut v1, v5);
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(v2);
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::calculate_pricing_quorum_below(v0, v1, arg1, arg2, arg3);
        if (0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::is_calculation_completed(v0)) {
            arg0.current = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::calculated_pricing(v0);
            arg0.pricing_calculation_votes = 0x1::option::none<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::PricingInfoCalculationVotes>();
        };
    }

    public(friend) fun charge_gas_fee_reimbursement_sui_for_system_calls(arg0: &mut PricingAndFeeManager) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.gas_fee_reimbursement_sui_system_call_balance);
        let v1 = arg0.gas_fee_reimbursement_sui_system_call_value;
        if (v0 > 0 && v1 > 0) {
            if (v0 > v1) {
                0x2::balance::split<0x2::sui::SUI>(&mut arg0.gas_fee_reimbursement_sui_system_call_balance, v1)
            } else {
                0x2::balance::split<0x2::sui::SUI>(&mut arg0.gas_fee_reimbursement_sui_system_call_balance, v0)
            }
        } else {
            0x2::balance::zero<0x2::sui::SUI>()
        }
    }

    public(friend) fun create(arg0: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::PricingInfo, arg1: &mut 0x2::tx_context::TxContext) : PricingAndFeeManager {
        PricingAndFeeManager{
            current                                       : arg0,
            default                                       : arg0,
            validator_votes                               : 0x2::table::new<0x2::object::ID, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::PricingInfo>(arg1),
            pricing_calculation_votes                     : 0x1::option::none<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::PricingInfoCalculationVotes>(),
            gas_fee_reimbursement_sui_system_call_value   : 0,
            gas_fee_reimbursement_sui_system_call_balance : 0x2::balance::zero<0x2::sui::SUI>(),
            fee_charged_ika                               : 0x2::balance::zero<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(),
        }
    }

    public(friend) fun current_pricing(arg0: &PricingAndFeeManager) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::PricingInfo {
        arg0.current
    }

    public(friend) fun get_pricing_value_for_protocol(arg0: &PricingAndFeeManager, arg1: u32, arg2: 0x1::option::Option<u32>, arg3: u32) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::PricingInfoValue {
        let v0 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::try_get_pricing_value(&arg0.current, arg1, arg2, arg3);
        assert!(0x1::option::is_some<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::PricingInfoValue>(&v0), 1);
        0x1::option::extract<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::PricingInfoValue>(&mut v0)
    }

    public(friend) fun initiate_pricing_calculation(arg0: &mut PricingAndFeeManager, arg1: 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee) {
        arg0.pricing_calculation_votes = 0x1::option::some<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::PricingInfoCalculationVotes>(0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::new_pricing_calculation(arg1, arg0.default));
    }

    public(friend) fun join_fee_charged_ika(arg0: &mut PricingAndFeeManager, arg1: 0x2::balance::Balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>) {
        0x2::balance::join<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.fee_charged_ika, arg1);
    }

    public(friend) fun join_gas_fee_reimbursement_sui_system_call_balance(arg0: &mut PricingAndFeeManager, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.gas_fee_reimbursement_sui_system_call_balance, arg1);
    }

    public(friend) fun set_default_pricing(arg0: &mut PricingAndFeeManager, arg1: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::PricingInfo) {
        arg0.default = arg1;
    }

    public(friend) fun set_gas_fee_reimbursement_sui_system_call_value(arg0: &mut PricingAndFeeManager, arg1: u64) {
        arg0.gas_fee_reimbursement_sui_system_call_value = arg1;
    }

    public(friend) fun set_pricing_vote(arg0: &mut PricingAndFeeManager, arg1: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::PricingInfo, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::VerifiedValidatorOperationCap) {
        let v0 = 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::verified_validator_operation_cap_validator_id(arg2);
        assert!(0x1::option::is_none<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::PricingInfoCalculationVotes>(&arg0.pricing_calculation_votes), 4);
        if (0x2::table::contains<0x2::object::ID, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::PricingInfo>(&arg0.validator_votes, v0)) {
            *0x2::table::borrow_mut<0x2::object::ID, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::PricingInfo>(&mut arg0.validator_votes, v0) = arg1;
        } else {
            0x2::table::add<0x2::object::ID, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::PricingInfo>(&mut arg0.validator_votes, v0, arg1);
        };
    }

    // decompiled from Move bytecode v6
}

