module 0x5e3f1febcbe160736488fcac08c374e3a6e7f007071afd352a7a8d0412e72529::iturf {
    struct MapCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
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

    public fun add_alive_units(arg0: &MapCap, arg1: &mut TurfInformation, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>) {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg3);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = 0x1::vector::borrow<0x1::string::String>(&arg3, v0);
            add_units(arg1, *v1, count_occurrences<0x1::string::String>(&arg2, v1));
        };
    }

    public fun add_coordinate_in_system(arg0: &MapCap, arg1: &mut TurfSystem, arg2: Coordinates, arg3: 0x2::object::ID) {
        0x2::table::add<Coordinates, 0x2::object::ID>(&mut arg1.coordinates_turfs, arg2, arg3);
    }

    public fun add_gangster_in_turf(arg0: &MapCap, arg1: &mut TurfInformation, arg2: 0x1::string::String, arg3: u64) {
        let v0 = 0x2::vec_map::get_mut<0x1::string::String, u64>(&mut arg1.garrison, &arg2);
        *v0 = *v0 + arg3;
    }

    public(friend) fun add_new_gangster_in_turf(arg0: &mut TurfInformation, arg1: 0x1::string::String, arg2: u64) {
        0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.garrison, arg1, arg2);
    }

    public(friend) fun add_turf_count(arg0: &mut MapConfig, arg1: u64) {
        arg0.turf_count = arg0.turf_count + arg1;
    }

    public(friend) fun add_units(arg0: &mut TurfInformation, arg1: 0x1::string::String, arg2: u64) {
        if (0x2::vec_map::contains<0x1::string::String, u64>(&arg0.garrison, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<0x1::string::String, u64>(&mut arg0.garrison, &arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.garrison, arg1, arg2);
        };
    }

    public(friend) fun borrow_density(arg0: &MapConfig) : u128 {
        arg0.density
    }

    public fun borrow_garrison_count(arg0: &TurfInformation) : u64 {
        arg0.garrison_count
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

    public(friend) fun has_gangster_in_tuf(arg0: &TurfInformation, arg1: 0x1::string::String) : bool {
        0x2::vec_map::contains<0x1::string::String, u64>(&arg0.garrison, &arg1) && *0x2::vec_map::get<0x1::string::String, u64>(&arg0.garrison, &arg1) >= 1
    }

    public(friend) fun increase_max_radius_with_expansion_rate(arg0: &mut MapConfig) {
        arg0.max_radius = arg0.max_radius + arg0.expansion_rate;
    }

    public(friend) fun increase_tur_garrison_count(arg0: &mut TurfInformation) {
        arg0.garrison_count = arg0.garrison_count + 1;
    }

    public fun increase_turf_cooldown(arg0: &MapCap, arg1: &mut TurfInformation, arg2: &0x2::clock::Clock) {
        arg1.cooldown = 0x2::clock::timestamp_ms(arg2) + 600000;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TurfSystem{
            id                : 0x2::object::new(arg0),
            coordinates_turfs : 0x2::table::new<Coordinates, 0x2::object::ID>(arg0),
            turf_cooldown     : 600000,
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

    public fun new_coordinates(arg0: u64, arg1: bool, arg2: u64, arg3: bool) : Coordinates {
        Coordinates{
            x     : arg0,
            x_neg : arg1,
            y     : arg2,
            y_neg : arg3,
        }
    }

    public fun new_turf_from_coordinate(arg0: &MapCap, arg1: 0x2::object::ID, arg2: u64, arg3: bool, arg4: u64, arg5: bool, arg6: vector<0x1::string::String>, arg7: vector<0x1::string::String>, arg8: &mut 0x2::tx_context::TxContext) : TurfInformation {
        let v0 = TurfInformation{
            id             : 0x2::object::new(arg8),
            x              : arg2,
            x_neg          : arg3,
            y              : arg4,
            y_neg          : arg5,
            owner_id       : arg1,
            garrison       : 0x2::vec_map::empty<0x1::string::String, u64>(),
            garrison_limit : 10,
            garrison_count : 0,
            land_perks     : 0x1::vector::empty<0x2::object::ID>(),
            cooldown       : 0,
        };
        let v1 = &mut v0;
        add_alive_units(arg0, v1, arg7, arg6);
        v0
    }

    public fun remove_gangster_from_turf(arg0: &MapCap, arg1: &mut TurfInformation, arg2: 0x1::string::String, arg3: u64) {
        if (0x2::vec_map::contains<0x1::string::String, u64>(&arg1.garrison, &arg2)) {
            let v0 = 0x2::vec_map::get_mut<0x1::string::String, u64>(&mut arg1.garrison, &arg2);
            *v0 = *v0 - arg3;
        };
    }

    public(friend) fun reset_garrison(arg0: &mut TurfInformation) {
        arg0.garrison_count = 0;
        arg0.garrison = 0x2::vec_map::empty<0x1::string::String, u64>();
    }

    public(friend) fun set_current_max_radius(arg0: &mut MapConfig, arg1: u64) {
        arg0.current_max_radius = arg1;
    }

    public(friend) fun set_density(arg0: &mut MapConfig, arg1: u128) {
        arg0.density = arg1;
    }

    entry fun set_map_config(arg0: &AdminCap, arg1: &mut MapConfig, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u128, arg8: u64) {
        arg1.max_radius = arg2;
        arg1.min_radius = arg3;
        arg1.current_max_radius = arg4;
        arg1.expansion_rate = arg5;
        arg1.density = arg7;
        arg1.max_density = arg6;
        arg1.turf_count = arg8;
    }

    entry fun set_turf_attack_cooldown(arg0: &AdminCap, arg1: &mut TurfSystem, arg2: u64) {
        arg1.turf_cooldown = arg2;
    }

    public fun set_turf_cooldown(arg0: &MapCap, arg1: &mut TurfInformation, arg2: u64) {
        arg1.cooldown = arg2;
    }

    public fun set_turf_owner(arg0: &MapCap, arg1: &mut TurfInformation, arg2: 0x2::object::ID) {
        arg1.owner_id = arg2;
    }

    public fun share_turf(arg0: &MapCap, arg1: TurfInformation) {
        0x2::transfer::share_object<TurfInformation>(arg1);
    }

    // decompiled from Move bytecode v6
}

