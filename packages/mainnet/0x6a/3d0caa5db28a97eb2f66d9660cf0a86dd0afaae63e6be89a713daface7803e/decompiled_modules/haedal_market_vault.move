module 0x6a3d0caa5db28a97eb2f66d9660cf0a86dd0afaae63e6be89a713daface7803e::haedal_market_vault {
    struct HaedalMarketVault<phantom T0: drop, phantom T1: drop, phantom T2: drop> has key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        staking_id: 0x2::object::ID,
        hasui_balance: 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>,
        updated_at: u64,
    }

    struct MarketVaultCreatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        staking_id: 0x2::object::ID,
        created_by: address,
    }

    struct DepositEvent has copy, drop {
        market_id: 0x2::object::ID,
        staking_id: 0x2::object::ID,
        sui_value_in: u64,
        hasui_in: u64,
        hasui_change_out: u64,
        depositor: address,
    }

    struct ReceiptRedeemedEvent has copy, drop {
        market_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        receipt_amount: u64,
        redeemer: address,
    }

    struct RedeemEvent has copy, drop {
        market_id: 0x2::object::ID,
        staking_id: 0x2::object::ID,
        sui_value_out: u64,
        hasui_out: u64,
        redeemer: address,
    }

    fun assert_market_match<T0: drop, T1: drop, T2: drop>(arg0: &HaedalMarketVault<T0, T1, T2>, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>) {
        assert!(arg0.market_id == 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg1), 1000);
    }

    public(friend) fun assert_staking_match<T0: drop, T1: drop, T2: drop>(arg0: &HaedalMarketVault<T0, T1, T2>, arg1: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) {
        assert!(arg0.staking_id == 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg1), 1001);
    }

    fun create_market_vault<T0: drop, T1: drop, T2: drop>(arg0: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::SyState, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg3: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        exchange_rate(arg3);
        let v0 = HaedalMarketVault<T0, T1, T2>{
            id            : 0x2::object::new(arg5),
            market_id     : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::id<T0, T1, T2>(arg2),
            staking_id    : 0x2::object::id<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking>(arg3),
            hasui_balance : 0x2::balance::zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(),
            updated_at    : 0x2::clock::timestamp_ms(arg4),
        };
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::bind_market_vault<T0, 0x2::sui::SUI, 0x6a3d0caa5db28a97eb2f66d9660cf0a86dd0afaae63e6be89a713daface7803e::sign::HAEDAL>(arg0, arg1, 0x6a3d0caa5db28a97eb2f66d9660cf0a86dd0afaae63e6be89a713daface7803e::sign::sign(), v0.market_id, 0x2::object::id<HaedalMarketVault<T0, T1, T2>>(&v0));
        let v1 = MarketVaultCreatedEvent{
            vault_id   : 0x2::object::id<HaedalMarketVault<T0, T1, T2>>(&v0),
            market_id  : v0.market_id,
            staking_id : v0.staking_id,
            created_by : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<MarketVaultCreatedEvent>(v1);
        0x2::transfer::share_object<HaedalMarketVault<T0, T1, T2>>(v0);
    }

    public fun create_market_vault_by_ACL<T0: drop, T1: drop, T2: drop>(arg0: &0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::ACL, arg1: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::SyState, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x6a3d0caa5db28a97eb2f66d9660cf0a86dd0afaae63e6be89a713daface7803e::package_version::assert_current(arg2);
        0x413f0b727ca3a6fded067960c364d337ad57e284c96f3b21a922455627ca332b::acl::assert_has_role(arg0, arg2, 0x2::tx_context::sender(arg6), 0x1::string::utf8(b"haedal_adapter.create_market"));
        create_market_vault<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun create_market_vault_by_admin<T0: drop, T1: drop, T2: drop>(arg0: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::admin::AdminCap, arg1: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::SyState, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg3: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg4: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x6a3d0caa5db28a97eb2f66d9660cf0a86dd0afaae63e6be89a713daface7803e::package_version::assert_current(arg2);
        create_market_vault<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun deposit<T0: drop, T1: drop, T2: drop>(arg0: 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::MintSyRequest<T0>, arg1: 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg2: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::SyState, arg3: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg4: &mut HaedalMarketVault<T0, T1, T2>, arg5: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg6: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        0x6a3d0caa5db28a97eb2f66d9660cf0a86dd0afaae63e6be89a713daface7803e::package_version::assert_current(arg3);
        assert_market_match<T0, T1, T2>(arg4, arg5);
        assert_staking_match<T0, T1, T2>(arg4, arg6);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::get_mint_request_market_id<T0>(&arg0) == arg4.market_id, 1000);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::get_mint_request_sy_amount<T0>(&arg0);
        assert!(0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg1) >= v0, 1002);
        0x2::balance::join<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg4.hasui_balance, 0x2::coin::into_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(0x2::coin::split<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg1, v0, arg8)));
        arg4.updated_at = 0x2::clock::timestamp_ms(arg7);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::destroy_mint_request<T0, 0x2::sui::SUI, 0x6a3d0caa5db28a97eb2f66d9660cf0a86dd0afaae63e6be89a713daface7803e::sign::HAEDAL>(arg0, 0x6a3d0caa5db28a97eb2f66d9660cf0a86dd0afaae63e6be89a713daface7803e::sign::sign(), arg2, arg3, arg4.market_id, 0x2::object::id<HaedalMarketVault<T0, T1, T2>>(arg4));
        let v1 = DepositEvent{
            market_id        : arg4.market_id,
            staking_id       : arg4.staking_id,
            sui_value_in     : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::get_mint_request_amount<T0>(&arg0),
            hasui_in         : v0,
            hasui_change_out : 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg1),
            depositor        : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<DepositEvent>(v1);
        arg1
    }

    public fun exchange_rate(arg0: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : u64 {
        let v0 = 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_exchange_rate(arg0);
        assert!(v0 > 0, 1003);
        v0
    }

    public fun hasui_balance<T0: drop, T1: drop, T2: drop>(arg0: &HaedalMarketVault<T0, T1, T2>) : u64 {
        0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg0.hasui_balance)
    }

    public fun market_id<T0: drop, T1: drop, T2: drop>(arg0: &HaedalMarketVault<T0, T1, T2>) : 0x2::object::ID {
        arg0.market_id
    }

    public fun redeem<T0: drop, T1: drop, T2: drop>(arg0: 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::BurnSyRequest<T0>, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::SyState, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg3: &mut HaedalMarketVault<T0, T1, T2>, arg4: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg5: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        0x6a3d0caa5db28a97eb2f66d9660cf0a86dd0afaae63e6be89a713daface7803e::package_version::assert_current(arg2);
        assert_market_match<T0, T1, T2>(arg3, arg4);
        assert_staking_match<T0, T1, T2>(arg3, arg5);
        assert!(0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::get_burn_request_market_id<T0>(&arg0) == arg3.market_id, 1000);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::get_burn_request_sy_amount<T0>(&arg0);
        arg3.updated_at = 0x2::clock::timestamp_ms(arg6);
        0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::destroy_burn_request<T0, 0x2::sui::SUI, 0x6a3d0caa5db28a97eb2f66d9660cf0a86dd0afaae63e6be89a713daface7803e::sign::HAEDAL>(arg0, 0x6a3d0caa5db28a97eb2f66d9660cf0a86dd0afaae63e6be89a713daface7803e::sign::sign(), arg1, arg2, arg3.market_id, 0x2::object::id<HaedalMarketVault<T0, T1, T2>>(arg3));
        let v1 = RedeemEvent{
            market_id     : arg3.market_id,
            staking_id    : arg3.staking_id,
            sui_value_out : 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::get_burn_request_amount<T0>(&arg0),
            hasui_out     : v0,
            redeemer      : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<RedeemEvent>(v1);
        0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(0x2::balance::split<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg3.hasui_balance, v0), arg7)
    }

    public fun redeem_receipt<T0: drop, T1: drop, T2: drop>(arg0: 0x2::coin::Coin<T0>, arg1: &0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::SyState, arg2: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg3: &mut HaedalMarketVault<T0, T1, T2>, arg4: &mut 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::market::Market<T0, T1, T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        0x6a3d0caa5db28a97eb2f66d9660cf0a86dd0afaae63e6be89a713daface7803e::package_version::assert_current(arg2);
        assert_market_match<T0, T1, T2>(arg3, arg4);
        let v0 = 0xa8a74beede1f9574474d8c56a5147659390344eeae109d67d5db50cdba39d0c8::sy::burn_escrowed_sy_market_state<T0, 0x2::sui::SUI, T1, T2, 0x6a3d0caa5db28a97eb2f66d9660cf0a86dd0afaae63e6be89a713daface7803e::sign::HAEDAL>(arg0, 0x6a3d0caa5db28a97eb2f66d9660cf0a86dd0afaae63e6be89a713daface7803e::sign::sign(), arg1, arg2, arg4, 0x2::object::id<HaedalMarketVault<T0, T1, T2>>(arg3));
        arg3.updated_at = 0x2::clock::timestamp_ms(arg5);
        let v1 = ReceiptRedeemedEvent{
            market_id      : arg3.market_id,
            vault_id       : 0x2::object::id<HaedalMarketVault<T0, T1, T2>>(arg3),
            receipt_amount : v0,
            redeemer       : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<ReceiptRedeemedEvent>(v1);
        0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(0x2::balance::split<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg3.hasui_balance, v0), arg6)
    }

    public fun staking_id<T0: drop, T1: drop, T2: drop>(arg0: &HaedalMarketVault<T0, T1, T2>) : 0x2::object::ID {
        arg0.staking_id
    }

    public fun updated_at<T0: drop, T1: drop, T2: drop>(arg0: &HaedalMarketVault<T0, T1, T2>) : u64 {
        arg0.updated_at
    }

    // decompiled from Move bytecode v7
}

