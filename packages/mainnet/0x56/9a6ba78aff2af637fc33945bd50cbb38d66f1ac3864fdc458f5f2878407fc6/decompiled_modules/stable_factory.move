module 0xd2599c296594f62d19bcf023e34c13783371706e2d3729fc13715ccde861cf97::stable_factory {
    struct StableKey<phantom T0, phantom T1> has copy, drop, store {
        dummy_field: bool,
    }

    struct StableFactoryEntity<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct StableRegistry has key {
        id: 0x2::object::UID,
    }

    struct StableFactory<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        sheet: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Sheet<T1, StableFactoryEntity<T0, T1>>,
        claimers: 0x2::vec_set::VecSet<address>,
    }

    struct FactoryCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        factory_id: 0x2::object::ID,
    }

    public fun mint<T0, T1, T2>(arg0: &mut StableFactory<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Loan<T1, StableFactoryEntity<T0, T1>, T2>) {
        let v0 = StableFactoryEntity<T0, T1>{dummy_field: false};
        (0x2::coin::mint<T0>(&mut arg0.treasury_cap, 0x2::coin::value<T1>(&arg1), arg2), 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::lend<T1, StableFactoryEntity<T0, T1>, T2>(&mut arg0.sheet, 0x2::coin::into_balance<T1>(arg1), v0))
    }

    public fun new<T0, T1>(arg0: &mut StableRegistry, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::tx_context::TxContext) : (StableFactory<T0, T1>, FactoryCap<T0>) {
        let v0 = StableKey<T0, T1>{dummy_field: false};
        let v1 = StableFactoryEntity<T0, T1>{dummy_field: false};
        let v2 = StableFactory<T0, T1>{
            id           : 0x2::derived_object::claim<StableKey<T0, T1>>(&mut arg0.id, v0),
            treasury_cap : arg1,
            sheet        : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::new<T1, StableFactoryEntity<T0, T1>>(v1),
            claimers     : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg2)),
        };
        let v3 = FactoryCap<T0>{
            id         : 0x2::object::new(arg2),
            factory_id : 0x2::object::id<StableFactory<T0, T1>>(&v2),
        };
        (v2, v3)
    }

    public fun sheet<T0, T1>(arg0: &StableFactory<T0, T1>) : &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Sheet<T1, StableFactoryEntity<T0, T1>> {
        &arg0.sheet
    }

    public fun add_claimer<T0, T1>(arg0: &mut StableFactory<T0, T1>, arg1: &FactoryCap<T0>, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg0.claimers, arg2);
    }

    public fun add_entity<T0, T1, T2>(arg0: &mut StableFactory<T0, T1>, arg1: &FactoryCap<T0>) {
        let v0 = StableFactoryEntity<T0, T1>{dummy_field: false};
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::add_debtor<T1, StableFactoryEntity<T0, T1>>(&mut arg0.sheet, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::entity<T2>(), v0);
    }

    public fun assert_sender_is_claimer<T0, T1>(arg0: &StableFactory<T0, T1>, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest) {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1);
        if (!0x2::vec_set::contains<address>(&arg0.claimers, &v0)) {
            err_sender_is_not_claimer();
        };
    }

    public fun ban_entity<T0, T1, T2>(arg0: &mut StableFactory<T0, T1>, arg1: &FactoryCap<T0>) {
        let v0 = StableFactoryEntity<T0, T1>{dummy_field: false};
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::ban<T1, StableFactoryEntity<T0, T1>>(&mut arg0.sheet, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::entity<T2>(), v0);
    }

    public fun default<T0, T1>(arg0: &mut StableRegistry, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new<T0, T1>(arg0, arg1, arg2);
        0x2::transfer::share_object<StableFactory<T0, T1>>(v0);
        0x2::transfer::transfer<FactoryCap<T0>>(v1, 0x2::tx_context::sender(arg2));
    }

    fun err_request_not_fulfull() {
        abort 102
    }

    fun err_sender_is_not_claimer() {
        abort 101
    }

    public fun fulfill_burn<T0, T1>(arg0: &mut StableFactory<T0, T1>, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Request<T1, StableFactoryEntity<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::shortage<T1, StableFactoryEntity<T0, T1>>(&arg1) > 0) {
            err_request_not_fulfull();
        };
        let v0 = StableFactoryEntity<T0, T1>{dummy_field: false};
        0x2::coin::from_balance<T1>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::collect<T1, StableFactoryEntity<T0, T1>>(&mut arg0.sheet, arg1, v0), arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StableRegistry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<StableRegistry>(v0);
    }

    public fun request_burn<T0, T1>(arg0: &mut StableFactory<T0, T1>, arg1: 0x2::coin::Coin<T0>) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Request<T1, StableFactoryEntity<T0, T1>> {
        0x2::coin::burn<T0>(&mut arg0.treasury_cap, arg1);
        let v0 = StableFactoryEntity<T0, T1>{dummy_field: false};
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::request<T1, StableFactoryEntity<T0, T1>>(0x2::coin::value<T0>(&arg1), 0x1::option::none<vector<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::sheet::Entity>>(), v0)
    }

    // decompiled from Move bytecode v6
}

