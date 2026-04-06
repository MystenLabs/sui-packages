module 0xa42d41a60ec61a7327e69181c79bff19141394600d0d61d519c9e48d7433e5ea::pvp_coinflip {
    struct PvpCoinflipParametersSetEvent<phantom T0> has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        house_edge_bps: u64,
        min_stake: u64,
        is_new: bool,
    }

    struct PvpCoinflipSettingsCreatedEvent has copy, drop {
        settings_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        creator: address,
    }

    struct PvpCoinflipRegistryVersionChangedEvent has copy, drop {
        version_number: u64,
        is_added: bool,
    }

    struct GameCreatedEvent<phantom T0> has copy, drop {
        game_id: 0x2::object::ID,
        creator: address,
        creator_is_tails: bool,
        is_private: bool,
        joiner_is_tails: bool,
        stake_per_player: u64,
        house_edge_bps: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct GameResolvedEvent<phantom T0> has copy, drop {
        game_id: 0x2::object::ID,
        creator: address,
        joiner: address,
        winner: address,
        creator_is_tails: bool,
        is_private: bool,
        joiner_is_tails: bool,
        stake_per_player: u64,
        total_pot: u64,
        house_edge_amount: u64,
        payout_amount: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct GameCancelledEvent<phantom T0> has copy, drop {
        game_id: 0x2::object::ID,
        creator: address,
        creator_is_tails: bool,
        is_private: bool,
        stake_per_player: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct PvpCoinflip has copy, drop, store {
        dummy_field: bool,
    }

    struct PvpCoinflipSettingsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PvpCoinflipSettings has store, key {
        id: 0x2::object::UID,
    }

    struct PvpCoinflipRegistryKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PvpCoinflipRegistry has store, key {
        id: 0x2::object::UID,
        version_set: 0x2::vec_set::VecSet<u64>,
    }

    struct Parameters<phantom T0> has store, key {
        id: 0x2::object::UID,
        house_edge_bps: u64,
        min_stake: u64,
    }

    struct Game<phantom T0> has store, key {
        id: 0x2::object::UID,
        creator: address,
        creator_is_tails: bool,
        is_private: bool,
        creator_metadata: 0x2::vec_map::VecMap<0x1::string::String, vector<u8>>,
        joiner: address,
        winner: address,
        stake_per_player: u64,
        house_edge_bps: u64,
        stake_pot: 0x2::balance::Balance<T0>,
    }

    public fun admin_add_version(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: u64) {
        let v0 = PvpCoinflip{dummy_field: false};
        let v1 = PvpCoinflipRegistryKey{dummy_field: false};
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::dof_exists_with_type<PvpCoinflip, PvpCoinflipRegistryKey, PvpCoinflipRegistry>(arg0, v0, v1), 13837592987931246613);
        let v2 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_borrow_operator_dof_mut<PvpCoinflip, PvpCoinflipRegistryKey, PvpCoinflipRegistry>(arg0, v0, v1);
        if (!0x2::vec_set::contains<u64>(&v2.version_set, &arg2)) {
            0x2::vec_set::insert<u64>(&mut v2.version_set, arg2);
            let v3 = PvpCoinflipRegistryVersionChangedEvent{
                version_number : arg2,
                is_added       : true,
            };
            0x2::event::emit<PvpCoinflipRegistryVersionChangedEvent>(v3);
        };
    }

    public fun admin_create_pvp_coinflip_settings(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        create_pvp_coinflip_settings(arg0, arg2);
    }

    public fun admin_remove_version(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: u64) {
        let v0 = PvpCoinflip{dummy_field: false};
        let v1 = PvpCoinflipRegistryKey{dummy_field: false};
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::dof_exists_with_type<PvpCoinflip, PvpCoinflipRegistryKey, PvpCoinflipRegistry>(arg0, v0, v1), 13837593146845036565);
        let v2 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_borrow_operator_dof_mut<PvpCoinflip, PvpCoinflipRegistryKey, PvpCoinflipRegistry>(arg0, v0, v1);
        remove_version_internal(v2, arg2);
    }

    public fun admin_set_parameters<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        set_parameters<T0>(arg0, arg2, arg3, arg4);
    }

    fun assert_valid_version(arg0: &PvpCoinflipRegistry) {
        let v0 = package_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &v0), 13838999413627682847);
    }

    public fun borrow_game<T0>(arg0: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: 0x2::object::ID) : &Game<T0> {
        let v0 = borrow_pvp_coinflip_registry(arg0);
        assert!(game_exists<T0>(v0, arg1), 13837873981871751191);
        0x2::dynamic_object_field::borrow<0x2::object::ID, Game<T0>>(&v0.id, arg1)
    }

    fun borrow_mut_parameters<T0>(arg0: &mut PvpCoinflipSettings) : &mut Parameters<T0> {
        assert!(parameters_exist<T0>(arg0), 13835622104747606023);
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, Parameters<T0>>(&mut arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun borrow_parameters<T0>(arg0: &PvpCoinflipSettings) : &Parameters<T0> {
        assert!(parameters_exist<T0>(arg0), 13835622078977802247);
        0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, Parameters<T0>>(&arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun borrow_pvp_coinflip_registry(arg0: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) : &PvpCoinflipRegistry {
        let v0 = PvpCoinflipRegistryKey{dummy_field: false};
        let v1 = PvpCoinflip{dummy_field: false};
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::dof_exists_with_type<PvpCoinflip, PvpCoinflipRegistryKey, PvpCoinflipRegistry>(arg0, v1, v0), 13837592274966675477);
        let v2 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::borrow_operator_dof<PvpCoinflip, PvpCoinflipRegistryKey, PvpCoinflipRegistry>(arg0, v0);
        assert_valid_version(v2);
        v2
    }

    fun borrow_pvp_coinflip_registry_mut(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) : &mut PvpCoinflipRegistry {
        let v0 = PvpCoinflip{dummy_field: false};
        let v1 = PvpCoinflipRegistryKey{dummy_field: false};
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::dof_exists_with_type<PvpCoinflip, PvpCoinflipRegistryKey, PvpCoinflipRegistry>(arg0, v0, v1), 13837592343686152213);
        let v2 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_borrow_operator_dof_mut<PvpCoinflip, PvpCoinflipRegistryKey, PvpCoinflipRegistry>(arg0, v0, v1);
        assert_valid_version(v2);
        v2
    }

    public fun borrow_pvp_coinflip_settings(arg0: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) : &PvpCoinflipSettings {
        borrow_pvp_coinflip_registry(arg0);
        let v0 = PvpCoinflipSettingsKey{dummy_field: false};
        let v1 = PvpCoinflip{dummy_field: false};
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::dof_exists_with_type<PvpCoinflip, PvpCoinflipSettingsKey, PvpCoinflipSettings>(arg0, v1, v0), 13835340294763315205);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::borrow_operator_dof<PvpCoinflip, PvpCoinflipSettingsKey, PvpCoinflipSettings>(arg0, v0)
    }

    fun borrow_pvp_coinflip_settings_mut(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) : &mut PvpCoinflipSettings {
        let v0 = PvpCoinflipRegistryKey{dummy_field: false};
        let v1 = PvpCoinflip{dummy_field: false};
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::dof_exists_with_type<PvpCoinflip, PvpCoinflipRegistryKey, PvpCoinflipRegistry>(arg0, v1, v0), 13837592159002558485);
        assert_valid_version(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::borrow_operator_dof<PvpCoinflip, PvpCoinflipRegistryKey, PvpCoinflipRegistry>(arg0, v0));
        let v2 = PvpCoinflip{dummy_field: false};
        let v3 = PvpCoinflipSettingsKey{dummy_field: false};
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::dof_exists_with_type<PvpCoinflip, PvpCoinflipSettingsKey, PvpCoinflipSettings>(arg0, v2, v3), 13835340415022399493);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_borrow_operator_dof_mut<PvpCoinflip, PvpCoinflipSettingsKey, PvpCoinflipSettings>(arg0, v2, v3)
    }

    entry fun cancel_game<T0>(arg0: 0x2::object::ID, arg1: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = cancel_game_internal<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    fun cancel_game_internal<T0>(arg0: 0x2::object::ID, arg1: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = borrow_pvp_coinflip_registry_mut(arg1);
        assert!(game_exists<T0>(v0, arg0), 13837876052045987863);
        let v1 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Game<T0>>(&v0.id, arg0);
        assert!(v1.creator == 0x2::tx_context::sender(arg2), 13838157535612764185);
        assert!(v1.joiner == @0x0, 13836750165023522831);
        let Game {
            id               : v2,
            creator          : v3,
            creator_is_tails : v4,
            is_private       : v5,
            creator_metadata : _,
            joiner           : v7,
            winner           : _,
            stake_per_player : v9,
            house_edge_bps   : _,
            stake_pot        : v11,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Game<T0>>(&mut borrow_pvp_coinflip_registry_mut(arg1).id, arg0);
        let v12 = v11;
        assert!(v7 == @0x0, 13836750250922868751);
        0x2::balance::destroy_zero<T0>(v12);
        0x2::object::delete(v2);
        let v13 = GameCancelledEvent<T0>{
            game_id          : arg0,
            creator          : v3,
            creator_is_tails : v4,
            is_private       : v5,
            stake_per_player : v9,
            coin_type        : 0x1::type_name::with_defining_ids<T0>(),
        };
        0x2::event::emit<GameCancelledEvent<T0>>(v13);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut v12), arg2)
    }

    fun compute_house_edge_amount(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    fun create_and_process_player_stake_ticket<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: address, arg2: bool, arg3: bool, arg4: u64, arg5: 0x2::balance::Balance<T0>, arg6: 0x2::vec_map::VecMap<0x1::string::String, vector<u8>>, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x2::clock::Clock, arg9: &0x2::random::Random, arg10: &mut 0x2::tx_context::TxContext) : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::StakeTicket<T0, PvpCoinflip> {
        let v0 = PvpCoinflip{dummy_field: false};
        let v1 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_put_private_pool_and_get_stake_ticket_with_stake_amount<T0, PvpCoinflip>(arg0, v0, 0x2::coin::from_balance<T0>(arg5, arg10), arg4, 1, arg1, arg10);
        0xd2ccfa506d533b8640918f958e1f9471338e47febab14bfb7ab8a5936620a74f::loyalty::process_stake_ticket<T0, PvpCoinflip>(&mut v1, arg0, merge_player_side_metadata(arg6, arg2, arg3), arg7, arg8, arg9, arg10);
        v1
    }

    public fun create_game<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: 0x2::coin::Coin<T0>, arg2: bool, arg3: bool, arg4: vector<0x1::string::String>, arg5: vector<vector<u8>>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = borrow_parameters<T0>(borrow_pvp_coinflip_settings(arg0));
        let v1 = v0.house_edge_bps;
        assert!(v1 >= 100 && v1 <= 2000, 13835904786610257929);
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_stake_config_exists<T0, PvpCoinflip>(arg0), 13838719544968609821);
        let v2 = 0x2::coin::value<T0>(&arg1);
        assert!(v2 >= v0.min_stake, 13836467758038777869);
        assert!(v2 <= 9223372036854775807, 13838438087171637275);
        let v3 = Game<T0>{
            id               : 0x2::object::new(arg6),
            creator          : 0x2::tx_context::sender(arg6),
            creator_is_tails : arg2,
            is_private       : arg3,
            creator_metadata : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::utils::build_metadata<0x1::string::String, vector<u8>>(arg4, arg5),
            joiner           : @0x0,
            winner           : @0x0,
            stake_per_player : v2,
            house_edge_bps   : v1,
            stake_pot        : 0x2::coin::into_balance<T0>(arg1),
        };
        let v4 = 0x2::object::id<Game<T0>>(&v3);
        0x2::dynamic_object_field::add<0x2::object::ID, Game<T0>>(&mut borrow_pvp_coinflip_registry_mut(arg0).id, v4, v3);
        let v5 = GameCreatedEvent<T0>{
            game_id          : v4,
            creator          : 0x2::tx_context::sender(arg6),
            creator_is_tails : arg2,
            is_private       : arg3,
            joiner_is_tails  : !arg2,
            stake_per_player : v2,
            house_edge_bps   : v1,
            coin_type        : 0x1::type_name::with_defining_ids<T0>(),
        };
        0x2::event::emit<GameCreatedEvent<T0>>(v5);
        v4
    }

    fun create_pvp_coinflip_settings(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PvpCoinflip{dummy_field: false};
        let v1 = PvpCoinflipSettings{id: 0x2::object::new(arg1)};
        let v2 = PvpCoinflipRegistry{
            id          : 0x2::object::new(arg1),
            version_set : 0x2::vec_set::singleton<u64>(package_version()),
        };
        let v3 = PvpCoinflipSettingsKey{dummy_field: false};
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_add_operator_dof<PvpCoinflip, PvpCoinflipSettingsKey, PvpCoinflipSettings>(arg0, v0, v3, v1);
        let v4 = PvpCoinflipRegistryKey{dummy_field: false};
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_add_operator_dof<PvpCoinflip, PvpCoinflipRegistryKey, PvpCoinflipRegistry>(arg0, v0, v4, v2);
        let v5 = PvpCoinflipSettingsCreatedEvent{
            settings_id : 0x2::object::id<PvpCoinflipSettings>(&v1),
            registry_id : 0x2::object::id<PvpCoinflipRegistry>(&v2),
            creator     : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<PvpCoinflipSettingsCreatedEvent>(v5);
    }

    public fun creator<T0>(arg0: &Game<T0>) : address {
        arg0.creator
    }

    public fun creator_is_tails<T0>(arg0: &Game<T0>) : bool {
        arg0.creator_is_tails
    }

    fun game_exists<T0>(arg0: &PvpCoinflipRegistry, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Game<T0>>(&arg0.id, arg1)
    }

    public fun game_exists_in_registry<T0>(arg0: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: 0x2::object::ID) : bool {
        game_exists<T0>(borrow_pvp_coinflip_registry(arg0), arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun is_private<T0>(arg0: &Game<T0>) : bool {
        arg0.is_private
    }

    entry fun join_game<T0>(arg0: 0x2::object::ID, arg1: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg2: 0x2::coin::Coin<T0>, arg3: vector<0x1::string::String>, arg4: vector<vector<u8>>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x2::clock::Clock, arg7: &0x2::random::Random, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_pvp_coinflip_registry_mut(arg1);
        assert!(game_exists<T0>(v0, arg0), 13837875880247296023);
        let (v1, v2, _, _, v5) = join_game_internal<T0>(0x2::dynamic_object_field::remove<0x2::object::ID, Game<T0>>(&mut v0.id, arg0), arg1, arg2, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::utils::build_metadata<0x1::string::String, vector<u8>>(arg3, arg4), arg5, arg6, arg7, arg8);
        let Game {
            id               : v6,
            creator          : _,
            creator_is_tails : _,
            is_private       : _,
            creator_metadata : _,
            joiner           : _,
            winner           : _,
            stake_per_player : _,
            house_edge_bps   : _,
            stake_pot        : v15,
        } = v1;
        0x2::balance::destroy_zero<T0>(v15);
        0x2::object::delete(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, v2);
    }

    fun join_game_internal<T0>(arg0: Game<T0>, arg1: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::vec_map::VecMap<0x1::string::String, vector<u8>>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) : (Game<T0>, address, u64, u64, 0x2::coin::Coin<T0>) {
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_stake_config_exists<T0, PvpCoinflip>(arg1), 13838719755422007325);
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(v0 != arg0.creator, 13837030918445858833);
        assert!(arg0.joiner == @0x0, 13836749447763984399);
        assert!(0x2::coin::value<T0>(&arg2) == arg0.stake_per_player, 13837312410602569747);
        assert!(arg0.stake_per_player <= 9223372036854775807, 13838438314804903963);
        let v1 = arg0.stake_per_player * 2;
        let v2 = compute_house_edge_amount(v1, arg0.house_edge_bps);
        let v3 = v1 - v2;
        let v4 = !arg0.creator_is_tails;
        let v5 = create_and_process_player_stake_ticket<T0>(arg1, arg0.creator, arg0.creator_is_tails, v4, arg0.stake_per_player, 0x2::balance::withdraw_all<T0>(&mut arg0.stake_pot), arg0.creator_metadata, arg4, arg5, arg6, arg7);
        let v6 = create_and_process_player_stake_ticket<T0>(arg1, v0, v4, arg0.creator_is_tails, arg0.stake_per_player, 0x2::coin::into_balance<T0>(arg2), arg3, arg4, arg5, arg6, arg7);
        let v7 = 0x2::random::new_generator(arg6, arg7);
        let v8 = if (0x2::random::generate_u64_in_range(&mut v7, 0, 1) == 0) {
            arg0.creator
        } else {
            v0
        };
        let v9 = 0x1::string::utf8(b"pvp_result");
        if (v8 == arg0.creator) {
            0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::add_outcome_amount<T0, PvpCoinflip>(&mut v5, v3);
            0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::add_outcome_amount<T0, PvpCoinflip>(&mut v6, 0);
            let v10 = 0x2::vec_map::empty<0x1::string::String, vector<u8>>();
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v10, v9, b"win");
            0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::add_game_details<T0, PvpCoinflip>(&mut v5, v10);
            let v11 = 0x2::vec_map::empty<0x1::string::String, vector<u8>>();
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v11, v9, b"loss");
            0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::add_game_details<T0, PvpCoinflip>(&mut v6, v11);
        } else {
            0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::add_outcome_amount<T0, PvpCoinflip>(&mut v5, 0);
            0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::add_outcome_amount<T0, PvpCoinflip>(&mut v6, v3);
            let v12 = 0x2::vec_map::empty<0x1::string::String, vector<u8>>();
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v12, v9, b"loss");
            0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::add_game_details<T0, PvpCoinflip>(&mut v5, v12);
            let v13 = 0x2::vec_map::empty<0x1::string::String, vector<u8>>();
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v13, v9, b"win");
            0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::add_game_details<T0, PvpCoinflip>(&mut v6, v13);
        };
        let v14 = PvpCoinflip{dummy_field: false};
        let v15 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_take_and_destroy_stake_ticket<T0, PvpCoinflip>(arg1, v14, v5, arg6, arg7);
        0x2::coin::join<T0>(&mut v15, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_take_and_destroy_stake_ticket<T0, PvpCoinflip>(arg1, v14, v6, arg6, arg7));
        arg0.joiner = v0;
        arg0.winner = v8;
        let v16 = GameResolvedEvent<T0>{
            game_id           : 0x2::object::uid_to_inner(&arg0.id),
            creator           : arg0.creator,
            joiner            : v0,
            winner            : v8,
            creator_is_tails  : arg0.creator_is_tails,
            is_private        : arg0.is_private,
            joiner_is_tails   : v4,
            stake_per_player  : arg0.stake_per_player,
            total_pot         : v1,
            house_edge_amount : v2,
            payout_amount     : v3,
            coin_type         : 0x1::type_name::with_defining_ids<T0>(),
        };
        0x2::event::emit<GameResolvedEvent<T0>>(v16);
        (arg0, v8, v2, v3, v15)
    }

    public fun joiner<T0>(arg0: &Game<T0>) : address {
        arg0.joiner
    }

    public fun joiner_is_tails<T0>(arg0: &Game<T0>) : bool {
        !arg0.creator_is_tails
    }

    public fun manager_create_pvp_coinflip_settings(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<PvpCoinflip>(arg1, 0x2::tx_context::sender(arg2));
        create_pvp_coinflip_settings(arg0, arg2);
    }

    public fun manager_remove_version(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<PvpCoinflip>(arg1, 0x2::tx_context::sender(arg3));
        let v0 = PvpCoinflip{dummy_field: false};
        let v1 = PvpCoinflipRegistryKey{dummy_field: false};
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::dof_exists_with_type<PvpCoinflip, PvpCoinflipRegistryKey, PvpCoinflipRegistry>(arg0, v0, v1), 13837593237039349781);
        let v2 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_borrow_operator_dof_mut<PvpCoinflip, PvpCoinflipRegistryKey, PvpCoinflipRegistry>(arg0, v0, v1);
        remove_version_internal(v2, arg2);
    }

    public fun manager_set_parameters<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<PvpCoinflip>(arg1, 0x2::tx_context::sender(arg4));
        set_parameters<T0>(arg0, arg2, arg3, arg4);
    }

    fun merge_player_side_metadata(arg0: 0x2::vec_map::VecMap<0x1::string::String, vector<u8>>, arg1: bool, arg2: bool) : 0x2::vec_map::VecMap<0x1::string::String, vector<u8>> {
        let v0 = 0x1::string::utf8(b"coin_side");
        if (0x2::vec_map::contains<0x1::string::String, vector<u8>>(&arg0, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, vector<u8>>(&mut arg0, &v0);
        };
        let v3 = if (arg1) {
            b"tails"
        } else {
            b"heads"
        };
        0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut arg0, v0, v3);
        let v4 = 0x1::string::utf8(b"opponent_coin_side");
        if (0x2::vec_map::contains<0x1::string::String, vector<u8>>(&arg0, &v4)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, vector<u8>>(&mut arg0, &v4);
        };
        let v7 = if (arg2) {
            b"tails"
        } else {
            b"heads"
        };
        0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut arg0, v4, v7);
        arg0
    }

    fun package_version() : u64 {
        0
    }

    fun parameters_exist<T0>(arg0: &PvpCoinflipSettings) : bool {
        0x2::dynamic_object_field::exists_with_type<0x1::type_name::TypeName, Parameters<T0>>(&arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun parameters_house_edge_bps<T0>(arg0: &Parameters<T0>) : u64 {
        arg0.house_edge_bps
    }

    public fun parameters_min_stake<T0>(arg0: &Parameters<T0>) : u64 {
        arg0.min_stake
    }

    fun remove_version_internal(arg0: &mut PvpCoinflipRegistry, arg1: u64) {
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &arg1), 13839281923691642913);
        0x2::vec_set::remove<u64>(&mut arg0.version_set, &arg1);
        let v0 = PvpCoinflipRegistryVersionChangedEvent{
            version_number : arg1,
            is_added       : false,
        };
        0x2::event::emit<PvpCoinflipRegistryVersionChangedEvent>(v0);
    }

    fun set_parameters<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 100 && arg1 <= 2000, 13835903871782223881);
        let v0 = borrow_pvp_coinflip_settings_mut(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = parameters_exist<T0>(v0);
        if (v2) {
            let v3 = borrow_mut_parameters<T0>(v0);
            v3.house_edge_bps = arg1;
            v3.min_stake = arg2;
        } else {
            let v4 = Parameters<T0>{
                id             : 0x2::object::new(arg3),
                house_edge_bps : arg1,
                min_stake      : arg2,
            };
            0x2::dynamic_object_field::add<0x1::type_name::TypeName, Parameters<T0>>(&mut v0.id, v1, v4);
        };
        let v5 = PvpCoinflipParametersSetEvent<T0>{
            coin_type      : v1,
            house_edge_bps : arg1,
            min_stake      : arg2,
            is_new         : !v2,
        };
        0x2::event::emit<PvpCoinflipParametersSetEvent<T0>>(v5);
    }

    public fun stake_per_player<T0>(arg0: &Game<T0>) : u64 {
        arg0.stake_per_player
    }

    public fun winner<T0>(arg0: &Game<T0>) : address {
        arg0.winner
    }

    // decompiled from Move bytecode v6
}

