module 0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::vault {
    struct RebalanceToCex has copy, drop {
        operator: address,
        amount: u64,
        to_address: address,
        token: 0x1::type_name::TypeName,
    }

    struct BuyToAlphaEvent has copy, drop {
        order_id: u256,
        from_token: 0x1::type_name::TypeName,
        from_amount: u64,
        to_token: 0x1::type_name::TypeName,
        to_amount: u64,
        account_id: u256,
        cloud_wallet: address,
    }

    struct SellToSelfFromAlpha has copy, drop {
        order_id: u256,
        from_token: 0x1::type_name::TypeName,
        from_amount: u64,
        to_token: 0x1::type_name::TypeName,
        to_amount: u64,
        withdraw_id: u256,
        cloud_wallet: address,
    }

    struct Swaping {
        order_id: u256,
        account_id: u256,
        withdraw_id: u256,
        checksum: vector<u8>,
        from_coin_type: 0x1::type_name::TypeName,
        total_from_amount: u64,
        remaining_from_amount: u64,
        to_coin_type: 0x1::type_name::TypeName,
        accumulated_to_amount: u64,
        min_to_amount: u64,
        middle_coin_type: 0x1::type_name::TypeName,
        middle_amount: u64,
    }

    public fun after_swap<T0>(arg0: &mut 0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::vault_config::VaultConfig, arg1: &mut 0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::vault_config::VaultTokenHolder, arg2: &0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet_config::CloudWalletConfig, arg3: &mut 0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet_config::CloudWalletTokenHolder, arg4: 0x2::coin::Coin<T0>, arg5: Swaping, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        let Swaping {
            order_id              : v0,
            account_id            : v1,
            withdraw_id           : v2,
            checksum              : v3,
            from_coin_type        : v4,
            total_from_amount     : v5,
            remaining_from_amount : v6,
            to_coin_type          : v7,
            accumulated_to_amount : v8,
            min_to_amount         : v9,
            middle_coin_type      : _,
            middle_amount         : v11,
        } = arg5;
        assert!(v7 == 0x1::type_name::get<T0>(), 30003);
        assert!(v6 == 0, 30004);
        let v12 = 0x2::coin::value<T0>(&arg4);
        assert!(v8 == v12, 30005);
        assert!(v12 >= v9, 30001);
        assert!(v11 == 0, 30006);
        0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::vault_config::mark_order_id_used(arg0, v0);
        let v13 = 0x2::object::id<0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet_config::CloudWalletTokenHolder>(arg3);
        if (v2 == 0) {
            let v14 = BuyToAlphaEvent{
                order_id     : v0,
                from_token   : v4,
                from_amount  : v5,
                to_token     : v7,
                to_amount    : v12,
                account_id   : v1,
                cloud_wallet : 0x2::object::id_to_address(&v13),
            };
            0x2::event::emit<BuyToAlphaEvent>(v14);
            0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet::deposit<T0>(arg2, arg3, 0x2::coin::into_balance<T0>(arg4), v0, v1, v3, arg6);
        } else {
            let v15 = SellToSelfFromAlpha{
                order_id     : v0,
                from_token   : v4,
                from_amount  : v5,
                to_token     : v7,
                to_amount    : v12,
                withdraw_id  : v2,
                cloud_wallet : 0x2::object::id_to_address(&v13),
            };
            0x2::event::emit<SellToSelfFromAlpha>(v15);
            0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::vault_config::deposit_token_from_vault<T0>(arg1, arg4);
        };
        v12
    }

    public fun before_buy<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::vault_config::VaultConfig, arg2: &mut 0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::vault_config::VaultTokenHolder, arg3: u64, arg4: u64, arg5: u256, arg6: u256, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Swaping) {
        swap_check<T0>(arg0, arg1, arg7, arg3, arg5, arg8);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = Swaping{
            order_id              : arg5,
            account_id            : arg6,
            withdraw_id           : 0,
            checksum              : get_checksum<T0>(arg3, arg7),
            from_coin_type        : v0,
            total_from_amount     : arg3,
            remaining_from_amount : arg3,
            to_coin_type          : 0x1::type_name::get<T1>(),
            accumulated_to_amount : 0,
            min_to_amount         : arg4,
            middle_coin_type      : v0,
            middle_amount         : 0,
        };
        (0x2::coin::from_balance<T0>(0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::vault_config::get_token_to_vault<T0>(arg2, arg3), arg8), v1)
    }

    public fun before_sell<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::vault_config::VaultConfig, arg2: &mut 0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::vault_config::VaultTokenHolder, arg3: &mut 0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet_config::CloudWalletConfig, arg4: &mut 0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet_config::CloudWalletTokenHolder, arg5: u64, arg6: u64, arg7: u256, arg8: u256, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Swaping) {
        swap_check<T1>(arg0, arg1, arg9, 0, arg7, arg11);
        let v0 = 0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::vault_config::borrow_withdraw_cap(arg2);
        assert!(arg8 > 0, 30011);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = Swaping{
            order_id              : arg7,
            account_id            : 0,
            withdraw_id           : arg8,
            checksum              : get_checksum<T0>(arg5, arg9),
            from_coin_type        : v1,
            total_from_amount     : arg5,
            remaining_from_amount : arg5,
            to_coin_type          : 0x1::type_name::get<T1>(),
            accumulated_to_amount : 0,
            min_to_amount         : arg6,
            middle_coin_type      : v1,
            middle_amount         : 0,
        };
        (0x2::coin::from_balance<T0>(0xb6c020c2097c1dade1a652a2af4f340c6a8e57755c253e902235921233421fb2::cloud_wallet::quick_withdraw<T0>(v0, arg3, arg4, arg0, arg8, arg5, arg10), arg11), v2)
    }

    public fun bluefin_swap_a2b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: Swaping, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, Swaping) {
        let v0 = 0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::bluefin::swap_a2b<T0, T1>(arg1, arg2, arg3, arg0, arg5);
        let v1 = &mut arg4;
        update_swaping<T0, T1>(v1, 0x2::coin::value<T0>(&arg3), 0x2::coin::value<T1>(&v0));
        (v0, arg4)
    }

    public fun bluefin_swap_b2a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: Swaping, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Swaping) {
        let v0 = 0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::bluefin::swap_b2a<T0, T1>(arg1, arg2, arg3, arg0, arg5);
        let v1 = &mut arg4;
        update_swaping<T1, T0>(v1, 0x2::coin::value<T1>(&arg3), 0x2::coin::value<T0>(&v0));
        (v0, arg4)
    }

    public fun cetus_swap_a2b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: Swaping, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, Swaping) {
        let v0 = 0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::cetus::swap_a2b<T0, T1>(arg1, arg3, arg2, arg4, arg0, arg6);
        let v1 = &mut arg5;
        update_swaping<T0, T1>(v1, 0x2::coin::value<T0>(&arg4), 0x2::coin::value<T1>(&v0));
        (v0, arg5)
    }

    public fun cetus_swap_b2a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T1>, arg5: Swaping, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Swaping) {
        let v0 = 0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::cetus::swap_b2a<T0, T1>(arg1, arg3, arg2, arg4, arg0, arg6);
        let v1 = &mut arg5;
        update_swaping<T1, T0>(v1, 0x2::coin::value<T1>(&arg4), 0x2::coin::value<T0>(&v0));
        (v0, arg5)
    }

    public fun credit_coin<T0>(arg0: &0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::vault_config::VaultConfig, arg1: &mut 0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::vault_config::VaultTokenHolder, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg3: &mut 0x2::tx_context::TxContext) {
        0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::vault_config::only_operator(arg0, arg3);
        0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::vault_config::only_allow_version(arg0);
        0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::vault_config::credit_coin<T0>(arg1, arg2, arg3);
    }

    public fun deepbookv3_swap_a2b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::GlobalConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg5: Swaping, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, Swaping) {
        let v0 = 0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::deepbookv3::swap_a2b<T0, T1>(arg1, arg2, arg3, arg4, arg0, arg6);
        let v1 = &mut arg5;
        update_swaping<T0, T1>(v1, 0x2::coin::value<T0>(&arg3), 0x2::coin::value<T1>(&v0));
        (v0, arg5)
    }

    public fun deepbookv3_swap_b2a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x79bd71317665179f4f6025df6c478d9ed47fd281c9335c4c51e1ba0996010519::global_config::GlobalConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg5: Swaping, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Swaping) {
        let v0 = 0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::deepbookv3::swap_b2a<T0, T1>(arg1, arg2, arg3, arg4, arg0, arg6);
        let v1 = &mut arg5;
        update_swaping<T1, T0>(v1, 0x2::coin::value<T1>(&arg3), 0x2::coin::value<T0>(&v0));
        (v0, arg5)
    }

    public fun emergency_withdraw<T0>(arg0: &0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::vault_config::VaultConfig, arg1: &mut 0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::vault_config::VaultTokenHolder, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::vault_config::only_admin(arg0, arg4);
        0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::vault_config::only_allow_version(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::vault_config::emergency_withdraw<T0>(arg1, arg2), arg4), arg3);
    }

    public fun flowx_swap_a2b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: Swaping, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, Swaping) {
        let v0 = 0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::flowx_clmm::swap_a2b<T0, T1>(arg2, arg3, arg4, arg1, arg0, arg6);
        let v1 = &mut arg5;
        update_swaping<T0, T1>(v1, 0x2::coin::value<T0>(&arg4), 0x2::coin::value<T1>(&v0));
        (v0, arg5)
    }

    public fun flowx_swap_b2a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: Swaping, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Swaping) {
        let v0 = 0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::flowx_clmm::swap_b2a<T0, T1>(arg2, arg3, arg4, arg1, arg0, arg6);
        let v1 = &mut arg5;
        update_swaping<T1, T0>(v1, 0x2::coin::value<T1>(&arg4), 0x2::coin::value<T0>(&v0));
        (v0, arg5)
    }

    public(friend) fun get_checksum<T0>(arg0: u64, arg1: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256((arg0 as u256))));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::address::from_u256(((arg1 / 1000) as u256))));
        0x2::hash::keccak256(&v0)
    }

    public fun momentum_swap_a2b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: Swaping, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, Swaping) {
        let v0 = 0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::momentum::swap_a2b<T0, T1>(arg2, arg3, arg1, arg0, arg5);
        let v1 = &mut arg4;
        update_swaping<T0, T1>(v1, 0x2::coin::value<T0>(&arg3), 0x2::coin::value<T1>(&v0));
        (v0, arg4)
    }

    public fun momentum_swap_b2a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: Swaping, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Swaping) {
        let v0 = 0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::momentum::swap_b2a<T0, T1>(arg2, arg3, arg1, arg0, arg5);
        let v1 = &mut arg4;
        update_swaping<T1, T0>(v1, 0x2::coin::value<T1>(&arg3), 0x2::coin::value<T0>(&v0));
        (v0, arg4)
    }

    public fun obric_swap_a2b<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: Swaping, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, Swaping) {
        let v0 = 0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::obric::swap_a2b<T0, T1>(arg2, arg3, arg1, arg4, arg5, arg0, arg7);
        let v1 = &mut arg6;
        update_swaping<T0, T1>(v1, 0x2::coin::value<T0>(&arg3), 0x2::coin::value<T1>(&v0));
        (v0, arg6)
    }

    public fun obric_swap_b2a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: Swaping, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Swaping) {
        let v0 = 0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::obric::swap_b2a<T0, T1>(arg2, arg3, arg1, arg4, arg5, arg0, arg7);
        let v1 = &mut arg6;
        update_swaping<T1, T0>(v1, 0x2::coin::value<T1>(&arg3), 0x2::coin::value<T0>(&v0));
        (v0, arg6)
    }

    public fun rebalance_out<T0>(arg0: &0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::vault_config::VaultConfig, arg1: &mut 0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::vault_config::VaultTokenHolder, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::vault_config::only_operator(arg0, arg4);
        0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::vault_config::only_allow_version(arg0);
        0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::vault_config::check_rebalance_to(arg0, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::vault_config::rebalance_out<T0>(arg1, arg3), arg4), arg2);
        let v0 = RebalanceToCex{
            operator   : 0x2::tx_context::sender(arg4),
            amount     : arg3,
            to_address : arg2,
            token      : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<RebalanceToCex>(v0);
    }

    public(friend) fun swap_check<T0>(arg0: &0x2::clock::Clock, arg1: &0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::vault_config::VaultConfig, arg2: u64, arg3: u64, arg4: u256, arg5: &0x2::tx_context::TxContext) {
        0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::vault_config::only_trusted_bot(arg1, arg5);
        0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::vault_config::when_not_paused(arg1);
        0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::vault_config::when_not_expired(arg0, arg2);
        0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::vault_config::check_trade_token<T0>(arg1, arg3);
        0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::vault_config::only_allow_version(arg1);
        0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::vault_config::when_order_id_not_used(arg1, arg4);
    }

    public fun turbos_swap_a2b<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: 0x2::coin::Coin<T0>, arg4: Swaping, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, Swaping) {
        let v0 = 0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::turbos::swap_a2b<T0, T1, T2>(arg2, arg3, arg0, arg1, arg5);
        let v1 = &mut arg4;
        update_swaping<T0, T1>(v1, 0x2::coin::value<T0>(&arg3), 0x2::coin::value<T1>(&v0));
        (v0, arg4)
    }

    public fun turbos_swap_b2a<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: 0x2::coin::Coin<T1>, arg4: Swaping, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Swaping) {
        let v0 = 0xcab1c9fda59f00dd393978c3095276bc6fe42e77c06ba00bf0dd50fa14fe5701::turbos::swap_b2a<T0, T1, T2>(arg2, arg3, arg0, arg1, arg5);
        let v1 = &mut arg4;
        update_swaping<T1, T0>(v1, 0x2::coin::value<T1>(&arg3), 0x2::coin::value<T0>(&v0));
        (v0, arg4)
    }

    fun update_swaping<T0, T1>(arg0: &mut Swaping, arg1: u64, arg2: u64) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(v0 != v1, 30007);
        assert!(v1 != arg0.from_coin_type, 30003);
        assert!(v0 != arg0.to_coin_type, 30008);
        if (v0 == arg0.from_coin_type) {
            arg0.remaining_from_amount = arg0.remaining_from_amount - arg1;
        } else {
            assert!(v0 == arg0.middle_coin_type, 30009);
            assert!(arg1 == arg0.middle_amount, 30010);
            arg0.middle_amount = 0;
        };
        assert!(arg0.middle_amount == 0, 30006);
        if (v1 == arg0.to_coin_type) {
            arg0.accumulated_to_amount = arg0.accumulated_to_amount + arg2;
        } else {
            arg0.middle_coin_type = v1;
            arg0.middle_amount = arg2;
        };
    }

    // decompiled from Move bytecode v6
}

