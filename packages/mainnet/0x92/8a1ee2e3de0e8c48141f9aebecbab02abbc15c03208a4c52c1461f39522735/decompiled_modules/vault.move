module 0x928a1ee2e3de0e8c48141f9aebecbab02abbc15c03208a4c52c1461f39522735::vault {
    struct VAULT has drop {
        dummy_field: bool,
    }

    struct WithdrawRequest<phantom T0, phantom T1> has store {
        lp_token: 0x2::coin::Coin<VAULT>,
        owner: address,
    }

    struct ClaimableWithdrawals<phantom T0, phantom T1> has store {
        coin_base: 0x2::balance::Balance<T0>,
        coin_quote: 0x2::balance::Balance<T1>,
        owner: address,
    }

    struct DepositRequest<phantom T0> has store {
        amount: 0x2::balance::Balance<T0>,
        owner: address,
    }

    struct Vault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        type_x: 0x1::type_name::TypeName,
        type_y: 0x1::type_name::TypeName,
        balance_x: 0x2::balance::Balance<T0>,
        balance_y: 0x2::balance::Balance<T1>,
        maker_fees_X: 0x2::balance::Balance<T0>,
        maker_fees_Y: 0x2::balance::Balance<T1>,
        deposit_requests: vector<DepositRequest<T1>>,
        withdraw_requests: vector<WithdrawRequest<T0, T1>>,
        whitelisted_addresses: vector<address>,
        deepbook_account_cap: 0xdee9::custodian_v2::AccountCap,
        claimable_withdrawals: vector<ClaimableWithdrawals<T0, T1>>,
    }

    struct VaultCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    public fun add_deposit_request<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = DepositRequest<T1>{
            amount : arg1,
            owner  : 0x2::tx_context::sender(arg2),
        };
        0x1::vector::push_back<DepositRequest<T1>>(&mut arg0.deposit_requests, v0);
    }

    public fun add_withdraw_request<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<VAULT>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = WithdrawRequest<T0, T1>{
            lp_token : arg1,
            owner    : 0x2::tx_context::sender(arg2),
        };
        0x1::vector::push_back<WithdrawRequest<T0, T1>>(&mut arg0.withdraw_requests, v0);
    }

    public fun calculate_lp_token_share<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0xdee9::clob_v2::Pool<T0, T1>, arg2: &0x2::coin::TreasuryCap<VAULT>, arg3: u64) : (u64, u64) {
        let (v0, _, v2, _) = get_deepbook_account_assets<T0, T1>(arg0, arg1);
        let v4 = 0x2::coin::total_supply<VAULT>(arg2);
        (v0 * arg3 / v4, v2 * arg3 / v4)
    }

    public(friend) fun get_account_cap<T0, T1>(arg0: &Vault<T0, T1>) : &0xdee9::custodian_v2::AccountCap {
        &arg0.deepbook_account_cap
    }

    public(friend) fun get_deepbook_account_assets<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0xdee9::clob_v2::Pool<T0, T1>) : (u64, u64, u64, u64) {
        0xdee9::clob_v2::account_balance<T0, T1>(arg1, get_account_cap<T0, T1>(arg0))
    }

    public fun get_deepbook_price<T0, T1>(arg0: &0xdee9::clob_v2::Pool<T0, T1>) : (u64, u64, u64) {
        let (v0, v1) = 0xdee9::clob_v2::get_market_price<T0, T1>(arg0);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x1::option::get_with_default<u64>(&v3, 0);
        let v5 = 0x1::option::get_with_default<u64>(&v2, 0);
        (v4, v5, (v4 + v5) / 2)
    }

    public(friend) fun get_deposit_requests<T0, T1>(arg0: &mut Vault<T0, T1>) : &mut vector<DepositRequest<T1>> {
        &mut arg0.deposit_requests
    }

    public(friend) fun get_vault_id_from_vault<T0, T1>(arg0: &Vault<T0, T1>) : 0x2::object::ID {
        *0x2::object::uid_as_inner(&arg0.id)
    }

    public(friend) fun get_vault_id_from_vault_cap(arg0: &VaultCap) : 0x2::object::ID {
        arg0.vault_id
    }

    public(friend) fun get_withdraw_requests<T0, T1>(arg0: &mut Vault<T0, T1>) : &mut vector<WithdrawRequest<T0, T1>> {
        &mut arg0.withdraw_requests
    }

    fun init(arg0: VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x928a1ee2e3de0e8c48141f9aebecbab02abbc15c03208a4c52c1461f39522735::constants::lp_token_metadata();
        let (v4, v5) = 0x2::coin::create_currency<VAULT>(arg0, v0, v1, v2, v3, 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<VAULT>>(v4);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VAULT>>(v5);
    }

    public(friend) fun is_address_whitelisted_for_trading<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.whitelisted_addresses, &arg1)
    }

    fun mint_lp_token(arg0: &mut 0x2::coin::TreasuryCap<VAULT>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<VAULT> {
        let v0 = 0x2::coin::total_supply<VAULT>(arg0);
        let v1 = if (v0 == 0) {
            let v2 = (0x2::math::sqrt_u128((arg3 as u128) * (arg4 as u128)) as u64);
            assert!(v2 > 0x928a1ee2e3de0e8c48141f9aebecbab02abbc15c03208a4c52c1461f39522735::constants::minimal_liquidity(), 0x928a1ee2e3de0e8c48141f9aebecbab02abbc15c03208a4c52c1461f39522735::error::notEnoughInitialLiquidity());
            v2
        } else {
            0x2::math::min(0x928a1ee2e3de0e8c48141f9aebecbab02abbc15c03208a4c52c1461f39522735::safe_math::safe_mul_div_u64(arg3, v0, arg1), 0x928a1ee2e3de0e8c48141f9aebecbab02abbc15c03208a4c52c1461f39522735::safe_math::safe_mul_div_u64(arg4, v0, arg2))
        };
        assert!(v1 > 0, 0x928a1ee2e3de0e8c48141f9aebecbab02abbc15c03208a4c52c1461f39522735::error::liquidityInsufficientMinted());
        0x2::coin::mint<VAULT>(arg0, v1, arg5)
    }

    public fun new_vault<T0, T1>(arg0: &0x928a1ee2e3de0e8c48141f9aebecbab02abbc15c03208a4c52c1461f39522735::app::AdminCap, arg1: &mut 0x2::tx_context::TxContext) : (Vault<T0, T1>, VaultCap) {
        let v0 = Vault<T0, T1>{
            id                    : 0x2::object::new(arg1),
            type_x                : 0x1::type_name::get<T0>(),
            type_y                : 0x1::type_name::get<T1>(),
            balance_x             : 0x2::balance::zero<T0>(),
            balance_y             : 0x2::balance::zero<T1>(),
            maker_fees_X          : 0x2::balance::zero<T0>(),
            maker_fees_Y          : 0x2::balance::zero<T1>(),
            deposit_requests      : 0x1::vector::empty<DepositRequest<T1>>(),
            withdraw_requests     : 0x1::vector::empty<WithdrawRequest<T0, T1>>(),
            whitelisted_addresses : 0x1::vector::empty<address>(),
            deepbook_account_cap  : 0xdee9::clob_v2::create_account(arg1),
            claimable_withdrawals : 0x1::vector::empty<ClaimableWithdrawals<T0, T1>>(),
        };
        let v1 = VaultCap{
            id       : 0x2::object::new(arg1),
            vault_id : 0x2::object::id<Vault<T0, T1>>(&v0),
        };
        (v0, v1)
    }

    public fun process_deposits<T0, T1>(arg0: &VaultCap, arg1: &mut Vault<T0, T1>, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: &mut 0x2::coin::TreasuryCap<VAULT>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(get_vault_id_from_vault_cap(arg0) == get_vault_id_from_vault<T0, T1>(arg1), 0x928a1ee2e3de0e8c48141f9aebecbab02abbc15c03208a4c52c1461f39522735::error::invalid_vault_cap());
        assert!(is_address_whitelisted_for_trading<T0, T1>(arg1, 0x2::tx_context::sender(arg5)), 0x928a1ee2e3de0e8c48141f9aebecbab02abbc15c03208a4c52c1461f39522735::error::address_not_whitelisted());
        let v0 = &arg1.deepbook_account_cap;
        let (v1, v2, v3, v4) = get_deepbook_account_assets<T0, T1>(arg1, arg2);
        assert!(v2 == 0, 0x928a1ee2e3de0e8c48141f9aebecbab02abbc15c03208a4c52c1461f39522735::error::locked_base_asset_found());
        assert!(v4 == 0, 0x928a1ee2e3de0e8c48141f9aebecbab02abbc15c03208a4c52c1461f39522735::error::locked_quote_asset_found());
        let v5 = v1 / v3;
        let (_, _, v8) = get_deepbook_price<T0, T1>(arg2);
        let v9 = v1;
        let v10 = v3;
        while (0x1::vector::length<DepositRequest<T1>>(&arg1.deposit_requests) > 0) {
            let DepositRequest {
                amount : v11,
                owner  : v12,
            } = 0x1::vector::pop_back<DepositRequest<T1>>(&mut arg1.deposit_requests);
            let v13 = v11;
            let (v14, v15) = 0xdee9::clob_v2::place_market_order<T0, T1>(arg2, v0, 1, 0x928a1ee2e3de0e8c48141f9aebecbab02abbc15c03208a4c52c1461f39522735::safe_math::safe_mul_div_u64(0x2::balance::value<T1>(&v13), v5, v5 + 1) * v8, true, 0x2::coin::zero<T0>(arg5), 0x2::coin::from_balance<T1>(v13, arg5), arg4, arg5);
            let v16 = v15;
            let v17 = v14;
            let v18 = v9 + 0x2::coin::value<T0>(&v17);
            v9 = v18;
            let v19 = v10 + 0x2::coin::value<T1>(&v16);
            v10 = v19;
            0xdee9::clob_v2::deposit_base<T0, T1>(arg2, v17, v0);
            0xdee9::clob_v2::deposit_quote<T0, T1>(arg2, v16, v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<VAULT>>(mint_lp_token(arg3, v18, v19, 0x2::coin::value<T0>(&v17), 0x2::coin::value<T1>(&v16), arg5), v12);
        };
    }

    public fun process_withdrawals<T0, T1>(arg0: &VaultCap, arg1: &mut Vault<T0, T1>, arg2: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg3: &mut 0x2::coin::TreasuryCap<VAULT>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(get_vault_id_from_vault_cap(arg0) == get_vault_id_from_vault<T0, T1>(arg1), 0x928a1ee2e3de0e8c48141f9aebecbab02abbc15c03208a4c52c1461f39522735::error::invalid_vault_cap());
        assert!(is_address_whitelisted_for_trading<T0, T1>(arg1, 0x2::tx_context::sender(arg4)), 0x928a1ee2e3de0e8c48141f9aebecbab02abbc15c03208a4c52c1461f39522735::error::address_not_whitelisted());
        let v0 = &arg1.deepbook_account_cap;
        while (0x1::vector::length<WithdrawRequest<T0, T1>>(&arg1.withdraw_requests) > 0) {
            let WithdrawRequest {
                lp_token : v1,
                owner    : v2,
            } = 0x1::vector::pop_back<WithdrawRequest<T0, T1>>(&mut arg1.withdraw_requests);
            let v3 = v1;
            let (v4, v5) = calculate_lp_token_share<T0, T1>(arg1, arg2, arg3, 0x2::coin::value<VAULT>(&v3));
            0x2::coin::burn<VAULT>(arg3, v3);
            let v6 = ClaimableWithdrawals<T0, T1>{
                coin_base  : 0x2::coin::into_balance<T0>(0xdee9::clob_v2::withdraw_base<T0, T1>(arg2, v4, v0, arg4)),
                coin_quote : 0x2::coin::into_balance<T1>(0xdee9::clob_v2::withdraw_quote<T0, T1>(arg2, v5, v0, arg4)),
                owner      : v2,
            };
            0x1::vector::push_back<ClaimableWithdrawals<T0, T1>>(&mut arg1.claimable_withdrawals, v6);
        };
    }

    public fun revoke_trading_permission<T0, T1>(arg0: &VaultCap, arg1: &mut Vault<T0, T1>, arg2: address) {
        assert!(get_vault_id_from_vault_cap(arg0) == get_vault_id_from_vault<T0, T1>(arg1), 0x928a1ee2e3de0e8c48141f9aebecbab02abbc15c03208a4c52c1461f39522735::error::invalid_vault_cap());
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.whitelisted_addresses, &arg2);
        assert!(v0, 0x928a1ee2e3de0e8c48141f9aebecbab02abbc15c03208a4c52c1461f39522735::error::address_not_whitelisted());
        0x1::vector::remove<address>(&mut arg1.whitelisted_addresses, v1);
    }

    public fun whitelist_address_for_trading<T0, T1>(arg0: &VaultCap, arg1: &mut Vault<T0, T1>, arg2: address) {
        assert!(get_vault_id_from_vault_cap(arg0) == get_vault_id_from_vault<T0, T1>(arg1), 0x928a1ee2e3de0e8c48141f9aebecbab02abbc15c03208a4c52c1461f39522735::error::invalid_vault_cap());
        0x1::vector::push_back<address>(&mut arg1.whitelisted_addresses, arg2);
    }

    // decompiled from Move bytecode v6
}

