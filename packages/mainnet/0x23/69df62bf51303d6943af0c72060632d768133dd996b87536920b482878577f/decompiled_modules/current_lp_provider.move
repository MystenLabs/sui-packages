module 0x2369df62bf51303d6943af0c72060632d768133dd996b87536920b482878577f::current_lp_provider {
    struct CurrentLp<phantom T0> has drop {
        dummy_field: bool,
    }

    struct CurrentLpProvider has key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u16>,
        creditor_obligation_caps: 0x2::vec_map::VecMap<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x1::option::Option<0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::ObligationOwnerCap>>,
        decimals: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u8>,
        usdb_managers: 0x2::vec_set::VecSet<address>,
    }

    public fun add_usdb_manager(arg0: &mut CurrentLpProvider, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg0.usdb_managers, arg2);
    }

    public fun add_version(arg0: &mut CurrentLpProvider, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: u16) {
        0x2::vec_set::insert<u16>(&mut arg0.versions, arg2);
    }

    fun assert_valid_package_version(arg0: &CurrentLpProvider) {
        let v0 = package_version();
        assert!(0x2::vec_set::contains<u16>(&arg0.versions, &v0), 13906834934552657922);
    }

    fun assert_valid_usdb_manager(arg0: &CurrentLpProvider, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.usdb_managers, &v0), 13906834951732658180);
    }

    public fun deposit_usdb<T0>(arg0: &mut CurrentLpProvider, arg1: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Loan<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, CurrentLp<T0>, CurrentLp<T0>> {
        assert_valid_usdb_manager(arg0, arg3);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::entity<CurrentLp<T0>>();
        let v1 = sheet_mut<T0, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg0, v0);
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::add_debtor<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, CurrentLp<T0>>(v1, v0, stamp<T0>());
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::lend<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, CurrentLp<T0>, CurrentLp<T0>>(v1, 0x2::coin::into_balance<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::mint<CurrentLp<T0>>(arg1, stamp<T0>(), package_version(), arg2, arg3)), stamp<T0>())
    }

    fun extract_obligation_cap<T0>(arg0: &mut CurrentLpProvider, arg1: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::ProtocolApp, arg2: &mut 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market::Market<T0>, arg3: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, arg4: &mut 0x2::tx_context::TxContext) : 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::ObligationOwnerCap {
        if (!0x2::vec_map::contains<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x1::option::Option<0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::ObligationOwnerCap>>(&arg0.creditor_obligation_caps, &arg3)) {
            0x2::vec_map::insert<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x1::option::Option<0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::ObligationOwnerCap>>(&mut arg0.creditor_obligation_caps, arg3, 0x1::option::some<0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::ObligationOwnerCap>(0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::enter_market::enter_market_return<T0>(arg1, arg2, arg4)));
        };
        0x1::option::extract<0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::ObligationOwnerCap>(0x2::vec_map::get_mut<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x1::option::Option<0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::ObligationOwnerCap>>(&mut arg0.creditor_obligation_caps, &arg3))
    }

    fun fill_obligation_cap(arg0: &mut CurrentLpProvider, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, arg2: 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::ObligationOwnerCap) {
        0x1::option::fill<0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::ObligationOwnerCap>(0x2::vec_map::get_mut<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x1::option::Option<0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::ObligationOwnerCap>>(&mut arg0.creditor_obligation_caps, &arg1), arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CurrentLpProvider{
            id                       : 0x2::object::new(arg0),
            versions                 : 0x2::vec_set::singleton<u16>(package_version()),
            creditor_obligation_caps : 0x2::vec_map::empty<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x1::option::Option<0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::obligation::ObligationOwnerCap>>(),
            decimals                 : 0x2::vec_map::empty<0x1::type_name::TypeName, u8>(),
            usdb_managers            : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg0)),
        };
        0x2::transfer::share_object<CurrentLpProvider>(v0);
    }

    public fun package_version() : u16 {
        1
    }

    public fun receive_loan<T0, T1, T2>(arg0: &mut CurrentLpProvider, arg1: &0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::app::ProtocolApp, arg2: &mut 0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::market::Market<T0>, arg3: &0x2::clock::Clock, arg4: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Loan<T1, T2, CurrentLp<T0>>, arg5: &mut 0x2::tx_context::TxContext) {
        assert_valid_package_version(arg0);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::entity<T2>();
        let v1 = sheet_mut<T0, T1>(arg0, v0);
        let v2 = 0x2::coin::from_balance<T1>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::receive<T1, T2, CurrentLp<T0>>(v1, arg4, stamp<T0>()), arg5);
        let v3 = extract_obligation_cap<T0>(arg0, arg1, arg2, v0, arg5);
        0xa377cac91d12de361e03940bad7f17ceaaa9dc095ae2c30b284110ef099cb8b6::deposit::deposit<T0, T1>(arg1, arg2, &v3, v2, arg3, arg5);
        fill_obligation_cap(arg0, v0, v3);
    }

    public fun remove_usdb_manager(arg0: &mut CurrentLpProvider, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg0.usdb_managers, &arg2);
    }

    public fun remove_version(arg0: &mut CurrentLpProvider, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: u16) {
        0x2::vec_set::remove<u16>(&mut arg0.versions, &arg2);
    }

    public fun set_decimal<T0>(arg0: &mut CurrentLpProvider, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: u8) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u8>(&arg0.decimals, &v0)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, u8>(&mut arg0.decimals, v0, arg2);
        } else {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u8>(&mut arg0.decimals, &v0) = arg2;
        };
    }

    fun sheet_mut<T0, T1>(arg0: &mut CurrentLpProvider, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity) : &mut 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Sheet<T1, CurrentLp<T0>> {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Sheet<T1, CurrentLp<T0>>>(&arg0.id, v0)) {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Sheet<T1, CurrentLp<T0>>>(&mut arg0.id, v0, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::new<T1, CurrentLp<T0>>(stamp<T0>()));
        };
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Sheet<T1, CurrentLp<T0>>>(&mut arg0.id, v0);
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::add_creditor<T1, CurrentLp<T0>>(v1, arg1, stamp<T0>());
        v1
    }

    fun stamp<T0>() : CurrentLp<T0> {
        CurrentLp<T0>{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

