module 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters {
    struct GangsterBaseStats has store, key {
        id: 0x2::object::UID,
        available_units: vector<0x1::string::String>,
    }

    struct GangsterRecruitCost has store {
        cost_type: 0x1::string::String,
        amount: u128,
    }

    struct GangsterStats has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image: 0x1::string::String,
        health: u128,
        attack: u128,
        description: 0x1::string::String,
        recruit_cost: vector<GangsterRecruitCost>,
        damage_modifier: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    public fun add_gangster_recruit_cost(arg0: &mut GangsterStats, arg1: GangsterRecruitCost) {
        0x1::vector::push_back<GangsterRecruitCost>(&mut arg0.recruit_cost, arg1);
    }

    public fun borrow_gangster_battle_stats(arg0: &GangsterStats) : (u128, u128) {
        (arg0.attack, arg0.health)
    }

    public(friend) fun borrow_gangster_df<T0: store + key>(arg0: &GangsterBaseStats, arg1: 0x1::string::String) : &T0 {
        0x2::dynamic_field::borrow<0x1::string::String, T0>(&arg0.id, arg1)
    }

    public(friend) fun borrow_gangster_recruit_cost(arg0: &GangsterStats) : &vector<GangsterRecruitCost> {
        &arg0.recruit_cost
    }

    public fun borrow_gangster_recruit_cost_amount(arg0: &GangsterRecruitCost) : u128 {
        arg0.amount
    }

    public fun borrow_gangster_recruit_cost_type(arg0: &GangsterRecruitCost) : 0x1::string::String {
        arg0.cost_type
    }

    public fun borrow_mut_gangster_stats(arg0: &mut GangsterBaseStats, arg1: 0x1::string::String) : &mut GangsterStats {
        0x2::dynamic_field::borrow_mut<0x1::string::String, GangsterStats>(&mut arg0.id, arg1)
    }

    public fun borrow_unit_types(arg0: &GangsterBaseStats) : vector<0x1::string::String> {
        arg0.available_units
    }

    public fun has_unit_df(arg0: &GangsterBaseStats, arg1: 0x1::string::String) : bool {
        0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, arg1)
    }

    public fun is_valid_unit(arg0: &GangsterBaseStats, arg1: 0x1::string::String) : bool {
        0x1::vector::contains<0x1::string::String>(&arg0.available_units, &arg1)
    }

    // decompiled from Move bytecode v6
}

