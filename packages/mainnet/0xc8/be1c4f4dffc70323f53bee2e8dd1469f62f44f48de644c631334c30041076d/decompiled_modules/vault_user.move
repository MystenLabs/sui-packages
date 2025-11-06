module 0xc733a183de5d0d13ba242f4d9974421053c7ee547fed53b66669748bad09aa34::vault_user {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct VaultUserConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        access_cap: 0x1::option::Option<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>,
        operators: 0x2::table::Table<address, bool>,
        pausers: 0x2::table::Table<address, bool>,
        enable: bool,
    }

    struct Pause has copy, drop {
        dummy_field: bool,
    }

    struct Resume has copy, drop {
        dummy_field: bool,
    }

    struct PausePauser has copy, drop {
        address: address,
    }

    struct SetOperator has copy, drop {
        operator: address,
        allow: bool,
    }

    struct SetPauser has copy, drop {
        pauser: address,
        allow: bool,
    }

    entry fun add_access_cap(arg0: &AdminCap, arg1: &mut VaultUserConfig, arg2: 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap) {
        0x1::option::fill<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&mut arg1.access_cap, arg2);
    }

    public fun check_operator(arg0: &VaultUserConfig, arg1: address) : bool {
        if (!0x2::table::contains<address, bool>(&arg0.operators, arg1)) {
            return false
        };
        *0x2::table::borrow<address, bool>(&arg0.operators, arg1)
    }

    public fun check_pauser(arg0: &VaultUserConfig, arg1: address) : bool {
        if (!0x2::table::contains<address, bool>(&arg0.pausers, arg1)) {
            return false
        };
        *0x2::table::borrow<address, bool>(&arg0.pausers, arg1)
    }

    public fun deposit_vault_bluefin<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg5: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg6: &0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg8: 0x2::coin::Coin<T0>, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = 0x2::object::id<0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg7);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg9, arg10);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_v2<T0, T1>(arg1, arg2, arg8, 0x200e7a35a40dedada76d97b58409825943e54ecd5f445c0b5c7a98be75029888::vault_lens::calculate_liquidity_bluefin<T0, T1, T2, T3>(arg6, arg7, arg2, arg3, arg4, arg5, arg11), arg11, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg12);
    }

    public fun deposit_vault_cetus<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg5: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg6: &0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg8: 0x2::coin::Coin<T0>, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg7);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg9, arg10);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_v2<T0, T1>(arg1, arg2, arg8, 0x200e7a35a40dedada76d97b58409825943e54ecd5f445c0b5c7a98be75029888::vault_lens::calculate_liquidity_cetus<T0, T1, T2, T3>(arg6, arg7, arg2, arg3, arg4, arg5, arg11), arg11, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg12);
    }

    public fun deposit_vault_mmt<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg5: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg6: &0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg8: 0x2::coin::Coin<T0>, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = 0x2::object::id<0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg7);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg9, arg10);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_v2<T0, T1>(arg1, arg2, arg8, 0, arg11, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg12);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = VaultUserConfig{
            id         : 0x2::object::new(arg0),
            version    : 1,
            access_cap : 0x1::option::none<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(),
            operators  : 0x2::table::new<address, bool>(arg0),
            pausers    : 0x2::table::new<address, bool>(arg0),
            enable     : true,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<VaultUserConfig>(v1);
    }

    entry fun migrate(arg0: &AdminCap, arg1: &mut VaultUserConfig) {
        assert!(arg1.version < 1, 1);
        arg1.version = 1;
    }

    entry fun pause(arg0: &AdminCap, arg1: &mut VaultUserConfig) {
        assert!(arg1.version == 1, 2);
        assert!(arg1.enable, 4);
        arg1.enable = false;
        let v0 = Pause{dummy_field: false};
        0x2::event::emit<Pause>(v0);
    }

    entry fun pauser(arg0: &mut VaultUserConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(check_pauser(arg0, 0x2::tx_context::sender(arg1)), 3);
        assert!(arg0.enable, 4);
        arg0.enable = false;
        let v0 = PausePauser{address: 0x2::tx_context::sender(arg1)};
        0x2::event::emit<PausePauser>(v0);
    }

    public fun redeem<T0, T1, T2>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: address, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>, arg7: u64, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::redeem_v2<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg11);
    }

    public fun redeem_dual<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: address, arg4: vector<vector<0x1::ascii::String>>, arg5: vector<u64>, arg6: vector<vector<u64>>, arg7: vector<u64>, arg8: u64, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::redeem_dual_v2<T0, T1, T2, T3>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg12);
    }

    entry fun resume(arg0: &AdminCap, arg1: &mut VaultUserConfig) {
        assert!(arg1.version == 1, 2);
        assert!(!arg1.enable, 5);
        arg1.enable = true;
        let v0 = Resume{dummy_field: false};
        0x2::event::emit<Resume>(v0);
    }

    entry fun set_operator(arg0: &AdminCap, arg1: &mut VaultUserConfig, arg2: address, arg3: bool) {
        assert!(arg1.version == 1, 2);
        let v0 = false;
        if (0x2::table::contains<address, bool>(&arg1.operators, arg2)) {
            if (*0x2::table::borrow<address, bool>(&arg1.operators, arg2) != arg3) {
                *0x2::table::borrow_mut<address, bool>(&mut arg1.operators, arg2) = arg3;
                v0 = true;
            };
        } else {
            0x2::table::add<address, bool>(&mut arg1.operators, arg2, arg3);
            v0 = true;
        };
        if (v0) {
            let v1 = SetOperator{
                operator : arg2,
                allow    : arg3,
            };
            0x2::event::emit<SetOperator>(v1);
        };
    }

    entry fun set_pauser(arg0: &AdminCap, arg1: &mut VaultUserConfig, arg2: address, arg3: bool) {
        assert!(arg1.version == 1, 2);
        let v0 = false;
        if (0x2::table::contains<address, bool>(&arg1.pausers, arg2)) {
            if (*0x2::table::borrow<address, bool>(&arg1.pausers, arg2) != arg3) {
                *0x2::table::borrow_mut<address, bool>(&mut arg1.pausers, arg2) = arg3;
                v0 = true;
            };
        } else {
            0x2::table::add<address, bool>(&mut arg1.pausers, arg2, arg3);
            v0 = true;
        };
        if (v0) {
            let v1 = SetPauser{
                pauser : arg2,
                allow  : arg3,
            };
            0x2::event::emit<SetPauser>(v1);
        };
    }

    fun signature_message<T0, T1>(arg0: &VaultUserConfig, arg1: &0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg5: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x2::object::id<VaultUserConfig>(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig>(arg1);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg2);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        let v4 = 0x2::object::id<0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg4)) {
            let v6 = 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(0x1::vector::borrow<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg4, v5));
            0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v6));
            v5 = v5 + 1;
        };
        let v7 = 0;
        while (v7 < 0x1::vector::length<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>(arg5)) {
            let v8 = 0x2::object::id<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>(0x1::vector::borrow<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>(arg5, v7));
            0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v8));
            v7 = v7 + 1;
        };
        v0
    }

    public fun swap_coin_a_then_deposit_bluefin<T0, T1, T2>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg5: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg6: &0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg9: u128, arg10: 0x2::coin::Coin<T0>, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = 0x2::object::id<0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg7);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg8);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg9));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg11, arg12);
        let v4 = 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap);
        let v5 = 0x2::coin::value<T0>(&arg10);
        assert!(v5 > 0, 5);
        let (v6, v7) = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::bluefin_adapter::internal_swap<T0, T1>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>>(arg2), arg7, arg8, arg10, 0x2::coin::zero<T1>(arg14), v5, arg9, true, false, 0x2::tx_context::sender(arg14), arg13, arg14);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_v2<T1, T2>(arg1, arg2, v7, 0x200e7a35a40dedada76d97b58409825943e54ecd5f445c0b5c7a98be75029888::vault_lens::calculate_liquidity_bluefin<T1, T2, T0, T1>(arg6, arg8, arg2, arg3, arg4, arg5, arg13), arg13, v4, arg14);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T0>(v6, 0x2::tx_context::sender(arg14), arg14);
    }

    public fun swap_coin_a_then_deposit_cetus<T0, T1, T2>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg5: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg6: &0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg9: u128, arg10: 0x2::coin::Coin<T0>, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg7);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg8);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg9));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg11, arg12);
        let v4 = 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap);
        let v5 = 0x2::coin::value<T0>(&arg10);
        assert!(v5 > 0, 5);
        let (v6, v7) = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::cetus_adapter::internal_swap<T0, T1>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>>(arg2), arg7, arg8, arg10, 0x2::coin::zero<T1>(arg14), v5, arg9, true, false, 0x2::tx_context::sender(arg14), arg13, arg14);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_v2<T1, T2>(arg1, arg2, v7, 0x200e7a35a40dedada76d97b58409825943e54ecd5f445c0b5c7a98be75029888::vault_lens::calculate_liquidity_cetus<T1, T2, T0, T1>(arg6, arg8, arg2, arg3, arg4, arg5, arg13), arg13, v4, arg14);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T0>(v6, 0x2::tx_context::sender(arg14), arg14);
    }

    public fun swap_coin_a_then_deposit_mmt<T0, T1, T2>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg5: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg6: &0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg9: u128, arg10: 0x2::coin::Coin<T0>, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = 0x2::object::id<0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg7);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg8);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg9));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg11, arg12);
        let v4 = 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap);
        let v5 = 0x2::coin::value<T0>(&arg10);
        assert!(v5 > 0, 5);
        let (v6, v7) = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::mmt_adapter::internal_swap<T0, T1>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>>(arg2), arg8, arg7, arg10, 0x2::coin::zero<T1>(arg14), v5, arg9, true, false, 0x2::tx_context::sender(arg14), arg13, arg14);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_v2<T1, T2>(arg1, arg2, v7, 0x200e7a35a40dedada76d97b58409825943e54ecd5f445c0b5c7a98be75029888::vault_lens::calculate_liquidity_mmt<T1, T2, T0, T1>(arg6, arg8, arg2, arg3, arg4, arg5, arg13), arg13, v4, arg14);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T0>(v6, 0x2::tx_context::sender(arg14), arg14);
    }

    public fun swap_coin_b_then_deposit_bluefin<T0, T1, T2>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg5: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg6: &0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg9: u128, arg10: 0x2::coin::Coin<T0>, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = 0x2::object::id<0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg7);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(arg8);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg9));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg11, arg12);
        let v4 = 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap);
        let v5 = 0x2::coin::value<T0>(&arg10);
        assert!(v5 > 0, 5);
        let (v6, v7) = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::bluefin_adapter::internal_swap<T1, T0>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>>(arg2), arg7, arg8, 0x2::coin::zero<T1>(arg14), arg10, v5, arg9, false, false, 0x2::tx_context::sender(arg14), arg13, arg14);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_v2<T1, T2>(arg1, arg2, v6, 0x200e7a35a40dedada76d97b58409825943e54ecd5f445c0b5c7a98be75029888::vault_lens::calculate_liquidity_bluefin<T1, T2, T1, T0>(arg6, arg8, arg2, arg3, arg4, arg5, arg13), arg13, v4, arg14);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T0>(v7, 0x2::tx_context::sender(arg14), arg14);
    }

    public fun swap_coin_b_then_deposit_cetus<T0, T1, T2>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg5: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg6: &0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg9: u128, arg10: 0x2::coin::Coin<T0>, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg7);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg8);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg9));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg11, arg12);
        let v4 = 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap);
        let v5 = 0x2::coin::value<T0>(&arg10);
        assert!(v5 > 0, 5);
        let (v6, v7) = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::cetus_adapter::internal_swap<T1, T0>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>>(arg2), arg7, arg8, 0x2::coin::zero<T1>(arg14), arg10, v5, arg9, false, false, 0x2::tx_context::sender(arg14), arg13, arg14);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_v2<T1, T2>(arg1, arg2, v6, 0x200e7a35a40dedada76d97b58409825943e54ecd5f445c0b5c7a98be75029888::vault_lens::calculate_liquidity_cetus<T1, T2, T1, T0>(arg6, arg8, arg2, arg3, arg4, arg5, arg13), arg13, v4, arg14);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T0>(v7, 0x2::tx_context::sender(arg14), arg14);
    }

    public fun swap_coin_b_then_deposit_mmt<T0, T1, T2>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg5: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg6: &0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg9: u128, arg10: 0x2::coin::Coin<T0>, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = 0x2::object::id<0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg7);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>>(arg8);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg9));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg11, arg12);
        let v4 = 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap);
        let v5 = 0x2::coin::value<T0>(&arg10);
        assert!(v5 > 0, 5);
        let (v6, v7) = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::mmt_adapter::internal_swap<T1, T0>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>>(arg2), arg8, arg7, 0x2::coin::zero<T1>(arg14), arg10, v5, arg9, false, false, 0x2::tx_context::sender(arg14), arg13, arg14);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_v2<T1, T2>(arg1, arg2, v6, 0x200e7a35a40dedada76d97b58409825943e54ecd5f445c0b5c7a98be75029888::vault_lens::calculate_liquidity_mmt<T1, T2, T1, T0>(arg6, arg8, arg2, arg3, arg4, arg5, arg13), arg13, v4, arg14);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T0>(v7, 0x2::tx_context::sender(arg14), arg14);
    }

    public fun update_rate_bluefin<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg5: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg6: &0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        assert!(check_operator(arg0, 0x2::tx_context::sender(arg11)), 3);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = 0x2::object::id<0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg7);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg8, arg9);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::update_rate_v2<T0, T1>(arg1, arg2, 0x200e7a35a40dedada76d97b58409825943e54ecd5f445c0b5c7a98be75029888::vault_lens::calculate_liquidity_bluefin<T0, T1, T2, T3>(arg6, arg7, arg2, arg3, arg4, arg5, arg10), arg10, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg11);
    }

    public fun update_rate_cetus<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg5: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg6: &0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg7);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg8, arg9);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::update_rate_v2<T0, T1>(arg1, arg2, 0x200e7a35a40dedada76d97b58409825943e54ecd5f445c0b5c7a98be75029888::vault_lens::calculate_liquidity_cetus<T0, T1, T2, T3>(arg6, arg7, arg2, arg3, arg4, arg5, arg10), arg10, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg11);
    }

    public fun update_rate_mmt<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg5: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg6: &0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = 0x2::object::id<0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg7);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg8, arg9);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::update_rate_v2<T0, T1>(arg1, arg2, 0x200e7a35a40dedada76d97b58409825943e54ecd5f445c0b5c7a98be75029888::vault_lens::calculate_liquidity_mmt<T0, T1, T2, T3>(arg6, arg7, arg2, arg3, arg4, arg5, arg10), arg10, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg11);
    }

    public fun user_deposit_and_add_liquidity_bluefin<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg5: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg6: &mut 0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg9: u128, arg10: u32, arg11: u32, arg12: 0x2::coin::Coin<T2>, arg13: 0x2::coin::Coin<T3>, arg14: vector<vector<u8>>, arg15: vector<vector<u8>>, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = 0x2::object::id<0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg7);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg8);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg9));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u32>(&arg10));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u32>(&arg11));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg14, arg15);
        let (v4, v5, v6) = 0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_composer::user_deposit_and_add_liquidity_v2<T0, T1, T2, T3>(arg6, arg7, arg3, arg8, arg2, arg1, arg4, arg5, arg12, arg13, arg9, arg10, arg11, arg16, arg17);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_dual_token_v2<T0, T1>(arg1, arg2, v4, 0x200e7a35a40dedada76d97b58409825943e54ecd5f445c0b5c7a98be75029888::vault_lens::calculate_liquidity_bluefin<T0, T1, T2, T3>(arg6, arg8, arg2, arg3, arg4, arg5, arg16), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T3>()), v5, v6, arg16, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg17);
    }

    public fun user_deposit_and_add_liquidity_cetus<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg5: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg6: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg9: u128, arg10: u32, arg11: u32, arg12: 0x2::coin::Coin<T2>, arg13: 0x2::coin::Coin<T3>, arg14: vector<vector<u8>>, arg15: vector<vector<u8>>, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg7);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg8);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg9));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u32>(&arg10));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u32>(&arg11));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg14, arg15);
        let (v4, v5, v6) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_composer::user_deposit_and_add_liquidity_v2<T0, T1, T2, T3>(arg6, arg7, arg3, arg8, arg2, arg1, arg4, arg5, arg12, arg13, arg9, arg10, arg11, arg16, arg17);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_dual_token_v2<T0, T1>(arg1, arg2, v4, 0x200e7a35a40dedada76d97b58409825943e54ecd5f445c0b5c7a98be75029888::vault_lens::calculate_liquidity_cetus<T0, T1, T2, T3>(arg6, arg8, arg2, arg3, arg4, arg5, arg16), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T3>()), v5, v6, arg16, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg17);
    }

    public fun user_deposit_and_add_liquidity_mmt<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg5: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg6: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg9: u128, arg10: u32, arg11: u32, arg12: 0x2::coin::Coin<T2>, arg13: 0x2::coin::Coin<T3>, arg14: vector<vector<u8>>, arg15: vector<vector<u8>>, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = 0x2::object::id<0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg7);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg8);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg9));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u32>(&arg10));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u32>(&arg11));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg14, arg15);
        let (v4, v5, v6) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_composer::user_deposit_and_add_liquidity_v2<T0, T1, T2, T3>(arg6, arg7, arg3, arg8, arg2, arg1, arg4, arg5, arg12, arg13, arg9, arg10, arg11, arg16, arg17);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_dual_token_v2<T0, T1>(arg1, arg2, v4, 0x200e7a35a40dedada76d97b58409825943e54ecd5f445c0b5c7a98be75029888::vault_lens::calculate_liquidity_mmt<T0, T1, T2, T3>(arg6, arg8, arg2, arg3, arg4, arg5, arg16), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T3>()), v5, v6, arg16, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg17);
    }

    public fun user_deposit_then_add_liquidity_bluefin<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg5: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg6: &mut 0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg9: u128, arg10: 0x2::coin::Coin<T2>, arg11: 0x2::coin::Coin<T3>, arg12: vector<vector<u8>>, arg13: vector<vector<u8>>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = 0x2::object::id<0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg7);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg8);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg9));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg12, arg13);
        let (v4, v5, v6) = 0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_composer::user_deposit_then_add_liquidity_v2<T0, T1, T2, T3>(arg6, arg7, arg3, arg8, arg2, arg1, arg4, arg5, arg10, arg11, arg9, arg14, arg15);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_dual_token_v2<T0, T1>(arg1, arg2, v4, 0x200e7a35a40dedada76d97b58409825943e54ecd5f445c0b5c7a98be75029888::vault_lens::calculate_liquidity_bluefin<T0, T1, T2, T3>(arg6, arg8, arg2, arg3, arg4, arg5, arg14), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T3>()), v5, v6, arg14, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg15);
        abort 0
    }

    public fun user_deposit_then_add_liquidity_cetus<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg5: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg6: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg9: u128, arg10: 0x2::coin::Coin<T2>, arg11: 0x2::coin::Coin<T3>, arg12: vector<vector<u8>>, arg13: vector<vector<u8>>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg7);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg8);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg9));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg12, arg13);
        let (v4, v5, v6) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_composer::user_deposit_then_add_liquidity_v2<T0, T1, T2, T3>(arg6, arg7, arg3, arg8, arg2, arg1, arg4, arg5, arg10, arg11, arg9, arg14, arg15);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_dual_token_v2<T0, T1>(arg1, arg2, v4, 0x200e7a35a40dedada76d97b58409825943e54ecd5f445c0b5c7a98be75029888::vault_lens::calculate_liquidity_cetus<T0, T1, T2, T3>(arg6, arg8, arg2, arg3, arg4, arg5, arg14), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T3>()), v5, v6, arg14, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg15);
        abort 0
    }

    public fun user_deposit_then_add_liquidity_have_coin_a_in_vault_bluefin<T0, T1, T2>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg5: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg6: &mut 0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T2>, arg9: u128, arg10: 0x2::coin::Coin<T0>, arg11: 0x2::coin::Coin<T2>, arg12: vector<vector<u8>>, arg13: vector<vector<u8>>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        0x200e7a35a40dedada76d97b58409825943e54ecd5f445c0b5c7a98be75029888::vault_lens::calculate_liquidity_bluefin<T0, T1, T0, T2>(arg6, arg8, arg2, arg3, arg4, arg5, arg14);
        abort 0
    }

    public fun user_deposit_then_add_liquidity_have_coin_a_in_vault_cetus<T0, T1, T2>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg5: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg6: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg9: u128, arg10: 0x2::coin::Coin<T0>, arg11: 0x2::coin::Coin<T2>, arg12: vector<vector<u8>>, arg13: vector<vector<u8>>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        0x200e7a35a40dedada76d97b58409825943e54ecd5f445c0b5c7a98be75029888::vault_lens::calculate_liquidity_cetus<T0, T1, T0, T2>(arg6, arg8, arg2, arg3, arg4, arg5, arg14);
        abort 0
    }

    public fun user_deposit_then_add_liquidity_have_coin_a_in_vault_mmt<T0, T1, T2>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg5: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg6: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T2>, arg9: u128, arg10: 0x2::coin::Coin<T0>, arg11: 0x2::coin::Coin<T2>, arg12: vector<vector<u8>>, arg13: vector<vector<u8>>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        0x200e7a35a40dedada76d97b58409825943e54ecd5f445c0b5c7a98be75029888::vault_lens::calculate_liquidity_mmt<T0, T1, T0, T2>(arg6, arg8, arg2, arg3, arg4, arg5, arg14);
        abort 0
    }

    public fun user_deposit_then_add_liquidity_have_coin_b_in_vault_bluefin<T0, T1, T2>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg5: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg6: &mut 0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T0>, arg9: u128, arg10: 0x2::coin::Coin<T2>, arg11: 0x2::coin::Coin<T0>, arg12: vector<vector<u8>>, arg13: vector<vector<u8>>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        0x200e7a35a40dedada76d97b58409825943e54ecd5f445c0b5c7a98be75029888::vault_lens::calculate_liquidity_bluefin<T0, T1, T2, T0>(arg6, arg8, arg2, arg3, arg4, arg5, arg14);
        abort 0
    }

    public fun user_deposit_then_add_liquidity_have_coin_b_in_vault_cetus<T0, T1, T2>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg5: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg6: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg9: u128, arg10: 0x2::coin::Coin<T2>, arg11: 0x2::coin::Coin<T0>, arg12: vector<vector<u8>>, arg13: vector<vector<u8>>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        0x200e7a35a40dedada76d97b58409825943e54ecd5f445c0b5c7a98be75029888::vault_lens::calculate_liquidity_cetus<T0, T1, T2, T0>(arg6, arg8, arg2, arg3, arg4, arg5, arg14);
        abort 0
    }

    public fun user_deposit_then_add_liquidity_have_coin_b_in_vault_mmt<T0, T1, T2>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg5: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg6: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T0>, arg9: u128, arg10: 0x2::coin::Coin<T2>, arg11: 0x2::coin::Coin<T0>, arg12: vector<vector<u8>>, arg13: vector<vector<u8>>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        0x200e7a35a40dedada76d97b58409825943e54ecd5f445c0b5c7a98be75029888::vault_lens::calculate_liquidity_mmt<T0, T1, T2, T0>(arg6, arg8, arg2, arg3, arg4, arg5, arg14);
        abort 0
    }

    public fun user_deposit_then_add_liquidity_mmt<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg5: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg6: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg9: u128, arg10: 0x2::coin::Coin<T2>, arg11: 0x2::coin::Coin<T3>, arg12: vector<vector<u8>>, arg13: vector<vector<u8>>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = 0x2::object::id<0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg7);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg8);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg9));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg12, arg13);
        let (v4, v5, v6) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_composer::user_deposit_then_add_liquidity_v2<T0, T1, T2, T3>(arg6, arg7, arg3, arg8, arg2, arg1, arg4, arg5, arg10, arg11, arg9, arg14, arg15);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_dual_token_v2<T0, T1>(arg1, arg2, v4, 0x200e7a35a40dedada76d97b58409825943e54ecd5f445c0b5c7a98be75029888::vault_lens::calculate_liquidity_mmt<T0, T1, T2, T3>(arg6, arg8, arg2, arg3, arg4, arg5, arg14), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T3>()), v5, v6, arg14, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg15);
        abort 0
    }

    public fun withdraw_dual_vault_bluefin<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg5: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg6: &0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg8: 0x2::coin::Coin<T1>, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = 0x2::object::id<0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg7);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg9, arg10);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::withdraw_dual_v2<T0, T1, T2, T3>(arg1, arg2, arg3, arg8, 0x200e7a35a40dedada76d97b58409825943e54ecd5f445c0b5c7a98be75029888::vault_lens::calculate_liquidity_bluefin<T0, T1, T2, T3>(arg6, arg7, arg2, arg3, arg4, arg5, arg11), arg4, arg5, arg11, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg12);
    }

    public fun withdraw_dual_vault_cetus<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg5: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg6: &0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg8: 0x2::coin::Coin<T1>, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg7);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg9, arg10);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::withdraw_dual_v2<T0, T1, T2, T3>(arg1, arg2, arg3, arg8, 0x200e7a35a40dedada76d97b58409825943e54ecd5f445c0b5c7a98be75029888::vault_lens::calculate_liquidity_cetus<T0, T1, T2, T3>(arg6, arg7, arg2, arg3, arg4, arg5, arg11), arg4, arg5, arg11, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg12);
    }

    public fun withdraw_dual_vault_mmt<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg5: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg6: &0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg8: 0x2::coin::Coin<T1>, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = 0x2::object::id<0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg7);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg9, arg10);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::withdraw_dual_v2<T0, T1, T2, T3>(arg1, arg2, arg3, arg8, 0x200e7a35a40dedada76d97b58409825943e54ecd5f445c0b5c7a98be75029888::vault_lens::calculate_liquidity_mmt<T0, T1, T2, T3>(arg6, arg7, arg2, arg3, arg4, arg5, arg11), arg4, arg5, arg11, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg12);
    }

    public fun withdraw_vault_bluefin<T0, T1, T2, T3, T4>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg5: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg6: &0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig, arg7: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg8: 0x2::coin::Coin<T1>, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = 0x2::object::id<0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg7);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg9, arg10);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::withdraw_v2<T0, T1, T4>(arg1, arg2, arg3, arg8, 0x200e7a35a40dedada76d97b58409825943e54ecd5f445c0b5c7a98be75029888::vault_lens::calculate_liquidity_bluefin<T0, T1, T2, T3>(arg6, arg7, arg2, arg3, arg4, arg5, arg11), arg4, arg5, arg11, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg12);
    }

    public fun withdraw_vault_cetus<T0, T1, T2, T3, T4>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg5: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg6: &0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg8: 0x2::coin::Coin<T1>, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg7);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg9, arg10);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::withdraw_v2<T0, T1, T4>(arg1, arg2, arg3, arg8, 0x200e7a35a40dedada76d97b58409825943e54ecd5f445c0b5c7a98be75029888::vault_lens::calculate_liquidity_cetus<T0, T1, T2, T3>(arg6, arg7, arg2, arg3, arg4, arg5, arg11), arg4, arg5, arg11, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg12);
    }

    public fun withdraw_vault_mmt<T0, T1, T2, T3, T4>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg5: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg6: &0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg8: 0x2::coin::Coin<T1>, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = 0x2::object::id<0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg7);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg9, arg10);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::withdraw_v2<T0, T1, T4>(arg1, arg2, arg3, arg8, 0x200e7a35a40dedada76d97b58409825943e54ecd5f445c0b5c7a98be75029888::vault_lens::calculate_liquidity_mmt<T0, T1, T2, T3>(arg6, arg7, arg2, arg3, arg4, arg5, arg11), arg4, arg5, arg11, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg12);
    }

    // decompiled from Move bytecode v6
}

