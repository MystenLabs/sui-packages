module 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::validator {
    struct ValidatorRegistered has copy, drop {
        validator: address,
    }

    struct ValidatorUpdated has copy, drop {
        validator: address,
    }

    struct ValidatorResigned has copy, drop {
        validator: address,
    }

    struct ValidatorResignationWithdrawn has copy, drop {
        validator: address,
    }

    struct ValidatorDeregistered has copy, drop {
        validator: address,
    }

    entry fun remove_inactive_member(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: &0x3::sui_system::SuiSystemState, arg2: address) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        let v0 = 0x3::sui_system::active_validator_addresses_ref(arg1);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::remove_inactive_member(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set_mut(arg0), arg2, 0x1::vector::contains<address>(&v0, &arg2));
        let v1 = ValidatorDeregistered{validator: arg2};
        0x2::event::emit<ValidatorDeregistered>(v1);
    }

    entry fun register(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: &0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::new_member(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set_mut(arg0), arg1, arg2);
        let v0 = ValidatorRegistered{validator: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<ValidatorRegistered>(v0);
    }

    entry fun resign(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::request_resignation(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set_mut(arg0), arg1, arg2);
        let v0 = ValidatorResigned{validator: arg1};
        0x2::event::emit<ValidatorResigned>(v0);
    }

    entry fun update_endpoint_url(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: address, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::set_endpoint_url(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set_mut(arg0), arg1, arg2, arg3);
        let v0 = ValidatorUpdated{validator: arg1};
        0x2::event::emit<ValidatorUpdated>(v0);
    }

    entry fun update_next_epoch_encryption_public_key(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: address, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::set_next_epoch_encryption_public_key(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set_mut(arg0), arg1, arg2, arg3);
        let v0 = ValidatorUpdated{validator: arg1};
        0x2::event::emit<ValidatorUpdated>(v0);
    }

    entry fun update_next_epoch_public_key(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::set_next_epoch_public_key(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set_mut(arg0), 0x2::object::uid_to_address(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::id(arg0)), arg1, arg2, arg3, arg4);
        let v0 = ValidatorUpdated{validator: arg1};
        0x2::event::emit<ValidatorUpdated>(v0);
    }

    entry fun update_operator_address(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::set_operator_address(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set_mut(arg0), arg1, arg2, arg3);
        let v0 = ValidatorUpdated{validator: arg1};
        0x2::event::emit<ValidatorUpdated>(v0);
    }

    entry fun update_tls_public_key(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::set_tls_public_key(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set_mut(arg0), 0x2::object::uid_to_address(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::id(arg0)), arg1, arg2, arg3, arg4);
        let v0 = ValidatorUpdated{validator: arg1};
        0x2::event::emit<ValidatorUpdated>(v0);
    }

    entry fun withdraw_resignation(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::clear_resignation(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set_mut(arg0), arg1, arg2);
        let v0 = ValidatorResignationWithdrawn{validator: arg1};
        0x2::event::emit<ValidatorResignationWithdrawn>(v0);
    }

    // decompiled from Move bytecode v7
}

