module 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel {
    struct PlayerLevelPoint has drop, store {
        level: u64,
        next_level_at: u128,
        level_point: u128,
        previous_level_point: u128,
    }

    struct LevelPointRegistry has key {
        id: 0x2::object::UID,
        level_modifier: 0x2::vec_map::VecMap<u64, u8>,
        level_curve: 0x2::vec_map::VecMap<u64, u8>,
        level_points: 0x2::vec_map::VecMap<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, u64>>,
    }

    public(friend) fun add_level_point(arg0: &mut PlayerLevelPoint, arg1: u128) {
        arg0.level_point = arg0.level_point + arg1;
    }

    public(friend) fun borrow_action_point_range(arg0: &LevelPointRegistry, arg1: 0x1::string::String) : vector<u64> {
        let v0 = 0x2::vec_map::get<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&arg0.level_points, &arg1);
        let v1 = 0x1::string::utf8(b"base_min");
        let v2 = 0x1::string::utf8(b"base_max");
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, *0x2::vec_map::get<0x1::string::String, u64>(v0, &v1));
        0x1::vector::push_back<u64>(v4, *0x2::vec_map::get<0x1::string::String, u64>(v0, &v2));
        v3
    }

    public(friend) fun borrow_action_point_value(arg0: &LevelPointRegistry, arg1: 0x1::string::String) : 0x2::vec_map::VecMap<0x1::string::String, u64> {
        *0x2::vec_map::get<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&arg0.level_points, &arg1)
    }

    public fun borrow_level(arg0: &PlayerLevelPoint) : u64 {
        arg0.level
    }

    public fun borrow_level_point(arg0: &PlayerLevelPoint) : u128 {
        arg0.level_point
    }

    public fun borrow_level_points(arg0: &LevelPointRegistry) : &0x2::vec_map::VecMap<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, u64>> {
        &arg0.level_points
    }

    public fun borrow_next_level_at(arg0: &PlayerLevelPoint) : u128 {
        arg0.next_level_at
    }

    public fun borrow_previous_level_point(arg0: &PlayerLevelPoint) : u128 {
        arg0.previous_level_point
    }

    public(friend) fun get_level_modifier_curve(arg0: &LevelPointRegistry, arg1: u64) : (u64, u64) {
        let v0 = 0x2::vec_map::keys<u64, u8>(&arg0.level_modifier);
        let v1 = 0x2::vec_map::keys<u64, u8>(&arg0.level_curve);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        while (v2 < 0x1::vector::length<u64>(&v0)) {
            if (arg1 <= *0x1::vector::borrow<u64>(&v0, v2)) {
                v3 = *0x1::vector::borrow<u64>(&v0, v2);
                v4 = *0x1::vector::borrow<u64>(&v1, v2);
                break
            };
            v2 = v2 + 1;
        };
        ((*0x2::vec_map::get<u64, u8>(&arg0.level_modifier, &v3) as u64), (*0x2::vec_map::get<u64, u8>(&arg0.level_curve, &v4) as u64))
    }

    public(friend) fun has_action_type(arg0: &LevelPointRegistry, arg1: 0x1::string::String) : bool {
        0x2::vec_map::contains<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, u64>>(&arg0.level_points, &arg1)
    }

    public(friend) fun has_level_curve(arg0: &LevelPointRegistry, arg1: u64) : bool {
        0x2::vec_map::contains<u64, u8>(&arg0.level_curve, &arg1)
    }

    public(friend) fun has_multiplier(arg0: &LevelPointRegistry, arg1: u64) : bool {
        0x2::vec_map::contains<u64, u8>(&arg0.level_modifier, &arg1)
    }

    public(friend) fun increase_level(arg0: &mut PlayerLevelPoint, arg1: u64) {
        arg0.level = arg0.level + arg1;
    }

    public(friend) fun level_point_required(arg0: &LevelPointRegistry, arg1: u64) : u128 {
        let (v0, v1) = get_level_modifier_curve(arg0, arg1);
        ((arg1 * (arg1 + v1) * v0) as u128) * 0x1::u128::pow(2, 64)
    }

    public(friend) fun new_level_point(arg0: u128) : PlayerLevelPoint {
        PlayerLevelPoint{
            level                : 1,
            next_level_at        : arg0,
            level_point          : 0,
            previous_level_point : 0,
        }
    }

    public(friend) fun new_level_point_registry(arg0: &mut 0x2::tx_context::TxContext) : LevelPointRegistry {
        LevelPointRegistry{
            id             : 0x2::object::new(arg0),
            level_modifier : 0x2::vec_map::empty<u64, u8>(),
            level_curve    : 0x2::vec_map::empty<u64, u8>(),
            level_points   : 0x2::vec_map::empty<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, u64>>(),
        }
    }

    public(friend) fun set_previous_level_point(arg0: &mut PlayerLevelPoint) {
        arg0.previous_level_point = arg0.next_level_at;
    }

    public(friend) fun update_next_level_up_at_points(arg0: &mut PlayerLevelPoint, arg1: u128) {
        arg0.next_level_at = arg1;
    }

    // decompiled from Move bytecode v6
}

