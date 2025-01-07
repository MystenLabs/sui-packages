module 0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::meme {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct MemeConfig has key {
        id: 0x2::object::UID,
        version: u64,
        minimum_version: u64,
        virtual_sui_amount: u64,
        listing_fee: u64,
        swap_fee_bps: u64,
        migration_fee: u64,
        treasury: address,
    }

    struct BondingCurve<phantom T0> has key {
        id: 0x2::object::UID,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        virtual_sui_amount: u64,
        token_balance: 0x2::balance::Balance<T0>,
        metadata: 0x2::coin::CoinMetadata<T0>,
        creator: address,
        curve_type: u8,
        status: u8,
        reached_migration_at: 0x1::option::Option<u64>,
    }

    struct MEME has drop {
        dummy_field: bool,
    }

    public fun get_id<T0>(arg0: &BondingCurve<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public entry fun buy<T0>(arg0: &mut BondingCurve<T0>, arg1: &MemeConfig, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        enforce_config_version(arg1);
        assert!(arg0.status == 0, 4);
        let v0 = 0x2::balance::value<T0>(&arg0.token_balance);
        let v1 = arg0.virtual_sui_amount + 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance);
        let v2 = 0x2::math::min(arg3, 0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::math::find_amount_with_fee(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::math::get_amount_in(v0 - 300000000000000, v1, v0), arg1.swap_fee_bps));
        let v3 = 0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::math::get_fee_amount(v2, arg1.swap_fee_bps);
        let v4 = v2 - v3;
        let v5 = 0x2::coin::take<T0>(&mut arg0.token_balance, 0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::math::get_amount_out(v4, v1, v0), arg5);
        assert!(0x2::coin::value<T0>(&v5) >= arg4, 6);
        if (0x2::balance::value<T0>(&arg0.token_balance) <= 300000000000000) {
            arg0.status = 2;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v3, arg5), arg1.treasury);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::split<0x2::sui::SUI>(&mut arg2, v4, arg5));
        delete_or_return<0x2::sui::SUI>(arg2, arg5);
        let v6 = 0x2::tx_context::sender(arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, v6);
        0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::events::emit_buy<T0>(get_id<T0>(arg0), v4, v6, arg0.virtual_sui_amount, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), 0x2::balance::value<T0>(&arg0.token_balance));
    }

    public entry fun create_bonding_curve<T0>(arg0: 0x2::object::ID, arg1: &mut MemeConfig, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        enforce_config_version(arg1);
        assert!(arg2 == 0, 5);
        assert!(0x2::dynamic_field::exists_<0x2::object::ID>(&arg1.id, arg0), 1);
        let v0 = 0x2::dynamic_field::remove<0x2::object::ID, 0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<T0>>(&mut arg1.id, arg0);
        assert!(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::get_creator<T0>(&v0) == 0x2::tx_context::sender(arg3), 3);
        let (v1, v2, v3, v4) = 0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::deconstruct<T0>(v0);
        let v5 = v2;
        0x2::object::delete(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T0>>(v5);
        let v6 = BondingCurve<T0>{
            id                   : 0x2::object::new(arg3),
            sui_balance          : 0x2::balance::zero<0x2::sui::SUI>(),
            virtual_sui_amount   : arg1.virtual_sui_amount,
            token_balance        : 0x2::coin::mint_balance<T0>(&mut v5, 1000000000000000),
            metadata             : v3,
            creator              : v4,
            curve_type           : arg2,
            status               : 0,
            reached_migration_at : 0x1::option::none<u64>(),
        };
        0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::events::emit_curve_create<T0>(get_id<T0>(&v6), v4);
        0x2::transfer::share_object<BondingCurve<T0>>(v6);
    }

    fun delete_or_return<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    fun enforce_config_version(arg0: &MemeConfig) {
        assert!(arg0.version >= arg0.version, 2);
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MemeConfig{
            id                 : 0x2::object::new(arg1),
            version            : 0,
            minimum_version    : 0,
            virtual_sui_amount : 2370000000000,
            listing_fee        : 2000000000,
            swap_fee_bps       : 100,
            migration_fee      : 300000000000,
            treasury           : @0x2,
        };
        0x2::transfer::share_object<MemeConfig>(v0);
    }

    public fun migrate<T0>(arg0: &AdminCap, arg1: &MemeConfig, arg2: &mut BondingCurve<T0>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        enforce_config_version(arg1);
        assert!(arg2.status == 2, 4);
        let v0 = 0x2::coin::take<0x2::sui::SUI>(&mut arg2.sui_balance, 0x2::balance::value<0x2::sui::SUI>(&arg2.sui_balance), arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v0, arg1.migration_fee, arg3), arg1.treasury);
        0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::events::emit_migrate<T0>(0x2::object::uid_to_inner(&arg2.id));
        (v0, 0x2::coin::take<T0>(&mut arg2.token_balance, 0x2::balance::value<T0>(&arg2.token_balance), arg3))
    }

    public fun receive_connector<T0>(arg0: &mut MemeConfig, arg1: 0x2::transfer::Receiving<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<T0>>) {
        let v0 = 0x2::transfer::public_receive<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<T0>>(&mut arg0.id, arg1);
        let v1 = &mut arg0.id;
        let v2 = 0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::get_id<T0>(&v0);
        assert!(!0x2::dynamic_field::exists_<0x2::object::ID>(v1, v2), 0);
        assert!(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::get_decimals<T0>(&v0) == 6, 7);
        0x2::dynamic_field::add<0x2::object::ID, 0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<T0>>(v1, v2, v0);
        0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::events::emit_connector_create<T0>(v2, 0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::get_creator<T0>(&v0));
    }

    public entry fun sell<T0>(arg0: &mut BondingCurve<T0>, arg1: &MemeConfig, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        enforce_config_version(arg1);
        assert!(arg0.status == 0, 4);
        let v0 = 0x2::balance::value<T0>(&arg0.token_balance);
        let v1 = arg0.virtual_sui_amount + 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance);
        let v2 = 0x2::math::min(arg3, 0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::math::get_amount_in(v1 - arg0.virtual_sui_amount, v0, v1));
        let v3 = 0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::math::get_amount_out(v2, v0, v1);
        0x2::coin::put<T0>(&mut arg0.token_balance, 0x2::coin::split<T0>(&mut arg2, v2, arg5));
        delete_or_return<T0>(arg2, arg5);
        let v4 = 0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_balance, v3, arg5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v4) >= arg4, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v4, 0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::math::get_fee_amount(v3, arg1.swap_fee_bps), arg5), arg1.treasury);
        let v5 = 0x2::tx_context::sender(arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v5);
        0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::events::emit_sell<T0>(get_id<T0>(arg0), v2, v5, arg0.virtual_sui_amount, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), 0x2::balance::value<T0>(&arg0.token_balance));
    }

    // decompiled from Move bytecode v6
}

