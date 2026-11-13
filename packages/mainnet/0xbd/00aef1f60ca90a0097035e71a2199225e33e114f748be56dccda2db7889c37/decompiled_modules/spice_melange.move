module 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice_melange {
    struct SPICE_MELANGE has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PolicyLock has key {
        id: 0x2::object::UID,
        spice: 0x2::transfer_policy::TransferPolicyCap<0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice::Spice>,
        seal: 0x2::transfer_policy::TransferPolicyCap<0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::seal::SiaynoqSeal>,
    }

    public fun set_fees(arg0: &AdminCap, arg1: &mut 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::market::Market, arg2: u64, arg3: u64) {
        0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::market::set_fees(arg1, arg2, arg3);
    }

    fun displays(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::display::new_with_fields<0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice::Spice>(arg0, 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::launch::display_keys(), 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::launch::spice_display(), arg1);
        0x2::display::update_version<0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice::Spice>(&mut v0);
        0x2::transfer::public_transfer<0x2::display::Display<0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice::Spice>>(v0, 0x2::tx_context::sender(arg1));
        let v1 = 0x2::display::new_with_fields<0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::seal::SiaynoqSeal>(arg0, 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::launch::display_keys(), 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::launch::seal_display(), arg1);
        0x2::display::update_version<0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::seal::SiaynoqSeal>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::seal::SiaynoqSeal>>(v1, 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: SPICE_MELANGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SPICE_MELANGE>(arg0, arg1);
        let v1 = 0x2::tx_context::sender(arg1);
        setup(&v0, arg1);
        displays(&v0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v1);
    }

    public fun open_rebate_vault<T0>(arg0: &AdminCap, arg1: &mut 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice::MintBook, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::rebate::create<T0>(arg2, 600, arg3);
        let v1 = 0x2::object::id<0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::rebate::RebateVault>(&v0);
        0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice::set_rebate_vault(arg1, v1);
        0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::rebate::share(v0);
        v1
    }

    public fun open_yield_pool<T0, T1>(arg0: &AdminCap, arg1: u128, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::soos_yield::create<T0, T1>(800, arg1, arg2);
        0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::soos_yield::share(v0);
        0x2::object::id<0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::soos_yield::YieldPool>(&v0)
    }

    public fun set_market_paused(arg0: &AdminCap, arg1: &mut 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::market::Market, arg2: bool) {
        0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::market::set_paused(arg1, arg2);
    }

    public fun set_mint_paused(arg0: &AdminCap, arg1: &mut 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice::MintBook, arg2: bool) {
        0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice::set_paused(arg1, arg2);
    }

    public fun set_rebate(arg0: &AdminCap, arg1: &mut 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::rebate::RebateVault, arg2: u64, arg3: u64) {
        0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::rebate::set_params(arg1, arg2, arg3);
    }

    public fun set_yield(arg0: &AdminCap, arg1: &mut 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::soos_yield::YieldPool, arg2: u64, arg3: u128, arg4: bool) {
        0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::soos_yield::set_params(arg1, arg2, arg3, arg4);
    }

    fun setup(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::transfer_policy::new<0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice::Spice>(arg0, arg1);
        let v3 = v2;
        let v4 = v1;
        0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::market::add_rule<0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice::Spice>(&mut v4, &v3);
        let (v5, v6) = 0x2::transfer_policy::new<0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::seal::SiaynoqSeal>(arg0, arg1);
        let v7 = v6;
        let v8 = v5;
        0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::market::add_rule<0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::seal::SiaynoqSeal>(&mut v8, &v7);
        let v9 = PolicyLock{
            id    : 0x2::object::new(arg1),
            spice : v3,
            seal  : v7,
        };
        0x2::transfer::freeze_object<PolicyLock>(v9);
        let (v10, v11) = 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::seal::create(arg1);
        let v12 = v11;
        let v13 = 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::launch::owner_orders();
        let v14 = 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::launch::owner_holders();
        let v15 = 0;
        while (v15 < 0x1::vector::length<0x1::string::String>(&v13)) {
            0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::seal::issue_at_publish(&mut v12, &v8, *0x1::vector::borrow<0x1::string::String>(&v13, v15), *0x1::vector::borrow<address>(&v14, v15), arg1);
            v15 = v15 + 1;
        };
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice::Spice>>(v4);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::seal::SiaynoqSeal>>(v8);
        0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::seal::share_registry(v12);
        0x2::transfer::public_transfer<0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::seal::SealIssuerCap>(v10, v0);
        0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::market::share(0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::market::create(600, 600, arg1));
        0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::revenue::share(0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::revenue::create(arg1));
        let v16 = 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice::create(arg1);
        let v17 = 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::rebate::create_named(0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::launch::soos_coin(), 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::launch::ref_value(), 600, arg1);
        0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice::set_rebate_vault(&mut v16, 0x2::object::id<0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::rebate::RebateVault>(&v17));
        0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::rebate::share(v17);
        0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::spice::share(v16);
        0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::soos_yield::share(0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::soos_yield::create_named(0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::launch::soos_coin(), 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::launch::usdc_coin(), 800, 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::launch::price_e12(), arg1));
        let v18 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v18, v0);
    }

    public fun withdraw_rebate<T0>(arg0: &AdminCap, arg1: &mut 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::rebate::RebateVault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::rebate::withdraw<T0>(arg1, arg2, arg3)
    }

    public fun withdraw_yield_rewards<T0, T1>(arg0: &AdminCap, arg1: &mut 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::soos_yield::YieldPool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::soos_yield::withdraw_rewards<T0, T1>(arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

