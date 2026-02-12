module 0xb7386fc8c6e64ea2b0079e293592b57e984988afdda763f78a3151021c5fbc22::tradeport_nft_strategy {
    struct TRADEPORT_NFT_STRATEGY has drop {
        dummy_field: bool,
    }

    struct Manager has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
    }

    struct Strategy<phantom T0: store + key, phantom T1> has store {
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        ft_balance: 0x2::balance::Balance<T1>,
        swap_fee: u64,
        kiosk_id: 0x2::object::ID,
        kiosk_cap: 0x2::kiosk::KioskOwnerCap,
        price_increase_bps: u64,
        maybe_transfer_policy: 0x1::option::Option<0x2::transfer_policy::TransferPolicy<T0>>,
    }

    struct StrategyKey<phantom T0, phantom T1> has copy, drop, store {
        dummy_field: bool,
    }

    struct CreateStrategyEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        ft_type: 0x1::ascii::String,
        kiosk_id: 0x2::object::ID,
        kiosk_cap_id: 0x2::object::ID,
    }

    struct ApplyFtStrategyEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        ft_type: 0x1::ascii::String,
        amount_in: u64,
        amount_out: u64,
        ft_balance: u64,
    }

    struct ApplyNftStrategyEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        ft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        price: u64,
        new_price: u64,
        sui_balance: u64,
    }

    struct RewardStrategyEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        ft_type: 0x1::ascii::String,
        sui_amount: u64,
        sui_balance: u64,
    }

    public fun apply_ft_strategy<T0: store + key, T1>(arg0: &mut Manager, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::pool_manager::PoolRegistry, arg3: &0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        let v0 = StrategyKey<T0, T1>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<StrategyKey<T0, T1>>(&arg0.id, v0), 5);
        let v1 = 0x2::dynamic_field::borrow_mut<StrategyKey<T0, T1>, Strategy<T0, T1>>(&mut arg0.id, v0);
        assert!(v1.kiosk_id == 0x2::object::id<0x2::kiosk::Kiosk>(arg1), 10);
        if (0x2::kiosk::profits_amount(arg1) == 0) {
            return
        };
        let v2 = 0x2::kiosk::withdraw(arg1, &v1.kiosk_cap, 0x1::option::none<u64>(), arg5);
        let v3 = 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::swap_router::swap_exact_input<0x2::sui::SUI, T1>(arg2, v1.swap_fee, v2, 0, 0, 18446744073709551615, arg3, arg4, arg5);
        0x2::balance::join<T1>(&mut v1.ft_balance, 0x2::coin::into_balance<T1>(v3));
        let v4 = ApplyFtStrategyEvent{
            nft_type   : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            ft_type    : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>()),
            amount_in  : 0x2::coin::value<0x2::sui::SUI>(&v2),
            amount_out : 0x2::coin::value<T1>(&v3),
            ft_balance : 0x2::balance::value<T1>(&v1.ft_balance),
        };
        0x2::event::emit<ApplyFtStrategyEvent>(v4);
    }

    public fun apply_tradeport_nft_strategy_confirm_request<T0: store + key, T1>(arg0: &mut Manager, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0xff2251ea99230ed1cbe3a347a209352711c6723fcdcd9286e16636e65bb55cab::tradeport_listings::Store, arg3: &mut 0x6cefebb11191abd347654200a6fd8ae47fa97b54506e4e680db64dae54d0b12::tradeport_orderbook::Store, arg4: &mut 0x2::kiosk::Kiosk, arg5: 0x2::object::ID, arg6: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg7: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        let v0 = 0x2::object::uid_to_address(&arg0.id);
        let v1 = StrategyKey<T0, T1>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<StrategyKey<T0, T1>>(&arg0.id, v1), 5);
        let v2 = 0x2::dynamic_field::borrow_mut<StrategyKey<T0, T1>, Strategy<T0, T1>>(&mut arg0.id, v1);
        assert!(v2.kiosk_id == 0x2::object::id<0x2::kiosk::Kiosk>(arg1), 10);
        let (v3, v4, _, v6, v7, v8) = 0x6cefebb11191abd347654200a6fd8ae47fa97b54506e4e680db64dae54d0b12::tradeport_orderbook::get_floor_listing<T0>(arg3);
        let v9 = v8;
        let v10 = v7;
        let v11 = v6;
        let v12 = v4;
        let v13 = v3;
        while (v13) {
            if (v11 != v0) {
                break
            };
            let (v14, v15, _, v17, v18, v19) = 0x6cefebb11191abd347654200a6fd8ae47fa97b54506e4e680db64dae54d0b12::tradeport_orderbook::get_next_floor_listing<T0>(arg3, v12);
            v9 = v19;
            v10 = v18;
            v11 = v17;
            v12 = v15;
            v13 = v14;
        };
        assert!(v13, 7);
        assert!(v10 == arg5, 8);
        let v20 = if (0x1::option::is_some<0x2::transfer_policy::TransferPolicy<T0>>(&v2.maybe_transfer_policy)) {
            0x1::option::borrow_mut<0x2::transfer_policy::TransferPolicy<T0>>(&mut v2.maybe_transfer_policy)
        } else {
            arg6
        };
        let v21 = 0xff2251ea99230ed1cbe3a347a209352711c6723fcdcd9286e16636e65bb55cab::tradeport_listings::get_listing_price_with_transfer_policy<T0>(arg2, v10, v20);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v2.sui_balance) >= v21, 9);
        let v22 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v2.sui_balance, v21), arg7);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(v20, 0xff2251ea99230ed1cbe3a347a209352711c6723fcdcd9286e16636e65bb55cab::tradeport_listings::buy_ob_listing_with_transfer_policy<T0>(arg2, arg3, arg4, arg1, &v2.kiosk_cap, v0, v10, &mut v22, v20, arg7));
        0x2::balance::join<0x2::sui::SUI>(&mut v2.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(v22));
        let v26 = v9 + v9 * v2.price_increase_bps / 10000;
        0xff2251ea99230ed1cbe3a347a209352711c6723fcdcd9286e16636e65bb55cab::tradeport_listings::create_ob_listing_with_transfer_policy<T0>(arg2, arg3, arg1, &v2.kiosk_cap, v0, v10, v26, arg7);
        let v27 = ApplyNftStrategyEvent{
            nft_type    : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            ft_type     : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>()),
            nft_id      : v10,
            price       : v9,
            new_price   : v26,
            sui_balance : 0x2::balance::value<0x2::sui::SUI>(&v2.sui_balance),
        };
        0x2::event::emit<ApplyNftStrategyEvent>(v27);
    }

    entry fun create_strategy<T0: store + key, T1>(arg0: &mut Manager, arg1: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg1);
        let v0 = StrategyKey<T0, T1>{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<StrategyKey<T0, T1>>(&arg0.id, v0), 4);
        let (v1, v2) = 0x2::kiosk::new(arg1);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x2::object::id<0x2::kiosk::Kiosk>(&v4);
        let v6 = Strategy<T0, T1>{
            sui_balance           : 0x2::balance::zero<0x2::sui::SUI>(),
            ft_balance            : 0x2::balance::zero<T1>(),
            swap_fee              : 1000,
            kiosk_id              : v5,
            kiosk_cap             : v3,
            price_increase_bps    : 2000,
            maybe_transfer_policy : 0x1::option::none<0x2::transfer_policy::TransferPolicy<T0>>(),
        };
        0x2::dynamic_field::add<StrategyKey<T0, T1>, Strategy<T0, T1>>(&mut arg0.id, v0, v6);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
        let v7 = CreateStrategyEvent{
            nft_type     : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            ft_type      : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>()),
            kiosk_id     : v5,
            kiosk_cap_id : 0x2::object::id<0x2::kiosk::KioskOwnerCap>(&v3),
        };
        0x2::event::emit<CreateStrategyEvent>(v7);
    }

    fun init(arg0: TRADEPORT_NFT_STRATEGY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Manager{
            id      : 0x2::object::new(arg1),
            version : 1,
            admin   : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<Manager>(v0);
    }

    public fun reward_strategy<T0: store + key, T1>(arg0: &mut Manager, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        verify_version(arg0);
        let v0 = StrategyKey<T0, T1>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<StrategyKey<T0, T1>>(&arg0.id, v0), 5);
        let v1 = 0x2::dynamic_field::borrow_mut<StrategyKey<T0, T1>, Strategy<T0, T1>>(&mut arg0.id, v0);
        0x2::balance::join<0x2::sui::SUI>(&mut v1.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v2 = RewardStrategyEvent{
            nft_type    : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            ft_type     : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>()),
            sui_amount  : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            sui_balance : 0x2::balance::value<0x2::sui::SUI>(&v1.sui_balance),
        };
        0x2::event::emit<RewardStrategyEvent>(v2);
    }

    entry fun set_admin(arg0: &mut Manager, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.admin = arg1;
    }

    entry fun set_swap_fee<T0: store + key, T1>(arg0: &mut Manager, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        let v0 = StrategyKey<T0, T1>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<StrategyKey<T0, T1>>(&arg0.id, v0), 5);
        0x2::dynamic_field::borrow_mut<StrategyKey<T0, T1>, Strategy<T0, T1>>(&mut arg0.id, v0).swap_fee = arg1;
    }

    entry fun set_transfer_policy<T0: store + key, T1>(arg0: &mut Manager, arg1: 0x2::transfer_policy::TransferPolicy<T0>) {
        verify_version(arg0);
        assert!(!0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::Rule>(&arg1), 6);
        let v0 = StrategyKey<T0, T1>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<StrategyKey<T0, T1>>(&arg0.id, v0), 5);
        0x1::option::fill<0x2::transfer_policy::TransferPolicy<T0>>(&mut 0x2::dynamic_field::borrow_mut<StrategyKey<T0, T1>, Strategy<T0, T1>>(&mut arg0.id, v0).maybe_transfer_policy, arg1);
    }

    entry fun set_version(arg0: &mut Manager, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.version = arg1;
    }

    fun verify_admin(arg0: &Manager, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 2);
    }

    fun verify_version(arg0: &Manager) {
        assert!(arg0.version <= 1, 1);
    }

    // decompiled from Move bytecode v6
}

