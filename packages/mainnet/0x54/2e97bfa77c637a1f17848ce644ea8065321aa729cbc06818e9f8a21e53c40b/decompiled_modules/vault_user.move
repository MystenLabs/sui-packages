module 0x4acbecdf9a09a9f1788023303fc166622aa3adb1d762f730380e566100dcc8b2::vault_user {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct VaultUserConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        access_cap: 0x1::option::Option<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>,
        operators: 0x2::table::Table<address, bool>,
        pausers: 0x2::table::Table<address, bool>,
        enable: bool,
    }

    struct SecurePriceReceipt<phantom T0, phantom T1> {
        vault_id: 0x2::object::ID,
        tokens: vector<0x1::ascii::String>,
        price_ids: vector<0x2::object::ID>,
        coin_decimals: vector<u64>,
        prices: vector<u64>,
        vec_time_ts: vector<u64>,
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
        tokens: vector<0x1::ascii::String>,
        price_ids: vector<0x2::object::ID>,
        coin_decimals: vector<u64>,
        prices: vector<u64>,
        vec_time_ts: vector<u64>,
        timestamp: u64,
    }

    struct SecurePriceUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        tokens: vector<0x1::ascii::String>,
        price_ids: vector<0x2::object::ID>,
        coin_decimals: vector<u64>,
        prices: vector<u64>,
        vec_time_ts: vector<u64>,
        timestamp: u64,
    }

    struct SecurePriceCompleted has copy, drop {
        vault_id: 0x2::object::ID,
        tokens: vector<0x1::ascii::String>,
        price_ids: vector<0x2::object::ID>,
        coin_decimals: vector<u64>,
        prices: vector<u64>,
        vec_time_ts: vector<u64>,
        timestamp: u64,
    }

    entry fun add_access_cap(arg0: &AdminCap, arg1: &mut VaultUserConfig, arg2: 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap) {
        0x1::option::fill<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&mut arg1.access_cap, arg2);
    }

    public fun build_nodo_secure_price_receipt<T0, T1, T2>(arg0: &VaultUserConfig, arg1: &0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo, arg5: u64, arg6: vector<vector<u8>>, arg7: vector<vector<u8>>, arg8: SecurePriceReceipt<T0, T1>, arg9: &0x2::clock::Clock) : SecurePriceReceipt<T0, T1> {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = 0x2::clock::timestamp_ms(arg9);
        assert!(arg5 <= v0, 9);
        assert!(v0 - arg5 <= 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_max_staleness(arg3), 10);
        verify_signature_price<T0, T1, T2>(arg0, arg1, arg2, arg3, 0x2::object::id_bytes<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>(arg4), arg5, arg6, arg7);
        let (v1, v2, v3, v4, v5) = validate_updated_receipt<T0, T1, T2>(arg2, arg8);
        let v6 = v1;
        let v7 = v2;
        let v8 = v3;
        let v9 = v4;
        let v10 = v5;
        let v11 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>());
        0x1::vector::push_back<0x1::ascii::String>(&mut v6, v11);
        0x1::vector::push_back<0x2::object::ID>(&mut v7, 0x2::object::id<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>(arg4));
        0x1::vector::push_back<u64>(&mut v10, arg5);
        let (_, v13, v14, v15) = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::utils::get_nodo_price(arg3, arg4, arg9);
        assert!(v13 == v11, 11);
        0x1::vector::push_back<u64>(&mut v8, v14);
        0x1::vector::push_back<u64>(&mut v9, v15);
        let v16 = SecurePriceReceipt<T0, T1>{
            vault_id      : 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg2),
            tokens        : v6,
            price_ids     : v7,
            coin_decimals : v8,
            prices        : v9,
            vec_time_ts   : v10,
        };
        let v17 = SecurePriceUpdated{
            vault_id      : 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg2),
            tokens        : v6,
            price_ids     : v7,
            coin_decimals : v8,
            prices        : v9,
            vec_time_ts   : v10,
            timestamp     : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<SecurePriceUpdated>(v17);
        v16
    }

    public fun build_pyth_secure_price_receipt<T0, T1, T2>(arg0: &VaultUserConfig, arg1: &0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: u64, arg6: vector<vector<u8>>, arg7: vector<vector<u8>>, arg8: SecurePriceReceipt<T0, T1>, arg9: &0x2::clock::Clock) : SecurePriceReceipt<T0, T1> {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = 0x2::clock::timestamp_ms(arg9);
        assert!(arg5 <= v0, 9);
        assert!(v0 - arg5 <= 0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::get_max_staleness(arg3), 10);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg4);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v1);
        verify_signature_price<T0, T1, T2>(arg0, arg1, arg2, arg3, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2), arg5, arg6, arg7);
        let (v3, v4, v5, v6, v7) = validate_updated_receipt<T0, T1, T2>(arg2, arg8);
        let v8 = v3;
        let v9 = v4;
        let v10 = v5;
        let v11 = v6;
        let v12 = v7;
        let v13 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>());
        0x1::vector::push_back<0x1::ascii::String>(&mut v8, v13);
        0x1::vector::push_back<0x2::object::ID>(&mut v9, 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg4));
        0x1::vector::push_back<u64>(&mut v12, arg5);
        let (_, v15, v16) = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::utils::get_pyth_price(v13, arg3, arg4, arg9);
        0x1::vector::push_back<u64>(&mut v10, v15);
        0x1::vector::push_back<u64>(&mut v11, v16);
        let v17 = SecurePriceReceipt<T0, T1>{
            vault_id      : 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg2),
            tokens        : v8,
            price_ids     : v9,
            coin_decimals : v10,
            prices        : v11,
            vec_time_ts   : v12,
        };
        let v18 = SecurePriceUpdated{
            vault_id      : 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg2),
            tokens        : v8,
            price_ids     : v9,
            coin_decimals : v10,
            prices        : v11,
            vec_time_ts   : v12,
            timestamp     : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<SecurePriceUpdated>(v18);
        v17
    }

    fun calculate_fee(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / (10000 as u64)
    }

    fun charge_deposit_fee<T0, T1, T2>(arg0: &0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg1: &0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg2: &mut 0x2::coin::Coin<T2>, arg3: &0x2::clock::Clock, arg4: &0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T2>(arg2);
        if (v0 > 0) {
            0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::collect_fee_from_user<T0, T1, T2>(arg0, arg1, 0x2::coin::split<T2>(arg2, calculate_fee(v0, 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::get_deposit_fee_bps<T0, T1>(arg1)), arg5), 0, arg4, arg3);
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

    public fun deposit_vault_bluefin<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg3: &0x15d6ceabb34c99ea7c05c8c8bad904649b907102053d660ba91bde13d6f4761::bluefin_executor::BluefinExecutorConfig, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: SecurePriceReceipt<T0, T1>, arg6: 0x2::coin::Coin<T0>, arg7: vector<vector<u8>>, arg8: vector<vector<u8>>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2);
        let v1 = 0x2::object::id<0x15d6ceabb34c99ea7c05c8c8bad904649b907102053d660ba91bde13d6f4761::bluefin_executor::BluefinExecutorConfig>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg1, v0, arg7, arg8);
        let (v3, v4, v5) = validate_final_receipt<T0, T1>(arg2, arg5, arg9);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::deposit_v2<T0, T1>(arg1, arg2, arg6, 0x3647adb183782ec081a048038d45db126da265e5de8c9c30095a1b17a7ba82d8::vault_lens::calculate_net_value_vault_bluefin<T0, T1, T2, T3>(arg3, arg4, arg2, v3, v4, v5), arg9, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap), arg10);
    }

    public fun deposit_vault_cetus<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg3: &0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_executor::CetusConfig, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: SecurePriceReceipt<T0, T1>, arg6: 0x2::coin::Coin<T0>, arg7: vector<vector<u8>>, arg8: vector<vector<u8>>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2);
        let v1 = 0x2::object::id<0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_executor::CetusConfig>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg1, v0, arg7, arg8);
        let (v3, v4, v5) = validate_final_receipt<T0, T1>(arg2, arg5, arg9);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::deposit_v2<T0, T1>(arg1, arg2, arg6, 0x3647adb183782ec081a048038d45db126da265e5de8c9c30095a1b17a7ba82d8::vault_lens::calculate_net_value_vault_cetus<T0, T1, T2, T3>(arg3, arg4, arg2, v3, v4, v5), arg9, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap), arg10);
    }

    public fun deposit_vault_mmt<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg3: &0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: SecurePriceReceipt<T0, T1>, arg6: 0x2::coin::Coin<T0>, arg7: vector<vector<u8>>, arg8: vector<vector<u8>>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2);
        let v1 = 0x2::object::id<0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg1, v0, arg7, arg8);
        let (v3, v4, v5) = validate_final_receipt<T0, T1>(arg2, arg5, arg9);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::deposit_v2<T0, T1>(arg1, arg2, arg6, 0x3647adb183782ec081a048038d45db126da265e5de8c9c30095a1b17a7ba82d8::vault_lens::calculate_net_value_vault_mmt<T0, T1, T2, T3>(arg3, arg4, arg2, v3, v4, v5), arg9, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap), arg10);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = VaultUserConfig{
            id         : 0x2::object::new(arg0),
            version    : 1,
            access_cap : 0x1::option::none<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(),
            operators  : 0x2::table::new<address, bool>(arg0),
            pausers    : 0x2::table::new<address, bool>(arg0),
            enable     : true,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<VaultUserConfig>(v1);
    }

    public fun issue_secure_price_receipt<T0, T1>(arg0: &VaultUserConfig, arg1: &0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg2: &0x2::clock::Clock) : SecurePriceReceipt<T0, T1> {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = SecurePriceReceipt<T0, T1>{
            vault_id      : 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg1),
            tokens        : 0x1::vector::empty<0x1::ascii::String>(),
            price_ids     : 0x1::vector::empty<0x2::object::ID>(),
            coin_decimals : 0x1::vector::empty<u64>(),
            prices        : 0x1::vector::empty<u64>(),
            vec_time_ts   : 0x1::vector::empty<u64>(),
        };
        let v1 = SecurePriceInitiated{
            vault_id      : 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg1),
            tokens        : 0x1::vector::empty<0x1::ascii::String>(),
            price_ids     : 0x1::vector::empty<0x2::object::ID>(),
            coin_decimals : 0x1::vector::empty<u64>(),
            prices        : 0x1::vector::empty<u64>(),
            vec_time_ts   : 0x1::vector::empty<u64>(),
            timestamp     : 0x2::clock::timestamp_ms(arg2),
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

    public fun redeem<T0, T1, T2>(arg0: &VaultUserConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg3: address, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>, arg7: u64, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::redeem_v2<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap), arg11);
    }

    public fun redeem_dual<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg3: address, arg4: vector<vector<0x1::ascii::String>>, arg5: vector<u64>, arg6: vector<vector<u64>>, arg7: vector<u64>, arg8: u64, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::redeem_dual_v2<T0, T1, T2, T3>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap), arg12);
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

    fun signature_message<T0, T1>(arg0: &VaultUserConfig, arg1: &0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x2::object::id<VaultUserConfig>(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig>(arg1);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg2);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        v0
    }

    public fun swap_coin_a_then_deposit_bluefin<T0, T1, T2>(arg0: &VaultUserConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T1, T2>, arg3: &0x15d6ceabb34c99ea7c05c8c8bad904649b907102053d660ba91bde13d6f4761::bluefin_executor::BluefinExecutorConfig, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: u128, arg7: SecurePriceReceipt<T1, T2>, arg8: 0x2::coin::Coin<T0>, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T1, T2>(arg0, arg1, arg2);
        let v1 = 0x2::object::id<0x15d6ceabb34c99ea7c05c8c8bad904649b907102053d660ba91bde13d6f4761::bluefin_executor::BluefinExecutorConfig>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        let v4 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg6));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg1, v0, arg9, arg10);
        let (v5, v6, v7) = validate_final_receipt<T1, T2>(arg2, arg7, arg11);
        let v8 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let v9 = &mut arg8;
        charge_deposit_fee<T1, T2, T0>(arg1, arg2, v9, arg11, v8, arg12);
        let v10 = 0x2::coin::value<T0>(&arg8);
        assert!(v10 > 0, 6);
        let (v11, v12) = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::bluefin_adapter::internal_swap<T0, T1>(0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T1, T2>>(arg2), arg4, arg5, arg8, 0x2::coin::zero<T1>(arg12), v10, arg6, true, false, 0x2::tx_context::sender(arg12), arg11, arg12);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::deposit_with_no_fee_v2<T1, T2>(arg1, arg2, v12, 0x3647adb183782ec081a048038d45db126da265e5de8c9c30095a1b17a7ba82d8::vault_lens::calculate_net_value_vault_bluefin<T1, T2, T0, T1>(arg3, arg5, arg2, v5, v6, v7), arg11, v8, arg12);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::utils::destroy_zero_or_transfer_to_receiver<T0>(v11, 0x2::tx_context::sender(arg12), arg12);
    }

    public fun swap_coin_a_then_deposit_cetus<T0, T1, T2>(arg0: &VaultUserConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T1, T2>, arg3: &0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_executor::CetusConfig, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: u128, arg7: SecurePriceReceipt<T1, T2>, arg8: 0x2::coin::Coin<T0>, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T1, T2>(arg0, arg1, arg2);
        let v1 = 0x2::object::id<0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_executor::CetusConfig>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        let v4 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg6));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg1, v0, arg9, arg10);
        let (v5, v6, v7) = validate_final_receipt<T1, T2>(arg2, arg7, arg11);
        let v8 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let v9 = &mut arg8;
        charge_deposit_fee<T1, T2, T0>(arg1, arg2, v9, arg11, v8, arg12);
        let v10 = 0x2::coin::value<T0>(&arg8);
        assert!(v10 > 0, 6);
        let (v11, v12) = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::cetus_adapter::internal_swap<T0, T1>(0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T1, T2>>(arg2), arg4, arg5, arg8, 0x2::coin::zero<T1>(arg12), v10, arg6, true, false, 0x2::tx_context::sender(arg12), arg11, arg12);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::deposit_with_no_fee_v2<T1, T2>(arg1, arg2, v12, 0x3647adb183782ec081a048038d45db126da265e5de8c9c30095a1b17a7ba82d8::vault_lens::calculate_net_value_vault_cetus<T1, T2, T0, T1>(arg3, arg5, arg2, v5, v6, v7), arg11, v8, arg12);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::utils::destroy_zero_or_transfer_to_receiver<T0>(v11, 0x2::tx_context::sender(arg12), arg12);
    }

    public fun swap_coin_a_then_deposit_mmt<T0, T1, T2>(arg0: &VaultUserConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T1, T2>, arg3: &0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg6: u128, arg7: SecurePriceReceipt<T1, T2>, arg8: 0x2::coin::Coin<T0>, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T1, T2>(arg0, arg1, arg2);
        let v1 = 0x2::object::id<0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        let v4 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg6));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg1, v0, arg9, arg10);
        let (v5, v6, v7) = validate_final_receipt<T1, T2>(arg2, arg7, arg11);
        let v8 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let v9 = &mut arg8;
        charge_deposit_fee<T1, T2, T0>(arg1, arg2, v9, arg11, v8, arg12);
        let v10 = 0x2::coin::value<T0>(&arg8);
        assert!(v10 > 0, 6);
        let (v11, v12) = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::mmt_adapter::internal_swap<T0, T1>(0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T1, T2>>(arg2), arg5, arg4, arg8, 0x2::coin::zero<T1>(arg12), v10, arg6, true, false, 0x2::tx_context::sender(arg12), arg11, arg12);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::deposit_with_no_fee_v2<T1, T2>(arg1, arg2, v12, 0x3647adb183782ec081a048038d45db126da265e5de8c9c30095a1b17a7ba82d8::vault_lens::calculate_net_value_vault_mmt<T1, T2, T0, T1>(arg3, arg5, arg2, v5, v6, v7), arg11, v8, arg12);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::utils::destroy_zero_or_transfer_to_receiver<T0>(v11, 0x2::tx_context::sender(arg12), arg12);
    }

    public fun swap_coin_a_then_deposit_on_bluefin<T0, T1, T2, T3, T4>(arg0: &VaultUserConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T1, T2>, arg3: &0x15d6ceabb34c99ea7c05c8c8bad904649b907102053d660ba91bde13d6f4761::bluefin_executor::BluefinExecutorConfig, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T4>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg7: u128, arg8: SecurePriceReceipt<T1, T2>, arg9: 0x2::coin::Coin<T0>, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T1, T2>(arg0, arg1, arg2);
        let v1 = 0x2::object::id<0x15d6ceabb34c99ea7c05c8c8bad904649b907102053d660ba91bde13d6f4761::bluefin_executor::BluefinExecutorConfig>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T4>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        let v4 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg7));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg1, v0, arg10, arg11);
        let (v5, v6, v7) = validate_final_receipt<T1, T2>(arg2, arg8, arg12);
        let v8 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let v9 = &mut arg9;
        charge_deposit_fee<T1, T2, T0>(arg1, arg2, v9, arg12, v8, arg13);
        let v10 = 0x2::coin::value<T0>(&arg9);
        assert!(v10 > 0, 6);
        let (v11, v12) = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::bluefin_adapter::internal_swap<T0, T1>(0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T1, T2>>(arg2), arg4, arg6, arg9, 0x2::coin::zero<T1>(arg13), v10, arg7, true, false, 0x2::tx_context::sender(arg13), arg12, arg13);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::deposit_with_no_fee_v2<T1, T2>(arg1, arg2, v12, 0x3647adb183782ec081a048038d45db126da265e5de8c9c30095a1b17a7ba82d8::vault_lens::calculate_net_value_vault_bluefin<T1, T2, T3, T4>(arg3, arg5, arg2, v5, v6, v7), arg12, v8, arg13);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::utils::destroy_zero_or_transfer_to_receiver<T0>(v11, 0x2::tx_context::sender(arg13), arg13);
    }

    public fun swap_coin_a_then_deposit_on_cetus<T0, T1, T2, T3, T4>(arg0: &VaultUserConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T1, T2>, arg3: &0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_executor::CetusConfig, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T4>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: u128, arg8: SecurePriceReceipt<T1, T2>, arg9: 0x2::coin::Coin<T0>, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T1, T2>(arg0, arg1, arg2);
        let v1 = 0x2::object::id<0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_executor::CetusConfig>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T4>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        let v4 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg7));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg1, v0, arg10, arg11);
        let (v5, v6, v7) = validate_final_receipt<T1, T2>(arg2, arg8, arg12);
        let v8 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let v9 = &mut arg9;
        charge_deposit_fee<T1, T2, T0>(arg1, arg2, v9, arg12, v8, arg13);
        let v10 = 0x2::coin::value<T0>(&arg9);
        assert!(v10 > 0, 6);
        let (v11, v12) = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::cetus_adapter::internal_swap<T0, T1>(0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T1, T2>>(arg2), arg4, arg6, arg9, 0x2::coin::zero<T1>(arg13), v10, arg7, true, false, 0x2::tx_context::sender(arg13), arg12, arg13);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::deposit_with_no_fee_v2<T1, T2>(arg1, arg2, v12, 0x3647adb183782ec081a048038d45db126da265e5de8c9c30095a1b17a7ba82d8::vault_lens::calculate_net_value_vault_cetus<T1, T2, T3, T4>(arg3, arg5, arg2, v5, v6, v7), arg12, v8, arg13);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::utils::destroy_zero_or_transfer_to_receiver<T0>(v11, 0x2::tx_context::sender(arg13), arg13);
    }

    public fun swap_coin_a_then_deposit_on_mmt<T0, T1, T2, T3, T4>(arg0: &VaultUserConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T1, T2>, arg3: &0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T4>, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg7: u128, arg8: SecurePriceReceipt<T1, T2>, arg9: 0x2::coin::Coin<T0>, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T1, T2>(arg0, arg1, arg2);
        let v1 = 0x2::object::id<0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T4>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        let v4 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg7));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg1, v0, arg10, arg11);
        let (v5, v6, v7) = validate_final_receipt<T1, T2>(arg2, arg8, arg12);
        let v8 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let v9 = &mut arg9;
        charge_deposit_fee<T1, T2, T0>(arg1, arg2, v9, arg12, v8, arg13);
        let v10 = 0x2::coin::value<T0>(&arg9);
        assert!(v10 > 0, 6);
        let (v11, v12) = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::mmt_adapter::internal_swap<T0, T1>(0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T1, T2>>(arg2), arg6, arg4, arg9, 0x2::coin::zero<T1>(arg13), v10, arg7, true, false, 0x2::tx_context::sender(arg13), arg12, arg13);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::deposit_with_no_fee_v2<T1, T2>(arg1, arg2, v12, 0x3647adb183782ec081a048038d45db126da265e5de8c9c30095a1b17a7ba82d8::vault_lens::calculate_net_value_vault_mmt<T1, T2, T3, T4>(arg3, arg5, arg2, v5, v6, v7), arg12, v8, arg13);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::utils::destroy_zero_or_transfer_to_receiver<T0>(v11, 0x2::tx_context::sender(arg13), arg13);
    }

    public fun swap_coin_b_then_deposit_bluefin<T0, T1, T2>(arg0: &VaultUserConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T1, T2>, arg3: &0x15d6ceabb34c99ea7c05c8c8bad904649b907102053d660ba91bde13d6f4761::bluefin_executor::BluefinExecutorConfig, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg6: u128, arg7: SecurePriceReceipt<T1, T2>, arg8: 0x2::coin::Coin<T0>, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T1, T2>(arg0, arg1, arg2);
        let v1 = 0x2::object::id<0x15d6ceabb34c99ea7c05c8c8bad904649b907102053d660ba91bde13d6f4761::bluefin_executor::BluefinExecutorConfig>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        let v4 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg6));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg1, v0, arg9, arg10);
        let (v5, v6, v7) = validate_final_receipt<T1, T2>(arg2, arg7, arg11);
        let v8 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let v9 = &mut arg8;
        charge_deposit_fee<T1, T2, T0>(arg1, arg2, v9, arg11, v8, arg12);
        let v10 = 0x2::coin::value<T0>(&arg8);
        assert!(v10 > 0, 6);
        let (v11, v12) = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::bluefin_adapter::internal_swap<T1, T0>(0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T1, T2>>(arg2), arg4, arg5, 0x2::coin::zero<T1>(arg12), arg8, v10, arg6, false, false, 0x2::tx_context::sender(arg12), arg11, arg12);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::deposit_with_no_fee_v2<T1, T2>(arg1, arg2, v11, 0x3647adb183782ec081a048038d45db126da265e5de8c9c30095a1b17a7ba82d8::vault_lens::calculate_net_value_vault_bluefin<T1, T2, T1, T0>(arg3, arg5, arg2, v5, v6, v7), arg11, v8, arg12);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::utils::destroy_zero_or_transfer_to_receiver<T0>(v12, 0x2::tx_context::sender(arg12), arg12);
    }

    public fun swap_coin_b_then_deposit_cetus<T0, T1, T2>(arg0: &VaultUserConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T1, T2>, arg3: &0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_executor::CetusConfig, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg6: u128, arg7: SecurePriceReceipt<T1, T2>, arg8: 0x2::coin::Coin<T0>, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T1, T2>(arg0, arg1, arg2);
        let v1 = 0x2::object::id<0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_executor::CetusConfig>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        let v4 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg6));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg1, v0, arg9, arg10);
        let (v5, v6, v7) = validate_final_receipt<T1, T2>(arg2, arg7, arg11);
        let v8 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let v9 = &mut arg8;
        charge_deposit_fee<T1, T2, T0>(arg1, arg2, v9, arg11, v8, arg12);
        let v10 = 0x2::coin::value<T0>(&arg8);
        assert!(v10 > 0, 6);
        let (v11, v12) = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::cetus_adapter::internal_swap<T1, T0>(0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T1, T2>>(arg2), arg4, arg5, 0x2::coin::zero<T1>(arg12), arg8, v10, arg6, false, false, 0x2::tx_context::sender(arg12), arg11, arg12);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::deposit_with_no_fee_v2<T1, T2>(arg1, arg2, v11, 0x3647adb183782ec081a048038d45db126da265e5de8c9c30095a1b17a7ba82d8::vault_lens::calculate_net_value_vault_cetus<T1, T2, T1, T0>(arg3, arg5, arg2, v5, v6, v7), arg11, v8, arg12);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::utils::destroy_zero_or_transfer_to_receiver<T0>(v12, 0x2::tx_context::sender(arg12), arg12);
    }

    public fun swap_coin_b_then_deposit_mmt<T0, T1, T2>(arg0: &VaultUserConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T1, T2>, arg3: &0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg6: u128, arg7: SecurePriceReceipt<T1, T2>, arg8: 0x2::coin::Coin<T0>, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T1, T2>(arg0, arg1, arg2);
        let v1 = 0x2::object::id<0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        let v4 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg6));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg1, v0, arg9, arg10);
        let (v5, v6, v7) = validate_final_receipt<T1, T2>(arg2, arg7, arg11);
        let v8 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let v9 = &mut arg8;
        charge_deposit_fee<T1, T2, T0>(arg1, arg2, v9, arg11, v8, arg12);
        let v10 = 0x2::coin::value<T0>(&arg8);
        assert!(v10 > 0, 6);
        let (v11, v12) = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::mmt_adapter::internal_swap<T1, T0>(0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T1, T2>>(arg2), arg5, arg4, 0x2::coin::zero<T1>(arg12), arg8, v10, arg6, false, false, 0x2::tx_context::sender(arg12), arg11, arg12);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::deposit_with_no_fee_v2<T1, T2>(arg1, arg2, v11, 0x3647adb183782ec081a048038d45db126da265e5de8c9c30095a1b17a7ba82d8::vault_lens::calculate_net_value_vault_mmt<T1, T2, T1, T0>(arg3, arg5, arg2, v5, v6, v7), arg11, v8, arg12);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::utils::destroy_zero_or_transfer_to_receiver<T0>(v12, 0x2::tx_context::sender(arg12), arg12);
    }

    public fun swap_coin_b_then_deposit_on_bluefin<T0, T1, T2, T3, T4>(arg0: &VaultUserConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T1, T2>, arg3: &0x15d6ceabb34c99ea7c05c8c8bad904649b907102053d660ba91bde13d6f4761::bluefin_executor::BluefinExecutorConfig, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T4>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg7: u128, arg8: SecurePriceReceipt<T1, T2>, arg9: 0x2::coin::Coin<T0>, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T1, T2>(arg0, arg1, arg2);
        let v1 = 0x2::object::id<0x15d6ceabb34c99ea7c05c8c8bad904649b907102053d660ba91bde13d6f4761::bluefin_executor::BluefinExecutorConfig>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T4>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        let v4 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg7));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg1, v0, arg10, arg11);
        let (v5, v6, v7) = validate_final_receipt<T1, T2>(arg2, arg8, arg12);
        let v8 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let v9 = &mut arg9;
        charge_deposit_fee<T1, T2, T0>(arg1, arg2, v9, arg12, v8, arg13);
        let v10 = 0x2::coin::value<T0>(&arg9);
        assert!(v10 > 0, 6);
        let (v11, v12) = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::bluefin_adapter::internal_swap<T1, T0>(0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T1, T2>>(arg2), arg4, arg6, 0x2::coin::zero<T1>(arg13), arg9, v10, arg7, false, false, 0x2::tx_context::sender(arg13), arg12, arg13);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::deposit_with_no_fee_v2<T1, T2>(arg1, arg2, v11, 0x3647adb183782ec081a048038d45db126da265e5de8c9c30095a1b17a7ba82d8::vault_lens::calculate_net_value_vault_bluefin<T1, T2, T3, T4>(arg3, arg5, arg2, v5, v6, v7), arg12, v8, arg13);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::utils::destroy_zero_or_transfer_to_receiver<T0>(v12, 0x2::tx_context::sender(arg13), arg13);
    }

    public fun swap_coin_b_then_deposit_on_cetus<T0, T1, T2, T3, T4>(arg0: &VaultUserConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T1, T2>, arg3: &0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_executor::CetusConfig, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T4>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg7: u128, arg8: SecurePriceReceipt<T1, T2>, arg9: 0x2::coin::Coin<T0>, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T1, T2>(arg0, arg1, arg2);
        let v1 = 0x2::object::id<0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_executor::CetusConfig>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T4>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        let v4 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg7));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg1, v0, arg10, arg11);
        let (v5, v6, v7) = validate_final_receipt<T1, T2>(arg2, arg8, arg12);
        let v8 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let v9 = &mut arg9;
        charge_deposit_fee<T1, T2, T0>(arg1, arg2, v9, arg12, v8, arg13);
        let v10 = 0x2::coin::value<T0>(&arg9);
        assert!(v10 > 0, 6);
        let (v11, v12) = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::cetus_adapter::internal_swap<T1, T0>(0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T1, T2>>(arg2), arg4, arg6, 0x2::coin::zero<T1>(arg13), arg9, v10, arg7, false, false, 0x2::tx_context::sender(arg13), arg12, arg13);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::deposit_with_no_fee_v2<T1, T2>(arg1, arg2, v11, 0x3647adb183782ec081a048038d45db126da265e5de8c9c30095a1b17a7ba82d8::vault_lens::calculate_net_value_vault_cetus<T1, T2, T3, T4>(arg3, arg5, arg2, v5, v6, v7), arg12, v8, arg13);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::utils::destroy_zero_or_transfer_to_receiver<T0>(v12, 0x2::tx_context::sender(arg13), arg13);
    }

    public fun swap_coin_b_then_deposit_on_mmt<T0, T1, T2, T3, T4>(arg0: &VaultUserConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T1, T2>, arg3: &0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T4>, arg6: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg7: u128, arg8: SecurePriceReceipt<T1, T2>, arg9: 0x2::coin::Coin<T0>, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T1, T2>(arg0, arg1, arg2);
        let v1 = 0x2::object::id<0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T3, T4>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        let v4 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>>(arg6);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg7));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg1, v0, arg10, arg11);
        let (v5, v6, v7) = validate_final_receipt<T1, T2>(arg2, arg8, arg12);
        let v8 = 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap);
        let v9 = &mut arg9;
        charge_deposit_fee<T1, T2, T0>(arg1, arg2, v9, arg12, v8, arg13);
        let v10 = 0x2::coin::value<T0>(&arg9);
        assert!(v10 > 0, 6);
        let (v11, v12) = 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::mmt_adapter::internal_swap<T1, T0>(0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T1, T2>>(arg2), arg6, arg4, 0x2::coin::zero<T1>(arg13), arg9, v10, arg7, false, false, 0x2::tx_context::sender(arg13), arg12, arg13);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::deposit_with_no_fee_v2<T1, T2>(arg1, arg2, v11, 0x3647adb183782ec081a048038d45db126da265e5de8c9c30095a1b17a7ba82d8::vault_lens::calculate_net_value_vault_mmt<T1, T2, T3, T4>(arg3, arg5, arg2, v5, v6, v7), arg12, v8, arg13);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::utils::destroy_zero_or_transfer_to_receiver<T0>(v12, 0x2::tx_context::sender(arg13), arg13);
    }

    public fun update_rate_bluefin<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg3: &0x15d6ceabb34c99ea7c05c8c8bad904649b907102053d660ba91bde13d6f4761::bluefin_executor::BluefinExecutorConfig, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: SecurePriceReceipt<T0, T1>, arg6: vector<vector<u8>>, arg7: vector<vector<u8>>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        assert!(check_operator(arg0, 0x2::tx_context::sender(arg9)), 3);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2);
        let v1 = 0x2::object::id<0x15d6ceabb34c99ea7c05c8c8bad904649b907102053d660ba91bde13d6f4761::bluefin_executor::BluefinExecutorConfig>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg1, v0, arg6, arg7);
        let (v3, v4, v5) = validate_final_receipt<T0, T1>(arg2, arg5, arg8);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::update_rate_v2<T0, T1>(arg1, arg2, 0x3647adb183782ec081a048038d45db126da265e5de8c9c30095a1b17a7ba82d8::vault_lens::calculate_net_value_vault_bluefin<T0, T1, T2, T3>(arg3, arg4, arg2, v3, v4, v5), arg8, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap), arg9);
    }

    public fun update_rate_cetus<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg3: &0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_executor::CetusConfig, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: SecurePriceReceipt<T0, T1>, arg6: vector<vector<u8>>, arg7: vector<vector<u8>>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        assert!(check_operator(arg0, 0x2::tx_context::sender(arg9)), 3);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2);
        let v1 = 0x2::object::id<0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_executor::CetusConfig>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg1, v0, arg6, arg7);
        let (v3, v4, v5) = validate_final_receipt<T0, T1>(arg2, arg5, arg8);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::update_rate_v2<T0, T1>(arg1, arg2, 0x3647adb183782ec081a048038d45db126da265e5de8c9c30095a1b17a7ba82d8::vault_lens::calculate_net_value_vault_cetus<T0, T1, T2, T3>(arg3, arg4, arg2, v3, v4, v5), arg8, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap), arg9);
    }

    public fun update_rate_mmt<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg3: &0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: SecurePriceReceipt<T0, T1>, arg6: vector<vector<u8>>, arg7: vector<vector<u8>>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        assert!(check_operator(arg0, 0x2::tx_context::sender(arg9)), 3);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2);
        let v1 = 0x2::object::id<0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg1, v0, arg6, arg7);
        let (v3, v4, v5) = validate_final_receipt<T0, T1>(arg2, arg5, arg8);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::update_rate_v2<T0, T1>(arg1, arg2, 0x3647adb183782ec081a048038d45db126da265e5de8c9c30095a1b17a7ba82d8::vault_lens::calculate_net_value_vault_mmt<T0, T1, T2, T3>(arg3, arg4, arg2, v3, v4, v5), arg8, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap), arg9);
    }

    public fun user_deposit_and_add_liquidity_bluefin<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg3: &mut 0x15d6ceabb34c99ea7c05c8c8bad904649b907102053d660ba91bde13d6f4761::bluefin_executor::BluefinExecutorConfig, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg6: u128, arg7: u32, arg8: u32, arg9: SecurePriceReceipt<T0, T1>, arg10: 0x2::coin::Coin<T2>, arg11: 0x2::coin::Coin<T3>, arg12: vector<vector<u8>>, arg13: vector<vector<u8>>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2);
        let v1 = 0x2::object::id<0x15d6ceabb34c99ea7c05c8c8bad904649b907102053d660ba91bde13d6f4761::bluefin_executor::BluefinExecutorConfig>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg6));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u32>(&arg7));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u32>(&arg8));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg1, v0, arg12, arg13);
        let (v4, v5, v6) = validate_final_receipt<T0, T1>(arg2, arg9, arg14);
        let (v7, v8, v9) = 0x15d6ceabb34c99ea7c05c8c8bad904649b907102053d660ba91bde13d6f4761::bluefin_composer::user_add_liquidity_v2<T0, T1, T2, T3>(arg3, arg4, arg5, arg2, arg1, v4, v5, v6, arg10, arg11, arg6, arg7, arg8, arg14, arg15);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::deposit_dual_token_v2<T0, T1>(arg1, arg2, v7, 0x3647adb183782ec081a048038d45db126da265e5de8c9c30095a1b17a7ba82d8::vault_lens::calculate_net_value_vault_bluefin<T0, T1, T2, T3>(arg3, arg5, arg2, v4, v5, v6), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T3>()), v8, v9, arg14, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap), arg15);
    }

    public fun user_deposit_and_add_liquidity_cetus<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg3: &mut 0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_executor::CetusConfig, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg6: u128, arg7: u32, arg8: u32, arg9: SecurePriceReceipt<T0, T1>, arg10: 0x2::coin::Coin<T2>, arg11: 0x2::coin::Coin<T3>, arg12: vector<vector<u8>>, arg13: vector<vector<u8>>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2);
        let v1 = 0x2::object::id<0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_executor::CetusConfig>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg6));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u32>(&arg7));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u32>(&arg8));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg1, v0, arg12, arg13);
        let (v4, v5, v6) = validate_final_receipt<T0, T1>(arg2, arg9, arg14);
        let (v7, v8, v9) = 0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_composer::user_add_liquidity_v2<T0, T1, T2, T3>(arg3, arg4, arg5, arg2, arg1, v4, v5, v6, arg10, arg11, arg6, arg7, arg8, arg14, arg15);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::deposit_dual_token_v2<T0, T1>(arg1, arg2, v7, 0x3647adb183782ec081a048038d45db126da265e5de8c9c30095a1b17a7ba82d8::vault_lens::calculate_net_value_vault_cetus<T0, T1, T2, T3>(arg3, arg5, arg2, v4, v5, v6), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T3>()), v8, v9, arg14, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap), arg15);
    }

    public fun user_deposit_and_add_liquidity_mmt<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg3: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg6: u128, arg7: u32, arg8: u32, arg9: SecurePriceReceipt<T0, T1>, arg10: 0x2::coin::Coin<T2>, arg11: 0x2::coin::Coin<T3>, arg12: vector<vector<u8>>, arg13: vector<vector<u8>>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2);
        let v1 = 0x2::object::id<0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg6));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u32>(&arg7));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u32>(&arg8));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg1, v0, arg12, arg13);
        let (v4, v5, v6) = validate_final_receipt<T0, T1>(arg2, arg9, arg14);
        let (v7, v8, v9) = 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_composer::user_add_liquidity_v2<T0, T1, T2, T3>(arg3, arg4, arg5, arg2, arg1, v4, v5, v6, arg10, arg11, arg6, arg7, arg8, arg14, arg15);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::deposit_dual_token_v2<T0, T1>(arg1, arg2, v7, 0x3647adb183782ec081a048038d45db126da265e5de8c9c30095a1b17a7ba82d8::vault_lens::calculate_net_value_vault_mmt<T0, T1, T2, T3>(arg3, arg5, arg2, v4, v5, v6), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T3>()), v8, v9, arg14, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap), arg15);
    }

    public fun user_deposit_then_add_liquidity_bluefin<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg3: &mut 0x15d6ceabb34c99ea7c05c8c8bad904649b907102053d660ba91bde13d6f4761::bluefin_executor::BluefinExecutorConfig, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg6: u128, arg7: SecurePriceReceipt<T0, T1>, arg8: 0x2::coin::Coin<T2>, arg9: 0x2::coin::Coin<T3>, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2);
        let v1 = 0x2::object::id<0x15d6ceabb34c99ea7c05c8c8bad904649b907102053d660ba91bde13d6f4761::bluefin_executor::BluefinExecutorConfig>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg6));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg1, v0, arg10, arg11);
        let (v4, v5, v6) = validate_final_receipt<T0, T1>(arg2, arg7, arg12);
        let (v7, v8, v9) = 0x15d6ceabb34c99ea7c05c8c8bad904649b907102053d660ba91bde13d6f4761::bluefin_composer::user_add_liquidity_new_v2<T0, T1, T2, T3>(arg3, arg4, arg5, arg2, arg1, v4, v5, v6, arg8, arg9, arg6, arg12, arg13);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::deposit_dual_token_v2<T0, T1>(arg1, arg2, v7, 0x3647adb183782ec081a048038d45db126da265e5de8c9c30095a1b17a7ba82d8::vault_lens::calculate_net_value_vault_bluefin<T0, T1, T2, T3>(arg3, arg5, arg2, v4, v5, v6), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T3>()), v8, v9, arg12, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap), arg13);
        abort 0
    }

    public fun user_deposit_then_add_liquidity_cetus<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg3: &mut 0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_executor::CetusConfig, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg6: u128, arg7: SecurePriceReceipt<T0, T1>, arg8: 0x2::coin::Coin<T2>, arg9: 0x2::coin::Coin<T3>, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2);
        let v1 = 0x2::object::id<0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_executor::CetusConfig>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg6));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg1, v0, arg10, arg11);
        let (v4, v5, v6) = validate_final_receipt<T0, T1>(arg2, arg7, arg12);
        let (v7, v8, v9) = 0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_composer::user_add_liquidity_new_v2<T0, T1, T2, T3>(arg3, arg4, arg5, arg2, arg1, v4, v5, v6, arg8, arg9, arg6, arg12, arg13);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::deposit_dual_token_v2<T0, T1>(arg1, arg2, v7, 0x3647adb183782ec081a048038d45db126da265e5de8c9c30095a1b17a7ba82d8::vault_lens::calculate_net_value_vault_cetus<T0, T1, T2, T3>(arg3, arg5, arg2, v4, v5, v6), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T3>()), v8, v9, arg12, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap), arg13);
        abort 0
    }

    public fun user_deposit_then_add_liquidity_mmt<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg3: &mut 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg6: u128, arg7: SecurePriceReceipt<T0, T1>, arg8: 0x2::coin::Coin<T2>, arg9: 0x2::coin::Coin<T3>, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2);
        let v1 = 0x2::object::id<0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        let v3 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg5);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u128>(&arg6));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg1, v0, arg10, arg11);
        let (v4, v5, v6) = validate_final_receipt<T0, T1>(arg2, arg7, arg12);
        let (v7, v8, v9) = 0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_composer::user_add_liquidity_new_v2<T0, T1, T2, T3>(arg3, arg4, arg5, arg2, arg1, v4, v5, v6, arg8, arg9, arg6, arg12, arg13);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::deposit_dual_token_v2<T0, T1>(arg1, arg2, v7, 0x3647adb183782ec081a048038d45db126da265e5de8c9c30095a1b17a7ba82d8::vault_lens::calculate_net_value_vault_mmt<T0, T1, T2, T3>(arg3, arg5, arg2, v4, v5, v6), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()), 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T3>()), v8, v9, arg12, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap), arg13);
        abort 0
    }

    fun validate_final_receipt<T0, T1>(arg0: &0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg1: SecurePriceReceipt<T0, T1>, arg2: &0x2::clock::Clock) : (vector<0x1::ascii::String>, vector<u64>, vector<u64>) {
        let SecurePriceReceipt {
            vault_id      : v0,
            tokens        : v1,
            price_ids     : v2,
            coin_decimals : v3,
            prices        : v4,
            vec_time_ts   : v5,
        } = arg1;
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let v9 = v2;
        let v10 = v1;
        assert!(0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg0) == v0, 8);
        let v11 = 0x1::vector::length<0x1::ascii::String>(&v10);
        assert!(0x1::vector::length<0x2::object::ID>(&v9) == v11, 13);
        assert!(0x1::vector::length<u64>(&v8) == v11, 12);
        assert!(0x1::vector::length<u64>(&v7) == v11, 14);
        assert!(0x1::vector::length<u64>(&v6) == v11, 15);
        let v12 = SecurePriceCompleted{
            vault_id      : 0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg0),
            tokens        : v10,
            price_ids     : v9,
            coin_decimals : v8,
            prices        : v7,
            vec_time_ts   : v6,
            timestamp     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<SecurePriceCompleted>(v12);
        (v10, v8, v7)
    }

    fun validate_updated_receipt<T0, T1, T2>(arg0: &0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg1: SecurePriceReceipt<T0, T1>) : (vector<0x1::ascii::String>, vector<0x2::object::ID>, vector<u64>, vector<u64>, vector<u64>) {
        let SecurePriceReceipt {
            vault_id      : v0,
            tokens        : v1,
            price_ids     : v2,
            coin_decimals : v3,
            prices        : v4,
            vec_time_ts   : v5,
        } = arg1;
        let v6 = v1;
        assert!(0x2::object::id<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>>(arg0) == v0, 8);
        let v7 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>());
        let v8 = 0;
        while (v8 < 0x1::vector::length<0x1::ascii::String>(&v6)) {
            assert!(&v7 != 0x1::vector::borrow<0x1::ascii::String>(&v6, v8), 7);
            v8 = v8 + 1;
        };
        (v6, v2, v3, v4, v5)
    }

    fun verify_signature_price<T0, T1, T2>(arg0: &VaultUserConfig, arg1: &0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: vector<u8>, arg5: u64, arg6: vector<vector<u8>>, arg7: vector<vector<u8>>) : bool {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>());
        let v1 = signature_message<T0, T1>(arg0, arg1, arg2);
        let v2 = 0x2::object::id<0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig>(arg3);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::ascii::String>(&v0));
        0x1::vector::append<u8>(&mut v1, arg4);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg5));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg1, v1, arg6, arg7)
    }

    public fun withdraw_dual_vault_bluefin<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg3: &0x15d6ceabb34c99ea7c05c8c8bad904649b907102053d660ba91bde13d6f4761::bluefin_executor::BluefinExecutorConfig, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: SecurePriceReceipt<T0, T1>, arg6: 0x2::coin::Coin<T1>, arg7: vector<vector<u8>>, arg8: vector<vector<u8>>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2);
        let v1 = 0x2::object::id<0x15d6ceabb34c99ea7c05c8c8bad904649b907102053d660ba91bde13d6f4761::bluefin_executor::BluefinExecutorConfig>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg1, v0, arg7, arg8);
        let (v3, v4, v5) = validate_final_receipt<T0, T1>(arg2, arg5, arg9);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::withdraw_dual_token_v2<T0, T1, T2, T3>(arg1, arg2, arg6, 0x3647adb183782ec081a048038d45db126da265e5de8c9c30095a1b17a7ba82d8::vault_lens::calculate_net_value_vault_bluefin<T0, T1, T2, T3>(arg3, arg4, arg2, v3, v4, v5), v3, v4, v5, arg9, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap), arg10);
    }

    public fun withdraw_dual_vault_cetus<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg3: &0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_executor::CetusConfig, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: SecurePriceReceipt<T0, T1>, arg6: 0x2::coin::Coin<T1>, arg7: vector<vector<u8>>, arg8: vector<vector<u8>>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2);
        let v1 = 0x2::object::id<0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_executor::CetusConfig>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg1, v0, arg7, arg8);
        let (v3, v4, v5) = validate_final_receipt<T0, T1>(arg2, arg5, arg9);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::withdraw_dual_token_v2<T0, T1, T2, T3>(arg1, arg2, arg6, 0x3647adb183782ec081a048038d45db126da265e5de8c9c30095a1b17a7ba82d8::vault_lens::calculate_net_value_vault_cetus<T0, T1, T2, T3>(arg3, arg4, arg2, v3, v4, v5), v3, v4, v5, arg9, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap), arg10);
    }

    public fun withdraw_dual_vault_mmt<T0, T1, T2, T3>(arg0: &VaultUserConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg3: &0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: SecurePriceReceipt<T0, T1>, arg6: 0x2::coin::Coin<T1>, arg7: vector<vector<u8>>, arg8: vector<vector<u8>>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2);
        let v1 = 0x2::object::id<0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg1, v0, arg7, arg8);
        let (v3, v4, v5) = validate_final_receipt<T0, T1>(arg2, arg5, arg9);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::withdraw_dual_token_v2<T0, T1, T2, T3>(arg1, arg2, arg6, 0x3647adb183782ec081a048038d45db126da265e5de8c9c30095a1b17a7ba82d8::vault_lens::calculate_net_value_vault_mmt<T0, T1, T2, T3>(arg3, arg4, arg2, v3, v4, v5), v3, v4, v5, arg9, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap), arg10);
    }

    public fun withdraw_vault_bluefin<T0, T1, T2, T3, T4>(arg0: &VaultUserConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg3: &0x15d6ceabb34c99ea7c05c8c8bad904649b907102053d660ba91bde13d6f4761::bluefin_executor::BluefinExecutorConfig, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg5: SecurePriceReceipt<T0, T1>, arg6: 0x2::coin::Coin<T1>, arg7: vector<vector<u8>>, arg8: vector<vector<u8>>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2);
        let v1 = 0x2::object::id<0x15d6ceabb34c99ea7c05c8c8bad904649b907102053d660ba91bde13d6f4761::bluefin_executor::BluefinExecutorConfig>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg1, v0, arg7, arg8);
        let (v3, v4, v5) = validate_final_receipt<T0, T1>(arg2, arg5, arg9);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::withdraw_token_v2<T0, T1, T4>(arg1, arg2, arg6, 0x3647adb183782ec081a048038d45db126da265e5de8c9c30095a1b17a7ba82d8::vault_lens::calculate_net_value_vault_bluefin<T0, T1, T2, T3>(arg3, arg4, arg2, v3, v4, v5), v3, v4, v5, arg9, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap), arg10);
    }

    public fun withdraw_vault_cetus<T0, T1, T2, T3, T4>(arg0: &VaultUserConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg3: &0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_executor::CetusConfig, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: SecurePriceReceipt<T0, T1>, arg6: 0x2::coin::Coin<T1>, arg7: vector<vector<u8>>, arg8: vector<vector<u8>>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2);
        let v1 = 0x2::object::id<0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_executor::CetusConfig>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg1, v0, arg7, arg8);
        let (v3, v4, v5) = validate_final_receipt<T0, T1>(arg2, arg5, arg9);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::withdraw_token_v2<T0, T1, T4>(arg1, arg2, arg6, 0x3647adb183782ec081a048038d45db126da265e5de8c9c30095a1b17a7ba82d8::vault_lens::calculate_net_value_vault_cetus<T0, T1, T2, T3>(arg3, arg4, arg2, v3, v4, v5), v3, v4, v5, arg9, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap), arg10);
    }

    public fun withdraw_vault_mmt<T0, T1, T2, T3, T4>(arg0: &VaultUserConfig, arg1: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::VaultConfig, arg2: &mut 0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>, arg3: &0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg5: SecurePriceReceipt<T0, T1>, arg6: 0x2::coin::Coin<T1>, arg7: vector<vector<u8>>, arg8: vector<vector<u8>>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(arg0.enable, 4);
        let v0 = signature_message<T0, T1>(arg0, arg1, arg2);
        let v1 = 0x2::object::id<0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig>(arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::verify_signature(arg1, v0, arg7, arg8);
        let (v3, v4, v5) = validate_final_receipt<T0, T1>(arg2, arg5, arg9);
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::withdraw_token_v2<T0, T1, T4>(arg1, arg2, arg6, 0x3647adb183782ec081a048038d45db126da265e5de8c9c30095a1b17a7ba82d8::vault_lens::calculate_net_value_vault_mmt<T0, T1, T2, T3>(arg3, arg4, arg2, v3, v4, v5), v3, v4, v5, arg9, 0x1::option::borrow<0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::AccessCap>(&arg0.access_cap), arg10);
    }

    // decompiled from Move bytecode v6
}

