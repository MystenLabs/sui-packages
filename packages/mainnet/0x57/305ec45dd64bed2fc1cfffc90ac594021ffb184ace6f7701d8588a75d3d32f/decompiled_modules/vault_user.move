module 0x57305ec45dd64bed2fc1cfffc90ac594021ffb184ace6f7701d8588a75d3d32f::vault_user {
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

    struct SecurePriceReceipt<phantom T0, phantom T1> {
        vault_id: 0x2::object::ID,
        pyth_tokens: vector<0x1::ascii::String>,
        pyth_token_decimals: vector<u64>,
        pyth_prices: vector<u64>,
        nodo_tokens: vector<0x1::ascii::String>,
        nodo_token_decimals: vector<u64>,
        nodo_prices: vector<u64>,
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

    struct SecurePriceInitiated has copy, drop {
        vault_id: 0x2::object::ID,
        pyth_tokens: vector<0x1::ascii::String>,
        pyth_token_decimals: vector<u64>,
        pyth_prices: vector<u64>,
        nodo_tokens: vector<0x1::ascii::String>,
        nodo_token_decimals: vector<u64>,
        nodo_prices: vector<u64>,
        timestamp: u64,
    }

    struct SecurePriceUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        pyth_tokens: vector<0x1::ascii::String>,
        pyth_token_decimals: vector<u64>,
        pyth_prices: vector<u64>,
        nodo_tokens: vector<0x1::ascii::String>,
        nodo_token_decimals: vector<u64>,
        nodo_prices: vector<u64>,
        timestamp: u64,
    }

    struct SecurePriceCompleted has copy, drop {
        vault_id: 0x2::object::ID,
        oracles: vector<u8>,
        tokens: vector<0x1::ascii::String>,
        decimals: vector<u64>,
        prices: vector<u64>,
        timestamp: u64,
    }

    entry fun add_access_cap(arg0: &AdminCap, arg1: &mut VaultUserConfig, arg2: 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap) {
        0x1::option::fill<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&mut arg1.access_cap, arg2);
    }

    public fun build_nodo_secure_price_receipt<T0, T1, T2>(arg0: &VaultUserConfig, arg1: &0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo, arg5: u64, arg6: vector<vector<u8>>, arg7: vector<vector<u8>>, arg8: SecurePriceReceipt<T0, T1>, arg9: &0x2::clock::Clock) : SecurePriceReceipt<T0, T1> {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = 0x2::clock::timestamp_ms(arg9);
        assert!(arg5 <= v0, 9);
        assert!(v0 - arg5 <= 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_max_staleness(arg3), 10);
        verify_signature_price<T0, T1, T2>(arg0, arg1, arg2, arg3, 0x2::object::id_bytes<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>(arg4), arg5, arg6, arg7);
        let (v1, v2, v3, v4, v5, v6) = validate_updated_receipt<T0, T1, T2>(arg2, arg8, 1);
        let v7 = v4;
        let v8 = v5;
        let v9 = v6;
        let v10 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>());
        0x1::vector::push_back<0x1::ascii::String>(&mut v7, v10);
        let (_, v12, v13, v14) = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::get_nodo_price(arg3, arg4, arg9);
        assert!(v12 == v10, 11);
        0x1::vector::push_back<u64>(&mut v8, v13);
        0x1::vector::push_back<u64>(&mut v9, v14);
        let v15 = SecurePriceReceipt<T0, T1>{
            vault_id            : 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg2),
            pyth_tokens         : v1,
            pyth_token_decimals : v2,
            pyth_prices         : v3,
            nodo_tokens         : v7,
            nodo_token_decimals : v8,
            nodo_prices         : v9,
        };
        let v16 = SecurePriceUpdated{
            vault_id            : 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg2),
            pyth_tokens         : v1,
            pyth_token_decimals : v2,
            pyth_prices         : v3,
            nodo_tokens         : v7,
            nodo_token_decimals : v8,
            nodo_prices         : v9,
            timestamp           : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<SecurePriceUpdated>(v16);
        v15
    }

    public fun build_pyth_secure_price_receipt<T0, T1, T2>(arg0: &VaultUserConfig, arg1: &0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: u64, arg6: vector<vector<u8>>, arg7: vector<vector<u8>>, arg8: SecurePriceReceipt<T0, T1>, arg9: &0x2::clock::Clock) : SecurePriceReceipt<T0, T1> {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = 0x2::clock::timestamp_ms(arg9);
        assert!(arg5 <= v0, 9);
        assert!(v0 - arg5 <= 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_max_staleness(arg3), 10);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg4);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v1);
        verify_signature_price<T0, T1, T2>(arg0, arg1, arg2, arg3, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2), arg5, arg6, arg7);
        let (v3, v4, v5, v6, v7, v8) = validate_updated_receipt<T0, T1, T2>(arg2, arg8, 0);
        let v9 = v3;
        let v10 = v4;
        let v11 = v5;
        let v12 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>());
        0x1::vector::push_back<0x1::ascii::String>(&mut v9, v12);
        let (_, v14, v15) = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::get_pyth_price(v12, arg3, arg4, arg9);
        0x1::vector::push_back<u64>(&mut v10, v14);
        0x1::vector::push_back<u64>(&mut v11, v15);
        let v16 = SecurePriceReceipt<T0, T1>{
            vault_id            : 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg2),
            pyth_tokens         : v9,
            pyth_token_decimals : v10,
            pyth_prices         : v11,
            nodo_tokens         : v6,
            nodo_token_decimals : v7,
            nodo_prices         : v8,
        };
        let v17 = SecurePriceUpdated{
            vault_id            : 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg2),
            pyth_tokens         : v9,
            pyth_token_decimals : v10,
            pyth_prices         : v11,
            nodo_tokens         : v6,
            nodo_token_decimals : v7,
            nodo_prices         : v8,
            timestamp           : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<SecurePriceUpdated>(v17);
        v16
    }

    fun calculate_fee(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / (10000 as u64)
    }

    fun charge_deposit_fee<T0, T1, T2>(arg0: &0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg1: &0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg2: &mut 0x2::coin::Coin<T2>, arg3: &0x2::clock::Clock, arg4: &0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T2>(arg2);
        if (v0 > 0) {
            0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::collect_fee_from_user<T0, T1, T2>(arg0, arg1, 0x2::coin::split<T2>(arg2, calculate_fee(v0, 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_deposit_fee_bps<T0, T1>(arg1)), arg5), 0, arg4, arg3);
        };
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

    public fun deposit_vault_bluefin<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg6: SecurePriceReceipt<T0, T1>, arg7: 0x2::coin::Coin<T0>, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::object::id<0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg8, arg9);
        let (v3, v4, v5) = validate_final_receipt<T0, T1>(arg2, arg6, arg3, arg10);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_v2<T0, T1>(arg1, arg2, arg7, 0x257e5ebb2bf7d893c5d0608d1af99a5007633056e8e08d27a5f98303ca189280::vault_lens::calculate_net_value_vault_bluefin<T0, T1, T2, T3>(arg4, arg5, arg2, v3, v4, v5), arg10, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg11);
    }

    public fun deposit_vault_cetus<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg6: SecurePriceReceipt<T0, T1>, arg7: 0x2::coin::Coin<T0>, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg8, arg9);
        let (v3, v4, v5) = validate_final_receipt<T0, T1>(arg2, arg6, arg3, arg10);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_v2<T0, T1>(arg1, arg2, arg7, 0x257e5ebb2bf7d893c5d0608d1af99a5007633056e8e08d27a5f98303ca189280::vault_lens::calculate_net_value_vault_cetus<T0, T1, T2, T3>(arg4, arg5, arg2, v3, v4, v5), arg10, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg11);
    }

    public fun deposit_vault_mmt<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg6: SecurePriceReceipt<T0, T1>, arg7: 0x2::coin::Coin<T0>, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::object::id<0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg8, arg9);
        let (v3, v4, v5) = validate_final_receipt<T0, T1>(arg2, arg6, arg3, arg10);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_v2<T0, T1>(arg1, arg2, arg7, 0x257e5ebb2bf7d893c5d0608d1af99a5007633056e8e08d27a5f98303ca189280::vault_lens::calculate_net_value_vault_mmt<T0, T1, T2, T3>(arg4, arg5, arg2, v3, v4, v5), arg10, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg11);
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

    public fun issue_secure_price_receipt<T0, T1>(arg0: &VaultUserConfig, arg1: &0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg2: &0x2::clock::Clock) : SecurePriceReceipt<T0, T1> {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = SecurePriceReceipt<T0, T1>{
            vault_id            : 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg1),
            pyth_tokens         : 0x1::vector::empty<0x1::ascii::String>(),
            pyth_token_decimals : 0x1::vector::empty<u64>(),
            pyth_prices         : 0x1::vector::empty<u64>(),
            nodo_tokens         : 0x1::vector::empty<0x1::ascii::String>(),
            nodo_token_decimals : 0x1::vector::empty<u64>(),
            nodo_prices         : 0x1::vector::empty<u64>(),
        };
        let v1 = SecurePriceInitiated{
            vault_id            : 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg1),
            pyth_tokens         : 0x1::vector::empty<0x1::ascii::String>(),
            pyth_token_decimals : 0x1::vector::empty<u64>(),
            pyth_prices         : 0x1::vector::empty<u64>(),
            nodo_tokens         : 0x1::vector::empty<0x1::ascii::String>(),
            nodo_token_decimals : 0x1::vector::empty<u64>(),
            nodo_prices         : 0x1::vector::empty<u64>(),
            timestamp           : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<SecurePriceInitiated>(v1);
        v0
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

    fun signature_message<T0, T1>(arg0: &VaultUserConfig, arg1: &0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x2::object::id<VaultUserConfig>(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig>(arg1);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg2);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        let v4 = 0x2::object::id<0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        v0
    }

    public fun swap_coin_a_then_deposit_bluefin<T0, T1, T2>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg7: u128, arg8: SecurePriceReceipt<T1, T2>, arg9: 0x2::coin::Coin<T0>, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T1, T2>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::object::id<0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        let v4 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg7));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg10, arg11);
        let (v5, v6, v7) = validate_final_receipt<T1, T2>(arg2, arg8, arg3, arg12);
        let v8 = 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap);
        let v9 = &mut arg9;
        charge_deposit_fee<T1, T2, T0>(arg1, arg2, v9, arg12, v8, arg13);
        let v10 = 0x2::coin::value<T0>(&arg9);
        assert!(v10 > 0, 6);
        let (v11, v12) = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::bluefin_adapter::internal_swap<T0, T1>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>>(arg2), arg5, arg6, arg9, 0x2::coin::zero<T1>(arg13), v10, arg7, true, false, 0x2::tx_context::sender(arg13), arg12, arg13);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_with_no_fee_v2<T1, T2>(arg1, arg2, v12, 0x257e5ebb2bf7d893c5d0608d1af99a5007633056e8e08d27a5f98303ca189280::vault_lens::calculate_net_value_vault_bluefin<T1, T2, T0, T1>(arg4, arg6, arg2, v5, v6, v7), arg12, v8, arg13);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T0>(v11, 0x2::tx_context::sender(arg13), arg13);
    }

    public fun swap_coin_a_then_deposit_cetus<T0, T1, T2>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: u128, arg8: SecurePriceReceipt<T1, T2>, arg9: 0x2::coin::Coin<T0>, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T1, T2>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        let v4 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg7));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg10, arg11);
        let (v5, v6, v7) = validate_final_receipt<T1, T2>(arg2, arg8, arg3, arg12);
        let v8 = 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap);
        let v9 = &mut arg9;
        charge_deposit_fee<T1, T2, T0>(arg1, arg2, v9, arg12, v8, arg13);
        let v10 = 0x2::coin::value<T0>(&arg9);
        assert!(v10 > 0, 6);
        let (v11, v12) = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::cetus_adapter::internal_swap<T0, T1>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>>(arg2), arg5, arg6, arg9, 0x2::coin::zero<T1>(arg13), v10, arg7, true, false, 0x2::tx_context::sender(arg13), arg12, arg13);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_with_no_fee_v2<T1, T2>(arg1, arg2, v12, 0x257e5ebb2bf7d893c5d0608d1af99a5007633056e8e08d27a5f98303ca189280::vault_lens::calculate_net_value_vault_cetus<T1, T2, T0, T1>(arg4, arg6, arg2, v5, v6, v7), arg12, v8, arg13);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T0>(v11, 0x2::tx_context::sender(arg13), arg13);
    }

    public fun swap_coin_a_then_deposit_mmt<T0, T1, T2>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg7: u128, arg8: SecurePriceReceipt<T1, T2>, arg9: 0x2::coin::Coin<T0>, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T1, T2>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::object::id<0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        let v4 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg7));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg10, arg11);
        let (v5, v6, v7) = validate_final_receipt<T1, T2>(arg2, arg8, arg3, arg12);
        let v8 = 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap);
        let v9 = &mut arg9;
        charge_deposit_fee<T1, T2, T0>(arg1, arg2, v9, arg12, v8, arg13);
        let v10 = 0x2::coin::value<T0>(&arg9);
        assert!(v10 > 0, 6);
        let (v11, v12) = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::mmt_adapter::internal_swap<T0, T1>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>>(arg2), arg6, arg5, arg9, 0x2::coin::zero<T1>(arg13), v10, arg7, true, false, 0x2::tx_context::sender(arg13), arg12, arg13);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_with_no_fee_v2<T1, T2>(arg1, arg2, v12, 0x257e5ebb2bf7d893c5d0608d1af99a5007633056e8e08d27a5f98303ca189280::vault_lens::calculate_net_value_vault_mmt<T1, T2, T0, T1>(arg4, arg6, arg2, v5, v6, v7), arg12, v8, arg13);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T0>(v11, 0x2::tx_context::sender(arg13), arg13);
    }

    public fun swap_coin_a_then_deposit_on_bluefin<T0, T1, T2, T3, T4>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T4>, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg8: u128, arg9: SecurePriceReceipt<T1, T2>, arg10: 0x2::coin::Coin<T0>, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T1, T2>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::object::id<0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T4>>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        let v4 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg7);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg8));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg11, arg12);
        let (v5, v6, v7) = validate_final_receipt<T1, T2>(arg2, arg9, arg3, arg13);
        let v8 = 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap);
        let v9 = &mut arg10;
        charge_deposit_fee<T1, T2, T0>(arg1, arg2, v9, arg13, v8, arg14);
        let v10 = 0x2::coin::value<T0>(&arg10);
        assert!(v10 > 0, 6);
        let (v11, v12) = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::bluefin_adapter::internal_swap<T0, T1>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>>(arg2), arg5, arg7, arg10, 0x2::coin::zero<T1>(arg14), v10, arg8, true, false, 0x2::tx_context::sender(arg14), arg13, arg14);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_with_no_fee_v2<T1, T2>(arg1, arg2, v12, 0x257e5ebb2bf7d893c5d0608d1af99a5007633056e8e08d27a5f98303ca189280::vault_lens::calculate_net_value_vault_bluefin<T1, T2, T3, T4>(arg4, arg6, arg2, v5, v6, v7), arg13, v8, arg14);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T0>(v11, 0x2::tx_context::sender(arg14), arg14);
    }

    public fun swap_coin_a_then_deposit_on_cetus<T0, T1, T2, T3, T4>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T4>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg8: u128, arg9: SecurePriceReceipt<T1, T2>, arg10: 0x2::coin::Coin<T0>, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T1, T2>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T4>>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        let v4 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg7);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg8));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg11, arg12);
        let (v5, v6, v7) = validate_final_receipt<T1, T2>(arg2, arg9, arg3, arg13);
        let v8 = 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap);
        let v9 = &mut arg10;
        charge_deposit_fee<T1, T2, T0>(arg1, arg2, v9, arg13, v8, arg14);
        let v10 = 0x2::coin::value<T0>(&arg10);
        assert!(v10 > 0, 6);
        let (v11, v12) = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::cetus_adapter::internal_swap<T0, T1>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>>(arg2), arg5, arg7, arg10, 0x2::coin::zero<T1>(arg14), v10, arg8, true, false, 0x2::tx_context::sender(arg14), arg13, arg14);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_with_no_fee_v2<T1, T2>(arg1, arg2, v12, 0x257e5ebb2bf7d893c5d0608d1af99a5007633056e8e08d27a5f98303ca189280::vault_lens::calculate_net_value_vault_cetus<T1, T2, T3, T4>(arg4, arg6, arg2, v5, v6, v7), arg13, v8, arg14);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T0>(v11, 0x2::tx_context::sender(arg14), arg14);
    }

    public fun swap_coin_a_then_deposit_on_mmt<T0, T1, T2, T3, T4>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T4>, arg7: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg8: u128, arg9: SecurePriceReceipt<T1, T2>, arg10: 0x2::coin::Coin<T0>, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T1, T2>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::object::id<0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T4>>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        let v4 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg7);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg8));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg11, arg12);
        let (v5, v6, v7) = validate_final_receipt<T1, T2>(arg2, arg9, arg3, arg13);
        let v8 = 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap);
        let v9 = &mut arg10;
        charge_deposit_fee<T1, T2, T0>(arg1, arg2, v9, arg13, v8, arg14);
        let v10 = 0x2::coin::value<T0>(&arg10);
        assert!(v10 > 0, 6);
        let (v11, v12) = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::mmt_adapter::internal_swap<T0, T1>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>>(arg2), arg7, arg5, arg10, 0x2::coin::zero<T1>(arg14), v10, arg8, true, false, 0x2::tx_context::sender(arg14), arg13, arg14);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_with_no_fee_v2<T1, T2>(arg1, arg2, v12, 0x257e5ebb2bf7d893c5d0608d1af99a5007633056e8e08d27a5f98303ca189280::vault_lens::calculate_net_value_vault_mmt<T1, T2, T3, T4>(arg4, arg6, arg2, v5, v6, v7), arg13, v8, arg14);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T0>(v11, 0x2::tx_context::sender(arg14), arg14);
    }

    public fun swap_coin_b_then_deposit_bluefin<T0, T1, T2>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg7: u128, arg8: SecurePriceReceipt<T1, T2>, arg9: 0x2::coin::Coin<T0>, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T1, T2>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::object::id<0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        let v4 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg7));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg10, arg11);
        let (v5, v6, v7) = validate_final_receipt<T1, T2>(arg2, arg8, arg3, arg12);
        let v8 = 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap);
        let v9 = &mut arg9;
        charge_deposit_fee<T1, T2, T0>(arg1, arg2, v9, arg12, v8, arg13);
        let v10 = 0x2::coin::value<T0>(&arg9);
        assert!(v10 > 0, 6);
        let (v11, v12) = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::bluefin_adapter::internal_swap<T1, T0>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>>(arg2), arg5, arg6, 0x2::coin::zero<T1>(arg13), arg9, v10, arg7, false, false, 0x2::tx_context::sender(arg13), arg12, arg13);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_with_no_fee_v2<T1, T2>(arg1, arg2, v11, 0x257e5ebb2bf7d893c5d0608d1af99a5007633056e8e08d27a5f98303ca189280::vault_lens::calculate_net_value_vault_bluefin<T1, T2, T1, T0>(arg4, arg6, arg2, v5, v6, v7), arg12, v8, arg13);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T0>(v12, 0x2::tx_context::sender(arg13), arg13);
    }

    public fun swap_coin_b_then_deposit_cetus<T0, T1, T2>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg7: u128, arg8: SecurePriceReceipt<T1, T2>, arg9: 0x2::coin::Coin<T0>, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T1, T2>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        let v4 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg7));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg10, arg11);
        let (v5, v6, v7) = validate_final_receipt<T1, T2>(arg2, arg8, arg3, arg12);
        let v8 = 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap);
        let v9 = &mut arg9;
        charge_deposit_fee<T1, T2, T0>(arg1, arg2, v9, arg12, v8, arg13);
        let v10 = 0x2::coin::value<T0>(&arg9);
        assert!(v10 > 0, 6);
        let (v11, v12) = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::cetus_adapter::internal_swap<T1, T0>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>>(arg2), arg5, arg6, 0x2::coin::zero<T1>(arg13), arg9, v10, arg7, false, false, 0x2::tx_context::sender(arg13), arg12, arg13);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_with_no_fee_v2<T1, T2>(arg1, arg2, v11, 0x257e5ebb2bf7d893c5d0608d1af99a5007633056e8e08d27a5f98303ca189280::vault_lens::calculate_net_value_vault_cetus<T1, T2, T1, T0>(arg4, arg6, arg2, v5, v6, v7), arg12, v8, arg13);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T0>(v12, 0x2::tx_context::sender(arg13), arg13);
    }

    public fun swap_coin_b_then_deposit_mmt<T0, T1, T2>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg7: u128, arg8: SecurePriceReceipt<T1, T2>, arg9: 0x2::coin::Coin<T0>, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T1, T2>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::object::id<0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        let v4 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg7));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg10, arg11);
        let (v5, v6, v7) = validate_final_receipt<T1, T2>(arg2, arg8, arg3, arg12);
        let v8 = 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap);
        let v9 = &mut arg9;
        charge_deposit_fee<T1, T2, T0>(arg1, arg2, v9, arg12, v8, arg13);
        let v10 = 0x2::coin::value<T0>(&arg9);
        assert!(v10 > 0, 6);
        let (v11, v12) = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::mmt_adapter::internal_swap<T1, T0>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>>(arg2), arg6, arg5, 0x2::coin::zero<T1>(arg13), arg9, v10, arg7, false, false, 0x2::tx_context::sender(arg13), arg12, arg13);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_with_no_fee_v2<T1, T2>(arg1, arg2, v11, 0x257e5ebb2bf7d893c5d0608d1af99a5007633056e8e08d27a5f98303ca189280::vault_lens::calculate_net_value_vault_mmt<T1, T2, T1, T0>(arg4, arg6, arg2, v5, v6, v7), arg12, v8, arg13);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T0>(v12, 0x2::tx_context::sender(arg13), arg13);
    }

    public fun swap_coin_b_then_deposit_on_bluefin<T0, T1, T2, T3, T4>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T4>, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg8: u128, arg9: SecurePriceReceipt<T1, T2>, arg10: 0x2::coin::Coin<T0>, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T1, T2>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::object::id<0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T4>>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        let v4 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(arg7);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg8));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg11, arg12);
        let (v5, v6, v7) = validate_final_receipt<T1, T2>(arg2, arg9, arg3, arg13);
        let v8 = 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap);
        let v9 = &mut arg10;
        charge_deposit_fee<T1, T2, T0>(arg1, arg2, v9, arg13, v8, arg14);
        let v10 = 0x2::coin::value<T0>(&arg10);
        assert!(v10 > 0, 6);
        let (v11, v12) = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::bluefin_adapter::internal_swap<T1, T0>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>>(arg2), arg5, arg7, 0x2::coin::zero<T1>(arg14), arg10, v10, arg8, false, false, 0x2::tx_context::sender(arg14), arg13, arg14);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_with_no_fee_v2<T1, T2>(arg1, arg2, v11, 0x257e5ebb2bf7d893c5d0608d1af99a5007633056e8e08d27a5f98303ca189280::vault_lens::calculate_net_value_vault_bluefin<T1, T2, T3, T4>(arg4, arg6, arg2, v5, v6, v7), arg13, v8, arg14);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T0>(v12, 0x2::tx_context::sender(arg14), arg14);
    }

    public fun swap_coin_b_then_deposit_on_cetus<T0, T1, T2, T3, T4>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T4>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg8: u128, arg9: SecurePriceReceipt<T1, T2>, arg10: 0x2::coin::Coin<T0>, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T1, T2>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T4>>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        let v4 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg7);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg8));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg11, arg12);
        let (v5, v6, v7) = validate_final_receipt<T1, T2>(arg2, arg9, arg3, arg13);
        let v8 = 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap);
        let v9 = &mut arg10;
        charge_deposit_fee<T1, T2, T0>(arg1, arg2, v9, arg13, v8, arg14);
        let v10 = 0x2::coin::value<T0>(&arg10);
        assert!(v10 > 0, 6);
        let (v11, v12) = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::cetus_adapter::internal_swap<T1, T0>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>>(arg2), arg5, arg7, 0x2::coin::zero<T1>(arg14), arg10, v10, arg8, false, false, 0x2::tx_context::sender(arg14), arg13, arg14);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_with_no_fee_v2<T1, T2>(arg1, arg2, v11, 0x257e5ebb2bf7d893c5d0608d1af99a5007633056e8e08d27a5f98303ca189280::vault_lens::calculate_net_value_vault_cetus<T1, T2, T3, T4>(arg4, arg6, arg2, v5, v6, v7), arg13, v8, arg14);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T0>(v12, 0x2::tx_context::sender(arg14), arg14);
    }

    public fun swap_coin_b_then_deposit_on_mmt<T0, T1, T2, T3, T4>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T4>, arg7: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg8: u128, arg9: SecurePriceReceipt<T1, T2>, arg10: 0x2::coin::Coin<T0>, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T1, T2>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::object::id<0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T4>>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        let v4 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>>(arg7);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg8));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg11, arg12);
        let (v5, v6, v7) = validate_final_receipt<T1, T2>(arg2, arg9, arg3, arg13);
        let v8 = 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap);
        let v9 = &mut arg10;
        charge_deposit_fee<T1, T2, T0>(arg1, arg2, v9, arg13, v8, arg14);
        let v10 = 0x2::coin::value<T0>(&arg10);
        assert!(v10 > 0, 6);
        let (v11, v12) = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::mmt_adapter::internal_swap<T1, T0>(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T1, T2>>(arg2), arg7, arg5, 0x2::coin::zero<T1>(arg14), arg10, v10, arg8, false, false, 0x2::tx_context::sender(arg14), arg13, arg14);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_with_no_fee_v2<T1, T2>(arg1, arg2, v11, 0x257e5ebb2bf7d893c5d0608d1af99a5007633056e8e08d27a5f98303ca189280::vault_lens::calculate_net_value_vault_mmt<T1, T2, T3, T4>(arg4, arg6, arg2, v5, v6, v7), arg13, v8, arg14);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::destroy_zero_or_transfer_to_receiver<T0>(v12, 0x2::tx_context::sender(arg14), arg14);
    }

    public fun update_rate_bluefin<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg6: SecurePriceReceipt<T0, T1>, arg7: vector<vector<u8>>, arg8: vector<vector<u8>>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        assert!(check_operator(arg0, 0x2::tx_context::sender(arg10)), 3);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::object::id<0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg7, arg8);
        let (v3, v4, v5) = validate_final_receipt<T0, T1>(arg2, arg6, arg3, arg9);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::update_rate_v2<T0, T1>(arg1, arg2, 0x257e5ebb2bf7d893c5d0608d1af99a5007633056e8e08d27a5f98303ca189280::vault_lens::calculate_net_value_vault_bluefin<T0, T1, T2, T3>(arg4, arg5, arg2, v3, v4, v5), arg9, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg10);
    }

    public fun update_rate_cetus<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg6: SecurePriceReceipt<T0, T1>, arg7: vector<vector<u8>>, arg8: vector<vector<u8>>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        assert!(check_operator(arg0, 0x2::tx_context::sender(arg10)), 3);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg7, arg8);
        let (v3, v4, v5) = validate_final_receipt<T0, T1>(arg2, arg6, arg3, arg9);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::update_rate_v2<T0, T1>(arg1, arg2, 0x257e5ebb2bf7d893c5d0608d1af99a5007633056e8e08d27a5f98303ca189280::vault_lens::calculate_net_value_vault_cetus<T0, T1, T2, T3>(arg4, arg5, arg2, v3, v4, v5), arg9, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg10);
    }

    public fun update_rate_mmt<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg6: SecurePriceReceipt<T0, T1>, arg7: vector<vector<u8>>, arg8: vector<vector<u8>>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        assert!(check_operator(arg0, 0x2::tx_context::sender(arg10)), 3);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::object::id<0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg7, arg8);
        let (v3, v4, v5) = validate_final_receipt<T0, T1>(arg2, arg6, arg3, arg9);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::update_rate_v2<T0, T1>(arg1, arg2, 0x257e5ebb2bf7d893c5d0608d1af99a5007633056e8e08d27a5f98303ca189280::vault_lens::calculate_net_value_vault_mmt<T0, T1, T2, T3>(arg4, arg5, arg2, v3, v4, v5), arg9, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg10);
    }

    public fun user_deposit_and_add_liquidity_bluefin<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &mut 0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg7: u128, arg8: u32, arg9: u32, arg10: SecurePriceReceipt<T0, T1>, arg11: 0x2::coin::Coin<T2>, arg12: 0x2::coin::Coin<T3>, arg13: vector<vector<u8>>, arg14: vector<vector<u8>>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::object::id<0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg7));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u32>(&arg8));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u32>(&arg9));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg13, arg14);
        let (v4, v5, v6) = validate_final_receipt<T0, T1>(arg2, arg10, arg3, arg15);
        let (v7, v8, v9) = 0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_composer::user_add_liquidity_v2<T0, T1, T2, T3>(arg4, arg5, arg6, arg2, arg1, v4, v5, v6, arg11, arg12, arg7, arg8, arg9, arg15, arg16);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_dual_token_v2<T0, T1>(arg1, arg2, v7, 0x257e5ebb2bf7d893c5d0608d1af99a5007633056e8e08d27a5f98303ca189280::vault_lens::calculate_net_value_vault_bluefin<T0, T1, T2, T3>(arg4, arg6, arg2, v4, v5, v6), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T3>()), v8, v9, arg15, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg16);
    }

    public fun user_deposit_and_add_liquidity_cetus<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg7: u128, arg8: u32, arg9: u32, arg10: SecurePriceReceipt<T0, T1>, arg11: 0x2::coin::Coin<T2>, arg12: 0x2::coin::Coin<T3>, arg13: vector<vector<u8>>, arg14: vector<vector<u8>>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg7));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u32>(&arg8));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u32>(&arg9));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg13, arg14);
        let (v4, v5, v6) = validate_final_receipt<T0, T1>(arg2, arg10, arg3, arg15);
        let (v7, v8, v9) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_composer::user_add_liquidity_v2<T0, T1, T2, T3>(arg4, arg5, arg6, arg2, arg1, v4, v5, v6, arg11, arg12, arg7, arg8, arg9, arg15, arg16);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_dual_token_v2<T0, T1>(arg1, arg2, v7, 0x257e5ebb2bf7d893c5d0608d1af99a5007633056e8e08d27a5f98303ca189280::vault_lens::calculate_net_value_vault_cetus<T0, T1, T2, T3>(arg4, arg6, arg2, v4, v5, v6), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T3>()), v8, v9, arg15, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg16);
    }

    public fun user_deposit_and_add_liquidity_mmt<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg7: u128, arg8: u32, arg9: u32, arg10: SecurePriceReceipt<T0, T1>, arg11: 0x2::coin::Coin<T2>, arg12: 0x2::coin::Coin<T3>, arg13: vector<vector<u8>>, arg14: vector<vector<u8>>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::object::id<0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg7));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u32>(&arg8));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u32>(&arg9));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg13, arg14);
        let (v4, v5, v6) = validate_final_receipt<T0, T1>(arg2, arg10, arg3, arg15);
        let (v7, v8, v9) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_composer::user_add_liquidity_v2<T0, T1, T2, T3>(arg4, arg5, arg6, arg2, arg1, v4, v5, v6, arg11, arg12, arg7, arg8, arg9, arg15, arg16);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_dual_token_v2<T0, T1>(arg1, arg2, v7, 0x257e5ebb2bf7d893c5d0608d1af99a5007633056e8e08d27a5f98303ca189280::vault_lens::calculate_net_value_vault_mmt<T0, T1, T2, T3>(arg4, arg6, arg2, v4, v5, v6), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T3>()), v8, v9, arg15, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg16);
    }

    public fun user_deposit_then_add_liquidity_bluefin<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &mut 0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg7: u128, arg8: SecurePriceReceipt<T0, T1>, arg9: 0x2::coin::Coin<T2>, arg10: 0x2::coin::Coin<T3>, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::object::id<0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg7));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg11, arg12);
        let (v4, v5, v6) = validate_final_receipt<T0, T1>(arg2, arg8, arg3, arg13);
        let (v7, v8, v9) = 0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_composer::user_add_liquidity_new_v2<T0, T1, T2, T3>(arg4, arg5, arg6, arg2, arg1, v4, v5, v6, arg9, arg10, arg7, arg13, arg14);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_dual_token_v2<T0, T1>(arg1, arg2, v7, 0x257e5ebb2bf7d893c5d0608d1af99a5007633056e8e08d27a5f98303ca189280::vault_lens::calculate_net_value_vault_bluefin<T0, T1, T2, T3>(arg4, arg6, arg2, v4, v5, v6), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T3>()), v8, v9, arg13, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg14);
        abort 0
    }

    public fun user_deposit_then_add_liquidity_cetus<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &mut 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg7: u128, arg8: SecurePriceReceipt<T0, T1>, arg9: 0x2::coin::Coin<T2>, arg10: 0x2::coin::Coin<T3>, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg7));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg11, arg12);
        let (v4, v5, v6) = validate_final_receipt<T0, T1>(arg2, arg8, arg3, arg13);
        let (v7, v8, v9) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_composer::user_add_liquidity_new_v2<T0, T1, T2, T3>(arg4, arg5, arg6, arg2, arg1, v4, v5, v6, arg9, arg10, arg7, arg13, arg14);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_dual_token_v2<T0, T1>(arg1, arg2, v7, 0x257e5ebb2bf7d893c5d0608d1af99a5007633056e8e08d27a5f98303ca189280::vault_lens::calculate_net_value_vault_cetus<T0, T1, T2, T3>(arg4, arg6, arg2, v4, v5, v6), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T3>()), v8, v9, arg13, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg14);
        abort 0
    }

    public fun user_deposit_then_add_liquidity_mmt<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &mut 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg7: u128, arg8: SecurePriceReceipt<T0, T1>, arg9: 0x2::coin::Coin<T2>, arg10: 0x2::coin::Coin<T3>, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::object::id<0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg7));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg11, arg12);
        let (v4, v5, v6) = validate_final_receipt<T0, T1>(arg2, arg8, arg3, arg13);
        let (v7, v8, v9) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_composer::user_add_liquidity_new_v2<T0, T1, T2, T3>(arg4, arg5, arg6, arg2, arg1, v4, v5, v6, arg9, arg10, arg7, arg13, arg14);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::deposit_dual_token_v2<T0, T1>(arg1, arg2, v7, 0x257e5ebb2bf7d893c5d0608d1af99a5007633056e8e08d27a5f98303ca189280::vault_lens::calculate_net_value_vault_mmt<T0, T1, T2, T3>(arg4, arg6, arg2, v4, v5, v6), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T3>()), v8, v9, arg13, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg14);
        abort 0
    }

    fun validate_final_receipt<T0, T1>(arg0: &0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg1: SecurePriceReceipt<T0, T1>, arg2: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg3: &0x2::clock::Clock) : (vector<0x1::ascii::String>, vector<u64>, vector<u64>) {
        let SecurePriceReceipt {
            vault_id            : v0,
            pyth_tokens         : v1,
            pyth_token_decimals : v2,
            pyth_prices         : v3,
            nodo_tokens         : v4,
            nodo_token_decimals : v5,
            nodo_prices         : v6,
        } = arg1;
        let v7 = v6;
        let v8 = v5;
        let v9 = v4;
        let v10 = v3;
        let v11 = v2;
        let v12 = v1;
        assert!(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg0) == v0, 8);
        let v13 = 0x1::vector::empty<0x1::ascii::String>();
        let v14 = 0x1::vector::empty<u64>();
        let v15 = 0x1::vector::empty<u64>();
        let v16 = 0x1::vector::empty<u8>();
        let v17 = 0x1::vector::length<0x1::ascii::String>(&v9);
        let v18 = 0;
        while (v18 < 0x1::vector::length<0x1::ascii::String>(&v12)) {
            let v19 = *0x1::vector::borrow<0x1::ascii::String>(&v12, v18);
            let v20 = *0x1::vector::borrow<u64>(&v11, v18);
            let v21 = *0x1::vector::borrow<u64>(&v10, v18);
            let v22 = false;
            let v23 = 0;
            while (v23 < v17) {
                if (*0x1::vector::borrow<0x1::ascii::String>(&v9, v23) == v19) {
                    v22 = true;
                    let v24 = *0x1::vector::borrow<u64>(&v7, v23);
                    let v25 = if (v21 > v24) {
                        v21 - v24
                    } else {
                        v24 - v21
                    };
                    assert!(v25 <= v21 * 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_max_conf_by_token(arg2, v19) / 10000, 12);
                    0x1::vector::push_back<u8>(&mut v16, 2);
                    0x1::vector::push_back<0x1::ascii::String>(&mut v13, v19);
                    0x1::vector::push_back<u64>(&mut v14, v20);
                    0x1::vector::push_back<u64>(&mut v15, v21);
                    break
                };
                v23 = v23 + 1;
            };
            if (!v22) {
                0x1::vector::push_back<u8>(&mut v16, 0);
                0x1::vector::push_back<0x1::ascii::String>(&mut v13, v19);
                0x1::vector::push_back<u64>(&mut v14, v20);
                0x1::vector::push_back<u64>(&mut v15, v21);
            };
            v18 = v18 + 1;
        };
        let v26 = 0;
        while (v26 < v17) {
            let v27 = *0x1::vector::borrow<0x1::ascii::String>(&v9, v26);
            if (!0x1::vector::contains<0x1::ascii::String>(&v13, &v27)) {
                0x1::vector::push_back<u8>(&mut v16, 1);
                0x1::vector::push_back<0x1::ascii::String>(&mut v13, v27);
                0x1::vector::push_back<u64>(&mut v14, *0x1::vector::borrow<u64>(&v8, v26));
                0x1::vector::push_back<u64>(&mut v15, *0x1::vector::borrow<u64>(&v7, v26));
            };
            v26 = v26 + 1;
        };
        let v28 = SecurePriceCompleted{
            vault_id  : 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg0),
            oracles   : v16,
            tokens    : v13,
            decimals  : v14,
            prices    : v15,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<SecurePriceCompleted>(v28);
        (v13, v14, v15)
    }

    fun validate_updated_receipt<T0, T1, T2>(arg0: &0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg1: SecurePriceReceipt<T0, T1>, arg2: u8) : (vector<0x1::ascii::String>, vector<u64>, vector<u64>, vector<0x1::ascii::String>, vector<u64>, vector<u64>) {
        let SecurePriceReceipt {
            vault_id            : v0,
            pyth_tokens         : v1,
            pyth_token_decimals : v2,
            pyth_prices         : v3,
            nodo_tokens         : v4,
            nodo_token_decimals : v5,
            nodo_prices         : v6,
        } = arg1;
        let v7 = v4;
        let v8 = v1;
        assert!(0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg0) == v0, 8);
        let v9 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>());
        if (arg2 == 0) {
            let v10 = 0;
            while (v10 < 0x1::vector::length<0x1::ascii::String>(&v8)) {
                assert!(&v9 != 0x1::vector::borrow<0x1::ascii::String>(&v8, v10), 7);
                v10 = v10 + 1;
            };
        } else if (arg2 == 1) {
            let v11 = 0;
            while (v11 < 0x1::vector::length<0x1::ascii::String>(&v7)) {
                assert!(&v9 != 0x1::vector::borrow<0x1::ascii::String>(&v7, v11), 7);
                v11 = v11 + 1;
            };
        };
        (v8, v2, v3, v7, v5, v6)
    }

    fun verify_signature_price<T0, T1, T2>(arg0: &VaultUserConfig, arg1: &0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: vector<u8>, arg5: u64, arg6: vector<vector<u8>>, arg7: vector<vector<u8>>) : bool {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>());
        let v1 = signature_message<T0, T1>(arg0, arg1, arg2, arg3);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::ascii::String>(&v0));
        0x1::vector::append<u8>(&mut v1, arg4);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg5));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v1, arg6, arg7)
    }

    public fun withdraw_dual_vault_bluefin<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg6: SecurePriceReceipt<T0, T1>, arg7: 0x2::coin::Coin<T1>, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::object::id<0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg8, arg9);
        let (v3, v4, v5) = validate_final_receipt<T0, T1>(arg2, arg6, arg3, arg10);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::withdraw_dual_token_v2<T0, T1, T2, T3>(arg1, arg2, arg7, 0x257e5ebb2bf7d893c5d0608d1af99a5007633056e8e08d27a5f98303ca189280::vault_lens::calculate_net_value_vault_bluefin<T0, T1, T2, T3>(arg4, arg5, arg2, v3, v4, v5), v3, v4, v5, arg10, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg11);
    }

    public fun withdraw_dual_vault_cetus<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg6: SecurePriceReceipt<T0, T1>, arg7: 0x2::coin::Coin<T1>, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg8, arg9);
        let (v3, v4, v5) = validate_final_receipt<T0, T1>(arg2, arg6, arg3, arg10);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::withdraw_dual_token_v2<T0, T1, T2, T3>(arg1, arg2, arg7, 0x257e5ebb2bf7d893c5d0608d1af99a5007633056e8e08d27a5f98303ca189280::vault_lens::calculate_net_value_vault_cetus<T0, T1, T2, T3>(arg4, arg5, arg2, v3, v4, v5), v3, v4, v5, arg10, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg11);
    }

    public fun withdraw_dual_vault_mmt<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg6: SecurePriceReceipt<T0, T1>, arg7: 0x2::coin::Coin<T1>, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::object::id<0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg8, arg9);
        let (v3, v4, v5) = validate_final_receipt<T0, T1>(arg2, arg6, arg3, arg10);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::withdraw_dual_token_v2<T0, T1, T2, T3>(arg1, arg2, arg7, 0x257e5ebb2bf7d893c5d0608d1af99a5007633056e8e08d27a5f98303ca189280::vault_lens::calculate_net_value_vault_mmt<T0, T1, T2, T3>(arg4, arg5, arg2, v3, v4, v5), v3, v4, v5, arg10, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg11);
    }

    public fun withdraw_vault_bluefin<T0, T1, T2, T3, T4>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg6: SecurePriceReceipt<T0, T1>, arg7: 0x2::coin::Coin<T1>, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::object::id<0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg8, arg9);
        let (v3, v4, v5) = validate_final_receipt<T0, T1>(arg2, arg6, arg3, arg10);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::withdraw_token_v2<T0, T1, T4>(arg1, arg2, arg7, 0x257e5ebb2bf7d893c5d0608d1af99a5007633056e8e08d27a5f98303ca189280::vault_lens::calculate_net_value_vault_bluefin<T0, T1, T2, T3>(arg4, arg5, arg2, v3, v4, v5), v3, v4, v5, arg10, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg11);
    }

    public fun withdraw_vault_cetus<T0, T1, T2, T3, T4>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg6: SecurePriceReceipt<T0, T1>, arg7: 0x2::coin::Coin<T1>, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::object::id<0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg8, arg9);
        let (v3, v4, v5) = validate_final_receipt<T0, T1>(arg2, arg6, arg3, arg10);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::withdraw_token_v2<T0, T1, T4>(arg1, arg2, arg7, 0x257e5ebb2bf7d893c5d0608d1af99a5007633056e8e08d27a5f98303ca189280::vault_lens::calculate_net_value_vault_cetus<T0, T1, T2, T3>(arg4, arg5, arg2, v3, v4, v5), v3, v4, v5, arg10, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg11);
    }

    public fun withdraw_vault_mmt<T0, T1, T2, T3, T4>(arg0: &VaultUserConfig, arg1: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::VaultConfig, arg2: &mut 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg6: SecurePriceReceipt<T0, T1>, arg7: 0x2::coin::Coin<T1>, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::object::id<0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::verify_signature(arg1, v0, arg8, arg9);
        let (v3, v4, v5) = validate_final_receipt<T0, T1>(arg2, arg6, arg3, arg10);
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::withdraw_token_v2<T0, T1, T4>(arg1, arg2, arg7, 0x257e5ebb2bf7d893c5d0608d1af99a5007633056e8e08d27a5f98303ca189280::vault_lens::calculate_net_value_vault_mmt<T0, T1, T2, T3>(arg4, arg5, arg2, v3, v4, v5), v3, v4, v5, arg10, 0x1::option::borrow<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::AccessCap>(&arg0.access_cap), arg11);
    }

    // decompiled from Move bytecode v6
}

