module 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing {
    struct PricingInfo has copy, drop, store {
        pricing_map: 0x2::vec_map::VecMap<PricingInfoKey, PricingInfoValue>,
    }

    struct PricingInfoKey has copy, drop, store {
        curve: u32,
        signature_algorithm: 0x1::option::Option<u32>,
        protocol: u32,
    }

    struct PricingInfoValue has copy, drop, store {
        fee_ika: u64,
        gas_fee_reimbursement_sui: u64,
        gas_fee_reimbursement_sui_for_system_calls: u64,
    }

    struct PricingInfoCalculationVotes has copy, drop, store {
        bls_committee: 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee,
        default_pricing: PricingInfo,
        working_pricing: PricingInfo,
    }

    public fun empty() : PricingInfo {
        PricingInfo{pricing_map: 0x2::vec_map::empty<PricingInfoKey, PricingInfoValue>()}
    }

    public(friend) fun calculate_pricing_quorum_below(arg0: &mut PricingInfoCalculationVotes, arg1: vector<PricingInfo>, arg2: u32, arg3: 0x1::option::Option<u32>, arg4: u32) {
        let v0 = 0x1::vector::empty<PricingInfoValue>();
        let v1 = &arg1;
        let v2 = 0;
        while (v2 < 0x1::vector::length<PricingInfo>(v1)) {
            let v3 = try_get_pricing_value(0x1::vector::borrow<PricingInfo>(v1, v2), arg2, arg3, arg4);
            let v4 = try_get_pricing_value(&arg0.default_pricing, arg2, arg3, arg4);
            0x1::vector::push_back<PricingInfoValue>(&mut v0, 0x1::option::get_with_default<PricingInfoValue>(&v3, 0x1::option::extract<PricingInfoValue>(&mut v4)));
            v2 = v2 + 1;
        };
        let v5 = &mut arg0.working_pricing;
        insert_or_update_pricing_value(v5, arg2, arg3, arg4, pricing_value_quorum_below(arg0.bls_committee, v0));
    }

    public(friend) fun calculated_pricing(arg0: &PricingInfoCalculationVotes) : PricingInfo {
        arg0.working_pricing
    }

    public(friend) fun committee_members_for_pricing_calculation_votes(arg0: &PricingInfoCalculationVotes) : vector<0x2::object::ID> {
        let v0 = 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::members(&arg0.bls_committee);
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommitteeMember>(v0)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v1, 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::validator_id(0x1::vector::borrow<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommitteeMember>(v0, v2)));
            v2 = v2 + 1;
        };
        v1
    }

    public fun fee_ika(arg0: &PricingInfoValue) : u64 {
        arg0.fee_ika
    }

    public fun gas_fee_reimbursement_sui(arg0: &PricingInfoValue) : u64 {
        arg0.gas_fee_reimbursement_sui
    }

    public fun gas_fee_reimbursement_sui_for_system_calls(arg0: &PricingInfoValue) : u64 {
        arg0.gas_fee_reimbursement_sui_for_system_calls
    }

    public fun insert_or_update_pricing(arg0: &mut PricingInfo, arg1: u32, arg2: 0x1::option::Option<u32>, arg3: u32, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = PricingInfoValue{
            fee_ika                                    : arg4,
            gas_fee_reimbursement_sui                  : arg5,
            gas_fee_reimbursement_sui_for_system_calls : arg6,
        };
        insert_or_update_pricing_value(arg0, arg1, arg2, arg3, v0);
    }

    fun insert_or_update_pricing_value(arg0: &mut PricingInfo, arg1: u32, arg2: 0x1::option::Option<u32>, arg3: u32, arg4: PricingInfoValue) {
        let v0 = PricingInfoKey{
            curve               : arg1,
            signature_algorithm : arg2,
            protocol            : arg3,
        };
        if (0x2::vec_map::contains<PricingInfoKey, PricingInfoValue>(&arg0.pricing_map, &v0)) {
            *0x2::vec_map::get_mut<PricingInfoKey, PricingInfoValue>(&mut arg0.pricing_map, &v0) = arg4;
        } else {
            0x2::vec_map::insert<PricingInfoKey, PricingInfoValue>(&mut arg0.pricing_map, v0, arg4);
        };
    }

    public(friend) fun is_calculation_completed(arg0: &PricingInfoCalculationVotes) : bool {
        let v0 = 0;
        let (v1, _) = 0x2::vec_map::into_keys_values<PricingInfoKey, PricingInfoValue>(arg0.default_pricing.pricing_map);
        let v3 = v1;
        while (v0 < 0x1::vector::length<PricingInfoKey>(&v3)) {
            let v4 = *0x1::vector::borrow<PricingInfoKey>(&v3, v0);
            let v5 = 0x2::vec_map::try_get<PricingInfoKey, PricingInfoValue>(&arg0.working_pricing.pricing_map, &v4);
            if (0x1::option::is_none<PricingInfoValue>(&v5)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public(friend) fun new_pricing_calculation(arg0: 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee, arg1: PricingInfo) : PricingInfoCalculationVotes {
        PricingInfoCalculationVotes{
            bls_committee   : arg0,
            default_pricing : arg1,
            working_pricing : empty(),
        }
    }

    public(friend) fun pricing_value_quorum_below(arg0: 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee, arg1: vector<PricingInfoValue>) : PricingInfoValue {
        let v0 = 0x2::priority_queue::new<u64>(0x1::vector::empty<0x2::priority_queue::Entry<u64>>());
        let v1 = 0x2::priority_queue::new<u64>(0x1::vector::empty<0x2::priority_queue::Entry<u64>>());
        let v2 = 0x2::priority_queue::new<u64>(0x1::vector::empty<0x2::priority_queue::Entry<u64>>());
        let v3 = &arg1;
        let v4 = 0;
        while (v4 < 0x1::vector::length<PricingInfoValue>(v3)) {
            let v5 = 0x1::vector::borrow<PricingInfoValue>(v3, v4);
            0x2::priority_queue::insert<u64>(&mut v0, fee_ika(v5), 1);
            0x2::priority_queue::insert<u64>(&mut v1, gas_fee_reimbursement_sui(v5), 1);
            0x2::priority_queue::insert<u64>(&mut v2, gas_fee_reimbursement_sui_for_system_calls(v5), 1);
            v4 = v4 + 1;
        };
        let v6 = &mut v0;
        let v7 = &mut v1;
        let v8 = &mut v2;
        PricingInfoValue{
            fee_ika                                    : quorum_below(arg0, v6),
            gas_fee_reimbursement_sui                  : quorum_below(arg0, v7),
            gas_fee_reimbursement_sui_for_system_calls : quorum_below(arg0, v8),
        }
    }

    fun quorum_below(arg0: 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee, arg1: &mut 0x2::priority_queue::PriorityQueue<u64>) : u64 {
        let v0 = 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::total_voting_power(&arg0);
        let v1;
        loop {
            let (v1, v2) = 0x2::priority_queue::pop_max<u64>(arg1);
            v0 = v0 - v2;
            if (!0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::is_quorum_threshold(&arg0, v0)) {
                break
            };
        };
        v1
    }

    public(friend) fun try_get_pricing_value(arg0: &PricingInfo, arg1: u32, arg2: 0x1::option::Option<u32>, arg3: u32) : 0x1::option::Option<PricingInfoValue> {
        let v0 = PricingInfoKey{
            curve               : arg1,
            signature_algorithm : arg2,
            protocol            : arg3,
        };
        0x2::vec_map::try_get<PricingInfoKey, PricingInfoValue>(&arg0.pricing_map, &v0)
    }

    // decompiled from Move bytecode v6
}

