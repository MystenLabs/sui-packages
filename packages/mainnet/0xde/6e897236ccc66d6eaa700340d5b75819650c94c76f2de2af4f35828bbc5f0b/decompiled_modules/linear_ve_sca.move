module 0xde6e897236ccc66d6eaa700340d5b75819650c94c76f2de2af4f35828bbc5f0b::linear_ve_sca {
    struct LINEAR_VE_SCA_ISSUER has drop {
        dummy_field: bool,
    }

    struct LinearVeScaConfig has key {
        id: 0x2::object::UID,
        issuers: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        vesting_model: 0xde6e897236ccc66d6eaa700340d5b75819650c94c76f2de2af4f35828bbc5f0b::vesting_model::VestingModel,
    }

    struct LinearVeScaCap has store, key {
        id: 0x2::object::UID,
    }

    public fun mint<T0: drop>(arg0: T0, arg1: &LinearVeScaConfig, arg2: &mut 0xa4e82763f9c719570d948e47dfc42992d35b29c756c59d367e81f00d6a685bd1::ve_sca::VeScaTreasury, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xa4e82763f9c719570d948e47dfc42992d35b29c756c59d367e81f00d6a685bd1::ve_sca::VeSca {
        assert_is_issuer<T0>(arg1);
        let v0 = LINEAR_VE_SCA_ISSUER{dummy_field: false};
        0xa4e82763f9c719570d948e47dfc42992d35b29c756c59d367e81f00d6a685bd1::ve_sca::mint<LINEAR_VE_SCA_ISSUER>(v0, arg2, arg3, arg4, arg5)
    }

    public fun add_issuer<T0: drop>(arg0: &LinearVeScaCap, arg1: &mut LinearVeScaConfig) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.issuers, 0x1::type_name::get<T0>());
    }

    public fun assert_is_issuer<T0: drop>(arg0: &LinearVeScaConfig) {
        assert!(is_issuer<T0>(arg0), 403);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LinearVeScaConfig{
            id            : 0x2::object::new(arg0),
            issuers       : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            vesting_model : 0xde6e897236ccc66d6eaa700340d5b75819650c94c76f2de2af4f35828bbc5f0b::vesting_model::new(0, 86400),
        };
        let v1 = LinearVeScaCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<LinearVeScaConfig>(v0);
        0x2::transfer::transfer<LinearVeScaCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_issuer<T0: drop>(arg0: &LinearVeScaConfig) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.issuers, &v0)
    }

    public fun redeem<T0: drop>(arg0: T0, arg1: &LinearVeScaConfig, arg2: &mut 0xa4e82763f9c719570d948e47dfc42992d35b29c756c59d367e81f00d6a685bd1::ve_sca::VeScaTreasury, arg3: 0xa4e82763f9c719570d948e47dfc42992d35b29c756c59d367e81f00d6a685bd1::ve_sca::VeSca, arg4: &mut 0x3a4062f38c5288228a45654f1bb3c6578981f9d6af1b78926764d31586fee2c7::sca::ScaTreasury, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x3a4062f38c5288228a45654f1bb3c6578981f9d6af1b78926764d31586fee2c7::sca::SCA> {
        assert_is_issuer<T0>(arg1);
        let v0 = LINEAR_VE_SCA_ISSUER{dummy_field: false};
        0xa4e82763f9c719570d948e47dfc42992d35b29c756c59d367e81f00d6a685bd1::ve_sca::burn<LINEAR_VE_SCA_ISSUER>(v0, arg2, arg3);
        let v1 = LINEAR_VE_SCA_ISSUER{dummy_field: false};
        0x3a4062f38c5288228a45654f1bb3c6578981f9d6af1b78926764d31586fee2c7::sca::mint<LINEAR_VE_SCA_ISSUER>(v1, arg4, 0xde6e897236ccc66d6eaa700340d5b75819650c94c76f2de2af4f35828bbc5f0b::vesting_model::calc_vested_amount(&arg1.vesting_model, 0xa4e82763f9c719570d948e47dfc42992d35b29c756c59d367e81f00d6a685bd1::ve_sca::value(&arg3), 0xa4e82763f9c719570d948e47dfc42992d35b29c756c59d367e81f00d6a685bd1::ve_sca::mint_timestamp(&arg3), arg5), arg6)
    }

    public fun remove_issuer<T0: drop>(arg0: &LinearVeScaCap, arg1: &mut LinearVeScaConfig) {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg1.issuers, &v0);
    }

    public fun update_vesting_model(arg0: &LinearVeScaCap, arg1: &mut LinearVeScaConfig, arg2: u64, arg3: u64) {
        arg1.vesting_model = 0xde6e897236ccc66d6eaa700340d5b75819650c94c76f2de2af4f35828bbc5f0b::vesting_model::new(arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

