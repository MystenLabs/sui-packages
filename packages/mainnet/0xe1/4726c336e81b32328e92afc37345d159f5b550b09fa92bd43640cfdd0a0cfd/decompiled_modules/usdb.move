module 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb {
    struct Mint<phantom T0> has copy, drop {
        amount: u64,
        module_supply: u64,
        total_supply: u64,
    }

    struct Burn<phantom T0> has copy, drop {
        amount: u64,
        module_supply: u64,
        total_supply: u64,
    }

    struct USDB has drop {
        dummy_field: bool,
    }

    struct CapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ModuleConfig has store {
        valid_versions: 0x2::vec_set::VecSet<u16>,
        limited_supply: 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::limited_supply::LimitedSupply,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        module_config_map: 0x2::vec_map::VecMap<0x1::type_name::TypeName, ModuleConfig>,
        beneficiary_address: address,
    }

    public fun burn<T0: drop>(arg0: &mut Treasury, arg1: T0, arg2: u16, arg3: 0x2::coin::Coin<USDB>) {
        assert_valid_module_version<T0>(arg0, arg2);
        let v0 = 0x2::coin::value<USDB>(&arg3);
        if (v0 > 0) {
            let v1 = borrow_supply_mut<T0>(arg0);
            let v2 = 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::limited_supply::decrease(v1, v0);
            let v3 = borrow_cap_mut(arg0);
            0x2::coin::burn<USDB>(v3, arg3);
            let v4 = Burn<T0>{
                amount        : v0,
                module_supply : v2,
                total_supply  : total_supply(arg0),
            };
            0x2::event::emit<Burn<T0>>(v4);
        } else {
            0x2::coin::destroy_zero<USDB>(arg3);
        };
    }

    public fun mint<T0: drop>(arg0: &mut Treasury, arg1: T0, arg2: u16, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<USDB> {
        assert_valid_module_version<T0>(arg0, arg2);
        if (arg3 > 0) {
            let v1 = borrow_supply_mut<T0>(arg0);
            let v2 = 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::limited_supply::increase(v1, arg3);
            let v3 = borrow_cap_mut(arg0);
            let v4 = Mint<T0>{
                amount        : arg3,
                module_supply : v2,
                total_supply  : total_supply(arg0),
            };
            0x2::event::emit<Mint<T0>>(v4);
            0x2::coin::mint<USDB>(v3, arg3, arg4)
        } else {
            0x2::coin::zero<USDB>(arg4)
        }
    }

    public fun total_supply(arg0: &Treasury) : u64 {
        0x2::coin::total_supply<USDB>(borrow_cap(arg0))
    }

    public fun limited_supply(arg0: &ModuleConfig) : &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::limited_supply::LimitedSupply {
        &arg0.limited_supply
    }

    public fun add_version<T0: drop>(arg0: &mut Treasury, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: u16) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, ModuleConfig>(module_config_map(arg0), &v0)) {
            0x2::vec_set::insert<u16>(&mut 0x2::vec_map::get_mut<0x1::type_name::TypeName, ModuleConfig>(&mut arg0.module_config_map, &v0).valid_versions, arg2);
        } else {
            let v1 = ModuleConfig{
                valid_versions : 0x2::vec_set::singleton<u16>(arg2),
                limited_supply : 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::limited_supply::new(0),
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, ModuleConfig>(&mut arg0.module_config_map, v0, v1);
        };
    }

    public fun assert_valid_module_version<T0>(arg0: &Treasury, arg1: u16) : 0x1::type_name::TypeName {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = module_config_map(arg0);
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, ModuleConfig>(v1, &v0)) {
            err_invalid_module();
        };
        if (!0x2::vec_set::contains<u16>(valid_versions(0x2::vec_map::get<0x1::type_name::TypeName, ModuleConfig>(v1, &v0)), &arg1)) {
            err_invalid_module_version();
        };
        v0
    }

    public fun beneficiary_address(arg0: &Treasury) : address {
        arg0.beneficiary_address
    }

    fun borrow_cap(arg0: &Treasury) : &0x2::coin::TreasuryCap<USDB> {
        0x2::dynamic_object_field::borrow<CapKey, 0x2::coin::TreasuryCap<USDB>>(&arg0.id, cap_key())
    }

    fun borrow_cap_mut(arg0: &mut Treasury) : &mut 0x2::coin::TreasuryCap<USDB> {
        0x2::dynamic_object_field::borrow_mut<CapKey, 0x2::coin::TreasuryCap<USDB>>(&mut arg0.id, cap_key())
    }

    fun borrow_supply_mut<T0>(arg0: &mut Treasury) : &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::limited_supply::LimitedSupply {
        let v0 = 0x1::type_name::get<T0>();
        &mut 0x2::vec_map::get_mut<0x1::type_name::TypeName, ModuleConfig>(&mut arg0.module_config_map, &v0).limited_supply
    }

    fun cap_key() : CapKey {
        CapKey{dummy_field: false}
    }

    public fun claim<T0, T1: drop>(arg0: &mut Treasury, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (beneficiary_address(arg0) != 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1)) {
            err_not_beneficiary();
        };
        let v0 = &mut arg0.id;
        let v1 = 0x1::type_name::get<T0>();
        if (!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>>(v0, v1)) {
            return 0x1::option::none<0x2::coin::Coin<T0>>()
        };
        let v2 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>>(v0, v1);
        let v3 = 0x1::type_name::get<T1>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v2, &v3)) {
            return 0x1::option::none<0x2::coin::Coin<T0>>()
        };
        let (_, v5) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v2, &v3);
        let v6 = 0x2::coin::from_balance<T0>(v5, arg2);
        if (0x2::coin::value<T0>(&v6) > 0) {
            0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::treasury::emit_claim_fee<T0, T1>(0x2::coin::value<T0>(&v6));
        };
        0x1::option::some<0x2::coin::Coin<T0>>(v6)
    }

    public fun claimable_map<T0>(arg0: &Treasury) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::balance::Balance<T0>> {
        if (!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>>(&arg0.id, 0x1::type_name::get<T0>())) {
            err_coin_type_not_found();
        };
        0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>>(&arg0.id, 0x1::type_name::get<T0>())
    }

    public fun collect<T0, T1: drop>(arg0: &mut Treasury, arg1: T1, arg2: 0x1::string::String, arg3: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg3);
        if (v0 > 0) {
            let v1 = &mut arg0.id;
            let v2 = 0x1::type_name::get<T0>();
            if (!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>>(v1, v2)) {
                0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>>(v1, v2, 0x2::vec_map::empty<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>());
            };
            let v3 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>>(v1, v2);
            let v4 = 0x1::type_name::get<T1>();
            if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v3, &v4)) {
                0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v3, v4, 0x2::balance::zero<T0>());
            };
            0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::treasury::emit_collect_fee<T0, T1>(arg2, v0);
            0x2::balance::join<T0>(0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v3, &v4), arg3);
        } else {
            0x2::balance::destroy_zero<T0>(arg3);
        };
    }

    public fun decimal() : u8 {
        6
    }

    fun err_coin_type_not_found() {
        abort 204
    }

    fun err_invalid_module() {
        abort 201
    }

    fun err_invalid_module_version() {
        abort 202
    }

    fun err_not_beneficiary() {
        abort 203
    }

    fun init(arg0: USDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDB>(arg0, decimal(), b"USDB", b"Bucket USD", b"USDB is a decentralized, overcollateralized stablecoin of bucketprotocol.io, pegged to 1 USD and backed by crypto assets via CDP and PSM mechanisms.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.bucketprotocol.io/icons/USDB.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDB>>(v1);
        let v2 = 0x2::object::new(arg1);
        0x2::dynamic_object_field::add<CapKey, 0x2::coin::TreasuryCap<USDB>>(&mut v2, cap_key(), v0);
        let v3 = Treasury{
            id                  : v2,
            module_config_map   : 0x2::vec_map::empty<0x1::type_name::TypeName, ModuleConfig>(),
            beneficiary_address : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<Treasury>(v3);
    }

    public fun is_claimable_map_exists_type<T0>(arg0: &Treasury) : bool {
        0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>>(&arg0.id, 0x1::type_name::get<T0>())
    }

    public fun module_config_map(arg0: &Treasury) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, ModuleConfig> {
        &arg0.module_config_map
    }

    public fun remove_module<T0: drop>(arg0: &mut Treasury, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, ModuleConfig>(module_config_map(arg0), &v0)) {
            let (_, v2) = 0x2::vec_map::remove<0x1::type_name::TypeName, ModuleConfig>(&mut arg0.module_config_map, &v0);
            let ModuleConfig {
                valid_versions : _,
                limited_supply : v4,
            } = v2;
            0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::limited_supply::destroy(v4);
        };
    }

    public fun remove_version<T0: drop>(arg0: &mut Treasury, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: u16) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = module_config_map(arg0);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, ModuleConfig>(v1, &v0) && 0x2::vec_set::contains<u16>(valid_versions(0x2::vec_map::get<0x1::type_name::TypeName, ModuleConfig>(v1, &v0)), &arg2)) {
            0x2::vec_set::remove<u16>(&mut 0x2::vec_map::get_mut<0x1::type_name::TypeName, ModuleConfig>(&mut arg0.module_config_map, &v0).valid_versions, &arg2);
        };
    }

    public fun set_beneficiary_address(arg0: &mut Treasury, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: address) {
        arg0.beneficiary_address = arg2;
    }

    public fun set_supply_limit<T0: drop>(arg0: &mut Treasury, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: u64) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, ModuleConfig>(module_config_map(arg0), &v0)) {
            0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::limited_supply::set_limit(&mut 0x2::vec_map::get_mut<0x1::type_name::TypeName, ModuleConfig>(&mut arg0.module_config_map, &v0).limited_supply, arg2);
        } else {
            let v1 = ModuleConfig{
                valid_versions : 0x2::vec_set::empty<u16>(),
                limited_supply : 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::limited_supply::new(arg2),
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, ModuleConfig>(&mut arg0.module_config_map, v0, v1);
        };
    }

    public fun valid_versions(arg0: &ModuleConfig) : &0x2::vec_set::VecSet<u16> {
        &arg0.valid_versions
    }

    // decompiled from Move bytecode v6
}

