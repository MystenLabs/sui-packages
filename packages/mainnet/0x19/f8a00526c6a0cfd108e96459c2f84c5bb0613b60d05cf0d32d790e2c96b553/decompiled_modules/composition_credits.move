module 0x19f8a00526c6a0cfd108e96459c2f84c5bb0613b60d05cf0d32d790e2c96b553::composition_credits {
    struct ExtensionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CompositionCredits has store {
        credits: 0x2::vec_map::VecMap<0x2::object::ID, 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x19f8a00526c6a0cfd108e96459c2f84c5bb0613b60d05cf0d32d790e2c96b553::composition_party_role::CompositionPartyRole>>,
    }

    struct CompositionCreditAddedEvent<phantom T0> has copy, drop {
        composition_id: address,
        composition_admin_cap_id: address,
        party_id: address,
        role_kinds: vector<u8>,
        credit_count_before: u64,
        credit_count_after: u64,
        credit_index: u64,
        credits_record_existed_before: bool,
        credits_record_exists_after: bool,
    }

    struct CompositionCreditRemovedEvent<phantom T0> has copy, drop {
        composition_id: address,
        composition_admin_cap_id: address,
        party_id: address,
        role_kinds: vector<u8>,
        credit_count_before: u64,
        credit_count_after: u64,
        credit_index: u64,
        credits_record_existed_before: bool,
        credits_record_exists_after: bool,
    }

    fun borrow(arg0: &0x2::object::UID) : &CompositionCredits {
        let v0 = ExtensionKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ExtensionKey>(arg0, v0), 50);
        let v1 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::borrow<ExtensionKey, CompositionCredits>(arg0, v1)
    }

    fun borrow_mut(arg0: &mut 0x2::object::UID) : &mut CompositionCredits {
        let v0 = ExtensionKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ExtensionKey>(arg0, v0), 50);
        let v1 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<ExtensionKey, CompositionCredits>(arg0, v1)
    }

    public fun add_credit<T0>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T0>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T0>, arg2: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party, arg3: 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x19f8a00526c6a0cfd108e96459c2f84c5bb0613b60d05cf0d32d790e2c96b553::composition_party_role::CompositionPartyRole>) {
        assert!(0x1::vector::length<0x19f8a00526c6a0cfd108e96459c2f84c5bb0613b60d05cf0d32d790e2c96b553::composition_party_role::CompositionPartyRole>(0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::roles<0x19f8a00526c6a0cfd108e96459c2f84c5bb0613b60d05cf0d32d790e2c96b553::composition_party_role::CompositionPartyRole>(&arg3)) <= 5, 30);
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T0>>(arg0);
        let v1 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T0>>(arg1);
        let v2 = 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party>(arg2);
        let v3 = 0x2::object::id<0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party>(arg2);
        let v4 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::uid_mut<T0>(arg0, arg1);
        let v5 = ExtensionKey{dummy_field: false};
        let v6 = 0x2::dynamic_field::exists<ExtensionKey>(v4, v5);
        let v7 = borrow_mut_or_init(v4);
        let v8 = 0x2::vec_map::length<0x2::object::ID, 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x19f8a00526c6a0cfd108e96459c2f84c5bb0613b60d05cf0d32d790e2c96b553::composition_party_role::CompositionPartyRole>>(&v7.credits);
        assert!(v8 < 50, 32);
        assert!(!0x2::vec_map::contains<0x2::object::ID, 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x19f8a00526c6a0cfd108e96459c2f84c5bb0613b60d05cf0d32d790e2c96b553::composition_party_role::CompositionPartyRole>>(&v7.credits, &v3), 40);
        0x2::vec_map::insert<0x2::object::ID, 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x19f8a00526c6a0cfd108e96459c2f84c5bb0613b60d05cf0d32d790e2c96b553::composition_party_role::CompositionPartyRole>>(&mut v7.credits, v3, arg3);
        let v9 = ExtensionKey{dummy_field: false};
        let v10 = CompositionCreditAddedEvent<T0>{
            composition_id                : 0x2::object::id_to_address(&v0),
            composition_admin_cap_id      : 0x2::object::id_to_address(&v1),
            party_id                      : 0x2::object::id_to_address(&v2),
            role_kinds                    : encode_credit(&arg3),
            credit_count_before           : v8,
            credit_count_after            : 0x2::vec_map::length<0x2::object::ID, 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x19f8a00526c6a0cfd108e96459c2f84c5bb0613b60d05cf0d32d790e2c96b553::composition_party_role::CompositionPartyRole>>(&v7.credits),
            credit_index                  : v8,
            credits_record_existed_before : v6,
            credits_record_exists_after   : 0x2::dynamic_field::exists<ExtensionKey>(v4, v9),
        };
        0x2::event::emit<CompositionCreditAddedEvent<T0>>(v10);
    }

    fun borrow_mut_or_init(arg0: &mut 0x2::object::UID) : &mut CompositionCredits {
        let v0 = ExtensionKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<ExtensionKey>(arg0, v0)) {
            let v1 = ExtensionKey{dummy_field: false};
            let v2 = CompositionCredits{credits: 0x2::vec_map::empty<0x2::object::ID, 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x19f8a00526c6a0cfd108e96459c2f84c5bb0613b60d05cf0d32d790e2c96b553::composition_party_role::CompositionPartyRole>>()};
            0x2::dynamic_field::add<ExtensionKey, CompositionCredits>(arg0, v1, v2);
        };
        let v3 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<ExtensionKey, CompositionCredits>(arg0, v3)
    }

    public fun credits<T0>(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T0>) : &0x2::vec_map::VecMap<0x2::object::ID, 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x19f8a00526c6a0cfd108e96459c2f84c5bb0613b60d05cf0d32d790e2c96b553::composition_party_role::CompositionPartyRole>> {
        &borrow(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::uid<T0>(arg0)).credits
    }

    fun encode_credit(arg0: &0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x19f8a00526c6a0cfd108e96459c2f84c5bb0613b60d05cf0d32d790e2c96b553::composition_party_role::CompositionPartyRole>) : vector<u8> {
        let v0 = b"";
        let v1 = 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::roles<0x19f8a00526c6a0cfd108e96459c2f84c5bb0613b60d05cf0d32d790e2c96b553::composition_party_role::CompositionPartyRole>(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x19f8a00526c6a0cfd108e96459c2f84c5bb0613b60d05cf0d32d790e2c96b553::composition_party_role::CompositionPartyRole>(v1)) {
            let (v3, _) = 0x19f8a00526c6a0cfd108e96459c2f84c5bb0613b60d05cf0d32d790e2c96b553::composition_party_role::event_encoding(0x1::vector::borrow<0x19f8a00526c6a0cfd108e96459c2f84c5bb0613b60d05cf0d32d790e2c96b553::composition_party_role::CompositionPartyRole>(v1, v2));
            0x1::vector::push_back<u8>(&mut v0, v3);
            v2 = v2 + 1;
        };
        v0
    }

    public fun has_credits<T0>(arg0: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T0>) : bool {
        let v0 = ExtensionKey{dummy_field: false};
        0x2::dynamic_field::exists<ExtensionKey>(0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::uid<T0>(arg0), v0)
    }

    public fun remove_credit<T0>(arg0: &mut 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T0>, arg1: &0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T0>, arg2: 0x2::object::ID) {
        let v0 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::Composition<T0>>(arg0);
        let v1 = 0x2::object::id<0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::CompositionAdminCap<T0>>(arg1);
        let v2 = 0x4c5c399d34fc60c34acd5008db032c213c04f76b9c07444e52b1133d5d006728::composition::uid_mut<T0>(arg0, arg1);
        let v3 = borrow_mut(v2);
        assert!(0x2::vec_map::contains<0x2::object::ID, 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x19f8a00526c6a0cfd108e96459c2f84c5bb0613b60d05cf0d32d790e2c96b553::composition_party_role::CompositionPartyRole>>(&v3.credits, &arg2), 52);
        let (_, v5) = 0x2::vec_map::remove<0x2::object::ID, 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x19f8a00526c6a0cfd108e96459c2f84c5bb0613b60d05cf0d32d790e2c96b553::composition_party_role::CompositionPartyRole>>(&mut v3.credits, &arg2);
        let v6 = v5;
        let v7 = ExtensionKey{dummy_field: false};
        let v8 = CompositionCreditRemovedEvent<T0>{
            composition_id                : 0x2::object::id_to_address(&v0),
            composition_admin_cap_id      : 0x2::object::id_to_address(&v1),
            party_id                      : 0x2::object::id_to_address(&arg2),
            role_kinds                    : encode_credit(&v6),
            credit_count_before           : 0x2::vec_map::length<0x2::object::ID, 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x19f8a00526c6a0cfd108e96459c2f84c5bb0613b60d05cf0d32d790e2c96b553::composition_party_role::CompositionPartyRole>>(&v3.credits),
            credit_count_after            : 0x2::vec_map::length<0x2::object::ID, 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x19f8a00526c6a0cfd108e96459c2f84c5bb0613b60d05cf0d32d790e2c96b553::composition_party_role::CompositionPartyRole>>(&v3.credits),
            credit_index                  : 0x2::vec_map::get_idx<0x2::object::ID, 0x63f2fb16fffa0f09ce7525ccd4d1331710b82aae194338ff49fd15f389016ebf::credit::Credit<0x19f8a00526c6a0cfd108e96459c2f84c5bb0613b60d05cf0d32d790e2c96b553::composition_party_role::CompositionPartyRole>>(&v3.credits, &arg2),
            credits_record_existed_before : true,
            credits_record_exists_after   : 0x2::dynamic_field::exists<ExtensionKey>(v2, v7),
        };
        0x2::event::emit<CompositionCreditRemovedEvent<T0>>(v8);
    }

    // decompiled from Move bytecode v7
}

