module 0x11c83e4d5057da2ab8bbe4fce70c43f828baccb67b2d4b950e4b2339b8eb126f::ember_market_vault {
    struct EmberMarketVault<phantom T0: drop, phantom T1: drop, phantom T2: drop, phantom T3: drop, phantom T4: drop> has key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        ember_vault_id: 0x2::object::ID,
        receipt_balance: 0x2::balance::Balance<T1>,
        updated_at: u64,
    }

    struct MarketVaultCreatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        ember_vault_id: 0x2::object::ID,
        created_by: address,
    }

    struct DepositEvent has copy, drop {
        market_id: 0x2::object::ID,
        ember_vault_id: 0x2::object::ID,
        underlying_value_in: u64,
        receipt_shares_in: u64,
        receipt_change_out: u64,
        depositor: address,
    }

    struct RedeemEvent has copy, drop {
        market_id: 0x2::object::ID,
        ember_vault_id: 0x2::object::ID,
        underlying_value_out: u64,
        receipt_shares_out: u64,
        redeemer: address,
    }

    struct ReceiptRedeemedEvent has copy, drop {
        market_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        receipt_amount: u64,
        redeemer: address,
    }

    public(friend) fun assert_ember_vault_match<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>) {
        assert!(arg0.ember_vault_id == 0x2::object::id<0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>>(arg1), 1004);
    }

    fun assert_market_match<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T2, T3, T4>) {
        assert!(arg0.market_id == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T2, T3, T4>(arg1), 1002);
    }

    fun create_market_vault<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::SyState, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T2, T3, T4>, arg3: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = EmberMarketVault<T0, T1, T2, T3, T4>{
            id              : 0x2::object::new(arg5),
            market_id       : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T2, T3, T4>(arg2),
            ember_vault_id  : 0x2::object::id<0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>>(arg3),
            receipt_balance : 0x2::balance::zero<T1>(),
            updated_at      : 0x2::clock::timestamp_ms(arg4),
        };
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::bind_market_vault<T2, T0, 0x11c83e4d5057da2ab8bbe4fce70c43f828baccb67b2d4b950e4b2339b8eb126f::sign::EMBER>(arg0, arg1, 0x11c83e4d5057da2ab8bbe4fce70c43f828baccb67b2d4b950e4b2339b8eb126f::sign::sign(), v0.market_id, 0x2::object::id<EmberMarketVault<T0, T1, T2, T3, T4>>(&v0));
        let v1 = MarketVaultCreatedEvent{
            vault_id       : 0x2::object::id<EmberMarketVault<T0, T1, T2, T3, T4>>(&v0),
            market_id      : v0.market_id,
            ember_vault_id : v0.ember_vault_id,
            created_by     : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<MarketVaultCreatedEvent>(v1);
        0x2::transfer::share_object<EmberMarketVault<T0, T1, T2, T3, T4>>(v0);
    }

    public fun create_market_vault_by_ACL<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::ACL, arg1: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::SyState, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T2, T3, T4>, arg4: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x11c83e4d5057da2ab8bbe4fce70c43f828baccb67b2d4b950e4b2339b8eb126f::package_version::assert_current(arg2);
        0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::assert_has_role(arg0, arg2, 0x2::tx_context::sender(arg6), 0x1::string::utf8(b"ember_adapter.create_market"));
        create_market_vault<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun create_market_vault_by_admin<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg1: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::SyState, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T2, T3, T4>, arg4: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x11c83e4d5057da2ab8bbe4fce70c43f828baccb67b2d4b950e4b2339b8eb126f::package_version::assert_current(arg2);
        create_market_vault<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun deposit<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::MintSyRequest<T2>, arg1: 0x2::coin::Coin<T1>, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::SyState, arg3: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg4: &mut EmberMarketVault<T0, T1, T2, T3, T4>, arg5: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T2, T3, T4>, arg6: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x11c83e4d5057da2ab8bbe4fce70c43f828baccb67b2d4b950e4b2339b8eb126f::package_version::assert_current(arg3);
        assert_market_match<T0, T1, T2, T3, T4>(arg4, arg5);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::get_mint_request_market_id<T2>(&arg0) == arg4.market_id, 1002);
        assert_ember_vault_match<T0, T1, T2, T3, T4>(arg4, arg6);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::get_mint_request_sy_amount<T2>(&arg0);
        assert!(0x2::coin::value<T1>(&arg1) >= v0, 1003);
        0x2::balance::join<T1>(&mut arg4.receipt_balance, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg1, v0, arg8)));
        arg4.updated_at = 0x2::clock::timestamp_ms(arg7);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::destroy_mint_request<T2, T0, 0x11c83e4d5057da2ab8bbe4fce70c43f828baccb67b2d4b950e4b2339b8eb126f::sign::EMBER>(arg0, 0x11c83e4d5057da2ab8bbe4fce70c43f828baccb67b2d4b950e4b2339b8eb126f::sign::sign(), arg2, arg3, arg4.market_id, 0x2::object::id<EmberMarketVault<T0, T1, T2, T3, T4>>(arg4));
        let v1 = DepositEvent{
            market_id           : arg4.market_id,
            ember_vault_id      : arg4.ember_vault_id,
            underlying_value_in : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::get_mint_request_amount<T2>(&arg0),
            receipt_shares_in   : v0,
            receipt_change_out  : 0x2::coin::value<T1>(&arg1),
            depositor           : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<DepositEvent>(v1);
        arg1
    }

    public fun ember_vault_id<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>) : 0x2::object::ID {
        arg0.ember_vault_id
    }

    public fun market_id<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>) : 0x2::object::ID {
        arg0.market_id
    }

    public fun receipt_balance<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>) : u64 {
        0x2::balance::value<T1>(&arg0.receipt_balance)
    }

    public fun redeem<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::BurnSyRequest<T2>, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::SyState, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg3: &mut EmberMarketVault<T0, T1, T2, T3, T4>, arg4: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T2, T3, T4>, arg5: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x11c83e4d5057da2ab8bbe4fce70c43f828baccb67b2d4b950e4b2339b8eb126f::package_version::assert_current(arg2);
        assert_market_match<T0, T1, T2, T3, T4>(arg3, arg4);
        assert_ember_vault_match<T0, T1, T2, T3, T4>(arg3, arg5);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::get_burn_request_market_id<T2>(&arg0) == arg3.market_id, 1002);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::get_burn_request_sy_amount<T2>(&arg0);
        arg3.updated_at = 0x2::clock::timestamp_ms(arg6);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::destroy_burn_request<T2, T0, 0x11c83e4d5057da2ab8bbe4fce70c43f828baccb67b2d4b950e4b2339b8eb126f::sign::EMBER>(arg0, 0x11c83e4d5057da2ab8bbe4fce70c43f828baccb67b2d4b950e4b2339b8eb126f::sign::sign(), arg1, arg2, arg3.market_id, 0x2::object::id<EmberMarketVault<T0, T1, T2, T3, T4>>(arg3));
        let v1 = RedeemEvent{
            market_id            : arg3.market_id,
            ember_vault_id       : arg3.ember_vault_id,
            underlying_value_out : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::get_burn_request_amount<T2>(&arg0),
            receipt_shares_out   : v0,
            redeemer             : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<RedeemEvent>(v1);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg3.receipt_balance, v0), arg7)
    }

    public fun redeem_receipt<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: 0x2::coin::Coin<T2>, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::SyState, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg3: &mut EmberMarketVault<T0, T1, T2, T3, T4>, arg4: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T2, T3, T4>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x11c83e4d5057da2ab8bbe4fce70c43f828baccb67b2d4b950e4b2339b8eb126f::package_version::assert_current(arg2);
        assert_market_match<T0, T1, T2, T3, T4>(arg3, arg4);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::burn_escrowed_sy_market_state<T2, T0, T3, T4, 0x11c83e4d5057da2ab8bbe4fce70c43f828baccb67b2d4b950e4b2339b8eb126f::sign::EMBER>(arg0, 0x11c83e4d5057da2ab8bbe4fce70c43f828baccb67b2d4b950e4b2339b8eb126f::sign::sign(), arg1, arg2, arg4, 0x2::object::id<EmberMarketVault<T0, T1, T2, T3, T4>>(arg3));
        arg3.updated_at = 0x2::clock::timestamp_ms(arg5);
        let v1 = ReceiptRedeemedEvent{
            market_id      : arg3.market_id,
            vault_id       : 0x2::object::id<EmberMarketVault<T0, T1, T2, T3, T4>>(arg3),
            receipt_amount : v0,
            redeemer       : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<ReceiptRedeemedEvent>(v1);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg3.receipt_balance, v0), arg6)
    }

    public fun shares_for_underlying_ceil(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 > 0, 1005);
        let v0 = (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_ceil((arg0 as u128), (arg1 as u128), 1000000000) as u64);
        assert!(v0 > 0, 1006);
        v0
    }

    public fun shares_for_underlying_floor(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 > 0, 1005);
        let v0 = (0xd72e334517b116630d3557fc18b48b207ba611913adb21231e743731a3e35a79::full_math_u128::mul_div_floor((arg0 as u128), (arg1 as u128), 1000000000) as u64);
        assert!(v0 > 0, 1006);
        v0
    }

    public fun updated_at<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>) : u64 {
        arg0.updated_at
    }

    public fun vault_id<T0: drop, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &EmberMarketVault<T0, T1, T2, T3, T4>) : 0x2::object::ID {
        0x2::object::id<EmberMarketVault<T0, T1, T2, T3, T4>>(arg0)
    }

    // decompiled from Move bytecode v7
}

