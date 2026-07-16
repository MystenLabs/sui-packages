module 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::compliance_service {
    struct ComplianceServiceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct ComplianceConfig<phantom T0> has key {
        id: 0x2::object::UID,
        rules_bag: 0x2::bag::Bag,
        rules: vector<0x1::type_name::TypeName>,
    }

    struct TransferInfo has copy, drop {
        amount: u64,
        equal_country: bool,
        equal_region: bool,
        timestamp_ms: u64,
    }

    struct IssuanceInfo has copy, drop {
        amount: u64,
        total_supply: u64,
        timestamp_ms: u64,
    }

    struct PartyInfo has copy, drop {
        addr: address,
        investor_id: 0x1::option::Option<0x1::string::String>,
        country: 0x1::string::String,
        region: u64,
        balance: u64,
        transferable_balance: u64,
        is_accredited: bool,
        is_qualified: bool,
        is_exit_investor: bool,
        is_new_investor: bool,
        is_special_wallet: bool,
    }

    public(friend) fun new<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Auth<T0>, arg2: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::Version, arg3: &mut 0x2::tx_context::TxContext) : ComplianceConfig<T0> {
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::add_role_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Master, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::RegisterRule>(arg1, arg2, arg3);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::add_role_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Master, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::UnregisterRule>(arg1, arg2, arg3);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::add_role_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Master, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::SetCountryCompliance>(arg1, arg2, arg3);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::add_role_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Master, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::ManageRules>(arg1, arg2, arg3);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::add_role_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::TransferAgent, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::RegisterRule>(arg1, arg2, arg3);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::add_role_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::TransferAgent, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::UnregisterRule>(arg1, arg2, arg3);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::add_role_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::TransferAgent, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::SetCountryCompliance>(arg1, arg2, arg3);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::add_role_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::TransferAgent, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::ManageRules>(arg1, arg2, arg3);
        let v0 = ComplianceServiceKey<T0>{dummy_field: false};
        ComplianceConfig<T0>{
            id        : 0x2::derived_object::claim<ComplianceServiceKey<T0>>(arg0, v0),
            rules_bag : 0x2::bag::new(arg3),
            rules     : 0x1::vector::empty<0x1::type_name::TypeName>(),
        }
    }

    public(friend) fun adjust_total_investors_counts<T0>(arg0: &mut 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::InvestorInfo<T0>, arg1: address, arg2: bool, arg3: bool) {
        if (arg2) {
            return
        };
        let v0 = 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::get_total_investors_count<T0>(arg0);
        if (arg3) {
            0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::set_total_investors_count_internal<T0>(arg0, v0 + 1);
        } else {
            assert!(v0 > 0, 13836186291651739657);
            0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::set_total_investors_count_internal<T0>(arg0, v0 - 1);
        };
        let v1 = 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::get_investor_id_by_wallet<T0>(arg0, arg1);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::adjust_investors_counts_by_country<T0>(arg0, v1, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::get_country<T0>(arg0, v1), arg3);
    }

    fun assert_and_compute_transferable_balance<T0>(arg0: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::InvestorInfo<T0>, arg1: &PartyInfo, arg2: u64, arg3: u64) : u64 {
        if (arg1.is_special_wallet) {
            return arg1.balance
        };
        let v0 = 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::lock_manager::compute_transferable<T0>(arg0, *0x1::option::borrow<0x1::string::String>(&arg1.investor_id), arg1.balance, arg3);
        assert!(v0 >= arg2, 13836750611699859467);
        v0
    }

    fun assert_not_liquidate_only<T0>(arg0: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::InvestorInfo<T0>, arg1: &PartyInfo) {
        if (arg1.is_special_wallet) {
            return
        };
        assert!(!0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::lock_manager::is_liquidate_only<T0>(arg0, *0x1::option::borrow<0x1::string::String>(&arg1.investor_id)), 13837032129626374157);
    }

    public fun borrow_rule<T0, T1: drop + store>(arg0: &ComplianceConfig<T0>) : &T1 {
        0x2::bag::borrow<0x1::type_name::TypeName, T1>(&arg0.rules_bag, 0x1::type_name::with_defining_ids<T1>())
    }

    fun cleanup_party_issuances<T0>(arg0: &ComplianceConfig<T0>, arg1: &mut 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::InvestorInfo<T0>, arg2: &PartyInfo, arg3: u64) {
        if (!arg2.is_special_wallet) {
            let v0 = 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::get_investor_issuances_mut<T0>(arg1, *0x1::option::borrow<0x1::string::String>(&arg2.investor_id));
            let v1 = get_lock_period_ms<T0>(arg0, arg2.region);
            if (v1 == 0) {
                while (!0x1::vector::is_empty<0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::Issuance>(v0)) {
                    0x1::vector::pop_back<0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::Issuance>(v0);
                };
                return
            };
            let v2 = 0;
            while (v2 < 0x1::vector::length<0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::Issuance>(v0)) {
                let v3 = 0x1::u256::try_as_u64((0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::issuance_time_ms(0x1::vector::borrow<0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::Issuance>(v0, v2)) as u256) + (v1 as u256));
                assert!(0x1::option::is_some<u64>(&v3), 13837876644751212563);
                if (0x1::option::extract<u64>(&mut v3) <= arg3) {
                    0x1::vector::swap_remove<0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::Issuance>(v0, v2);
                    continue
                };
                v2 = v2 + 1;
            };
            return
        };
    }

    public fun get_country_compliance<T0>(arg0: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::InvestorInfo<T0>, arg1: 0x1::string::String) : u64 {
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::get_country_compliance<T0>(arg0, arg1)
    }

    fun get_lock_period_ms<T0>(arg0: &ComplianceConfig<T0>, arg1: u64) : u64 {
        if (has_rule<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::lockup_restriction::LockupRestriction>(arg0)) {
            0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::lockup_restriction::lock_period_for_region(0x2::bag::borrow<0x1::type_name::TypeName, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::lockup_restriction::LockupRestriction>(&arg0.rules_bag, 0x1::type_name::with_defining_ids<0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::lockup_restriction::LockupRestriction>()), arg1)
        } else {
            0
        }
    }

    fun get_party_info<T0>(arg0: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::InvestorInfo<T0>, arg1: address, arg2: u64) : PartyInfo {
        if (0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::is_special_wallet<T0>(arg0, arg1)) {
            return PartyInfo{
                addr                 : arg1,
                investor_id          : 0x1::option::none<0x1::string::String>(),
                country              : 0x1::string::utf8(b""),
                region               : 0,
                balance              : 0,
                transferable_balance : 0,
                is_accredited        : false,
                is_qualified         : false,
                is_exit_investor     : false,
                is_new_investor      : false,
                is_special_wallet    : true,
            }
        };
        let v0 = 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::get_investor_id_by_wallet<T0>(arg0, arg1);
        let v1 = 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::get_country<T0>(arg0, v0);
        let v2 = 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::investor_wallet_balance_total<T0>(arg0, v0);
        PartyInfo{
            addr                 : arg1,
            investor_id          : 0x1::option::some<0x1::string::String>(v0),
            country              : v1,
            region               : 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::get_country_compliance<T0>(arg0, v1),
            balance              : v2,
            transferable_balance : v2,
            is_accredited        : 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::is_accredited_investor_by_id<T0>(arg0, v0),
            is_qualified         : 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::is_qualified_investor_by_id<T0>(arg0, v0),
            is_exit_investor     : v2 == arg2,
            is_new_investor      : v2 == 0,
            is_special_wallet    : false,
        }
    }

    public fun get_rule<T0, T1: drop + store>(arg0: &mut ComplianceConfig<T0>, arg1: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Auth<T0>, arg2: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::Version, arg3: &0x2::tx_context::TxContext) : 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::RuleUpdateWrapper<T0, T1> {
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::check_is_valid(arg2);
        assert!(0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::owner_has_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::ManageRules>(arg1, 0x2::tx_context::sender(arg3)), 13837592871966867473);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::new_update<T0, T1>(0x2::bag::remove<0x1::type_name::TypeName, T1>(&mut arg0.rules_bag, 0x1::type_name::with_defining_ids<T1>()))
    }

    fun handle_issuance_to_special_wallet_exit<T0>(arg0: &ComplianceConfig<T0>, arg1: &IssuanceInfo, arg2: &PartyInfo) : bool {
        if (!arg2.is_special_wallet) {
            return false
        };
        if (has_rule<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::authorized_securities::AuthorizedSecurities>(arg0)) {
            0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::authorized_securities::validate_rule(0x2::bag::borrow<0x1::type_name::TypeName, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::authorized_securities::AuthorizedSecurities>(&arg0.rules_bag, 0x1::type_name::with_defining_ids<0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::authorized_securities::AuthorizedSecurities>()), arg1.total_supply, arg1.amount);
        };
        true
    }

    fun handle_same_investor_exit<T0>(arg0: &ComplianceConfig<T0>, arg1: &mut 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::InvestorInfo<T0>, arg2: &TransferInfo, arg3: &PartyInfo, arg4: &PartyInfo) : bool {
        if (!is_same_investor(arg3, arg4)) {
            return false
        };
        record_transfer<T0>(arg0, arg1, arg2, arg3, arg4);
        true
    }

    fun handle_transfer_to_special_wallet_exit<T0>(arg0: &ComplianceConfig<T0>, arg1: &mut 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::InvestorInfo<T0>, arg2: &TransferInfo, arg3: &PartyInfo, arg4: &PartyInfo) : bool {
        if (!arg4.is_special_wallet) {
            return false
        };
        if (has_rule<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::force_full_transfer::ForceFullTransfer>(arg0)) {
            0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::force_full_transfer::validate_rule(0x2::bag::borrow<0x1::type_name::TypeName, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::force_full_transfer::ForceFullTransfer>(&arg0.rules_bag, 0x1::type_name::with_defining_ids<0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::force_full_transfer::ForceFullTransfer>()), arg3.region, arg3.is_special_wallet, arg3.is_exit_investor);
        };
        record_transfer<T0>(arg0, arg1, arg2, arg3, arg4);
        true
    }

    public fun has_rule<T0, T1: store>(arg0: &ComplianceConfig<T0>) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        0x1::vector::contains<0x1::type_name::TypeName>(&arg0.rules, &v0)
    }

    fun is_same_investor(arg0: &PartyInfo, arg1: &PartyInfo) : bool {
        if (arg0.is_special_wallet || arg1.is_special_wallet) {
            return false
        };
        *0x1::option::borrow<0x1::string::String>(&arg0.investor_id) == *0x1::option::borrow<0x1::string::String>(&arg1.investor_id)
    }

    public(friend) fun record_burn<T0>(arg0: &mut 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::InvestorInfo<T0>, arg1: &PartyInfo, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        if (arg1.is_exit_investor) {
            adjust_total_investors_counts<T0>(arg0, arg1.addr, arg1.is_special_wallet, false);
        };
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::events::emit_compliance_burn_recorded_event<T0>(arg1.addr, arg2);
    }

    public(friend) fun record_investor_issuance<T0>(arg0: &mut 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::InvestorInfo<T0>, arg1: 0x1::string::String, arg2: u64, arg3: u64) {
        if (arg2 == 0) {
            return
        };
        0x1::vector::push_back<0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::Issuance>(0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::get_investor_issuances_mut<T0>(arg0, arg1), 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::new_issuance(arg2, arg3));
    }

    public(friend) fun record_issuance<T0>(arg0: &ComplianceConfig<T0>, arg1: &mut 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::InvestorInfo<T0>, arg2: &IssuanceInfo, arg3: &PartyInfo, arg4: u64) {
        if (arg2.amount == 0) {
            return
        };
        if (arg3.is_new_investor) {
            adjust_total_investors_counts<T0>(arg1, arg3.addr, arg3.is_special_wallet, true);
        };
        if (!arg3.is_special_wallet) {
            0x1::vector::push_back<0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::Issuance>(0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::get_investor_issuances_mut<T0>(arg1, *0x1::option::borrow<0x1::string::String>(&arg3.investor_id)), 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::new_issuance(arg2.amount, arg2.timestamp_ms));
        };
        cleanup_party_issuances<T0>(arg0, arg1, arg3, arg4);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::events::emit_compliance_issuance_recorded_event<T0>(arg3.addr, arg2.amount);
    }

    public(friend) fun record_seize<T0>(arg0: &mut 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::InvestorInfo<T0>, arg1: &PartyInfo, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        if (arg1.is_exit_investor) {
            adjust_total_investors_counts<T0>(arg0, arg1.addr, arg1.is_special_wallet, false);
        };
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::events::emit_compliance_seize_recorded_event<T0>(arg1.addr, arg2);
    }

    public(friend) fun record_transfer<T0>(arg0: &ComplianceConfig<T0>, arg1: &mut 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::InvestorInfo<T0>, arg2: &TransferInfo, arg3: &PartyInfo, arg4: &PartyInfo) {
        if (arg2.amount == 0) {
            return
        };
        if (arg4.is_new_investor) {
            adjust_total_investors_counts<T0>(arg1, arg4.addr, arg4.is_special_wallet, true);
        };
        if (!is_same_investor(arg3, arg4) && arg3.is_exit_investor) {
            adjust_total_investors_counts<T0>(arg1, arg3.addr, arg3.is_special_wallet, false);
        };
        cleanup_party_issuances<T0>(arg0, arg1, arg3, arg2.timestamp_ms);
        cleanup_party_issuances<T0>(arg0, arg1, arg4, arg2.timestamp_ms);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::events::emit_compliance_transfer_recorded_event<T0>(arg3.addr, arg4.addr, arg2.amount);
    }

    public fun register_rule<T0, T1: store>(arg0: &mut ComplianceConfig<T0>, arg1: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Auth<T0>, arg2: 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::RuleInitWrapper<T0, T1>, arg3: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::check_is_valid(arg3);
        assert!(0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::owner_has_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::RegisterRule>(arg1, 0x2::tx_context::sender(arg4)), 13837592635743666193);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg0.rules, &v0), 13835340848813965315);
        0x2::bag::add<0x1::type_name::TypeName, T1>(&mut arg0.rules_bag, v0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::unwrap_init<T0, T1>(arg2));
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.rules, v0);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::events::emit_compliance_rule_added_event<T0>(v0);
    }

    fun resolve_issuance_time<T0>(arg0: &ComplianceConfig<T0>, arg1: u64, arg2: u64) : u64 {
        if (!has_rule<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::backdating_issuance::BackdatingIssuance>(arg0)) {
            return arg2
        };
        if (0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::backdating_issuance::is_backdating_allowed(0x2::bag::borrow<0x1::type_name::TypeName, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::backdating_issuance::BackdatingIssuance>(&arg0.rules_bag, 0x1::type_name::with_defining_ids<0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::backdating_issuance::BackdatingIssuance>()))) {
            arg1
        } else {
            arg2
        }
    }

    public fun return_rule<T0, T1: drop + store>(arg0: &mut ComplianceConfig<T0>, arg1: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Auth<T0>, arg2: 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::RuleUpdateWrapper<T0, T1>, arg3: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::check_is_valid(arg3);
        assert!(0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::owner_has_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::ManageRules>(arg1, 0x2::tx_context::sender(arg4)), 13837592953571246097);
        0x2::bag::add<0x1::type_name::TypeName, T1>(&mut arg0.rules_bag, 0x1::type_name::with_defining_ids<T1>(), 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::rule_wrapper::unwrap_update<T0, T1>(arg2));
    }

    public fun rules_vector<T0>(arg0: &ComplianceConfig<T0>) : &vector<0x1::type_name::TypeName> {
        &arg0.rules
    }

    public fun set_country_compliance<T0>(arg0: &mut 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::InvestorInfo<T0>, arg1: 0x1::string::String, arg2: u64, arg3: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Auth<T0>, arg4: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::Version, arg5: &0x2::tx_context::TxContext) {
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::check_is_valid(arg4);
        assert!(0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::owner_has_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::SetCountryCompliance>(arg3, 0x2::tx_context::sender(arg5)), 13837593091010199569);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::set_country_compliance<T0>(arg0, arg1, arg2);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::events::emit_string_to_uint_map_rule_set_event<T0>(0x1::string::utf8(b"countryCompliance"), arg1, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::get_country_compliance<T0>(arg0, arg1), arg2);
    }

    public(friend) fun share<T0>(arg0: ComplianceConfig<T0>) {
        0x2::transfer::share_object<ComplianceConfig<T0>>(arg0);
    }

    public fun unregister_rule<T0, T1: drop + store>(arg0: &mut ComplianceConfig<T0>, arg1: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::Auth<T0>, arg2: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::Version, arg3: &0x2::tx_context::TxContext) {
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::check_is_valid(arg2);
        assert!(0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::trust_service::owner_has_ability<T0, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::abilities::UnregisterRule>(arg1, 0x2::tx_context::sender(arg3)), 13837592743117848593);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let (v1, v2) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.rules, &v0);
        assert!(v1, 13835059485506273281);
        0x1::vector::remove<0x1::type_name::TypeName>(&mut arg0.rules, v2);
        0x2::bag::remove<0x1::type_name::TypeName, T1>(&mut arg0.rules_bag, v0);
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::events::emit_compliance_rule_removed_event<T0>(v0);
    }

    public(friend) fun validate_burn<T0>(arg0: &mut 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::InvestorInfo<T0>, arg1: address, arg2: u64) {
        let v0 = get_party_info<T0>(arg0, arg1, arg2);
        record_burn<T0>(arg0, &v0, arg2);
    }

    fun validate_issuance_rule<T0>(arg0: &ComplianceConfig<T0>, arg1: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::InvestorInfo<T0>, arg2: 0x1::type_name::TypeName, arg3: &IssuanceInfo, arg4: &PartyInfo) {
        if (arg2 == 0x1::type_name::with_defining_ids<0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::accredited_only::AccreditedOnly>()) {
            0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::accredited_only::validate_rule(0x2::bag::borrow<0x1::type_name::TypeName, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::accredited_only::AccreditedOnly>(&arg0.rules_bag, arg2), arg4.region, arg4.is_accredited);
        } else if (arg2 == 0x1::type_name::with_defining_ids<0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::holding_limits::HoldingLimits>()) {
            0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::holding_limits::validate_holding_limits_for_issuance(0x2::bag::borrow<0x1::type_name::TypeName, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::holding_limits::HoldingLimits>(&arg0.rules_bag, arg2), arg3.amount, arg4.balance, arg4.region);
        } else if (arg2 == 0x1::type_name::with_defining_ids<0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::investor_limits::InvestorLimits>()) {
            0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::investor_limits::validate_investor_limits_for_issuance<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::investor_limits::InvestorLimits>(&arg0.rules_bag, arg2), arg1, arg4.region, arg4.country, arg4.is_accredited, arg4.is_qualified, arg4.is_new_investor);
        } else if (arg2 == 0x1::type_name::with_defining_ids<0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::authorized_securities::AuthorizedSecurities>()) {
            0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::authorized_securities::validate_rule(0x2::bag::borrow<0x1::type_name::TypeName, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::authorized_securities::AuthorizedSecurities>(&arg0.rules_bag, arg2), arg3.total_supply, arg3.amount);
        };
    }

    public(friend) fun validate_issue<T0>(arg0: &ComplianceConfig<T0>, arg1: &mut 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::InvestorInfo<T0>, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::Version) {
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::check_is_valid(arg7);
        assert!(0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::is_special_wallet<T0>(arg1, arg2) || 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::is_wallet<T0>(arg1, arg2), 13835903463760199687);
        let v0 = get_party_info<T0>(arg1, arg2, arg3);
        assert!(v0.region != 4, 13835622014553161733);
        let v1 = IssuanceInfo{
            amount       : arg3,
            total_supply : arg4,
            timestamp_ms : resolve_issuance_time<T0>(arg0, arg5, arg6),
        };
        if (handle_issuance_to_special_wallet_exit<T0>(arg0, &v1, &v0)) {
            return
        };
        assert_not_liquidate_only<T0>(arg1, &v0);
        let v2 = &arg0.rules;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(v2)) {
            validate_issuance_rule<T0>(arg0, arg1, *0x1::vector::borrow<0x1::type_name::TypeName>(v2, v3), &v1, &v0);
            v3 = v3 + 1;
        };
        record_issuance<T0>(arg0, arg1, &v1, &v0, arg6);
    }

    public(friend) fun validate_seize<T0>(arg0: &mut 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::InvestorInfo<T0>, arg1: address, arg2: address, arg3: u64) {
        assert!(0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::wallet_manager::is_issuer_wallet<T0>(arg0, arg2), 13837311070572511247);
        let v0 = get_party_info<T0>(arg0, arg1, arg3);
        record_seize<T0>(arg0, &v0, arg3);
    }

    public(friend) fun validate_transfer<T0>(arg0: &ComplianceConfig<T0>, arg1: &mut 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::InvestorInfo<T0>, arg2: &0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::Request<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::SendFunds<0x2::balance::Balance<T0>>>, arg3: u64, arg4: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::Version) {
        0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::version::check_is_valid(arg4);
        let v0 = 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::recipient<0x2::balance::Balance<T0>>(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::data<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::SendFunds<0x2::balance::Balance<T0>>>(arg2));
        let v1 = 0x2::balance::value<T0>(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::funds<0x2::balance::Balance<T0>>(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::data<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::SendFunds<0x2::balance::Balance<T0>>>(arg2)));
        assert!(0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::is_special_wallet<T0>(arg1, v0) || 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::is_wallet<T0>(arg1, v0), 13835903158817521671);
        let v2 = get_party_info<T0>(arg1, 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::sender<0x2::balance::Balance<T0>>(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::data<0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds::SendFunds<0x2::balance::Balance<T0>>>(arg2)), v1);
        let v3 = get_party_info<T0>(arg1, v0, 0);
        let v4 = TransferInfo{
            amount        : v1,
            equal_country : &v2.country == &v3.country,
            equal_region  : v2.region == v3.region,
            timestamp_ms  : arg3,
        };
        if (handle_transfer_to_special_wallet_exit<T0>(arg0, arg1, &v4, &v2, &v3)) {
            return
        };
        if (handle_same_investor_exit<T0>(arg0, arg1, &v4, &v2, &v3)) {
            return
        };
        assert!(v3.region != 4, 13835621782624927749);
        v2.transferable_balance = assert_and_compute_transferable_balance<T0>(arg1, &v2, v1, arg3);
        assert_not_liquidate_only<T0>(arg1, &v3);
        let v5 = 0x1::vector::empty<0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::Issuance>();
        let v6 = if (!v2.is_special_wallet) {
            0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::get_investor_issuances<T0>(arg1, *0x1::option::borrow<0x1::string::String>(&v2.investor_id))
        } else {
            &v5
        };
        let v7 = &arg0.rules;
        let v8 = 0;
        while (v8 < 0x1::vector::length<0x1::type_name::TypeName>(v7)) {
            validate_transfer_rule<T0>(arg0, arg1, *0x1::vector::borrow<0x1::type_name::TypeName>(v7, v8), &v4, &v2, &v3, v6);
            v8 = v8 + 1;
        };
        record_transfer<T0>(arg0, arg1, &v4, &v2, &v3);
    }

    fun validate_transfer_rule<T0>(arg0: &ComplianceConfig<T0>, arg1: &0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::InvestorInfo<T0>, arg2: 0x1::type_name::TypeName, arg3: &TransferInfo, arg4: &PartyInfo, arg5: &PartyInfo, arg6: &vector<0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::registry_service::Issuance>) {
        if (arg2 == 0x1::type_name::with_defining_ids<0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::accredited_only::AccreditedOnly>()) {
            0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::accredited_only::validate_rule(0x2::bag::borrow<0x1::type_name::TypeName, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::accredited_only::AccreditedOnly>(&arg0.rules_bag, arg2), arg5.region, arg5.is_accredited);
        } else if (arg2 == 0x1::type_name::with_defining_ids<0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::holding_limits::HoldingLimits>()) {
            0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::holding_limits::validate_holding_limits_for_transfer(0x2::bag::borrow<0x1::type_name::TypeName, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::holding_limits::HoldingLimits>(&arg0.rules_bag, arg2), arg3.amount, arg4.is_special_wallet, arg4.balance, arg4.region, arg5.balance, arg5.region);
        } else if (arg2 == 0x1::type_name::with_defining_ids<0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::investor_limits::InvestorLimits>()) {
            0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::investor_limits::validate_investor_limits_for_transfer<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::investor_limits::InvestorLimits>(&arg0.rules_bag, arg2), arg1, arg4.is_accredited, arg4.is_exit_investor, arg4.is_qualified, arg5.region, arg5.country, arg5.is_accredited, arg5.is_qualified, arg5.is_new_investor, arg3.equal_region, arg3.equal_country);
        } else if (arg2 == 0x1::type_name::with_defining_ids<0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::force_full_transfer::ForceFullTransfer>()) {
            0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::force_full_transfer::validate_rule(0x2::bag::borrow<0x1::type_name::TypeName, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::force_full_transfer::ForceFullTransfer>(&arg0.rules_bag, arg2), arg4.region, arg4.is_special_wallet, arg4.is_exit_investor);
        } else if (arg2 == 0x1::type_name::with_defining_ids<0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::flowback_restriction::FlowbackRestriction>()) {
            0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::flowback_restriction::validate_rule(0x2::bag::borrow<0x1::type_name::TypeName, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::flowback_restriction::FlowbackRestriction>(&arg0.rules_bag, arg2), arg4.region, arg5.region, arg4.is_special_wallet, arg3.timestamp_ms);
        } else if (arg2 == 0x1::type_name::with_defining_ids<0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::lockup_restriction::LockupRestriction>()) {
            0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::lockup_restriction::validate_rule(0x2::bag::borrow<0x1::type_name::TypeName, 0xfa7d8ef63887b108ce7fe1e481d399c21ae3f898bb58d6c57b24405d34bfc06f::lockup_restriction::LockupRestriction>(&arg0.rules_bag, arg2), arg6, arg3.amount, arg4.region, arg4.is_special_wallet, arg4.transferable_balance, arg3.timestamp_ms);
        };
    }

    // decompiled from Move bytecode v7
}

