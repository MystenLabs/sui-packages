module 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::registry_service {
    struct RegistryServiceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct InvestorInfo<phantom T0> has key {
        id: 0x2::object::UID,
        investors: 0x2::table::Table<0x1::string::String, Investor>,
        investor_wallets: 0x2::table::Table<address, Wallet>,
        special_wallets: 0x2::table::Table<address, u64>,
        special_wallets_balance: 0x2::table::Table<address, u64>,
        total_investors_count: u64,
        accredited_investors_count: u64,
        us_accredited_investors_count: u64,
        us_investors_count: u64,
        jp_investors_count: u64,
        eu_retail_investors_count: 0x2::table::Table<0x1::string::String, u64>,
        countries_compliances: 0x2::table::Table<0x1::string::String, u64>,
        investor_locks: 0x2::table::Table<0x1::string::String, InvestorLockState>,
        investor_issuances: 0x2::table::Table<0x1::string::String, vector<Issuance>>,
    }

    struct Lock has drop, store {
        value: u64,
        reason_code: u64,
        reason_string: 0x1::string::String,
        release_time_ms: u64,
    }

    struct InvestorLockState has drop, store {
        fully_locked: bool,
        liquidate_only: bool,
        locks: vector<Lock>,
    }

    struct Issuance has copy, drop, store {
        amount: u64,
        issuance_time_ms: u64,
    }

    struct Investor has store {
        creator: address,
        country: 0x1::string::String,
        wallets: vector<address>,
        attributes: 0x2::table::Table<u64, Attribute>,
        total_balance: u64,
    }

    struct Wallet has drop, store {
        owner: 0x1::string::String,
        creator: address,
        wallet_balance: u64,
    }

    struct Attribute has copy, drop, store {
        value: u64,
        expiration: u64,
    }

    public(friend) fun new<T0: key>(arg0: &mut 0x2::object::UID, arg1: &mut 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Auth<T0>, arg2: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::Version, arg3: &mut 0x2::tx_context::TxContext) : InvestorInfo<T0> {
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::add_role_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Master, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::RegisterInvestor>(arg1, arg2, arg3);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::add_role_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Master, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::RemoveInvestor>(arg1, arg2, arg3);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::add_role_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Master, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::UpdateInvestor>(arg1, arg2, arg3);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::add_role_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Master, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::SetInvestorCounts>(arg1, arg2, arg3);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::add_role_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Master, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::SetCountry>(arg1, arg2, arg3);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::add_role_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Master, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::SetAttribute>(arg1, arg2, arg3);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::add_role_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Master, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::AddWallet>(arg1, arg2, arg3);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::add_role_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Master, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::RemoveWallet>(arg1, arg2, arg3);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::add_role_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Issuer, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::RegisterInvestor>(arg1, arg2, arg3);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::add_role_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Issuer, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::RemoveInvestor>(arg1, arg2, arg3);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::add_role_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Issuer, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::UpdateInvestor>(arg1, arg2, arg3);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::add_role_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Issuer, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::SetCountry>(arg1, arg2, arg3);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::add_role_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Issuer, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::SetAttribute>(arg1, arg2, arg3);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::add_role_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Issuer, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::AddWallet>(arg1, arg2, arg3);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::add_role_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Issuer, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::RemoveWallet>(arg1, arg2, arg3);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::add_role_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Exchange, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::RegisterInvestor>(arg1, arg2, arg3);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::add_role_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Exchange, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::RemoveInvestor>(arg1, arg2, arg3);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::add_role_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Exchange, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::SetCountry>(arg1, arg2, arg3);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::add_role_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Exchange, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::SetAttribute>(arg1, arg2, arg3);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::add_role_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Exchange, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::AddWallet>(arg1, arg2, arg3);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::add_role_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Exchange, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::RemoveWallet>(arg1, arg2, arg3);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::add_role_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::TransferAgent, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::RegisterInvestor>(arg1, arg2, arg3);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::add_role_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::TransferAgent, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::RemoveInvestor>(arg1, arg2, arg3);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::add_role_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::TransferAgent, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::UpdateInvestor>(arg1, arg2, arg3);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::add_role_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::TransferAgent, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::SetCountry>(arg1, arg2, arg3);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::add_role_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::TransferAgent, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::SetAttribute>(arg1, arg2, arg3);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::add_role_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::TransferAgent, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::AddWallet>(arg1, arg2, arg3);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::add_role_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::TransferAgent, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::RemoveWallet>(arg1, arg2, arg3);
        let v0 = RegistryServiceKey<T0>{dummy_field: false};
        InvestorInfo<T0>{
            id                            : 0x2::derived_object::claim<RegistryServiceKey<T0>>(arg0, v0),
            investors                     : 0x2::table::new<0x1::string::String, Investor>(arg3),
            investor_wallets              : 0x2::table::new<address, Wallet>(arg3),
            special_wallets               : 0x2::table::new<address, u64>(arg3),
            special_wallets_balance       : 0x2::table::new<address, u64>(arg3),
            total_investors_count         : 0,
            accredited_investors_count    : 0,
            us_accredited_investors_count : 0,
            us_investors_count            : 0,
            jp_investors_count            : 0,
            eu_retail_investors_count     : 0x2::table::new<0x1::string::String, u64>(arg3),
            countries_compliances         : 0x2::table::new<0x1::string::String, u64>(arg3),
            investor_locks                : 0x2::table::new<0x1::string::String, InvestorLockState>(arg3),
            investor_issuances            : 0x2::table::new<0x1::string::String, vector<Issuance>>(arg3),
        }
    }

    public(friend) fun add_lock(arg0: &mut InvestorLockState, arg1: u64, arg2: u64, arg3: 0x1::string::String, arg4: u64) {
        let v0 = Lock{
            value           : arg1,
            reason_code     : arg2,
            reason_string   : arg3,
            release_time_ms : arg4,
        };
        0x1::vector::push_back<Lock>(&mut arg0.locks, v0);
    }

    public fun add_wallet<T0>(arg0: &mut InvestorInfo<T0>, arg1: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Auth<T0>, arg2: &mut 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::namespace::Namespace, arg3: 0x1::string::String, arg4: address, arg5: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::check_is_valid(arg5);
        assert!(0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::owner_has_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::AddWallet>(arg1, 0x2::tx_context::sender(arg6)), 13835059833398624257);
        assert!(!is_special_wallet<T0>(arg0, arg4), 13836748687554641933);
        assert!(is_investor<T0>(arg0, arg3), 13835904266919084039);
        assert!(!is_wallet<T0>(arg0, arg4), 13837030171121418255);
        if (!0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::namespace::account_exists(arg2, arg4)) {
            0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::account::create_and_share(arg2, arg4);
        };
        let v0 = Wallet{
            owner          : arg3,
            creator        : 0x2::tx_context::sender(arg6),
            wallet_balance : 0,
        };
        0x2::table::add<address, Wallet>(&mut arg0.investor_wallets, arg4, v0);
        0x1::vector::push_back<address>(&mut 0x2::table::borrow_mut<0x1::string::String, Investor>(&mut arg0.investors, arg3).wallets, arg4);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::events::emit_wallet_added_event<T0>(arg4, arg3, 0x2::tx_context::sender(arg6));
    }

    fun adjust_investor_counts_after_country_change<T0>(arg0: &mut InvestorInfo<T0>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        if (investor_wallet_balance_total<T0>(arg0, arg1) != 0) {
            adjust_investors_counts_by_country<T0>(arg0, arg1, arg3, false);
            adjust_investors_counts_by_country<T0>(arg0, arg1, arg2, true);
        };
    }

    public(friend) fun adjust_investors_counts_by_country<T0>(arg0: &mut InvestorInfo<T0>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: bool) {
        let v0 = get_country_compliance<T0>(arg0, arg2);
        if (is_accredited_investor_by_id<T0>(arg0, arg1)) {
            let v1 = &mut arg0.accredited_investors_count;
            apply_change(v1, arg3);
            if (v0 == 1) {
                let v2 = &mut arg0.us_accredited_investors_count;
                apply_change(v2, arg3);
            };
        };
        if (v0 == 1) {
            let v3 = &mut arg0.us_investors_count;
            apply_change(v3, arg3);
        } else if (v0 == 2 && !is_qualified_investor_by_id<T0>(arg0, arg1)) {
            let v4 = get_eu_retail_investor_count<T0>(arg0, arg2);
            if (0x1::option::is_some<u64>(&v4)) {
                let v5 = 0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg0.eu_retail_investors_count, arg2);
                apply_change(v5, arg3);
            };
        } else if (v0 == 8) {
            let v6 = &mut arg0.jp_investors_count;
            apply_change(v6, arg3);
        };
    }

    public(friend) fun apply_change(arg0: &mut u64, arg1: bool) {
        if (arg1) {
            *arg0 = *arg0 + 1;
        } else {
            assert!(*arg0 > 0, 13839284698240385055);
            *arg0 = *arg0 - 1;
        };
    }

    public(friend) fun compute_locked_sum(arg0: &InvestorLockState, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = &arg0.locks;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Lock>(v1)) {
            let v3 = 0x1::vector::borrow<Lock>(v1, v2);
            if (v3.release_time_ms == 0 || v3.release_time_ms > arg1) {
                let v4 = 0x1::u256::try_as_u64((v0 as u256) + (v3.value as u256));
                assert!(0x1::option::is_some<u64>(&v4), 13839003455191777309);
                v0 = 0x1::option::extract<u64>(&mut v4);
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun get_accredited_investor_count<T0>(arg0: &InvestorInfo<T0>) : u64 {
        arg0.accredited_investors_count
    }

    public fun get_attribute_expiration<T0>(arg0: &InvestorInfo<T0>, arg1: 0x1::string::String, arg2: u64) : u64 {
        let v0 = 0x2::table::borrow<0x1::string::String, Investor>(&arg0.investors, arg1);
        if (!0x2::table::contains<u64, Attribute>(&v0.attributes, arg2)) {
            return 0
        };
        0x2::table::borrow<u64, Attribute>(&v0.attributes, arg2).expiration
    }

    public fun get_attribute_value<T0>(arg0: &InvestorInfo<T0>, arg1: 0x1::string::String, arg2: u64) : u64 {
        let v0 = 0x2::table::borrow<0x1::string::String, Investor>(&arg0.investors, arg1);
        if (!0x2::table::contains<u64, Attribute>(&v0.attributes, arg2)) {
            return 0
        };
        0x2::table::borrow<u64, Attribute>(&v0.attributes, arg2).value
    }

    public fun get_country<T0>(arg0: &InvestorInfo<T0>, arg1: 0x1::string::String) : 0x1::string::String {
        0x2::table::borrow<0x1::string::String, Investor>(&arg0.investors, arg1).country
    }

    public fun get_country_compliance<T0>(arg0: &InvestorInfo<T0>, arg1: 0x1::string::String) : u64 {
        if (!0x2::table::contains<0x1::string::String, u64>(&arg0.countries_compliances, arg1)) {
            return 0
        };
        *0x2::table::borrow<0x1::string::String, u64>(&arg0.countries_compliances, arg1)
    }

    public fun get_eu_retail_investor_count<T0>(arg0: &InvestorInfo<T0>, arg1: 0x1::string::String) : 0x1::option::Option<u64> {
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.eu_retail_investors_count, arg1)) {
            return 0x1::option::some<u64>(*0x2::table::borrow<0x1::string::String, u64>(&arg0.eu_retail_investors_count, arg1))
        };
        0x1::option::none<u64>()
    }

    public fun get_investor_id_by_wallet<T0>(arg0: &InvestorInfo<T0>, arg1: address) : 0x1::string::String {
        assert!(is_wallet<T0>(arg0, arg1), 13835904799495028743);
        0x2::table::borrow<address, Wallet>(&arg0.investor_wallets, arg1).owner
    }

    public fun get_investor_issuances<T0>(arg0: &InvestorInfo<T0>, arg1: 0x1::string::String) : &vector<Issuance> {
        0x2::table::borrow<0x1::string::String, vector<Issuance>>(&arg0.investor_issuances, arg1)
    }

    public(friend) fun get_investor_issuances_mut<T0>(arg0: &mut InvestorInfo<T0>, arg1: 0x1::string::String) : &mut vector<Issuance> {
        0x2::table::borrow_mut<0x1::string::String, vector<Issuance>>(&mut arg0.investor_issuances, arg1)
    }

    public(friend) fun get_investor_locks<T0>(arg0: &InvestorInfo<T0>, arg1: 0x1::string::String) : &InvestorLockState {
        0x2::table::borrow<0x1::string::String, InvestorLockState>(&arg0.investor_locks, arg1)
    }

    public(friend) fun get_investor_locks_mut<T0>(arg0: &mut InvestorInfo<T0>, arg1: 0x1::string::String) : &mut InvestorLockState {
        0x2::table::borrow_mut<0x1::string::String, InvestorLockState>(&mut arg0.investor_locks, arg1)
    }

    public fun get_jp_investor_count<T0>(arg0: &InvestorInfo<T0>) : u64 {
        arg0.jp_investors_count
    }

    public fun get_special_wallet_type<T0>(arg0: &InvestorInfo<T0>, arg1: address) : u64 {
        if (!0x2::table::contains<address, u64>(&arg0.special_wallets, arg1)) {
            return 0
        };
        *0x2::table::borrow<address, u64>(&arg0.special_wallets, arg1)
    }

    public fun get_total_investors_count<T0>(arg0: &InvestorInfo<T0>) : u64 {
        arg0.total_investors_count
    }

    public fun get_us_accredited_investor_count<T0>(arg0: &InvestorInfo<T0>) : u64 {
        arg0.us_accredited_investors_count
    }

    public fun get_us_investor_count<T0>(arg0: &InvestorInfo<T0>) : u64 {
        arg0.us_investors_count
    }

    public fun investor_wallet_balance<T0>(arg0: &InvestorInfo<T0>, arg1: address) : u64 {
        assert!(is_wallet<T0>(arg0, arg1), 13837312350472896529);
        0x2::table::borrow<address, Wallet>(&arg0.investor_wallets, arg1).wallet_balance
    }

    public fun investor_wallet_balance_total<T0>(arg0: &InvestorInfo<T0>, arg1: 0x1::string::String) : u64 {
        assert!(is_investor<T0>(arg0, arg1), 13835904932639014919);
        0x2::table::borrow<0x1::string::String, Investor>(&arg0.investors, arg1).total_balance
    }

    public fun is_accredited_investor<T0>(arg0: &InvestorInfo<T0>, arg1: address) : bool {
        is_accredited_investor_by_id<T0>(arg0, 0x2::table::borrow<address, Wallet>(&arg0.investor_wallets, arg1).owner)
    }

    public fun is_accredited_investor_by_id<T0>(arg0: &InvestorInfo<T0>, arg1: 0x1::string::String) : bool {
        get_attribute_value<T0>(arg0, arg1, 2) == 1
    }

    public(friend) fun is_fully_locked(arg0: &InvestorLockState) : bool {
        arg0.fully_locked
    }

    public fun is_investor<T0>(arg0: &InvestorInfo<T0>, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, Investor>(&arg0.investors, arg1)
    }

    public(friend) fun is_liquidate_only(arg0: &InvestorLockState) : bool {
        arg0.liquidate_only
    }

    public fun is_qualified_investor<T0>(arg0: &InvestorInfo<T0>, arg1: address) : bool {
        is_qualified_investor_by_id<T0>(arg0, 0x2::table::borrow<address, Wallet>(&arg0.investor_wallets, arg1).owner)
    }

    public fun is_qualified_investor_by_id<T0>(arg0: &InvestorInfo<T0>, arg1: 0x1::string::String) : bool {
        get_attribute_value<T0>(arg0, arg1, 4) == 1
    }

    public fun is_special_wallet<T0>(arg0: &InvestorInfo<T0>, arg1: address) : bool {
        get_special_wallet_type<T0>(arg0, arg1) != 0
    }

    public fun is_wallet<T0>(arg0: &InvestorInfo<T0>, arg1: address) : bool {
        0x2::table::contains<address, Wallet>(&arg0.investor_wallets, arg1)
    }

    public fun issuance_amount(arg0: &Issuance) : u64 {
        arg0.amount
    }

    public fun issuance_time_ms(arg0: &Issuance) : u64 {
        arg0.issuance_time_ms
    }

    public(friend) fun lock_reason_code(arg0: &Lock) : u64 {
        arg0.reason_code
    }

    public(friend) fun lock_reason_string(arg0: &Lock) : 0x1::string::String {
        arg0.reason_string
    }

    public(friend) fun lock_release_time_ms(arg0: &Lock) : u64 {
        arg0.release_time_ms
    }

    public(friend) fun lock_value(arg0: &Lock) : u64 {
        arg0.value
    }

    public(friend) fun locks_length(arg0: &InvestorLockState) : u64 {
        0x1::vector::length<Lock>(&arg0.locks)
    }

    public fun new_issuance(arg0: u64, arg1: u64) : Issuance {
        Issuance{
            amount           : arg0,
            issuance_time_ms : arg1,
        }
    }

    public fun register_investor<T0: key>(arg0: &mut InvestorInfo<T0>, arg1: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Auth<T0>, arg2: 0x1::string::String, arg3: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::check_is_valid(arg3);
        assert!(0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::owner_has_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::RegisterInvestor>(arg1, 0x2::tx_context::sender(arg4)), 13835059210628366337);
        assert!(!is_investor<T0>(arg0, arg2), 13835340689900175363);
        register_investor_internal<T0>(arg0, arg2, arg4);
    }

    public fun register_investor_if_not_exists<T0: key>(arg0: &mut InvestorInfo<T0>, arg1: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Auth<T0>, arg2: 0x1::string::String, arg3: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::check_is_valid(arg3);
        assert!(0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::owner_has_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::RegisterInvestor>(arg1, 0x2::tx_context::sender(arg4)), 13835059292232744961);
        if (is_investor<T0>(arg0, arg2)) {
            return
        };
        register_investor_internal<T0>(arg0, arg2, arg4);
    }

    fun register_investor_internal<T0: key>(arg0: &mut InvestorInfo<T0>, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg1) > 0, 13835625575081050117);
        let v0 = Investor{
            creator       : 0x2::tx_context::sender(arg2),
            country       : 0x1::string::utf8(b""),
            wallets       : vector[],
            attributes    : 0x2::table::new<u64, Attribute>(arg2),
            total_balance : 0,
        };
        0x2::table::add<0x1::string::String, Investor>(&mut arg0.investors, arg1, v0);
        0x2::table::add<0x1::string::String, vector<Issuance>>(&mut arg0.investor_issuances, arg1, 0x1::vector::empty<Issuance>());
        let v1 = InvestorLockState{
            fully_locked   : false,
            liquidate_only : false,
            locks          : 0x1::vector::empty<Lock>(),
        };
        0x2::table::add<0x1::string::String, InvestorLockState>(&mut arg0.investor_locks, arg1, v1);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::events::emit_investor_added_event<T0>(arg1, 0x2::tx_context::sender(arg2));
    }

    public fun remove_investor<T0: key>(arg0: &mut InvestorInfo<T0>, arg1: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Auth<T0>, arg2: 0x1::string::String, arg3: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::check_is_valid(arg3);
        assert!(0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::owner_has_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::RemoveInvestor>(arg1, 0x2::tx_context::sender(arg4)), 13835059391016992769);
        assert!(is_investor<T0>(arg0, arg2), 13835903820242485255);
        assert!(0x1::vector::length<address>(&0x2::table::borrow<0x1::string::String, Investor>(&arg0.investors, arg2).wallets) == 0, 13836185299514294281);
        let Investor {
            creator       : _,
            country       : _,
            wallets       : _,
            attributes    : v3,
            total_balance : _,
        } = 0x2::table::remove<0x1::string::String, Investor>(&mut arg0.investors, arg2);
        0x2::table::drop<u64, Attribute>(v3);
        0x2::table::remove<0x1::string::String, vector<Issuance>>(&mut arg0.investor_issuances, arg2);
        0x2::table::remove<0x1::string::String, InvestorLockState>(&mut arg0.investor_locks, arg2);
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::events::emit_investor_removed_event<T0>(arg2, 0x2::tx_context::sender(arg4));
    }

    public(friend) fun remove_lock(arg0: &mut InvestorLockState, arg1: u64) : Lock {
        let v0 = 0x1::vector::length<Lock>(&arg0.locks) - 1;
        if (arg1 != v0) {
            0x1::vector::swap<Lock>(&mut arg0.locks, arg1, v0);
        };
        0x1::vector::pop_back<Lock>(&mut arg0.locks)
    }

    public(friend) fun remove_special_wallet<T0>(arg0: &mut InvestorInfo<T0>, arg1: address) : u64 {
        0x2::table::remove<address, u64>(&mut arg0.special_wallets_balance, arg1);
        0x2::table::remove<address, u64>(&mut arg0.special_wallets, arg1)
    }

    public fun remove_wallet<T0>(arg0: &mut InvestorInfo<T0>, arg1: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Auth<T0>, arg2: 0x1::string::String, arg3: address, arg4: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::check_is_valid(arg4);
        assert!(0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::owner_has_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::RemoveWallet>(arg1, 0x2::tx_context::sender(arg5)), 13835059979427512321);
        assert!(is_wallet<T0>(arg0, arg3), 13837311783537213457);
        let v0 = 0x2::table::borrow<address, Wallet>(&arg0.investor_wallets, arg3);
        assert!(v0.owner == arg2, 13837593267103989779);
        assert!(v0.wallet_balance == 0, 13838719171306323995);
        0x2::table::remove<address, Wallet>(&mut arg0.investor_wallets, arg3);
        let v1 = 0x2::table::borrow_mut<0x1::string::String, Investor>(&mut arg0.investors, arg2).wallets;
        let v2 = &v1;
        let v3 = 0;
        let v4;
        while (v3 < 0x1::vector::length<address>(v2)) {
            if (0x1::vector::borrow<address>(v2, v3) == &arg3) {
                v4 = 0x1::option::some<u64>(v3);
                /* label 17 */
                if (0x1::option::is_some<u64>(&v4)) {
                    0x1::vector::remove<address>(&mut 0x2::table::borrow_mut<0x1::string::String, Investor>(&mut arg0.investors, arg2).wallets, 0x1::option::destroy_some<u64>(v4));
                    0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::events::emit_wallet_removed_event<T0>(arg3, arg2, 0x2::tx_context::sender(arg5));
                    return
                } else {
                    0x1::option::destroy_none<u64>(v4);
                    abort 13837311809307017233
                };
            };
            v3 = v3 + 1;
        };
        v4 = 0x1::option::none<u64>();
        /* goto 17 */
    }

    public fun set_accredited_investors_count<T0>(arg0: &mut InvestorInfo<T0>, arg1: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Auth<T0>, arg2: u64, arg3: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::check_is_valid(arg3);
        assert!(0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::owner_has_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::SetInvestorCounts>(arg1, 0x2::tx_context::sender(arg4)), 13835061821968482305);
        set_accredited_investors_count_internal<T0>(arg0, arg2);
    }

    public(friend) fun set_accredited_investors_count_internal<T0>(arg0: &mut InvestorInfo<T0>, arg1: u64) {
        arg0.accredited_investors_count = arg1;
    }

    public fun set_attribute<T0>(arg0: &mut InvestorInfo<T0>, arg1: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Auth<T0>, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::check_is_valid(arg6);
        assert!(0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::owner_has_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::SetAttribute>(arg1, 0x2::tx_context::sender(arg7)), 13835060228535615489);
        assert!(is_investor<T0>(arg0, arg2), 13835904657761107975);
        assert!(arg3 < 16, 13837874986893967381);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, Investor>(&mut arg0.investors, arg2);
        if (0x2::table::contains<u64, Attribute>(&v0.attributes, arg3)) {
            let v1 = 0x2::table::borrow_mut<u64, Attribute>(&mut v0.attributes, arg3);
            v1.value = arg4;
            v1.expiration = arg5;
        } else {
            let v2 = Attribute{
                value      : arg4,
                expiration : arg5,
            };
            0x2::table::add<u64, Attribute>(&mut v0.attributes, arg3, v2);
        };
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::events::emit_investor_attribute_changed_event<T0>(arg2, arg3, arg4, arg5, 0x2::tx_context::sender(arg7));
    }

    public fun set_country<T0: key>(arg0: &mut InvestorInfo<T0>, arg1: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Auth<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::check_is_valid(arg4);
        assert!(0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::owner_has_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::SetCountry>(arg1, 0x2::tx_context::sender(arg5)), 13835060103981563905);
        assert!(is_investor<T0>(arg0, arg2), 13835904533207056391);
        let v0 = 0x2::table::borrow<0x1::string::String, Investor>(&arg0.investors, arg2).country;
        adjust_investor_counts_after_country_change<T0>(arg0, arg2, arg3, v0);
        0x2::table::borrow_mut<0x1::string::String, Investor>(&mut arg0.investors, arg2).country = arg3;
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::events::emit_investor_country_changed_event<T0>(arg2, arg3, 0x2::tx_context::sender(arg5));
    }

    public(friend) fun set_country_compliance<T0>(arg0: &mut InvestorInfo<T0>, arg1: 0x1::string::String, arg2: u64) {
        let v0 = get_country_compliance<T0>(arg0, arg1);
        assert!(v0 != arg2, 13838438997704572953);
        if (arg2 == 0) {
            0x2::table::remove<0x1::string::String, u64>(&mut arg0.countries_compliances, arg1);
            return
        };
        if (arg2 == 2) {
            set_eu_retail_investors_country_if_not_exists<T0>(arg0, arg1);
        };
        if (v0 == 0) {
            0x2::table::add<0x1::string::String, u64>(&mut arg0.countries_compliances, arg1, arg2);
        } else {
            *0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg0.countries_compliances, arg1) = arg2;
        };
    }

    public(friend) fun set_eu_retail_investors_country_if_not_exists<T0>(arg0: &mut InvestorInfo<T0>, arg1: 0x1::string::String) {
        if (!0x2::table::contains<0x1::string::String, u64>(&arg0.eu_retail_investors_count, arg1)) {
            0x2::table::add<0x1::string::String, u64>(&mut arg0.eu_retail_investors_count, arg1, 0);
        };
    }

    public(friend) fun set_fully_locked(arg0: &mut InvestorLockState, arg1: bool) {
        arg0.fully_locked = arg1;
    }

    public fun set_jp_investors_count<T0>(arg0: &mut InvestorInfo<T0>, arg1: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Auth<T0>, arg2: u64, arg3: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::check_is_valid(arg3);
        assert!(0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::owner_has_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::SetInvestorCounts>(arg1, 0x2::tx_context::sender(arg4)), 13835061877803057153);
        set_jp_investors_count_internal<T0>(arg0, arg2);
    }

    public(friend) fun set_jp_investors_count_internal<T0>(arg0: &mut InvestorInfo<T0>, arg1: u64) {
        arg0.jp_investors_count = arg1;
    }

    public(friend) fun set_liquidate_only(arg0: &mut InvestorLockState, arg1: bool) {
        arg0.liquidate_only = arg1;
    }

    public(friend) fun set_special_wallet<T0>(arg0: &mut InvestorInfo<T0>, arg1: address, arg2: u64) {
        0x2::table::add<address, u64>(&mut arg0.special_wallets, arg1, arg2);
        0x2::table::add<address, u64>(&mut arg0.special_wallets_balance, arg1, 0);
    }

    public fun set_total_investors_count<T0>(arg0: &mut InvestorInfo<T0>, arg1: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Auth<T0>, arg2: u64, arg3: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::check_is_valid(arg3);
        assert!(0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::owner_has_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::SetInvestorCounts>(arg1, 0x2::tx_context::sender(arg4)), 13835061654464757761);
        set_total_investors_count_internal<T0>(arg0, arg2);
    }

    public(friend) fun set_total_investors_count_internal<T0>(arg0: &mut InvestorInfo<T0>, arg1: u64) {
        arg0.total_investors_count = arg1;
    }

    public fun set_us_accredited_investors_count<T0>(arg0: &mut InvestorInfo<T0>, arg1: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Auth<T0>, arg2: u64, arg3: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::check_is_valid(arg3);
        assert!(0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::owner_has_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::SetInvestorCounts>(arg1, 0x2::tx_context::sender(arg4)), 13835061766133907457);
        set_us_accredited_investors_count_internal<T0>(arg0, arg2);
    }

    public(friend) fun set_us_accredited_investors_count_internal<T0>(arg0: &mut InvestorInfo<T0>, arg1: u64) {
        arg0.us_accredited_investors_count = arg1;
    }

    public fun set_us_investors_count<T0>(arg0: &mut InvestorInfo<T0>, arg1: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Auth<T0>, arg2: u64, arg3: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::check_is_valid(arg3);
        assert!(0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::owner_has_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::SetInvestorCounts>(arg1, 0x2::tx_context::sender(arg4)), 13835061710299332609);
        set_us_investors_count_internal<T0>(arg0, arg2);
    }

    public(friend) fun set_us_investors_count_internal<T0>(arg0: &mut InvestorInfo<T0>, arg1: u64) {
        arg0.us_investors_count = arg1;
    }

    public(friend) fun share<T0>(arg0: InvestorInfo<T0>) {
        0x2::transfer::share_object<InvestorInfo<T0>>(arg0);
    }

    public(friend) fun special_wallet_balance<T0>(arg0: &InvestorInfo<T0>, arg1: address) : u64 {
        *0x2::table::borrow<address, u64>(&arg0.special_wallets_balance, arg1)
    }

    public fun update_investor<T0: key>(arg0: &mut InvestorInfo<T0>, arg1: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::Auth<T0>, arg2: &mut 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::namespace::Namespace, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<address>, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u64>, arg9: &0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::Version, arg10: &mut 0x2::tx_context::TxContext) {
        0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::version::check_is_valid(arg9);
        assert!(0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::trust_service::owner_has_ability<T0, 0xe3e2c59d10f49629470ce8cb27c8fee358157d591b5621d0cb00016db4258c47::abilities::UpdateInvestor>(arg1, 0x2::tx_context::sender(arg10)), 13835059562815684609);
        assert!(0x1::vector::length<u64>(&arg7) == 0x1::vector::length<u64>(&arg6), 13836466941994860555);
        assert!(0x1::vector::length<u64>(&arg8) == 0x1::vector::length<u64>(&arg6), 13836466946289827851);
        if (!is_investor<T0>(arg0, arg3)) {
            register_investor<T0>(arg0, arg1, arg3, arg9, arg10);
        };
        if (0x1::string::length(&arg4) > 0) {
            set_country<T0>(arg0, arg1, arg3, arg4, arg9, arg10);
        };
        0x1::vector::reverse<address>(&mut arg5);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg5)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg5);
            if (is_wallet<T0>(arg0, v1)) {
                assert!(0x2::table::borrow<address, Wallet>(&arg0.investor_wallets, v1).owner == arg3, 13838155851985453079);
            } else {
                add_wallet<T0>(arg0, arg1, arg2, arg3, v1, arg9, arg10);
            };
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg5);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg6)) {
            set_attribute<T0>(arg0, arg1, arg3, *0x1::vector::borrow<u64>(&arg6, v2), *0x1::vector::borrow<u64>(&arg7, v2), *0x1::vector::borrow<u64>(&arg8, v2), arg9, arg10);
            v2 = v2 + 1;
        };
    }

    public(friend) fun update_investor_total_balance<T0>(arg0: &mut InvestorInfo<T0>, arg1: 0x1::string::String, arg2: u64) {
        0x2::table::borrow_mut<0x1::string::String, Investor>(&mut arg0.investors, arg1).total_balance = arg2;
    }

    public(friend) fun update_special_wallet_total_balance<T0>(arg0: &mut InvestorInfo<T0>, arg1: address, arg2: u64) {
        *0x2::table::borrow_mut<address, u64>(&mut arg0.special_wallets_balance, arg1) = arg2;
    }

    public(friend) fun update_wallet_balance<T0>(arg0: &mut InvestorInfo<T0>, arg1: address, arg2: u64) {
        0x2::table::borrow_mut<address, Wallet>(&mut arg0.investor_wallets, arg1).wallet_balance = arg2;
    }

    // decompiled from Move bytecode v7
}

