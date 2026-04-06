module 0x45f6855a4bed5ecbc7cd0032c46c8126a8c0c81ad5376d05ff27e02ae1deef21::free_bet {
    struct FreeBet has copy, drop, store {
        dummy_field: bool,
    }

    struct FreeBetRegistryKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FreeBetRegistry has store, key {
        id: 0x2::object::UID,
        version_set: 0x2::vec_set::VecSet<u64>,
        is_enabled: bool,
        total_free_bet_per_coin: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct UserFreeBetKey has copy, drop, store {
        pos0: address,
    }

    struct UserFreeBetData has store, key {
        id: 0x2::object::UID,
        balances: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct FreeBetGrantedEvent<phantom T0> has copy, drop {
        actor: address,
        player: address,
        amount: u64,
    }

    struct FreeBetRemovedEvent<phantom T0> has copy, drop {
        actor: address,
        player: address,
        amount: u64,
    }

    struct FreeBetClaimedEvent<phantom T0> has copy, drop {
        actor: address,
        player: address,
        operator_type_name: 0x1::type_name::TypeName,
        amount: u64,
        remaining_balance: u64,
    }

    struct FreeBetRegistryEditedEvent has copy, drop {
        is_enabled: bool,
    }

    struct FreeBetRegistryCreatedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        is_enabled: bool,
    }

    struct FreeBetRegistryVersionChangedEvent has copy, drop {
        version_number: u64,
        is_added: bool,
    }

    struct UserFreeBetDataCreatedEvent has copy, drop {
        player: address,
        user_data_id: 0x2::object::ID,
    }

    fun add_free_bet_internal<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: address, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 13835622615848452099);
        let v0 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::total_rakeback_pool_balance<T0>(arg0);
        let v1 = borrow_free_bet_registry_mut(arg0);
        assert!(v1.is_enabled, 13835341162346446849);
        let v2 = total_allocated_for_coin<T0>(v1) + arg3;
        assert!(v2 <= v0, 13836467079433682953);
        create_user_free_bet_data_if_not_exists(v1, arg2, arg4);
        let v3 = borrow_user_free_bet_data_mut(v1, arg2);
        let v4 = user_free_bet_balance_internal<T0>(v3) + arg3;
        set_user_free_bet_balance<T0>(v3, v4);
        set_total_allocated_for_coin<T0>(v1, v2);
        let v5 = FreeBetGrantedEvent<T0>{
            actor  : arg1,
            player : arg2,
            amount : arg3,
        };
        0x2::event::emit<FreeBetGrantedEvent<T0>>(v5);
    }

    public fun admin_add_free_bet<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        add_free_bet_internal<T0>(arg0, v0, arg2, arg3, arg4);
    }

    public fun admin_add_version(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: u64) {
        let v0 = borrow_free_bet_registry_mut_unchecked(arg0);
        if (!0x2::vec_set::contains<u64>(&v0.version_set, &arg2)) {
            0x2::vec_set::insert<u64>(&mut v0.version_set, arg2);
            let v1 = FreeBetRegistryVersionChangedEvent{
                version_number : arg2,
                is_added       : true,
            };
            0x2::event::emit<FreeBetRegistryVersionChangedEvent>(v1);
        };
    }

    public fun admin_create_free_bet_registry(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        create_free_bet_registry_internal(arg0, arg2);
    }

    public fun admin_edit_free_bet_registry(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: bool) {
        edit_free_bet_registry_internal(arg0, arg2);
    }

    public fun admin_remove_free_bet<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        remove_free_bet_internal<T0>(arg0, 0x2::tx_context::sender(arg4), arg2, arg3);
    }

    public fun admin_remove_version(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: u64) {
        let v0 = borrow_free_bet_registry_mut_unchecked(arg0);
        remove_version_internal(v0, arg2);
    }

    fun assert_free_bet_operator_config_exists(arg0: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) {
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_config_exists<FreeBet>(arg0), 13837310434917351439);
    }

    fun assert_free_bet_registry_exists(arg0: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) {
        assert_free_bet_operator_config_exists(arg0);
        let v0 = free_bet_registry_key();
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::dof_exists<FreeBetRegistryKey>(arg0, v0), 13837591935663996945);
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::dof_exists_with_type<FreeBet, FreeBetRegistryKey, FreeBetRegistry>(arg0, free_bet_marker(), v0), 13838154915682451477);
    }

    fun assert_valid_version(arg0: &FreeBetRegistry) {
        let v0 = package_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &v0), 13838436283285110807);
    }

    public fun borrow_free_bet_registry(arg0: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) : &FreeBetRegistry {
        let v0 = borrow_free_bet_registry_unchecked(arg0);
        assert_valid_version(v0);
        v0
    }

    fun borrow_free_bet_registry_mut(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) : &mut FreeBetRegistry {
        let v0 = borrow_free_bet_registry_mut_unchecked(arg0);
        assert_valid_version(v0);
        v0
    }

    fun borrow_free_bet_registry_mut_unchecked(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) : &mut FreeBetRegistry {
        assert_free_bet_registry_exists(arg0);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_borrow_operator_dof_mut<FreeBet, FreeBetRegistryKey, FreeBetRegistry>(arg0, free_bet_marker(), free_bet_registry_key())
    }

    fun borrow_free_bet_registry_unchecked(arg0: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) : &FreeBetRegistry {
        assert_free_bet_registry_exists(arg0);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::borrow_operator_dof<FreeBet, FreeBetRegistryKey, FreeBetRegistry>(arg0, free_bet_registry_key())
    }

    public fun borrow_user_free_bet_data(arg0: &FreeBetRegistry, arg1: address) : &UserFreeBetData {
        let v0 = UserFreeBetKey{pos0: arg1};
        assert!(0x2::dynamic_object_field::exists_<UserFreeBetKey>(&arg0.id, v0), 13835903644148695045);
        let v1 = UserFreeBetKey{pos0: arg1};
        0x2::dynamic_object_field::borrow<UserFreeBetKey, UserFreeBetData>(&arg0.id, v1)
    }

    fun borrow_user_free_bet_data_mut(arg0: &mut FreeBetRegistry, arg1: address) : &mut UserFreeBetData {
        let v0 = UserFreeBetKey{pos0: arg1};
        0x2::dynamic_object_field::borrow_mut<UserFreeBetKey, UserFreeBetData>(&mut arg0.id, v0)
    }

    fun coin_type_name<T0>() : 0x1::type_name::TypeName {
        0x1::type_name::with_defining_ids<T0>()
    }

    fun create_free_bet_registry_internal(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &mut 0x2::tx_context::TxContext) {
        assert_free_bet_operator_config_exists(arg0);
        let v0 = free_bet_registry_key();
        assert!(!0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::dof_exists<FreeBetRegistryKey>(arg0, v0), 13837874119310442515);
        let v1 = 0x2::object::new(arg1);
        let v2 = FreeBetRegistry{
            id                      : v1,
            version_set             : 0x2::vec_set::singleton<u64>(0),
            is_enabled              : true,
            total_free_bet_per_coin : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
        };
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_add_operator_dof<FreeBet, FreeBetRegistryKey, FreeBetRegistry>(arg0, free_bet_marker(), v0, v2);
        let v3 = FreeBetRegistryCreatedEvent{
            registry_id : 0x2::object::uid_to_inner(&v1),
            is_enabled  : true,
        };
        0x2::event::emit<FreeBetRegistryCreatedEvent>(v3);
    }

    fun create_user_free_bet_data_if_not_exists(arg0: &mut FreeBetRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = UserFreeBetKey{pos0: arg1};
        if (!0x2::dynamic_object_field::exists_<UserFreeBetKey>(&arg0.id, v0)) {
            let v1 = 0x2::object::new(arg2);
            let v2 = UserFreeBetData{
                id       : v1,
                balances : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            };
            let v3 = UserFreeBetKey{pos0: arg1};
            0x2::dynamic_object_field::add<UserFreeBetKey, UserFreeBetData>(&mut arg0.id, v3, v2);
            let v4 = UserFreeBetDataCreatedEvent{
                player       : arg1,
                user_data_id : 0x2::object::uid_to_inner(&v1),
            };
            0x2::event::emit<UserFreeBetDataCreatedEvent>(v4);
        };
    }

    fun edit_free_bet_registry_internal(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: bool) {
        borrow_free_bet_registry_mut(arg0).is_enabled = arg1;
        let v0 = FreeBetRegistryEditedEvent{is_enabled: arg1};
        0x2::event::emit<FreeBetRegistryEditedEvent>(v0);
    }

    fun free_bet_marker() : FreeBet {
        FreeBet{dummy_field: false}
    }

    public fun free_bet_registry_exists(arg0: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) : bool {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::dof_exists<FreeBetRegistryKey>(arg0, free_bet_registry_key())
    }

    fun free_bet_registry_key() : FreeBetRegistryKey {
        FreeBetRegistryKey{dummy_field: false}
    }

    public fun manager_add_free_bet<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<FreeBet>(arg1, 0x2::tx_context::sender(arg4));
        let v0 = 0x2::tx_context::sender(arg4);
        add_free_bet_internal<T0>(arg0, v0, arg2, arg3, arg4);
    }

    public fun manager_create_free_bet_registry(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<FreeBet>(arg1, 0x2::tx_context::sender(arg2));
        create_free_bet_registry_internal(arg0, arg2);
    }

    public fun manager_edit_free_bet_registry(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<FreeBet>(arg1, 0x2::tx_context::sender(arg3));
        edit_free_bet_registry_internal(arg0, arg2);
    }

    public fun manager_remove_free_bet<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<FreeBet>(arg1, 0x2::tx_context::sender(arg4));
        remove_free_bet_internal<T0>(arg0, 0x2::tx_context::sender(arg4), arg2, arg3);
    }

    public fun manager_remove_version(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<FreeBet>(arg1, 0x2::tx_context::sender(arg3));
        let v0 = borrow_free_bet_registry_mut_unchecked(arg0);
        remove_version_internal(v0, arg2);
    }

    public fun operator_claim_player_free_bet<T0, T1: drop>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: T1, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg3 > 0, 13835623157014331395);
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_config_exists<T1>(arg0), 13837030536193507341);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::assert_operator_config_enabled<T1>(arg0);
        let v0 = borrow_free_bet_registry_mut(arg0);
        assert!(v0.is_enabled, 13835341716397228033);
        let v1 = UserFreeBetKey{pos0: arg2};
        assert!(0x2::dynamic_object_field::exists_<UserFreeBetKey>(&v0.id, v1), 13835904670645878789);
        let v2 = borrow_user_free_bet_data_mut(v0, arg2);
        let v3 = user_free_bet_balance_internal<T0>(v2);
        assert!(v3 >= arg3, 13836186162802589703);
        let v4 = v3 - arg3;
        set_user_free_bet_balance<T0>(v2, v4);
        let v5 = total_allocated_for_coin<T0>(v0);
        assert!(v5 >= arg3, 13836749134231109643);
        set_total_allocated_for_coin<T0>(v0, v5 - arg3);
        let v6 = FreeBetClaimedEvent<T0>{
            actor              : 0x2::tx_context::sender(arg4),
            player             : arg2,
            operator_type_name : 0x1::type_name::with_defining_ids<T1>(),
            amount             : arg3,
            remaining_balance  : v4,
        };
        0x2::event::emit<FreeBetClaimedEvent<T0>>(v6);
        0x2::coin::from_balance<T0>(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_take_from_rakeback_pool<T0, T1>(arg0, arg1, arg3), arg4)
    }

    fun package_version() : u64 {
        0
    }

    fun remove_free_bet_internal<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: address, arg2: address, arg3: u64) {
        assert!(arg3 > 0, 13835622740402503683);
        let v0 = borrow_free_bet_registry_mut(arg0);
        assert!(v0.is_enabled, 13835341282605531137);
        let v1 = UserFreeBetKey{pos0: arg2};
        assert!(0x2::dynamic_object_field::exists_<UserFreeBetKey>(&v0.id, v1), 13835904236854181893);
        let v2 = borrow_user_free_bet_data_mut(v0, arg2);
        let v3 = user_free_bet_balance_internal<T0>(v2);
        assert!(v3 >= arg3, 13836185729010892807);
        set_user_free_bet_balance<T0>(v2, v3 - arg3);
        let v4 = total_allocated_for_coin<T0>(v0);
        assert!(v4 >= arg3, 13836748700439412747);
        set_total_allocated_for_coin<T0>(v0, v4 - arg3);
        let v5 = FreeBetRemovedEvent<T0>{
            actor  : arg1,
            player : arg2,
            amount : arg3,
        };
        0x2::event::emit<FreeBetRemovedEvent<T0>>(v5);
    }

    fun remove_version_internal(arg0: &mut FreeBetRegistry, arg1: u64) {
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &arg1), 13838718110449270809);
        0x2::vec_set::remove<u64>(&mut arg0.version_set, &arg1);
        let v0 = FreeBetRegistryVersionChangedEvent{
            version_number : arg1,
            is_added       : false,
        };
        0x2::event::emit<FreeBetRegistryVersionChangedEvent>(v0);
    }

    fun set_total_allocated_for_coin<T0>(arg0: &mut FreeBetRegistry, arg1: u64) {
        let v0 = coin_type_name<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.total_free_bet_per_coin, &v0)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.total_free_bet_per_coin, &v0) = arg1;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.total_free_bet_per_coin, v0, arg1);
        };
    }

    fun set_user_free_bet_balance<T0>(arg0: &mut UserFreeBetData, arg1: u64) {
        let v0 = coin_type_name<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.balances, &v0)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.balances, &v0) = arg1;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.balances, v0, arg1);
        };
    }

    fun total_allocated_for_coin<T0>(arg0: &FreeBetRegistry) : u64 {
        let v0 = coin_type_name<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.total_free_bet_per_coin, &v0)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.total_free_bet_per_coin, &v0)
        } else {
            0
        }
    }

    public fun total_allocated_free_bet<T0>(arg0: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) : u64 {
        total_allocated_for_coin<T0>(borrow_free_bet_registry(arg0))
    }

    public fun user_free_bet_balance<T0>(arg0: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: address) : u64 {
        let v0 = borrow_free_bet_registry(arg0);
        let v1 = UserFreeBetKey{pos0: arg1};
        if (!0x2::dynamic_object_field::exists_<UserFreeBetKey>(&v0.id, v1)) {
            0
        } else {
            user_free_bet_balance_internal<T0>(borrow_user_free_bet_data(v0, arg1))
        }
    }

    fun user_free_bet_balance_internal<T0>(arg0: &UserFreeBetData) : u64 {
        let v0 = coin_type_name<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.balances, &v0)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.balances, &v0)
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

