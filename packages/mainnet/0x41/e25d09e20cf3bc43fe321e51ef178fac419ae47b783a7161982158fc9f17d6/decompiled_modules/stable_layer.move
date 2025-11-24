module 0x41e25d09e20cf3bc43fe321e51ef178fac419ae47b783a7161982158fc9f17d6::stable_layer {
    struct NewStable has copy, drop {
        u_type: 0x1::ascii::String,
        stable_type: 0x1::ascii::String,
        factory_id: 0x2::object::ID,
        factory_cap_id: 0x2::object::ID,
    }

    struct Mint has copy, drop {
        u_type: 0x1::ascii::String,
        stable_type: 0x1::ascii::String,
        mint_amount: u64,
        farm_type: 0x1::ascii::String,
    }

    struct Burn has copy, drop {
        u_type: 0x1::ascii::String,
        stable_type: 0x1::ascii::String,
        burn_amount: u64,
        farm_types: vector<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity>,
        repayment_amounts: vector<u64>,
    }

    struct StableFactoryEntity<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct StableRegistry has key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u16>,
        total_supply: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct StableFactory<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        max_supply: u64,
        sheet: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Sheet<T1, StableFactoryEntity<T0, T1>>,
        managers: 0x2::vec_set::VecSet<address>,
    }

    struct FactoryCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        factory_id: 0x2::object::ID,
    }

    public fun mint<T0, T1, T2>(arg0: &mut StableRegistry, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Loan<T1, StableFactoryEntity<T0, T1>, T2>) {
        let v0 = borrow_factory_mut<T0, T1>(arg0);
        let v1 = 0x2::coin::value<T1>(&arg1);
        let v2 = StableFactoryEntity<T0, T1>{dummy_field: false};
        if (stable_supply<T0, T1>(v0) > max_supply<T0, T1>(v0)) {
            err_exceed_max_supply();
        };
        let v3 = Mint{
            u_type      : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            stable_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            mint_amount : v1,
            farm_type   : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()),
        };
        0x2::event::emit<Mint>(v3);
        arg0.total_supply = arg0.total_supply + v1;
        (0x2::coin::mint<T0>(&mut v0.treasury_cap, v1, arg2), 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::lend<T1, StableFactoryEntity<T0, T1>, T2>(&mut v0.sheet, 0x2::coin::into_balance<T1>(arg1), v2))
    }

    public fun total_supply(arg0: &StableRegistry) : u64 {
        arg0.total_supply
    }

    public fun new<T0, T1>(arg0: &mut StableRegistry, arg1: 0x2::coin::TreasuryCap<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : FactoryCap<T0, T1> {
        assert_valid_package_version(arg0);
        if (0x2::coin::total_supply<T0>(&arg1) > 0) {
            err_treasury_cap_not_empty();
        };
        let v0 = StableFactoryEntity<T0, T1>{dummy_field: false};
        let v1 = StableFactory<T0, T1>{
            id           : 0x2::object::new(arg3),
            treasury_cap : arg1,
            max_supply   : arg2,
            sheet        : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::new<T1, StableFactoryEntity<T0, T1>>(v0),
            managers     : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg3)),
        };
        let v2 = FactoryCap<T0, T1>{
            id         : 0x2::object::new(arg3),
            factory_id : 0x2::object::id<StableFactory<T0, T1>>(&v1),
        };
        let v3 = NewStable{
            u_type         : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            stable_type    : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            factory_id     : 0x2::object::id<StableFactory<T0, T1>>(&v1),
            factory_cap_id : 0x2::object::id<FactoryCap<T0, T1>>(&v2),
        };
        0x2::event::emit<NewStable>(v3);
        let v4 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, v4)) {
            err_factory_already_exists();
        };
        0x2::dynamic_object_field::add<0x1::type_name::TypeName, StableFactory<T0, T1>>(&mut arg0.id, v4, v1);
        v2
    }

    public fun add_entity<T0, T1, T2>(arg0: &mut StableRegistry, arg1: &FactoryCap<T0, T1>) {
        let v0 = StableFactoryEntity<T0, T1>{dummy_field: false};
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::add_debtor<T1, StableFactoryEntity<T0, T1>>(&mut borrow_factory_mut<T0, T1>(arg0).sheet, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::entity<T2>(), v0);
    }

    public fun add_manager<T0, T1>(arg0: &mut StableRegistry, arg1: &FactoryCap<T0, T1>, arg2: address) {
        0x2::vec_set::insert<address>(&mut borrow_factory_mut<T0, T1>(arg0).managers, arg2);
    }

    public fun add_version(arg0: &AdminCap, arg1: &mut StableRegistry, arg2: u16) {
        0x2::vec_set::insert<u16>(&mut arg1.versions, arg2);
    }

    fun assert_valid_package_version(arg0: &StableRegistry) {
        let v0 = package_version();
        if (!0x2::vec_set::contains<u16>(versions(arg0), &v0)) {
            err_invalid_package_version();
        };
    }

    public fun ban_entity<T0, T1, T2>(arg0: &mut StableRegistry, arg1: &FactoryCap<T0, T1>) {
        let v0 = StableFactoryEntity<T0, T1>{dummy_field: false};
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::ban<T1, StableFactoryEntity<T0, T1>>(&mut borrow_factory_mut<T0, T1>(arg0).sheet, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::entity<T2>(), v0);
    }

    public fun borrow_factory<T0, T1>(arg0: &StableRegistry) : &StableFactory<T0, T1> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            err_factory_not_exists();
        };
        0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, StableFactory<T0, T1>>(&arg0.id, v0)
    }

    fun borrow_factory_mut<T0, T1>(arg0: &mut StableRegistry) : &mut StableFactory<T0, T1> {
        assert_valid_package_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            err_factory_not_exists();
        };
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, StableFactory<T0, T1>>(&mut arg0.id, v0)
    }

    public fun default<T0, T1>(arg0: &mut StableRegistry, arg1: 0x2::coin::TreasuryCap<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = new<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::transfer::transfer<FactoryCap<T0, T1>>(v0, 0x2::tx_context::sender(arg3));
    }

    fun err_exceed_max_supply() {
        abort 5
    }

    fun err_factory_already_exists() {
        abort 1
    }

    fun err_factory_not_exists() {
        abort 4
    }

    fun err_invalid_package_version() {
        abort 0
    }

    fun err_request_not_fulfilled() {
        abort 2
    }

    fun err_treasury_cap_not_empty() {
        abort 3
    }

    public fun fulfill_burn<T0, T1>(arg0: &mut StableRegistry, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Request<T1, StableFactoryEntity<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = borrow_factory_mut<T0, T1>(arg0);
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::shortage<T1, StableFactoryEntity<T0, T1>>(&arg1) > 0) {
            err_request_not_fulfilled();
        };
        let v1 = 0x2::vec_map::keys<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T1>>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::payer_debts<T1, StableFactoryEntity<T0, T1>>(&arg1));
        let v2 = &v1;
        let v3 = vector[];
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity>(v2)) {
            0x1::vector::push_back<u64>(&mut v3, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::debt_value<T1>(0x2::vec_map::get<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::liability::Debt<T1>>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::payer_debts<T1, StableFactoryEntity<T0, T1>>(&arg1), 0x1::vector::borrow<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity>(v2, v4))));
            v4 = v4 + 1;
        };
        let v5 = Burn{
            u_type            : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            stable_type       : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            burn_amount       : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::balance<T1, StableFactoryEntity<T0, T1>>(&arg1),
            farm_types        : v1,
            repayment_amounts : v3,
        };
        0x2::event::emit<Burn>(v5);
        let v6 = StableFactoryEntity<T0, T1>{dummy_field: false};
        let v7 = 0x2::coin::from_balance<T1>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::collect<T1, StableFactoryEntity<T0, T1>>(&mut v0.sheet, arg1, v6), arg2);
        arg0.total_supply = arg0.total_supply - 0x2::coin::value<T1>(&v7);
        v7
    }

    public fun sheet<T0, T1>(arg0: &StableFactory<T0, T1>) : &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Sheet<T1, StableFactoryEntity<T0, T1>> {
        &arg0.sheet
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StableRegistry{
            id           : 0x2::object::new(arg0),
            versions     : 0x2::vec_set::singleton<u16>(package_version()),
            total_supply : 0,
        };
        0x2::transfer::share_object<StableRegistry>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun managers<T0, T1>(arg0: &StableFactory<T0, T1>) : &0x2::vec_set::VecSet<address> {
        &arg0.managers
    }

    public fun max_supply<T0, T1>(arg0: &StableFactory<T0, T1>) : u64 {
        arg0.max_supply
    }

    public fun package_version() : u16 {
        1
    }

    public fun remove_manager<T0, T1>(arg0: &mut StableRegistry, arg1: &FactoryCap<T0, T1>, arg2: address) {
        0x2::vec_set::remove<address>(&mut borrow_factory_mut<T0, T1>(arg0).managers, &arg2);
    }

    public fun remove_version(arg0: &AdminCap, arg1: &mut StableRegistry, arg2: u16) {
        0x2::vec_set::remove<u16>(&mut arg1.versions, &arg2);
    }

    public fun request_burn<T0, T1>(arg0: &mut StableRegistry, arg1: 0x2::coin::Coin<T0>) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Request<T1, StableFactoryEntity<T0, T1>> {
        0x2::coin::burn<T0>(&mut borrow_factory_mut<T0, T1>(arg0).treasury_cap, arg1);
        let v0 = StableFactoryEntity<T0, T1>{dummy_field: false};
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::request<T1, StableFactoryEntity<T0, T1>>(0x2::coin::value<T0>(&arg1), 0x1::option::none<vector<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity>>(), v0)
    }

    public fun set_max_supply<T0, T1>(arg0: &mut StableRegistry, arg1: &FactoryCap<T0, T1>, arg2: u64) {
        borrow_factory_mut<T0, T1>(arg0).max_supply = arg2;
    }

    public fun stable_supply<T0, T1>(arg0: &StableFactory<T0, T1>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.treasury_cap)
    }

    public fun versions(arg0: &StableRegistry) : &0x2::vec_set::VecSet<u16> {
        &arg0.versions
    }

    // decompiled from Move bytecode v6
}

