module 0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::iturf {
    struct MapCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GameOperatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct OperatorCapsBag has key {
        id: 0x2::object::UID,
        caps: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct RaidInfo has store {
        current_raid_count: u64,
        max_raid_count: u64,
        attack_reset_in: u64,
    }

    struct MapRegistry has key {
        id: 0x2::object::UID,
        config: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    struct OperatorCapIssuedEvent has copy, drop {
        cap_id: 0x2::object::ID,
        to: address,
        timestamp: u64,
    }

    struct OperatorCapRevokedEvent has copy, drop {
        cap_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct TurfInformation has key {
        id: 0x2::object::UID,
        x: u64,
        x_neg: bool,
        y: u64,
        y_neg: bool,
        owner_id: 0x2::object::ID,
        garrison: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        garrison_limit: u64,
        garrison_count: u64,
        land_perks: vector<0x2::object::ID>,
        cooldown: u64,
    }

    struct MapConfig has key {
        id: 0x2::object::UID,
        max_density: u128,
        density: u128,
        max_radius: u64,
        expansion_rate: u64,
        min_radius: u64,
        current_max_radius: u64,
        turf_count: u64,
    }

    struct TurfSystem has store, key {
        id: 0x2::object::UID,
        coordinates_turfs: 0x2::table::Table<Coordinates, 0x2::object::ID>,
        turf_cooldown: u64,
    }

    struct FreeTurfDefenderRegistry has key {
        id: 0x2::object::UID,
        recovery_duration_ms: u64,
        defender_states: 0x2::table::Table<Coordinates, FreeTurfDefenderState>,
    }

    struct FreeTurfDefenderState has drop, store {
        defender_gangsters: vector<0x1::string::String>,
        created_timestamp: u64,
    }

    struct Coordinates has copy, drop, store {
        x: u64,
        x_neg: bool,
        y: u64,
        y_neg: bool,
    }

    struct HeadquarterAssignmentEvent has copy, drop {
        player_id: 0x2::object::ID,
        dvd_id: 0x2::object::ID,
        player_name: 0x1::string::String,
        headquarter: 0x2::object::ID,
    }

    struct ReAssignHeadquarterEvent has copy, drop {
        player_id: 0x2::object::ID,
        dvd_id: 0x2::object::ID,
        player_name: 0x1::string::String,
        headquarter: 0x2::object::ID,
    }

    struct MoveGangsterEvent has copy, drop {
        player_id: 0x2::object::ID,
        dvd_id: 0x2::object::ID,
        player_name: 0x1::string::String,
        gangster_name: 0x1::string::String,
        gangster_count: u64,
        from_turf: 0x2::object::ID,
        to_turf: 0x2::object::ID,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : TurfInformation {
        TurfInformation{
            id             : 0x2::object::new(arg7),
            x              : arg3,
            x_neg          : arg4,
            y              : arg5,
            y_neg          : arg6,
            owner_id       : arg0,
            garrison       : 0x2::vec_map::empty<0x1::string::String, u64>(),
            garrison_limit : arg1,
            garrison_count : arg2,
            land_perks     : 0x1::vector::empty<0x2::object::ID>(),
            cooldown       : 0,
        }
    }

    public fun add_alive_units(arg0: &MapCap, arg1: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::Version, arg2: &mut TurfInformation, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>) {
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::validate_version(arg1);
        let v0 = 0x1::vector::length<0x1::string::String>(&arg4);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = 0x1::vector::borrow<0x1::string::String>(&arg4, v0);
            add_units(arg2, *v1, count_occurrences<0x1::string::String>(&arg3, v1));
        };
    }

    public fun add_coordinate_in_system(arg0: &MapCap, arg1: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::Version, arg2: &mut TurfSystem, arg3: Coordinates, arg4: 0x2::object::ID) {
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::validate_version(arg1);
        0x2::table::add<Coordinates, 0x2::object::ID>(&mut arg2.coordinates_turfs, arg3, arg4);
    }

    public fun add_gangster_in_turf(arg0: &MapCap, arg1: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::Version, arg2: &mut TurfInformation, arg3: 0x1::string::String, arg4: u64) {
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::validate_version(arg1);
        let v0 = 0x2::vec_map::get_mut<0x1::string::String, u64>(&mut arg2.garrison, &arg3);
        *v0 = *v0 + arg4;
    }

    public(friend) fun add_new_free_turf_defender_state(arg0: &mut FreeTurfDefenderRegistry, arg1: Coordinates, arg2: vector<0x1::string::String>, arg3: &0x2::clock::Clock) {
        let v0 = FreeTurfDefenderState{
            defender_gangsters : arg2,
            created_timestamp  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::table::add<Coordinates, FreeTurfDefenderState>(&mut arg0.defender_states, arg1, v0);
    }

    public(friend) fun add_new_gangster_in_turf(arg0: &mut TurfInformation, arg1: 0x1::string::String, arg2: u64) {
        0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.garrison, arg1, arg2);
    }

    public fun add_turf_count(arg0: &MapCap, arg1: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::Version, arg2: &mut MapConfig, arg3: u64) {
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::validate_version(arg1);
        arg2.turf_count = arg2.turf_count + arg3;
    }

    public(friend) fun add_units(arg0: &mut TurfInformation, arg1: 0x1::string::String, arg2: u64) {
        if (0x2::vec_map::contains<0x1::string::String, u64>(&arg0.garrison, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<0x1::string::String, u64>(&mut arg0.garrison, &arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.garrison, arg1, arg2);
        };
    }

    public(friend) fun borrow_created_timestamp(arg0: &FreeTurfDefenderState) : u64 {
        arg0.created_timestamp
    }

    public(friend) fun borrow_defender_gangsters(arg0: &FreeTurfDefenderState) : &vector<0x1::string::String> {
        &arg0.defender_gangsters
    }

    public(friend) fun borrow_density(arg0: &MapConfig) : u128 {
        arg0.density
    }

    public fun borrow_garrison_count(arg0: &TurfInformation) : u64 {
        arg0.garrison_count
    }

    public fun borrow_key_value(arg0: &MapRegistry, arg1: 0x1::string::String) : u64 {
        *0x2::vec_map::get<0x1::string::String, u64>(&arg0.config, &arg1)
    }

    public(friend) fun borrow_map_config_info(arg0: &MapConfig) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, arg0.max_radius);
        0x1::vector::push_back<u64>(v1, arg0.turf_count);
        0x1::vector::push_back<u64>(v1, arg0.current_max_radius);
        0x1::vector::push_back<u64>(v1, arg0.min_radius);
        0x1::vector::push_back<u64>(v1, arg0.expansion_rate);
        v0
    }

    public(friend) fun borrow_max_density(arg0: &MapConfig) : u128 {
        arg0.max_density
    }

    public(friend) fun borrow_mut_defender_states(arg0: &mut FreeTurfDefenderRegistry, arg1: Coordinates) : &mut FreeTurfDefenderState {
        0x2::table::borrow_mut<Coordinates, FreeTurfDefenderState>(&mut arg0.defender_states, arg1)
    }

    public(friend) fun borrow_recovery_duration_ms(arg0: &FreeTurfDefenderRegistry) : u64 {
        arg0.recovery_duration_ms
    }

    public fun borrow_turf_cooldown(arg0: &TurfSystem) : u64 {
        arg0.turf_cooldown
    }

    public fun borrow_turf_cooldown_ms(arg0: &TurfInformation) : u64 {
        arg0.cooldown
    }

    public fun borrow_turf_id(arg0: &TurfSystem, arg1: u64, arg2: bool, arg3: u64, arg4: bool) : 0x2::object::ID {
        let v0 = Coordinates{
            x     : arg1,
            x_neg : arg2,
            y     : arg3,
            y_neg : arg4,
        };
        *0x2::table::borrow<Coordinates, 0x2::object::ID>(&arg0.coordinates_turfs, v0)
    }

    public(friend) fun borrow_turf_id_from_coordinate(arg0: &TurfSystem, arg1: Coordinates) : 0x2::object::ID {
        *0x2::table::borrow<Coordinates, 0x2::object::ID>(&arg0.coordinates_turfs, arg1)
    }

    public fun borrow_turf_information(arg0: &TurfInformation) : (u64, u64, u64, bool, u64, bool, 0x2::object::ID, u64) {
        (arg0.garrison_limit, arg0.garrison_count, arg0.x, arg0.x_neg, arg0.y, arg0.y_neg, arg0.owner_id, arg0.cooldown)
    }

    public fun borrow_unit_value(arg0: &TurfInformation, arg1: &0x1::string::String) : u64 {
        if (0x2::vec_map::contains<0x1::string::String, u64>(&arg0.garrison, arg1)) {
            *0x2::vec_map::get<0x1::string::String, u64>(&arg0.garrison, arg1)
        } else {
            0
        }
    }

    public fun count_occurrences<T0: copy + drop + store>(arg0: &vector<T0>, arg1: &T0) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<T0>(arg0)) {
            if (*0x1::vector::borrow<T0>(arg0, v1) == *arg1) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun decrease_turf_garrison_count(arg0: &MapCap, arg1: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::Version, arg2: &mut TurfInformation, arg3: u64) {
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::validate_version(arg1);
        assert!(arg2.garrison_count >= arg3, 0);
        arg2.garrison_count = arg2.garrison_count - arg3;
    }

    public(friend) fun does_coordinate_exists(arg0: Coordinates, arg1: &TurfSystem) : bool {
        0x2::table::contains<Coordinates, 0x2::object::ID>(&arg1.coordinates_turfs, arg0)
    }

    public fun emit_headquarter_assigned_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x2::object::ID) {
        let v0 = HeadquarterAssignmentEvent{
            player_id   : arg0,
            dvd_id      : arg1,
            player_name : arg2,
            headquarter : arg3,
        };
        0x2::event::emit<HeadquarterAssignmentEvent>(v0);
    }

    public fun emit_move_gangster_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: 0x2::object::ID, arg6: 0x2::object::ID) {
        let v0 = MoveGangsterEvent{
            player_id      : arg0,
            dvd_id         : arg1,
            player_name    : arg2,
            gangster_name  : arg3,
            gangster_count : arg4,
            from_turf      : arg5,
            to_turf        : arg6,
        };
        0x2::event::emit<MoveGangsterEvent>(v0);
    }

    public fun emit_re_assign_headquarter_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x2::object::ID) {
        let v0 = ReAssignHeadquarterEvent{
            player_id   : arg0,
            dvd_id      : arg1,
            player_name : arg2,
            headquarter : arg3,
        };
        0x2::event::emit<ReAssignHeadquarterEvent>(v0);
    }

    public fun gangster_type_exists(arg0: &TurfInformation, arg1: 0x1::string::String) : bool {
        0x2::vec_map::contains<0x1::string::String, u64>(&arg0.garrison, &arg1)
    }

    public fun has_alive_gangsters(arg0: &TurfInformation, arg1: vector<0x1::string::String>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg1)) {
            let v1 = 0x1::vector::borrow<0x1::string::String>(&arg1, v0);
            if (0x2::vec_map::contains<0x1::string::String, u64>(&arg0.garrison, v1)) {
                if (*0x2::vec_map::get<0x1::string::String, u64>(&arg0.garrison, v1) > 0) {
                    return true
                };
            };
            v0 = v0 + 1;
        };
        false
    }

    public(friend) fun has_coordinate(arg0: &FreeTurfDefenderRegistry, arg1: Coordinates) : bool {
        0x2::table::contains<Coordinates, FreeTurfDefenderState>(&arg0.defender_states, arg1)
    }

    public(friend) fun has_gangster_in_tuf(arg0: &TurfInformation, arg1: 0x1::string::String) : bool {
        0x2::vec_map::contains<0x1::string::String, u64>(&arg0.garrison, &arg1) && *0x2::vec_map::get<0x1::string::String, u64>(&arg0.garrison, &arg1) >= 1
    }

    entry fun heal_turf(arg0: &mut TurfInformation, arg1: &OperatorCapsBag, arg2: &GameOperatorCap, arg3: u64, arg4: u64, arg5: u64) {
        is_operator(arg2, arg1);
        if (gangster_type_exists(arg0, 0x1::string::utf8(b"henchman"))) {
            let v0 = 0x1::string::utf8(b"henchman");
            *0x2::vec_map::get_mut<0x1::string::String, u64>(&mut arg0.garrison, &v0) = arg3;
        };
        if (gangster_type_exists(arg0, 0x1::string::utf8(b"enforcer"))) {
            let v1 = 0x1::string::utf8(b"enforcer");
            *0x2::vec_map::get_mut<0x1::string::String, u64>(&mut arg0.garrison, &v1) = arg4;
        };
        if (gangster_type_exists(arg0, 0x1::string::utf8(b"bouncer"))) {
            let v2 = 0x1::string::utf8(b"bouncer");
            *0x2::vec_map::get_mut<0x1::string::String, u64>(&mut arg0.garrison, &v2) = arg5;
        };
    }

    public(friend) fun increase_max_radius_with_expansion_rate(arg0: &mut MapConfig) {
        arg0.max_radius = arg0.max_radius + arg0.expansion_rate;
    }

    public fun increase_turf_cooldown(arg0: &MapCap, arg1: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::Version, arg2: &mut TurfInformation, arg3: &TurfSystem, arg4: &0x2::clock::Clock) {
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::validate_version(arg1);
        arg2.cooldown = 0x2::clock::timestamp_ms(arg4) + arg3.turf_cooldown;
    }

    public fun increase_turf_garrison_count(arg0: &MapCap, arg1: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::Version, arg2: &mut TurfInformation, arg3: u64) {
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::validate_version(arg1);
        arg2.garrison_count = arg2.garrison_count + arg3;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TurfSystem{
            id                : 0x2::object::new(arg0),
            coordinates_turfs : 0x2::table::new<Coordinates, 0x2::object::ID>(arg0),
            turf_cooldown     : 0,
        };
        let v1 = MapConfig{
            id                 : 0x2::object::new(arg0),
            max_density        : 0,
            density            : 0,
            max_radius         : 0,
            expansion_rate     : 0,
            min_radius         : 0,
            current_max_radius : 0,
            turf_count         : 0,
        };
        0x2::transfer::share_object<TurfSystem>(v0);
        0x2::transfer::share_object<MapConfig>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
        let v3 = MapCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<MapCap>(v3, 0x2::tx_context::sender(arg0));
    }

    entry fun init_defender_registry(arg0: &GameOperatorCap, arg1: &OperatorCapsBag, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        is_operator(arg0, arg1);
        let v0 = FreeTurfDefenderRegistry{
            id                   : 0x2::object::new(arg3),
            recovery_duration_ms : arg2,
            defender_states      : 0x2::table::new<Coordinates, FreeTurfDefenderState>(arg3),
        };
        0x2::transfer::share_object<FreeTurfDefenderRegistry>(v0);
    }

    entry fun initialize_cap_bag(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCapsBag{
            id   : 0x2::object::new(arg1),
            caps : 0x2::table::new<0x2::object::ID, bool>(arg1),
        };
        0x2::transfer::share_object<OperatorCapsBag>(v0);
    }

    entry fun initialize_map_admin_config(arg0: &GameOperatorCap, arg1: &OperatorCapsBag, arg2: &mut 0x2::tx_context::TxContext) {
        is_operator(arg0, arg1);
        let v0 = MapRegistry{
            id     : 0x2::object::new(arg2),
            config : 0x2::vec_map::empty<0x1::string::String, u64>(),
        };
        0x2::transfer::share_object<MapRegistry>(v0);
    }

    public fun initialize_raid_info(arg0: &MapCap, arg1: &MapRegistry, arg2: &0x2::clock::Clock) : RaidInfo {
        RaidInfo{
            current_raid_count : 1,
            max_raid_count     : borrow_key_value(arg1, 0x1::string::utf8(b"max_raid_count")),
            attack_reset_in    : 0x2::clock::timestamp_ms(arg2) + borrow_key_value(arg1, 0x1::string::utf8(b"raid_reset_duration")),
        }
    }

    public(friend) fun is_operator(arg0: &GameOperatorCap, arg1: &OperatorCapsBag) {
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg1.caps, 0x2::object::id<GameOperatorCap>(arg0)), 0);
        assert!(*0x2::table::borrow<0x2::object::ID, bool>(&arg1.caps, 0x2::object::id<GameOperatorCap>(arg0)), 1);
    }

    entry fun issue_operator_cap(arg0: &AdminCap, arg1: &mut OperatorCapsBag, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = GameOperatorCap{id: 0x2::object::new(arg4)};
        let v1 = 0x2::object::id<GameOperatorCap>(&v0);
        0x2::transfer::public_transfer<GameOperatorCap>(v0, arg2);
        0x2::table::add<0x2::object::ID, bool>(&mut arg1.caps, v1, true);
        let v2 = OperatorCapIssuedEvent{
            cap_id    : v1,
            to        : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<OperatorCapIssuedEvent>(v2);
    }

    public fun new_coordinates(arg0: u64, arg1: bool, arg2: u64, arg3: bool) : Coordinates {
        Coordinates{
            x     : arg0,
            x_neg : arg1,
            y     : arg2,
            y_neg : arg3,
        }
    }

    public fun new_turf_from_coordinate(arg0: &MapCap, arg1: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::Version, arg2: 0x2::object::ID, arg3: u64, arg4: bool, arg5: u64, arg6: bool, arg7: vector<0x1::string::String>, arg8: vector<0x1::string::String>, arg9: &mut 0x2::tx_context::TxContext) : TurfInformation {
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::validate_version(arg1);
        let v0 = TurfInformation{
            id             : 0x2::object::new(arg9),
            x              : arg3,
            x_neg          : arg4,
            y              : arg5,
            y_neg          : arg6,
            owner_id       : arg2,
            garrison       : 0x2::vec_map::empty<0x1::string::String, u64>(),
            garrison_limit : 10,
            garrison_count : 0,
            land_perks     : 0x1::vector::empty<0x2::object::ID>(),
            cooldown       : 0,
        };
        let v1 = &mut v0;
        add_alive_units(arg0, arg1, v1, arg8, arg7);
        v0
    }

    public(friend) fun raid_reset_perk(arg0: &mut RaidInfo, arg1: &MapRegistry, arg2: &0x2::clock::Clock) {
        arg0.current_raid_count = 0;
        arg0.attack_reset_in = 0x2::clock::timestamp_ms(arg2) + borrow_key_value(arg1, 0x1::string::utf8(b"raid_reset_duration"));
    }

    public fun remove_coordinate(arg0: &MapCap, arg1: &mut FreeTurfDefenderRegistry, arg2: u64, arg3: bool, arg4: u64, arg5: bool) {
        let v0 = new_coordinates(arg2, arg3, arg4, arg5);
        if (0x2::table::contains<Coordinates, FreeTurfDefenderState>(&arg1.defender_states, v0)) {
            0x2::table::remove<Coordinates, FreeTurfDefenderState>(&mut arg1.defender_states, v0);
        };
    }

    public fun remove_gangster_from_turf(arg0: &MapCap, arg1: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::Version, arg2: &mut TurfInformation, arg3: 0x1::string::String, arg4: u64) {
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::validate_version(arg1);
        if (0x2::vec_map::contains<0x1::string::String, u64>(&arg2.garrison, &arg3)) {
            let v0 = 0x2::vec_map::get_mut<0x1::string::String, u64>(&mut arg2.garrison, &arg3);
            *v0 = *v0 - arg4;
        };
    }

    public(friend) fun reset_garrison(arg0: &mut TurfInformation) {
        arg0.garrison_count = 0;
        arg0.garrison = 0x2::vec_map::empty<0x1::string::String, u64>();
    }

    entry fun revoke_operator_cap(arg0: &AdminCap, arg1: &mut OperatorCapsBag, arg2: &0x2::clock::Clock, arg3: 0x2::object::ID) {
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg1.caps, arg3), 2);
        *0x2::table::borrow_mut<0x2::object::ID, bool>(&mut arg1.caps, arg3) = false;
        let v0 = OperatorCapRevokedEvent{
            cap_id    : arg3,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<OperatorCapRevokedEvent>(v0);
    }

    public(friend) fun set_current_max_radius(arg0: &mut MapConfig, arg1: u64) {
        arg0.current_max_radius = arg1;
    }

    public(friend) fun set_current_raid_count(arg0: &mut RaidInfo, arg1: u64) {
        arg0.current_raid_count = arg1;
    }

    entry fun set_defender_registry_recovery_duration_ms(arg0: &GameOperatorCap, arg1: &OperatorCapsBag, arg2: &mut FreeTurfDefenderRegistry, arg3: u64) {
        is_operator(arg0, arg1);
        arg2.recovery_duration_ms = arg3;
    }

    public(friend) fun set_density(arg0: &mut MapConfig, arg1: u128) {
        arg0.density = arg1;
    }

    entry fun set_map_admin_config(arg0: &GameOperatorCap, arg1: &OperatorCapsBag, arg2: &mut MapRegistry, arg3: 0x1::string::String, arg4: u64) {
        is_operator(arg0, arg1);
        if (0x2::vec_map::contains<0x1::string::String, u64>(&arg2.config, &arg3)) {
            *0x2::vec_map::get_mut<0x1::string::String, u64>(&mut arg2.config, &arg3) = arg4;
        } else {
            0x2::vec_map::insert<0x1::string::String, u64>(&mut arg2.config, arg3, arg4);
        };
    }

    entry fun set_map_config(arg0: &GameOperatorCap, arg1: &OperatorCapsBag, arg2: &mut MapConfig, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u128, arg8: u128, arg9: u64) {
        is_operator(arg0, arg1);
        arg2.max_radius = arg3;
        arg2.min_radius = arg4;
        arg2.current_max_radius = arg5;
        arg2.expansion_rate = arg6;
        arg2.density = arg8;
        arg2.max_density = (arg7 as u128) * 0x1::u128::pow(2, 64) / 1000;
        arg2.turf_count = arg9;
    }

    public(friend) fun set_max_raid_count(arg0: &mut RaidInfo, arg1: u64) {
        arg0.max_raid_count = arg1;
    }

    entry fun set_turf_attack_cooldown(arg0: &GameOperatorCap, arg1: &OperatorCapsBag, arg2: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::Version, arg3: &mut TurfSystem, arg4: u64) {
        is_operator(arg0, arg1);
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::validate_version(arg2);
        arg3.turf_cooldown = arg4;
    }

    public fun set_turf_cooldown(arg0: &MapCap, arg1: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::Version, arg2: &mut TurfInformation, arg3: u64) {
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::validate_version(arg1);
        arg2.cooldown = arg3;
    }

    public fun set_turf_owner(arg0: &MapCap, arg1: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::Version, arg2: &mut TurfInformation, arg3: 0x2::object::ID) {
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::validate_version(arg1);
        arg2.owner_id = arg3;
    }

    public(friend) fun set_turf_state_created_ts(arg0: &mut FreeTurfDefenderState, arg1: &0x2::clock::Clock) {
        arg0.created_timestamp = 0x2::clock::timestamp_ms(arg1);
    }

    public(friend) fun set_turf_state_defender_gangsters(arg0: &mut FreeTurfDefenderState, arg1: vector<0x1::string::String>) {
        arg0.defender_gangsters = arg1;
    }

    public fun share_turf(arg0: &MapCap, arg1: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::Version, arg2: TurfInformation) {
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::validate_version(arg1);
        0x2::transfer::share_object<TurfInformation>(arg2);
    }

    public fun update_defenders_after_battle(arg0: &MapCap, arg1: &mut FreeTurfDefenderRegistry, arg2: u64, arg3: bool, arg4: u64, arg5: bool, arg6: vector<0x1::string::String>) {
        let v0 = new_coordinates(arg2, arg3, arg4, arg5);
        if (0x2::table::contains<Coordinates, FreeTurfDefenderState>(&arg1.defender_states, v0)) {
            0x2::table::borrow_mut<Coordinates, FreeTurfDefenderState>(&mut arg1.defender_states, v0).defender_gangsters = arg6;
        };
    }

    entry fun update_map_config(arg0: &GameOperatorCap, arg1: &OperatorCapsBag, arg2: &0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::Version, arg3: &mut MapConfig, arg4: u64, arg5: u128) {
        is_operator(arg0, arg1);
        0xa0c4bb412c1d6121c1b6a40954ef76c3b1f75248211209e94726496f46a59ce0::map_version::validate_version(arg2);
        arg3.expansion_rate = arg4;
        arg3.max_density = (arg5 as u128) * 0x1::u128::pow(2, 64) / 1000;
    }

    public(friend) fun update_raid_info(arg0: &mut RaidInfo, arg1: &MapRegistry, arg2: &0x2::clock::Clock) {
        if (0x2::clock::timestamp_ms(arg2) >= arg0.attack_reset_in) {
            arg0.current_raid_count = 1;
            arg0.attack_reset_in = 0x2::clock::timestamp_ms(arg2) + borrow_key_value(arg1, 0x1::string::utf8(b"raid_reset_duration"));
        } else {
            arg0.current_raid_count = arg0.current_raid_count + 1;
        };
    }

    public(friend) fun validate_raid_counts(arg0: &mut RaidInfo, arg1: &MapRegistry, arg2: &0x2::clock::Clock) {
        let v0 = 0x1::string::utf8(b"max_raid_count");
        let v1 = *0x2::vec_map::get<0x1::string::String, u64>(&arg1.config, &v0);
        if (v1 != arg0.max_raid_count) {
            set_max_raid_count(arg0, v1);
        };
        if (arg0.max_raid_count < v1) {
            set_max_raid_count(arg0, v1);
        };
        if (0x2::clock::timestamp_ms(arg2) <= arg0.attack_reset_in) {
            assert!(arg0.max_raid_count > arg0.current_raid_count, 3);
        };
    }

    // decompiled from Move bytecode v6
}

