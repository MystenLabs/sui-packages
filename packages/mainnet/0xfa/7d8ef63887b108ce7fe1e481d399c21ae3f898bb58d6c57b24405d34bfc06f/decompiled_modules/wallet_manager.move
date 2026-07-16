module 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::wallet_manager {
    public fun remove_special_wallet<T0>(arg0: &mut 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::InvestorInfo<T0>, arg1: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Auth<T0>, arg2: address, arg3: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::check_is_valid(arg3);
        assert!(0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::owner_has_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::RemoveSpecialWallet>(arg1, 0x2::tx_context::sender(arg4)), 13835902935479353353);
        assert!(0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::is_special_wallet<T0>(arg0, arg2), 13835621464797478919);
        assert!(0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::special_wallet_balance<T0>(arg0, arg2) == 0, 13836184419046129675);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::events::emit_special_wallet_removed_event<T0>(arg2, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::remove_special_wallet<T0>(arg0, arg2), 0x2::tx_context::sender(arg4));
    }

    fun set_special_wallet<T0>(arg0: &mut 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::InvestorInfo<T0>, arg1: &mut 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::namespace::Namespace, arg2: address, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(!0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::is_wallet<T0>(arg0, arg2), 13835058579268304899);
        assert!(!0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::is_special_wallet<T0>(arg0, arg2), 13835340058540113925);
        if (!0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::namespace::account_exists(arg1, arg2)) {
            0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::account::create_and_share(arg1, arg2);
        };
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::set_special_wallet<T0>(arg0, arg2, arg3);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::events::emit_special_wallet_added_event<T0>(arg2, arg3, 0x2::tx_context::sender(arg4));
    }

    public fun add_issuer_wallet<T0>(arg0: &mut 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::InvestorInfo<T0>, arg1: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Auth<T0>, arg2: &mut 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::namespace::Namespace, arg3: address, arg4: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::check_is_valid(arg4);
        assert!(0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::owner_has_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::SetIssuerWallet>(arg1, 0x2::tx_context::sender(arg5)), 13835902772270596105);
        set_special_wallet<T0>(arg0, arg2, arg3, 1, arg5);
    }

    public fun add_platform_wallet<T0>(arg0: &mut 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::InvestorInfo<T0>, arg1: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Auth<T0>, arg2: &mut 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::namespace::Namespace, arg3: address, arg4: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::check_is_valid(arg4);
        assert!(0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::owner_has_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::SetPlatformWallet>(arg1, 0x2::tx_context::sender(arg5)), 13835902858169942025);
        set_special_wallet<T0>(arg0, arg2, arg3, 2, arg5);
    }

    public fun is_issuer_wallet<T0>(arg0: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::InvestorInfo<T0>, arg1: address) : bool {
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::get_special_wallet_type<T0>(arg0, arg1) == 1
    }

    public fun is_platform_wallet<T0>(arg0: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::InvestorInfo<T0>, arg1: address) : bool {
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::get_special_wallet_type<T0>(arg0, arg1) == 2
    }

    public(friend) fun new<T0: key>(arg0: &mut 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Auth<T0>, arg1: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::Version, arg2: &0x2::tx_context::TxContext) {
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::add_role_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Master, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::SetIssuerWallet>(arg0, arg1, arg2);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::add_role_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Master, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::SetPlatformWallet>(arg0, arg1, arg2);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::add_role_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Master, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::RemoveSpecialWallet>(arg0, arg1, arg2);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::add_role_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Issuer, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::SetIssuerWallet>(arg0, arg1, arg2);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::add_role_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Issuer, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::SetPlatformWallet>(arg0, arg1, arg2);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::add_role_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Issuer, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::RemoveSpecialWallet>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

