module 0x6369d3885d75db139e56d71ae9a1e9232af52ceaedb71e285972f5bae2a30e9e::typus_adapter {
    struct TypusAdapterRegistry has key {
        id: 0x2::object::UID,
        map: 0x2::vec_map::VecMap<0x2::object::ID, 0x2::object::ID>,
        whitelist: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct TypusVault has key {
        id: 0x2::object::UID,
        main_vault_id: 0x1::option::Option<0x2::object::ID>,
        contracts: 0x2::bag::Bag,
        record: TypusRecord,
        is_redeeming: bool,
    }

    struct TypusAdapterAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TypusRecord has store {
        long: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        short: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        supply: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
    }

    struct Typus has drop {
        dummy_field: bool,
    }

    public fun new<T0: drop>(arg0: &mut TypusAdapterRegistry, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Typus>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.whitelist, &v0)) {
            err_not_whitelisted_source();
        };
        let v1 = stamp();
        let v2 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::burn_and_get_info<T0, Typus>(arg1, &v1);
        let v3 = 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v2, b"main_vault_id");
        0x2::bag::destroy_empty(v2);
        if (0x2::vec_map::contains<0x2::object::ID, 0x2::object::ID>(&arg0.map, &v3)) {
            err_already_registered();
        };
        let v4 = TypusRecord{
            long   : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
            short  : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
            supply : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
        };
        let v5 = TypusVault{
            id            : 0x2::object::new(arg2),
            main_vault_id : 0x1::option::some<0x2::object::ID>(v3),
            contracts     : 0x2::bag::new(arg2),
            record        : v4,
            is_redeeming  : false,
        };
        0x2::vec_map::insert<0x2::object::ID, 0x2::object::ID>(&mut arg0.map, v3, *0x2::object::uid_as_inner(&v5.id));
        0x6369d3885d75db139e56d71ae9a1e9232af52ceaedb71e285972f5bae2a30e9e::typus_adapter_event::new_typus_vault_event(*0x2::object::uid_as_inner(&v5.id), v3);
        0x2::transfer::share_object<TypusVault>(v5);
    }

    entry fun add_whitelist<T0>(arg0: &mut TypusAdapterRegistry, arg1: &TypusAdapterAdminCap) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.whitelist, 0x1::type_name::get<T0>());
    }

    fun err_account_cap_existed() {
        abort 101
    }

    fun err_account_cap_not_existed() {
        abort 102
    }

    fun err_already_registered() {
        abort 103
    }

    fun err_main_vault_id_not_matched() {
        abort 100
    }

    fun err_not_whitelisted_source() {
        abort 104
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TypusAdapterRegistry{
            id        : 0x2::object::new(arg0),
            map       : 0x2::vec_map::empty<0x2::object::ID, 0x2::object::ID>(),
            whitelist : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v1 = TypusAdapterAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<TypusAdapterRegistry>(v0);
        0x2::transfer::public_transfer<TypusAdapterAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun remove_whitelist<T0>(arg0: &mut TypusAdapterRegistry, arg1: &TypusAdapterAdminCap) {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.whitelist, &v0);
    }

    fun stamp() : Typus {
        Typus{dummy_field: false}
    }

    public fun supply<T0, T1>(arg0: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg1: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry, arg2: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::treasury_caps::TreasuryCaps, arg3: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::mint_lp<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7), 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

