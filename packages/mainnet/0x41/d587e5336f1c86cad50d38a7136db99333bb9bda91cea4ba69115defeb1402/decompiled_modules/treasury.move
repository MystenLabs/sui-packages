module 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury {
    struct CollateralKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct TreasuryCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        roles: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::Roles,
        deny_cap: 0x2::coin::DenyCapV2<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::sui_usde::SUI_USDE>,
        metadata_cap: 0x2::coin_registry::MetadataCap<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::sui_usde::SUI_USDE>,
        config: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::Config,
        collaterals: 0x2::bag::Bag,
        benefactors: 0x2::bag::Bag,
    }

    public(friend) fun config(arg0: &Treasury) : &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::Config {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::assert_valid_version(&arg0.config);
        &arg0.config
    }

    public(friend) fun roles(arg0: &Treasury) : &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::Roles {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::assert_valid_version(&arg0.config);
        &arg0.roles
    }

    public(friend) fun add_benefactor(arg0: &mut Treasury, arg1: address, arg2: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::benefactor_config::BenefactorConfig) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::assert_valid_version(&arg0.config);
        let v0 = roles_mut(arg0);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::authorize<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::BenefactorRole>(v0, arg1);
        0x2::bag::add<address, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::benefactor_config::BenefactorConfig>(&mut arg0.benefactors, arg1, arg2);
    }

    public(friend) fun add_collateral<T0>(arg0: &mut Treasury, arg1: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::CollateralConfig<T0>) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::assert_valid_version(&arg0.config);
        let v0 = CollateralKey<T0>{dummy_field: false};
        assert!(!0x2::bag::contains<CollateralKey<T0>>(&arg0.collaterals, v0), 13835903184587194373);
        let v1 = CollateralKey<T0>{dummy_field: false};
        0x2::bag::add<CollateralKey<T0>, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::CollateralConfig<T0>>(&mut arg0.collaterals, v1, arg1);
    }

    public(friend) fun benefactor(arg0: &Treasury, arg1: address) : &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::benefactor_config::BenefactorConfig {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::assert_valid_version(&arg0.config);
        assert!(0x2::bag::contains<address>(&arg0.benefactors, arg1), 13835621649480810499);
        0x2::bag::borrow<address, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::benefactor_config::BenefactorConfig>(&arg0.benefactors, arg1)
    }

    public(friend) fun benefactor_mut(arg0: &mut Treasury, arg1: address) : &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::benefactor_config::BenefactorConfig {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::assert_valid_version(&arg0.config);
        assert!(0x2::bag::contains<address>(&arg0.benefactors, arg1), 13835621679545581571);
        0x2::bag::borrow_mut<address, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::benefactor_config::BenefactorConfig>(&mut arg0.benefactors, arg1)
    }

    public(friend) fun collateral<T0>(arg0: &Treasury) : &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::CollateralConfig<T0> {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::assert_valid_version(&arg0.config);
        let v0 = CollateralKey<T0>{dummy_field: false};
        assert!(0x2::bag::contains<CollateralKey<T0>>(&arg0.collaterals, v0), 13835340110079459329);
        let v1 = CollateralKey<T0>{dummy_field: false};
        0x2::bag::borrow<CollateralKey<T0>, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::CollateralConfig<T0>>(&arg0.collaterals, v1)
    }

    public(friend) fun collateral_mut<T0>(arg0: &mut Treasury) : &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::CollateralConfig<T0> {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::assert_valid_version(&arg0.config);
        let v0 = CollateralKey<T0>{dummy_field: false};
        assert!(0x2::bag::contains<CollateralKey<T0>>(&arg0.collaterals, v0), 13835340144439197697);
        let v1 = CollateralKey<T0>{dummy_field: false};
        0x2::bag::borrow_mut<CollateralKey<T0>, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::CollateralConfig<T0>>(&mut arg0.collaterals, v1)
    }

    public(friend) fun config_mut(arg0: &mut Treasury) : &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::Config {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::assert_valid_version(&arg0.config);
        &mut arg0.config
    }

    public(friend) fun config_mut_for_version_update(arg0: &mut Treasury) : &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::Config {
        &mut arg0.config
    }

    public fun create(arg0: 0x2::coin::TreasuryCap<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::sui_usde::SUI_USDE>, arg1: 0x2::coin::DenyCapV2<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::sui_usde::SUI_USDE>, arg2: 0x2::coin_registry::MetadataCap<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::sui_usde::SUI_USDE>, arg3: 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::Config, arg4: &mut 0x2::tx_context::TxContext) : Treasury {
        let v0 = 0x2::object::new(arg4);
        let v1 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryCapKey, 0x2::coin::TreasuryCap<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::sui_usde::SUI_USDE>>(&mut v0, v1, arg0);
        let v2 = 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::new(arg4);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::authorize<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::AdminRole>(&mut v2, 0x2::tx_context::sender(arg4));
        Treasury{
            id           : v0,
            roles        : v2,
            deny_cap     : arg1,
            metadata_cap : arg2,
            config       : arg3,
            collaterals  : 0x2::bag::new(arg4),
            benefactors  : 0x2::bag::new(arg4),
        }
    }

    public(friend) fun deny_cap_mut(arg0: &mut Treasury) : &mut 0x2::coin::DenyCapV2<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::sui_usde::SUI_USDE> {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::assert_valid_version(&arg0.config);
        &mut arg0.deny_cap
    }

    public(friend) fun has_benefactor(arg0: &Treasury, arg1: address) : bool {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::assert_valid_version(&arg0.config);
        0x2::bag::contains<address>(&arg0.benefactors, arg1)
    }

    public(friend) fun has_collateral<T0>(arg0: &Treasury) : bool {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::assert_valid_version(&arg0.config);
        let v0 = CollateralKey<T0>{dummy_field: false};
        0x2::bag::contains<CollateralKey<T0>>(&arg0.collaterals, v0)
    }

    public(friend) fun receive_coin<T0>(arg0: &mut Treasury, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) : 0x2::coin::Coin<T0> {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::assert_valid_version(&arg0.config);
        0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1)
    }

    public(friend) fun remove_benefactor(arg0: &mut Treasury, arg1: address) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::assert_valid_version(&arg0.config);
        let v0 = roles_mut(arg0);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::deauthorize<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::BenefactorRole>(v0, arg1);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::benefactor_config::destroy(0x2::bag::remove<address, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::benefactor_config::BenefactorConfig>(&mut arg0.benefactors, arg1));
    }

    public(friend) fun remove_collateral<T0>(arg0: &mut Treasury) {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::assert_valid_version(&arg0.config);
        let v0 = CollateralKey<T0>{dummy_field: false};
        assert!(0x2::bag::contains<CollateralKey<T0>>(&arg0.collaterals, v0), 13835340260403314689);
        let v1 = CollateralKey<T0>{dummy_field: false};
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::destroy<T0>(0x2::bag::remove<CollateralKey<T0>, 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::collateral_config::CollateralConfig<T0>>(&mut arg0.collaterals, v1));
    }

    public(friend) fun roles_for_version_update(arg0: &Treasury) : &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::Roles {
        &arg0.roles
    }

    public(friend) fun roles_mut(arg0: &mut Treasury) : &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::roles::Roles {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::assert_valid_version(&arg0.config);
        &mut arg0.roles
    }

    public fun share(arg0: Treasury) {
        0x2::transfer::share_object<Treasury>(arg0);
    }

    public(friend) fun treasury_cap_mut(arg0: &mut Treasury) : &mut 0x2::coin::TreasuryCap<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::sui_usde::SUI_USDE> {
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::config::assert_valid_version(&arg0.config);
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<TreasuryCapKey, 0x2::coin::TreasuryCap<0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::sui_usde::SUI_USDE>>(&mut arg0.id, v0)
    }

    // decompiled from Move bytecode v6
}

