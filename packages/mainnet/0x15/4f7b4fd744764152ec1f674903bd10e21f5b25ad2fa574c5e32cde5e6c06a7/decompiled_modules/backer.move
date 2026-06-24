module 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::backer {
    struct TierConfig has store {
        tier: u8,
        price: u64,
        max_supply: u64,
        minted: u64,
        deposit_cap_multiplier: u64,
        yield_share_bps: u64,
    }

    struct TierConfigKey has copy, drop, store {
        tier: u8,
    }

    struct BackerPass has store, key {
        id: 0x2::object::UID,
        launch_id: 0x2::object::ID,
        tier: u8,
        deposit_cap_multiplier: u64,
        yield_share_bps: u64,
        passes_used: u64,
    }

    public entry fun add_tier<T0>(arg0: &mut 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::VaultLaunch, arg1: &0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::config::LaunchCreatorCap, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = TierConfigKey{tier: arg2};
        let v1 = 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::uid_mut(arg0);
        assert!(!0x2::dynamic_field::exists_<TierConfigKey>(v1, v0), 301);
        let v2 = TierConfig{
            tier                   : arg2,
            price                  : arg3,
            max_supply             : arg4,
            minted                 : 0,
            deposit_cap_multiplier : arg5,
            yield_share_bps        : arg6,
        };
        0x2::dynamic_field::add<TierConfigKey, TierConfig>(v1, v0, v2);
    }

    public fun deposit_cap_multiplier(arg0: &BackerPass) : u64 {
        arg0.deposit_cap_multiplier
    }

    public fun launch_id(arg0: &BackerPass) : 0x2::object::ID {
        arg0.launch_id
    }

    public entry fun mint_backer_pass<T0>(arg0: &mut 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::VaultLaunch, arg1: 0x2::coin::Coin<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = TierConfigKey{tier: arg2};
        let v1 = 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::id(arg0);
        let v2 = 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::uid_mut(arg0);
        assert!(0x2::dynamic_field::exists_<TierConfigKey>(v2, v0), 301);
        let v3 = 0x2::dynamic_field::borrow_mut<TierConfigKey, TierConfig>(v2, v0);
        assert!(v3.minted < v3.max_supply, 300);
        assert!(0x2::coin::value<T0>(&arg1) == v3.price, 200);
        v3.minted = v3.minted + 1;
        let v4 = 0x2::object::new(arg3);
        let v5 = BackerPass{
            id                     : v4,
            launch_id              : v1,
            tier                   : arg2,
            deposit_cap_multiplier : v3.deposit_cap_multiplier,
            yield_share_bps        : v3.yield_share_bps,
            passes_used            : 0,
        };
        0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::events::emit_backer_pass_minted(v1, 0x2::object::uid_to_inner(&v4), 0x2::tx_context::sender(arg3), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::creator(arg0));
        0x2::transfer::transfer<BackerPass>(v5, 0x2::tx_context::sender(arg3));
    }

    public fun passes_used(arg0: &BackerPass) : u64 {
        arg0.passes_used
    }

    public fun tier(arg0: &BackerPass) : u8 {
        arg0.tier
    }

    public fun use_pass(arg0: &mut BackerPass, arg1: &0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::VaultLaunch) {
        assert!(arg0.launch_id == 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::id(arg1), 302);
        assert!(arg0.passes_used < 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch::max_backer_passes(arg1), 201);
        arg0.passes_used = arg0.passes_used + 1;
    }

    public fun yield_share_bps(arg0: &BackerPass) : u64 {
        arg0.yield_share_bps
    }

    // decompiled from Move bytecode v7
}

