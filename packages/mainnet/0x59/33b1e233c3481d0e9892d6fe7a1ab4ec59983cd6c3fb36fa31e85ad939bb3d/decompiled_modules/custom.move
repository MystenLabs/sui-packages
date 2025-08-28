module 0x5933b1e233c3481d0e9892d6fe7a1ab4ec59983cd6c3fb36fa31e85ad939bb3d::custom {
    struct CustomProviderRegistry has store, key {
        id: 0x2::object::UID,
        providers: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
    }

    struct CustomProvider has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        signer: address,
        owner: address,
    }

    struct UpdateSignerCap has store, key {
        id: 0x2::object::UID,
        provider: 0x2::object::ID,
    }

    struct CreateCustomProviderEvent has copy, drop, store {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        signer: address,
        owner: address,
    }

    struct UpdateSignerEvent has copy, drop, store {
        id: 0x2::object::ID,
        new_signer: address,
        old_signer: address,
    }

    public fun create_custom_provider(arg0: &mut CustomProviderRegistry, arg1: address, arg2: &mut 0x5933b1e233c3481d0e9892d6fe7a1ab4ec59983cd6c3fb36fa31e85ad939bb3d::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) : UpdateSignerCap {
        0x5933b1e233c3481d0e9892d6fe7a1ab4ec59983cd6c3fb36fa31e85ad939bb3d::versioned::check_version(arg2);
        let v0 = 0x2::address::to_string(0x2::tx_context::fresh_object_address(arg3));
        let v1 = CustomProvider{
            id     : 0x2::object::new(arg3),
            name   : v0,
            signer : arg1,
            owner  : 0x2::tx_context::sender(arg3),
        };
        let v2 = 0x2::object::id<CustomProvider>(&v1);
        assert!(0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.providers, v0), 13906834470696386565);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.providers, v0, v2);
        let v3 = CreateCustomProviderEvent{
            id     : v2,
            name   : v0,
            signer : arg1,
            owner  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<CreateCustomProviderEvent>(v3);
        0x2::transfer::public_share_object<CustomProvider>(v1);
        UpdateSignerCap{
            id       : 0x2::object::new(arg3),
            provider : v2,
        }
    }

    public fun create_custom_provider_with_name(arg0: &mut CustomProviderRegistry, arg1: 0x1::string::String, arg2: address, arg3: &0x5933b1e233c3481d0e9892d6fe7a1ab4ec59983cd6c3fb36fa31e85ad939bb3d::admin_cap::AdminCap, arg4: &mut 0x5933b1e233c3481d0e9892d6fe7a1ab4ec59983cd6c3fb36fa31e85ad939bb3d::versioned::Versioned, arg5: &mut 0x2::tx_context::TxContext) : UpdateSignerCap {
        0x5933b1e233c3481d0e9892d6fe7a1ab4ec59983cd6c3fb36fa31e85ad939bb3d::versioned::check_version(arg4);
        let v0 = CustomProvider{
            id     : 0x2::object::new(arg5),
            name   : arg1,
            signer : arg2,
            owner  : 0x2::tx_context::sender(arg5),
        };
        let v1 = 0x2::object::id<CustomProvider>(&v0);
        assert!(0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.providers, arg1), 13906834608135340037);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.providers, arg1, v1);
        let v2 = CreateCustomProviderEvent{
            id     : v1,
            name   : arg1,
            signer : arg2,
            owner  : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<CreateCustomProviderEvent>(v2);
        0x2::transfer::public_share_object<CustomProvider>(v0);
        UpdateSignerCap{
            id       : 0x2::object::new(arg5),
            provider : v1,
        }
    }

    public fun new_trust_quote<T0, T1>(arg0: &CustomProvider, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: &mut 0x5933b1e233c3481d0e9892d6fe7a1ab4ec59983cd6c3fb36fa31e85ad939bb3d::versioned::Versioned) : 0x5933b1e233c3481d0e9892d6fe7a1ab4ec59983cd6c3fb36fa31e85ad939bb3d::trust_quote::TrustQuote<T0, T1> {
        0x5933b1e233c3481d0e9892d6fe7a1ab4ec59983cd6c3fb36fa31e85ad939bb3d::versioned::check_version(arg6);
        let v0 = 0x1::string::into_bytes(arg1);
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg4));
        let (v1, v2) = 0x5933b1e233c3481d0e9892d6fe7a1ab4ec59983cd6c3fb36fa31e85ad939bb3d::utils::verify_internal(v0, &arg5);
        assert!(v1, 13906834852948213761);
        assert!(arg0.signer == v2, 13906834857243312131);
        0x5933b1e233c3481d0e9892d6fe7a1ab4ec59983cd6c3fb36fa31e85ad939bb3d::trust_quote::new_trust_quote<T0, T1>(arg2, arg3, 0x2::address::to_string(v2), arg4)
    }

    public fun update_signer(arg0: &mut CustomProvider, arg1: &UpdateSignerCap, arg2: address, arg3: &mut 0x5933b1e233c3481d0e9892d6fe7a1ab4ec59983cd6c3fb36fa31e85ad939bb3d::versioned::Versioned) {
        0x5933b1e233c3481d0e9892d6fe7a1ab4ec59983cd6c3fb36fa31e85ad939bb3d::versioned::check_version(arg3);
        assert!(arg1.provider == 0x2::object::id<CustomProvider>(arg0), 13906834706919718919);
        arg0.signer = arg2;
        let v0 = UpdateSignerEvent{
            id         : 0x2::object::id<CustomProvider>(arg0),
            new_signer : arg2,
            old_signer : arg0.signer,
        };
        0x2::event::emit<UpdateSignerEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

