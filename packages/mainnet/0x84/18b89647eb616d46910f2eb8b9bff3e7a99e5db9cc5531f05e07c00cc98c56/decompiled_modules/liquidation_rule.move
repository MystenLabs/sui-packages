module 0x8418b89647eb616d46910f2eb8b9bff3e7a99e5db9cc5531f05e07c00cc98c56::liquidation_rule {
    struct LiquidationRule has drop {
        dummy_field: bool,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        liquidators: 0x2::vec_set::VecSet<address>,
        unswappable_coin_types: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        protected_debtors: 0x2::vec_set::VecSet<address>,
        versions: 0x2::vec_set::VecSet<u16>,
    }

    public fun add_liquidator(arg0: &mut Config, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: address) {
        assert_valid_package_version(arg0);
        0x2::vec_set::insert<address>(&mut arg0.liquidators, arg2);
    }

    public fun add_protected_debtor(arg0: &mut Config, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: address) {
        assert_valid_package_version(arg0);
        0x2::vec_set::insert<address>(&mut arg0.protected_debtors, arg2);
    }

    public fun add_unswappable_coin_type<T0>(arg0: &mut Config, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap) {
        assert_valid_package_version(arg0);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.unswappable_coin_types, 0x1::type_name::with_defining_ids<T0>());
    }

    public fun add_version(arg0: &mut Config, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: u16) {
        0x2::vec_set::insert<u16>(&mut arg0.versions, arg2);
    }

    fun assert_invalid_liquidator(arg0: &Config, arg1: &address) {
        if (!0x2::vec_set::contains<address>(liquidators(arg0), arg1)) {
            err_invalid_liquidator();
        };
    }

    fun assert_invalid_unswappable_coin_type<T0>(arg0: &Config) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.unswappable_coin_types, &v0)) {
            err_invalid_coin_type();
        };
    }

    fun assert_protected_debtor(arg0: &Config, arg1: &address) {
        if (0x2::vec_set::contains<address>(&arg0.protected_debtors, arg1)) {
            err_debtor_is_protected();
        };
    }

    fun assert_valid_package_version(arg0: &Config) {
        let v0 = package_version();
        if (!0x2::vec_set::contains<u16>(versions(arg0), &v0)) {
            err_invalid_package_version();
        };
    }

    fun err_debtor_is_protected() {
        abort 3
    }

    fun err_invalid_coin_type() {
        abort 2
    }

    fun err_invalid_liquidator() {
        abort 1
    }

    fun err_invalid_package_version() {
        abort 0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                     : 0x2::object::new(arg0),
            liquidators            : 0x2::vec_set::empty<address>(),
            unswappable_coin_types : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            protected_debtors      : 0x2::vec_set::empty<address>(),
            versions               : 0x2::vec_set::singleton<u16>(package_version()),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun liquidate<T0>(arg0: &Config, arg1: &mut 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::Vault<T0>, arg2: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg3: &0x2::clock::Clock, arg4: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T0>, arg5: address, arg6: 0x2::coin::Coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>, arg7: &mut 0x2::tx_context::TxContext) : 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::request::UpdateRequest<T0> {
        assert_valid_package_version(arg0);
        let v0 = 0x2::tx_context::sender(arg7);
        assert_invalid_liquidator(arg0, &v0);
        assert_protected_debtor(arg0, &arg5);
        let v1 = LiquidationRule{dummy_field: false};
        0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::liquidate<T0, LiquidationRule>(arg1, arg2, arg3, arg4, arg5, arg6, v1, arg7)
    }

    public fun liquidate_unswappable<T0>(arg0: &Config, arg1: &mut 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::Vault<T0>, arg2: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg3: &0x2::clock::Clock, arg4: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T0>, arg5: address, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::request::UpdateRequest<T0> {
        assert_valid_package_version(arg0);
        let v0 = 0x2::tx_context::sender(arg7);
        assert_invalid_liquidator(arg0, &v0);
        assert_protected_debtor(arg0, &arg5);
        assert_invalid_unswappable_coin_type<T0>(arg0);
        let v1 = LiquidationRule{dummy_field: false};
        let v2 = LiquidationRule{dummy_field: false};
        0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::liquidate<T0, LiquidationRule>(arg1, arg2, arg3, arg4, arg5, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::mint<LiquidationRule>(arg2, v1, package_version(), arg6, arg7), v2, arg7)
    }

    public fun liquidators(arg0: &Config) : &0x2::vec_set::VecSet<address> {
        &arg0.liquidators
    }

    public fun package_version() : u16 {
        1
    }

    public fun protected_debtors(arg0: &Config) : &0x2::vec_set::VecSet<address> {
        &arg0.protected_debtors
    }

    public fun remove_liquidator(arg0: &mut Config, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: address) {
        assert_valid_package_version(arg0);
        0x2::vec_set::remove<address>(&mut arg0.liquidators, &arg2);
    }

    public fun remove_protected_debtor(arg0: &mut Config, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: address) {
        assert_valid_package_version(arg0);
        0x2::vec_set::remove<address>(&mut arg0.protected_debtors, &arg2);
    }

    public fun remove_unswappable_coin_type<T0>(arg0: &mut Config, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap) {
        assert_valid_package_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.unswappable_coin_types, &v0);
    }

    public fun remove_version(arg0: &mut Config, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: u16) {
        0x2::vec_set::remove<u16>(&mut arg0.versions, &arg2);
    }

    public fun versions(arg0: &Config) : &0x2::vec_set::VecSet<u16> {
        &arg0.versions
    }

    // decompiled from Move bytecode v6
}

