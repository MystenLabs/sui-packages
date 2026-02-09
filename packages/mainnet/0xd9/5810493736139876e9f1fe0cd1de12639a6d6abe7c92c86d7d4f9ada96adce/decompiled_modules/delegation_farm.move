module 0xd95810493736139876e9f1fe0cd1de12639a6d6abe7c92c86d7d4f9ada96adce::delegation_farm {
    struct DelegationEntity has drop {
        dummy_field: bool,
    }

    struct DelegationFarm has key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u16>,
        entity_accounts: 0x2::vec_map::VecMap<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account>,
    }

    public fun add_creditor<T0, T1>(arg0: &mut DelegationFarm, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::entity<T1>();
        if (!0x2::vec_map::contains<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account>(&arg0.entity_accounts, &v0)) {
            0x2::vec_map::insert<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account>(&mut arg0.entity_accounts, v0, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::new(0x1::option::none<0x1::string::String>(), arg2));
        };
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v1)) {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Sheet<T0, DelegationEntity>>(&mut arg0.id, v1, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::new<T0, DelegationEntity>(stamp()));
        };
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::add_creditor<T0, DelegationEntity>(sheet_mut<T0>(arg0), v0, stamp());
    }

    public fun add_version(arg0: &mut DelegationFarm, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap) {
        0x2::vec_set::insert<u16>(&mut arg0.versions, package_version());
    }

    fun assert_valid_package_version(arg0: &DelegationFarm) {
        let v0 = package_version();
        if (!0x2::vec_set::contains<u16>(&arg0.versions, &v0)) {
            err_invalid_package_version();
        };
    }

    fun creditor_account_address<T0>(arg0: &DelegationFarm) : address {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::entity<T0>();
        if (!0x2::vec_map::contains<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account>(&arg0.entity_accounts, &v0)) {
            err_creditor_not_exists();
        };
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::account_address(0x2::vec_map::get<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account>(&arg0.entity_accounts, &v0))
    }

    fun creditor_account_request<T0>(arg0: &DelegationFarm) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::entity<T0>();
        if (!0x2::vec_map::contains<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account>(&arg0.entity_accounts, &v0)) {
            err_creditor_not_exists();
        };
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_with_account(0x2::vec_map::get<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account>(&arg0.entity_accounts, &v0))
    }

    public fun delegate<T0, T1>(arg0: &mut DelegationFarm, arg1: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg2: &mut 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::Vault<T0>, arg3: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Loan<T0, T1, DelegationEntity>, arg4: &mut 0x2::tx_context::TxContext) : 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::request::UpdateRequest<T0> {
        assert_valid_package_version(arg0);
        let v0 = creditor_account_address<T1>(arg0);
        0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::donor_request<T0>(arg2, arg1, v0, 0x2::coin::from_balance<T0>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::receive<T0, T1, DelegationEntity>(sheet_mut<T0>(arg0), arg3, stamp()), arg4), 0x2::coin::zero<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg4))
    }

    fun err_creditor_not_exists() {
        abort 2
    }

    fun err_invalid_creditor_request() {
        abort 3
    }

    fun err_invalid_package_version() {
        abort 4
    }

    fun err_sheet_not_exists() {
        abort 1
    }

    public fun execute_undelegate<T0, T1>(arg0: &mut DelegationFarm, arg1: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg2: &mut 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::Vault<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Request<T0, T1>, arg5: 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::request::UpdateRequest<T0>, arg6: &mut 0x2::tx_context::TxContext) : 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::response::UpdateResponse<T0> {
        assert_valid_package_version(arg0);
        let v0 = creditor_account_request<T1>(arg0);
        if (0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::request::account<T0>(&arg5) != 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(&v0)) {
            err_invalid_creditor_request();
        };
        let v1 = 0x1::option::none<0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T0>>();
        let (v2, v3, v4) = 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::update_position<T0>(arg2, arg1, arg3, &v1, arg5, arg6);
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::pay<T0, T1, DelegationEntity>(sheet_mut<T0>(arg0), arg4, 0x2::coin::into_balance<T0>(v2), stamp());
        0x2::coin::destroy_zero<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(v3);
        v4
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DelegationFarm{
            id              : 0x2::object::new(arg0),
            versions        : 0x2::vec_set::singleton<u16>(package_version()),
            entity_accounts : 0x2::vec_map::empty<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account>(),
        };
        0x2::transfer::share_object<DelegationFarm>(v0);
    }

    public fun package_version() : u16 {
        1
    }

    public fun remove_version(arg0: &mut DelegationFarm, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: u16) {
        0x2::vec_set::remove<u16>(&mut arg0.versions, &arg2);
    }

    public fun request_undelegate<T0, T1>(arg0: &mut DelegationFarm, arg1: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg2: &mut 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::Vault<T0>, arg3: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Request<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::request::UpdateRequest<T0> {
        assert_valid_package_version(arg0);
        let v0 = creditor_account_request<T1>(arg0);
        0x9f835c21d21f8ce519fec17d679cd38243ef2643ad879e7048ba77374be4036e::vault::debtor_request<T0>(arg2, &v0, arg1, 0x2::coin::zero<T0>(arg4), 0, 0x2::coin::zero<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg4), 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::requirement<T0, T1>(arg3))
    }

    fun sheet_mut<T0>(arg0: &mut DelegationFarm) : &mut 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Sheet<T0, DelegationEntity> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            err_sheet_not_exists();
        };
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Sheet<T0, DelegationEntity>>(&mut arg0.id, v0)
    }

    fun stamp() : DelegationEntity {
        DelegationEntity{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

