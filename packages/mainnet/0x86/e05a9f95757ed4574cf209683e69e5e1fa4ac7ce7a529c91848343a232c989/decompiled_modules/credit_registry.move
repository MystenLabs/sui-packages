module 0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::credit_registry {
    struct CapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Mint<phantom T0, phantom T1> has copy, drop {
        amount: u64,
        module_supply: u64,
        total_supply: u64,
    }

    struct Burn<phantom T0, phantom T1> has copy, drop {
        amount: u64,
        module_supply: u64,
        total_supply: u64,
    }

    struct ProtocolCapBasisRefreshed<phantom T0> has copy, drop {
        cap_basis_supply: u64,
        last_refresh_ms: u64,
    }

    struct CollectFee<phantom T0, phantom T1> has copy, drop {
        memo: 0x1::string::String,
        coin_type: 0x1::string::String,
        amount: u64,
    }

    struct ClaimFee<phantom T0, phantom T1> has copy, drop {
        coin_type: 0x1::string::String,
        amount: u64,
    }

    struct ModuleConfig has store {
        valid_versions: 0x2::vec_set::VecSet<u16>,
        limited_supply: 0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::limited_supply::LimitedSupply,
    }

    struct BurnWindow has copy, drop, store {
        burned: u64,
        window_start_ms: u64,
    }

    struct PersonalBurnCap has store {
        cap_amount: u64,
        window_ms: u64,
        user_burns: 0x2::table::Table<address, BurnWindow>,
    }

    struct ProtocolBurnCap has store {
        cap_basis_supply: u64,
        cap_bps: u64,
        refresh_interval_ms: u64,
        last_refresh_ms: u64,
        burned_in_window: u64,
    }

    struct CreditRegistry<phantom T0> has key {
        id: 0x2::object::UID,
        module_config_map: 0x2::vec_map::VecMap<0x1::type_name::TypeName, ModuleConfig>,
        beneficiary_address: address,
        offset_supply: u64,
        personal_burn_cap: PersonalBurnCap,
        protocol_burn_cap: ProtocolBurnCap,
        allowed_versions: 0x2::vec_set::VecSet<u16>,
    }

    public fun burn<T0, T1: drop>(arg0: &mut CreditRegistry<T0>, arg1: 0x2::object::ID, arg2: T1, arg3: u16, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock) {
        burn_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5, 0x2::object::id_to_address(&arg1));
    }

    public fun mint<T0, T1: drop>(arg0: &mut CreditRegistry<T0>, arg1: T1, arg2: u16, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_package_version<T0>(arg0);
        assert_valid_module_version<T0, T1>(arg0, arg2);
        if (arg3 == 0) {
            return 0x2::coin::zero<T0>(arg4)
        };
        let v0 = borrow_supply_mut<T0, T1>(arg0);
        let v1 = 0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::limited_supply::increase(v0, arg3);
        let v2 = borrow_cap_mut<T0>(arg0);
        let v3 = 0x2::coin::mint<T0>(v2, arg3, arg4);
        let v4 = Mint<T0, T1>{
            amount        : arg3,
            module_supply : v1,
            total_supply  : total_supply<T0>(arg0),
        };
        0x2::event::emit<Mint<T0, T1>>(v4);
        v3
    }

    public fun total_supply<T0>(arg0: &CreditRegistry<T0>) : u64 {
        0x2::coin::total_supply<T0>(borrow_cap<T0>(arg0))
    }

    public fun add_package_version<T0>(arg0: &mut CreditRegistry<T0>, arg1: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg2: u16) {
        if (0x2::vec_set::contains<u16>(&arg0.allowed_versions, &arg2)) {
            return
        };
        0x2::vec_set::insert<u16>(&mut arg0.allowed_versions, arg2);
    }

    public fun add_version<T0, T1: drop>(arg0: &mut CreditRegistry<T0>, arg1: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg2: u16) {
        assert_valid_package_version<T0>(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, ModuleConfig>(&arg0.module_config_map, &v0)) {
            0x2::vec_set::insert<u16>(&mut 0x2::vec_map::get_mut<0x1::type_name::TypeName, ModuleConfig>(&mut arg0.module_config_map, &v0).valid_versions, arg2);
        } else {
            let v1 = ModuleConfig{
                valid_versions : 0x2::vec_set::singleton<u16>(arg2),
                limited_supply : 0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::limited_supply::new(0),
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, ModuleConfig>(&mut arg0.module_config_map, v0, v1);
        };
    }

    public fun assert_valid_module_version<T0, T1>(arg0: &CreditRegistry<T0>, arg1: u16) : 0x1::type_name::TypeName {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = &arg0.module_config_map;
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, ModuleConfig>(v1, &v0), 13906836927417614340);
        assert!(0x2::vec_set::contains<u16>(&0x2::vec_map::get<0x1::type_name::TypeName, ModuleConfig>(v1, &v0).valid_versions, &arg1), 13906836931712712710);
        v0
    }

    fun assert_valid_package_version<T0>(arg0: &CreditRegistry<T0>) {
        let v0 = 1;
        assert!(0x2::vec_set::contains<u16>(&arg0.allowed_versions, &v0), 13906836974663172114);
    }

    public fun beneficiary_address<T0>(arg0: &CreditRegistry<T0>) : address {
        arg0.beneficiary_address
    }

    fun borrow_cap<T0>(arg0: &CreditRegistry<T0>) : &0x2::coin::TreasuryCap<T0> {
        let v0 = CapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<CapKey, 0x2::coin::TreasuryCap<T0>>(&arg0.id, v0)
    }

    fun borrow_cap_mut<T0>(arg0: &mut CreditRegistry<T0>) : &mut 0x2::coin::TreasuryCap<T0> {
        let v0 = CapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<CapKey, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, v0)
    }

    fun borrow_supply_mut<T0, T1>(arg0: &mut CreditRegistry<T0>) : &mut 0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::limited_supply::LimitedSupply {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        &mut 0x2::vec_map::get_mut<0x1::type_name::TypeName, ModuleConfig>(&mut arg0.module_config_map, &v0).limited_supply
    }

    public fun limited_supply(arg0: &ModuleConfig) : &0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::limited_supply::LimitedSupply {
        &arg0.limited_supply
    }

    fun burn_internal<T0, T1: drop>(arg0: &mut CreditRegistry<T0>, arg1: T1, arg2: u16, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: address) {
        assert_valid_package_version<T0>(arg0);
        assert_valid_module_version<T0, T1>(arg0, arg2);
        let v0 = 0x2::coin::value<T0>(&arg3);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T0>(arg3);
            return
        };
        let v1 = 0x2::clock::timestamp_ms(arg4);
        check_personal_burn_cap<T0>(arg0, v0, v1, arg5);
        check_protocol_burn_cap<T0>(arg0, v0, v1);
        let v2 = borrow_supply_mut<T0, T1>(arg0);
        let v3 = 0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::limited_supply::decrease(v2, v0);
        let v4 = borrow_cap_mut<T0>(arg0);
        0x2::coin::burn<T0>(v4, arg3);
        let v5 = Burn<T0, T1>{
            amount        : v0,
            module_supply : v3,
            total_supply  : total_supply<T0>(arg0),
        };
        0x2::event::emit<Burn<T0, T1>>(v5);
    }

    fun check_personal_burn_cap<T0>(arg0: &mut CreditRegistry<T0>, arg1: u64, arg2: u64, arg3: address) {
        let v0 = &mut arg0.personal_burn_cap;
        if (v0.cap_amount == 0) {
            return
        };
        if (!0x2::table::contains<address, BurnWindow>(&v0.user_burns, arg3)) {
            let v1 = BurnWindow{
                burned          : 0,
                window_start_ms : arg2,
            };
            0x2::table::add<address, BurnWindow>(&mut v0.user_burns, arg3, v1);
        };
        let v2 = 0x2::table::borrow_mut<address, BurnWindow>(&mut v0.user_burns, arg3);
        if (arg2 >= v2.window_start_ms + v0.window_ms) {
            v2.burned = 0;
            v2.window_start_ms = arg2;
        };
        assert!(v2.burned + arg1 <= v0.cap_amount, 13906836154323894282);
        v2.burned = v2.burned + arg1;
    }

    fun check_protocol_burn_cap<T0>(arg0: &mut CreditRegistry<T0>, arg1: u64, arg2: u64) {
        if (arg0.protocol_burn_cap.cap_bps == 0) {
            return
        };
        if (arg2 >= arg0.protocol_burn_cap.last_refresh_ms + arg0.protocol_burn_cap.refresh_interval_ms) {
            arg0.protocol_burn_cap.cap_basis_supply = total_supply<T0>(arg0);
            arg0.protocol_burn_cap.last_refresh_ms = arg2;
            arg0.protocol_burn_cap.burned_in_window = 0;
        };
        let v0 = &mut arg0.protocol_burn_cap;
        assert!(v0.burned_in_window + arg1 <= (((v0.cap_basis_supply as u128) * (v0.cap_bps as u128) / (10000 as u128)) as u64), 13906836253108273164);
        v0.burned_in_window = v0.burned_in_window + arg1;
    }

    public fun claim<T0, T1, T2: drop>(arg0: &mut CreditRegistry<T0>, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T1>> {
        assert_valid_package_version<T0>(arg0);
        assert!(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1) == arg0.beneficiary_address, 13906836472151867408);
        let v0 = &mut arg0.id;
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        if (!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>>(v0, v1)) {
            return 0x1::option::none<0x2::coin::Coin<T1>>()
        };
        let v2 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>>(v0, v1);
        let v3 = 0x1::type_name::with_defining_ids<T2>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(v2, &v3)) {
            return 0x1::option::none<0x2::coin::Coin<T1>>()
        };
        let (_, v5) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(v2, &v3);
        let v6 = 0x2::coin::from_balance<T1>(v5, arg2);
        if (0x2::coin::value<T1>(&v6) > 0) {
            let v7 = ClaimFee<T0, T2>{
                coin_type : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>())),
                amount    : 0x2::coin::value<T1>(&v6),
            };
            0x2::event::emit<ClaimFee<T0, T2>>(v7);
        };
        0x1::option::some<0x2::coin::Coin<T1>>(v6)
    }

    public fun claimable_map<T0, T1>(arg0: &CreditRegistry<T0>) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::balance::Balance<T1>> {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>>(&arg0.id, v0), 13906836880173236232);
        0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>>(&arg0.id, v0)
    }

    public fun collect<T0, T1, T2: drop>(arg0: &mut CreditRegistry<T0>, arg1: T2, arg2: u16, arg3: 0x1::string::String, arg4: 0x2::balance::Balance<T1>) {
        assert_valid_package_version<T0>(arg0);
        assert_valid_module_version<T0, T2>(arg0, arg2);
        let v0 = 0x2::balance::value<T1>(&arg4);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T1>(arg4);
            return
        };
        let v1 = &mut arg0.id;
        let v2 = 0x1::type_name::with_defining_ids<T1>();
        if (!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>>(v1, v2)) {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>>(v1, v2, 0x2::vec_map::empty<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>());
        };
        let v3 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>>(v1, v2);
        let v4 = 0x1::type_name::with_defining_ids<T2>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(v3, &v4)) {
            0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(v3, v4, 0x2::balance::zero<T1>());
        };
        let v5 = CollectFee<T0, T2>{
            memo      : arg3,
            coin_type : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>())),
            amount    : v0,
        };
        0x2::event::emit<CollectFee<T0, T2>>(v5);
        0x2::balance::join<T1>(0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(v3, &v4), arg4);
    }

    public fun create_credit_registry<T0>(arg0: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg2);
        let v1 = CapKey{dummy_field: false};
        0x2::dynamic_object_field::add<CapKey, 0x2::coin::TreasuryCap<T0>>(&mut v0, v1, arg1);
        let v2 = 0x2::tx_context::sender(arg2);
        let v3 = CreditRegistry<T0>{
            id                  : v0,
            module_config_map   : 0x2::vec_map::empty<0x1::type_name::TypeName, ModuleConfig>(),
            beneficiary_address : v2,
            offset_supply       : 0x2::coin::total_supply<T0>(&arg1),
            personal_burn_cap   : new_personal_burn_cap(arg2),
            protocol_burn_cap   : new_protocol_burn_cap(),
            allowed_versions    : 0x2::vec_set::singleton<u16>(1),
        };
        0x2::transfer::share_object<CreditRegistry<T0>>(v3);
    }

    public fun is_claimable_map_exists_type<T0, T1>(arg0: &CreditRegistry<T0>) : bool {
        0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>>(&arg0.id, 0x1::type_name::with_defining_ids<T1>())
    }

    public fun module_config_map<T0>(arg0: &CreditRegistry<T0>) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, ModuleConfig> {
        &arg0.module_config_map
    }

    fun new_personal_burn_cap(arg0: &mut 0x2::tx_context::TxContext) : PersonalBurnCap {
        PersonalBurnCap{
            cap_amount : 0,
            window_ms  : 86400000,
            user_burns : 0x2::table::new<address, BurnWindow>(arg0),
        }
    }

    fun new_protocol_burn_cap() : ProtocolBurnCap {
        ProtocolBurnCap{
            cap_basis_supply    : 0,
            cap_bps             : 0,
            refresh_interval_ms : 86400000,
            last_refresh_ms     : 0,
            burned_in_window    : 0,
        }
    }

    public fun offset_supply<T0>(arg0: &CreditRegistry<T0>) : u64 {
        arg0.offset_supply
    }

    public fun package_version() : u16 {
        1
    }

    public fun personal_burn_cap_amount<T0>(arg0: &CreditRegistry<T0>) : u64 {
        arg0.personal_burn_cap.cap_amount
    }

    public fun personal_burn_cap_window_ms<T0>(arg0: &CreditRegistry<T0>) : u64 {
        arg0.personal_burn_cap.window_ms
    }

    public fun personal_burn_window_count<T0>(arg0: &CreditRegistry<T0>) : u64 {
        0x2::table::length<address, BurnWindow>(&arg0.personal_burn_cap.user_burns)
    }

    public fun personal_burned<T0>(arg0: &CreditRegistry<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, BurnWindow>(&arg0.personal_burn_cap.user_burns, arg1)) {
            0x2::table::borrow<address, BurnWindow>(&arg0.personal_burn_cap.user_burns, arg1).burned
        } else {
            0
        }
    }

    public fun protocol_cap_basis_supply<T0>(arg0: &CreditRegistry<T0>) : u64 {
        arg0.protocol_burn_cap.cap_basis_supply
    }

    public fun protocol_cap_bps<T0>(arg0: &CreditRegistry<T0>) : u64 {
        arg0.protocol_burn_cap.cap_bps
    }

    public fun protocol_cap_burned_in_window<T0>(arg0: &CreditRegistry<T0>) : u64 {
        arg0.protocol_burn_cap.burned_in_window
    }

    public fun protocol_cap_last_refresh_ms<T0>(arg0: &CreditRegistry<T0>) : u64 {
        arg0.protocol_burn_cap.last_refresh_ms
    }

    public fun protocol_cap_refresh_interval_ms<T0>(arg0: &CreditRegistry<T0>) : u64 {
        arg0.protocol_burn_cap.refresh_interval_ms
    }

    public fun refresh_protocol_cap_basis<T0>(arg0: &mut CreditRegistry<T0>, arg1: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg2: &0x2::clock::Clock) {
        assert_valid_package_version<T0>(arg0);
        let v0 = total_supply<T0>(arg0);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        arg0.protocol_burn_cap.cap_basis_supply = v0;
        arg0.protocol_burn_cap.last_refresh_ms = v1;
        arg0.protocol_burn_cap.burned_in_window = 0;
        let v2 = ProtocolCapBasisRefreshed<T0>{
            cap_basis_supply : v0,
            last_refresh_ms  : v1,
        };
        0x2::event::emit<ProtocolCapBasisRefreshed<T0>>(v2);
    }

    public fun remove_module<T0, T1: drop>(arg0: &mut CreditRegistry<T0>, arg1: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap) {
        assert_valid_package_version<T0>(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, ModuleConfig>(&arg0.module_config_map, &v0)) {
            let (_, v2) = 0x2::vec_map::remove<0x1::type_name::TypeName, ModuleConfig>(&mut arg0.module_config_map, &v0);
            let ModuleConfig {
                valid_versions : _,
                limited_supply : v4,
            } = v2;
            0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::limited_supply::destroy(v4);
        };
    }

    public fun remove_package_version<T0>(arg0: &mut CreditRegistry<T0>, arg1: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg2: u16) {
        if (!0x2::vec_set::contains<u16>(&arg0.allowed_versions, &arg2)) {
            return
        };
        0x2::vec_set::remove<u16>(&mut arg0.allowed_versions, &arg2);
    }

    public fun remove_version<T0, T1: drop>(arg0: &mut CreditRegistry<T0>, arg1: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg2: u16) {
        assert_valid_package_version<T0>(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = &arg0.module_config_map;
        if (0x2::vec_map::contains<0x1::type_name::TypeName, ModuleConfig>(v1, &v0) && 0x2::vec_set::contains<u16>(&0x2::vec_map::get<0x1::type_name::TypeName, ModuleConfig>(v1, &v0).valid_versions, &arg2)) {
            0x2::vec_set::remove<u16>(&mut 0x2::vec_map::get_mut<0x1::type_name::TypeName, ModuleConfig>(&mut arg0.module_config_map, &v0).valid_versions, &arg2);
        };
    }

    public fun reset_personal_burn_window<T0>(arg0: &mut CreditRegistry<T0>, arg1: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg2: address) {
        assert_valid_package_version<T0>(arg0);
        if (0x2::table::contains<address, BurnWindow>(&arg0.personal_burn_cap.user_burns, arg2)) {
            0x2::table::remove<address, BurnWindow>(&mut arg0.personal_burn_cap.user_burns, arg2);
        };
    }

    public fun set_beneficiary_address<T0>(arg0: &mut CreditRegistry<T0>, arg1: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg2: address) {
        assert_valid_package_version<T0>(arg0);
        arg0.beneficiary_address = arg2;
    }

    public fun set_personal_burn_cap<T0>(arg0: &mut CreditRegistry<T0>, arg1: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg2: u64, arg3: u64) {
        assert_valid_package_version<T0>(arg0);
        assert!(arg3 > 0, 13906835084877299726);
        arg0.personal_burn_cap.cap_amount = arg2;
        arg0.personal_burn_cap.window_ms = arg3;
    }

    public fun set_protocol_burn_cap<T0>(arg0: &mut CreditRegistry<T0>, arg1: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        assert_valid_package_version<T0>(arg0);
        assert!(arg2 <= 10000, 13906835183661547534);
        assert!(arg3 > 0, 13906835187956514830);
        arg0.protocol_burn_cap.cap_bps = arg2;
        arg0.protocol_burn_cap.refresh_interval_ms = arg3;
        if (arg0.protocol_burn_cap.cap_bps == 0 && arg2 > 0) {
            let v0 = total_supply<T0>(arg0);
            let v1 = 0x2::clock::timestamp_ms(arg4);
            arg0.protocol_burn_cap.cap_basis_supply = v0;
            arg0.protocol_burn_cap.last_refresh_ms = v1;
            arg0.protocol_burn_cap.burned_in_window = 0;
            let v2 = ProtocolCapBasisRefreshed<T0>{
                cap_basis_supply : v0,
                last_refresh_ms  : v1,
            };
            0x2::event::emit<ProtocolCapBasisRefreshed<T0>>(v2);
        };
    }

    public fun set_supply_limit<T0, T1: drop>(arg0: &mut CreditRegistry<T0>, arg1: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg2: u64) {
        assert_valid_package_version<T0>(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, ModuleConfig>(&arg0.module_config_map, &v0)) {
            0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::limited_supply::set_limit(&mut 0x2::vec_map::get_mut<0x1::type_name::TypeName, ModuleConfig>(&mut arg0.module_config_map, &v0).limited_supply, arg2);
        } else {
            let v1 = ModuleConfig{
                valid_versions : 0x2::vec_set::empty<u16>(),
                limited_supply : 0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::limited_supply::new(arg2),
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, ModuleConfig>(&mut arg0.module_config_map, v0, v1);
        };
    }

    public fun valid_versions(arg0: &ModuleConfig) : &0x2::vec_set::VecSet<u16> {
        &arg0.valid_versions
    }

    // decompiled from Move bytecode v7
}

