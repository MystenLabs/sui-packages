module 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::lineup {
    struct Global has key {
        id: 0x2::object::UID,
        standard_mood_pools: 0x2::table::Table<0x1::string::String, vector<LineUp>>,
        arena_mood_pools: 0x2::table::Table<0x1::string::String, vector<LineUp>>,
    }

    struct LineUp has copy, drop, store {
        creator: address,
        name: 0x1::string::String,
        role_num: u64,
        roles: vector<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>,
        gold_cost: u64,
        hash: vector<u8>,
    }

    public fun empty(arg0: &mut 0x2::tx_context::TxContext) : LineUp {
        let v0 = 0x1::vector::empty<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>();
        let v1 = 0;
        while (v1 < 6) {
            0x1::vector::push_back<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>(&mut v0, 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::empty());
            v1 = v1 + 1;
        };
        LineUp{
            creator   : 0x2::tx_context::sender(arg0),
            name      : 0x1::string::utf8(b""),
            role_num  : 0,
            roles     : v0,
            gold_cost : 0,
            hash      : 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::utils::seed(arg0, 12),
        }
    }

    public(friend) fun generate_lineup_by_power(arg0: &0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Global, arg1: u64, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : LineUp {
        let v0 = 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::utils::get_role_num_by_lineup_power(arg1);
        let v1 = 0x1::vector::empty<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>();
        while (v0 > 0) {
            0x1::vector::push_back<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>(&mut v1, 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::get_random_role_by_power(arg0, arg2, 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::utils::get_lineup_level2_prop_by_lineup_power(arg1), 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::utils::get_lineup_level3_prop_by_lineup_power(arg1), arg3));
            v0 = v0 - 1;
        };
        LineUp{
            creator   : 0x2::tx_context::sender(arg3),
            name      : 0x1::string::utf8(b"I'm a super robot"),
            role_num  : v0,
            roles     : v1,
            gold_cost : 0,
            hash      : 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::utils::seed(arg3, arg2),
        }
    }

    public fun generate_random_cards(arg0: &0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Global, arg1: &mut 0x2::tx_context::TxContext) : LineUp {
        let v0 = 30;
        let v1 = 0x1::vector::empty<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>();
        let v2 = 20;
        while (v0 != 0) {
            let v3 = v2 + 1;
            v2 = v3;
            0x1::vector::push_back<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>(&mut v1, 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::create_random_role_for_cards(arg0, v3, arg1));
            v0 = v0 - 1;
        };
        LineUp{
            creator   : 0x2::tx_context::sender(arg1),
            name      : 0x1::string::utf8(b"random cards pool"),
            role_num  : 0x1::vector::length<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>(&v1),
            roles     : v1,
            gold_cost : 0,
            hash      : 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::utils::seed(arg1, v2),
        }
    }

    public fun get_attack_hp_sum(arg0: &LineUp) : (u64, u64) {
        let v0 = arg0.roles;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v1 < 0x1::vector::length<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>(&v0)) {
            let v4 = 0x1::vector::borrow<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>(&v0, v1);
            v2 = v2 + 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::get_attack(v4);
            v3 = v3 + 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::get_hp(v4);
            v1 = v1 + 1;
        };
        (v2, v3)
    }

    public fun get_creator(arg0: &LineUp) : address {
        arg0.creator
    }

    public fun get_gold_cost(arg0: &LineUp) : u64 {
        arg0.gold_cost
    }

    public fun get_hash(arg0: &LineUp) : vector<u8> {
        arg0.hash
    }

    public fun get_mut_roles(arg0: &mut LineUp) : &mut vector<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role> {
        &mut arg0.roles
    }

    public fun get_name(arg0: &LineUp) : 0x1::string::String {
        arg0.name
    }

    public fun get_roles(arg0: &LineUp) : &vector<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role> {
        &arg0.roles
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{
            id                  : 0x2::object::new(arg0),
            standard_mood_pools : 0x2::table::new<0x1::string::String, vector<LineUp>>(arg0),
            arena_mood_pools    : 0x2::table::new<0x1::string::String, vector<LineUp>>(arg0),
        };
        0x2::transfer::share_object<Global>(v0);
    }

    public fun init_lineup_pools(arg0: &mut Global, arg1: &0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Global, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 10) {
            loop {
                let v2 = 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::utils::get_pool_tag(v0, v1);
                let v3 = 0x1::vector::empty<LineUp>();
                0x1::vector::push_back<LineUp>(&mut v3, generate_lineup_by_power(arg1, 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::utils::get_lineup_power_by_tag(v0, v1), 1, arg2));
                assert!(!0x2::table::contains<0x1::string::String, vector<LineUp>>(&arg0.standard_mood_pools, v2), 2);
                assert!(!0x2::table::contains<0x1::string::String, vector<LineUp>>(&arg0.arena_mood_pools, v2), 2);
                0x2::table::add<0x1::string::String, vector<LineUp>>(&mut arg0.standard_mood_pools, v2, v3);
                0x2::table::add<0x1::string::String, vector<LineUp>>(&mut arg0.arena_mood_pools, v2, v3);
                let v4 = v1 + 1;
                v1 = v4;
                if (v4 == 3) {
                    break
                };
            };
            v1 = 0;
            v0 = v0 + 1;
        };
    }

    public fun parse_lineup_str_vec(arg0: 0x1::string::String, arg1: &0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Global, arg2: vector<0x1::string::String>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : LineUp {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg2);
        let v1 = v0;
        let v2 = 0x1::vector::empty<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>();
        assert!(v0 == 6, 1);
        0x1::vector::reverse<0x1::string::String>(&mut arg2);
        while (v1 > 0) {
            let v3 = 0x1::vector::pop_back<0x1::string::String>(&mut arg2);
            if (0x1::string::length(&v3) == 0) {
                0x1::vector::push_back<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>(&mut v2, 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::empty());
                v1 = v1 - 1;
                continue
            };
            let v4 = 0x1::string::utf8(b":");
            let v5 = 0x1::string::index_of(&v3, &v4);
            let v6 = 0x1::string::sub_string(&v3, 0, v5);
            let v7 = 0x1::string::utf8(b"-");
            let v8 = 0x1::string::index_of(&v6, &v7);
            let v9 = 0x1::string::sub_string(&v3, v5 + 1, 0x1::string::length(&v3));
            let v10 = 0x1::string::utf8(b":");
            let v11 = 0x1::string::index_of(&v9, &v10);
            let v12 = 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::get_role_by_class(arg1, 0x1::string::sub_string(&v6, 0, v8));
            0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::set_hp(&mut v12, 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::utils::utf8_to_u64(0x1::string::sub_string(&v9, v11 + 1, 0x1::string::length(&v9))));
            0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::set_attack(&mut v12, 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::utils::utf8_to_u64(0x1::string::sub_string(&v9, 0, v11)));
            0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::set_level(&mut v12, (0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::utils::utf8_to_u64(0x1::string::sub_string(&v6, v8 + 1, 0x1::string::length(&v6))) as u8));
            0x1::vector::push_back<0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::role::Role>(&mut v2, v12);
            v1 = v1 - 1;
        };
        LineUp{
            creator   : 0x2::tx_context::sender(arg4),
            name      : arg0,
            role_num  : v1,
            roles     : v2,
            gold_cost : arg3,
            hash      : 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::utils::seed(arg4, 123),
        }
    }

    public fun record_player_lineup(arg0: u8, arg1: u8, arg2: &mut Global, arg3: LineUp, arg4: bool) {
        let v0 = 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::utils::get_pool_tag(arg0, arg1);
        if (arg4) {
            if (0x2::table::contains<0x1::string::String, vector<LineUp>>(&arg2.arena_mood_pools, v0)) {
                let v1 = 0x2::table::borrow_mut<0x1::string::String, vector<LineUp>>(&mut arg2.arena_mood_pools, v0);
                if (0x1::vector::length<LineUp>(v1) > 10) {
                    0x1::vector::remove<LineUp>(v1, 0);
                    0x1::vector::push_back<LineUp>(v1, arg3);
                } else {
                    0x1::vector::push_back<LineUp>(v1, arg3);
                };
            } else {
                let v2 = 0x1::vector::empty<LineUp>();
                0x1::vector::push_back<LineUp>(&mut v2, arg3);
                0x2::table::add<0x1::string::String, vector<LineUp>>(&mut arg2.arena_mood_pools, v0, v2);
            };
        } else if (0x2::table::contains<0x1::string::String, vector<LineUp>>(&arg2.standard_mood_pools, v0)) {
            let v3 = 0x2::table::borrow_mut<0x1::string::String, vector<LineUp>>(&mut arg2.standard_mood_pools, v0);
            if (0x1::vector::length<LineUp>(v3) > 10) {
                0x1::vector::remove<LineUp>(v3, 0);
                0x1::vector::push_back<LineUp>(v3, arg3);
            } else {
                0x1::vector::push_back<LineUp>(v3, arg3);
            };
        } else {
            let v4 = 0x1::vector::empty<LineUp>();
            0x1::vector::push_back<LineUp>(&mut v4, arg3);
            0x2::table::add<0x1::string::String, vector<LineUp>>(&mut arg2.standard_mood_pools, v0, v4);
        };
    }

    public fun select_random_lineup(arg0: u8, arg1: u8, arg2: &Global, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : LineUp {
        let v0 = 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::utils::get_pool_tag(arg0, arg1);
        let v1 = if (arg3) {
            if (0x2::table::contains<0x1::string::String, vector<LineUp>>(&arg2.arena_mood_pools, v0)) {
                *0x2::table::borrow<0x1::string::String, vector<LineUp>>(&arg2.arena_mood_pools, v0)
            } else {
                let v2 = 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::utils::u8_to_string(arg0);
                0x1::string::append(&mut v2, 0x1::string::utf8(b"-0"));
                *0x2::table::borrow<0x1::string::String, vector<LineUp>>(&arg2.arena_mood_pools, v2)
            }
        } else if (0x2::table::contains<0x1::string::String, vector<LineUp>>(&arg2.standard_mood_pools, v0)) {
            *0x2::table::borrow<0x1::string::String, vector<LineUp>>(&arg2.standard_mood_pools, v0)
        } else {
            let v3 = 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::utils::u8_to_string(arg0);
            0x1::string::append(&mut v3, 0x1::string::utf8(b"-0"));
            *0x2::table::borrow<0x1::string::String, vector<LineUp>>(&arg2.standard_mood_pools, v3)
        };
        let v4 = 0x1::vector::length<LineUp>(&v1);
        *0x1::vector::borrow<LineUp>(&v1, 0x43781cdf8ab80d27724041a8b34df02fbcdc5367bd180499408f61efaa086b4c::utils::get_random_num(0, v4, 10, arg4) % v4)
    }

    public fun set_hash(arg0: &mut LineUp, arg1: vector<u8>) {
        arg0.hash = arg1;
    }

    // decompiled from Move bytecode v6
}

