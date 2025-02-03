module 0x75908ec2bcdfe076f8c2c94e42af470b94b165b33c1c1d53046c29130028d483::transfer_allowlist {
    struct AllowlistRule has drop {
        dummy_field: bool,
    }

    public fun confirm_transfer<T0>(arg0: &0x9346bb5562cd221640e4ad431797149c7cab60bb5b90f8bf19e7079c51cc557b::allowlist::Allowlist, arg1: &mut 0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::transfer_request::TransferRequest<T0>) {
        0x9346bb5562cd221640e4ad431797149c7cab60bb5b90f8bf19e7079c51cc557b::allowlist::assert_transferable(arg0, 0x1::type_name::get<T0>(), 0xedd5a716fc7a7cdd829af4e0af9151705831453a031fe83d83e52cbe0b3dbe8b::ob_kiosk::get_transfer_request_auth<T0>(arg1));
        let v0 = AllowlistRule{dummy_field: false};
        0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::transfer_request::add_receipt<T0, AllowlistRule>(arg1, v0);
    }

    public fun confirm_transfer_<T0, T1>(arg0: &0x9346bb5562cd221640e4ad431797149c7cab60bb5b90f8bf19e7079c51cc557b::allowlist::Allowlist, arg1: &mut 0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::RequestBody<0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::WithNft<T0, T1>>) {
        0x9346bb5562cd221640e4ad431797149c7cab60bb5b90f8bf19e7079c51cc557b::allowlist::assert_transferable(arg0, 0x1::type_name::get<T0>(), 0xedd5a716fc7a7cdd829af4e0af9151705831453a031fe83d83e52cbe0b3dbe8b::ob_kiosk::get_transfer_request_auth_<T0, T1>(arg1));
        let v0 = AllowlistRule{dummy_field: false};
        0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::add_receipt<0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::WithNft<T0, T1>, AllowlistRule>(arg1, &v0);
    }

    public fun drop<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::transfer_request::remove_originbyte_rule<T0, AllowlistRule, bool>(arg0, arg1);
    }

    public fun drop_<T0, T1>(arg0: &mut 0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::Policy<0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::WithNft<T0, T1>>, arg1: &0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::PolicyCap) {
        0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::drop_rule_no_state<0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::WithNft<T0, T1>, AllowlistRule>(arg0, arg1);
    }

    public fun enforce<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        let v0 = AllowlistRule{dummy_field: false};
        0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::transfer_request::add_originbyte_rule<T0, AllowlistRule, bool>(v0, arg0, arg1, false);
    }

    public fun enforce_<T0, T1>(arg0: &mut 0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::Policy<0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::WithNft<T0, T1>>, arg1: &0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::PolicyCap) {
        0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::enforce_rule_no_state<0x2587163aa906f7d4235f675ae6266cf49d6e43f4b66a106a39ba2cf9c178ddb2::request::WithNft<T0, T1>, AllowlistRule>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

