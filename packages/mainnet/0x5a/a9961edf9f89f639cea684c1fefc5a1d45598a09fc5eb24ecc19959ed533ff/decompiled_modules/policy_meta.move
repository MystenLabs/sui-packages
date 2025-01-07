module 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy_meta {
    struct ListRecommendedPoliciesWitness has drop {
        dummy_field: bool,
    }

    struct AddRecommendedPolicyWitness has drop {
        dummy_field: bool,
    }

    public fun add_recommended_policy<T0>(arg0: &mut 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::Dao, arg1: &0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::Launchpad, arg2: &mut 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::ProposalAccepted<AddRecommendedPolicyWitness>) {
        let v0 = AddRecommendedPolicyWitness{dummy_field: false};
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::auth_add_policy<AddRecommendedPolicyWitness, T0>(arg0, arg2, &v0, 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::get_recommended_policy_conf(arg1, 0x1::type_name::get<T0>()));
        let v1 = AddRecommendedPolicyWitness{dummy_field: false};
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::stamp<AddRecommendedPolicyWitness>(arg2, &v1);
    }

    public fun add_recommended_policy_description() : 0x1::string::String {
        0x1::string::utf8(b"TODO")
    }

    public entry fun add_recommended_policy_entry<T0>(arg0: &mut 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::Dao, arg1: &0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::admin::AdminCap, arg2: &0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::Launchpad, arg3: &0x2::clock::Clock) {
        let v0 = 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::begin_proposal_execution<AddRecommendedPolicyWitness>(arg0, arg1);
        let v1 = &mut v0;
        add_recommended_policy<T0>(arg0, arg2, v1);
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::proposal_was_executed<AddRecommendedPolicyWitness>(arg0, v0, arg3);
    }

    public fun list_recommended_policies(arg0: &mut 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::Dao, arg1: &0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::Launchpad, arg2: &mut 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::ProposalAccepted<ListRecommendedPoliciesWitness>) {
        let v0 = 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::get_list_of_recommended_policies(arg1);
        let v1 = 0x1::string::utf8(b"Recommended policies: ");
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(v0, v2);
            let v4 = 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::get_recommended_policy_conf(arg1, v3);
            0x1::string::append_utf8(&mut v1, x"0a2d20");
            0x1::string::append_utf8(&mut v1, 0x1::ascii::into_bytes(0x1::type_name::into_string(v3)));
            0x1::string::append_utf8(&mut v1, b": ");
            0x1::string::append(&mut v1, 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy::conf_to_string(&v4));
            0x1::string::append_utf8(&mut v1, x"0a");
            v2 = v2 + 1;
        };
        let v5 = ListRecommendedPoliciesWitness{dummy_field: false};
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::auth_log<ListRecommendedPoliciesWitness>(arg0, arg2, &v5, v1);
        let v6 = ListRecommendedPoliciesWitness{dummy_field: false};
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::stamp<ListRecommendedPoliciesWitness>(arg2, &v6);
    }

    public fun list_recommended_policies_description() : 0x1::string::String {
        0x1::string::utf8(b"TODO")
    }

    public entry fun list_recommended_policies_entry(arg0: &mut 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::Dao, arg1: &0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::admin::AdminCap, arg2: &0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::launchpad::Launchpad, arg3: &0x2::clock::Clock) {
        let v0 = 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::begin_proposal_execution<ListRecommendedPoliciesWitness>(arg0, arg1);
        let v1 = &mut v0;
        list_recommended_policies(arg0, arg2, v1);
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::proposal_was_executed<ListRecommendedPoliciesWitness>(arg0, v0, arg3);
    }

    // decompiled from Move bytecode v6
}

