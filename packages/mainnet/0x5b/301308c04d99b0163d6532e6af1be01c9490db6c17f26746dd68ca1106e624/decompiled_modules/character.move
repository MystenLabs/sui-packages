module 0x5b301308c04d99b0163d6532e6af1be01c9490db6c17f26746dd68ca1106e624::character {
    struct AttackEvent has copy, drop {
        attacker: 0x2::object::ID,
        target: 0x2::object::ID,
        damage_dealt: u64,
        target_hp_remaining: u64,
        reward_coin: u64,
    }

    struct LevelUpEvent has copy, drop {
        character_id: 0x2::object::ID,
        new_level: u16,
    }

    entry fun attack_target(arg0: &0x5b301308c04d99b0163d6532e6af1be01c9490db6c17f26746dd68ca1106e624::registry::GameRegistry, arg1: &mut 0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::Character, arg2: &mut 0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::Character, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        0x5b301308c04d99b0163d6532e6af1be01c9490db6c17f26746dd68ca1106e624::registry::assert_version(arg0);
        let v0 = 0x5b301308c04d99b0163d6532e6af1be01c9490db6c17f26746dd68ca1106e624::registry::borrow_data_cap(arg0);
        let v1 = 0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::ap(arg1);
        assert!(v1 > 0, 6);
        0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::set_ap(v0, arg1, v1 - 1);
        let v2 = 0x2::object::id<0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::Character>(arg1);
        let v3 = 0x2::object::id<0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::Character>(arg2);
        let v4 = 0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::hp(arg1);
        let v5 = 0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::hp(arg2);
        let v6 = 0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::attack(arg1);
        assert!(v2 != v3, 3);
        assert!(v4 > 0, 2);
        assert!(v5 > 0, 5);
        assert!(v4 > 0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::attack(arg2), 4);
        let v7 = if (v5 > v6) {
            v5 - v6
        } else {
            0
        };
        0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::set_hp(v0, arg2, v7);
        let v8 = 0x2::random::new_generator(arg3, arg4);
        0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::set_exp(v0, arg1, 0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::exp(arg1) + calculate_exp_reward(0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::level(arg1), 0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::level(arg2)));
        check_level_up(arg0, arg1);
        let v9 = AttackEvent{
            attacker            : v2,
            target              : v3,
            damage_dealt        : v6,
            target_hp_remaining : v7,
            reward_coin         : 0x2::random::generate_u64_in_range(&mut v8, 10, 200),
        };
        0x2::event::emit<AttackEvent>(v9);
    }

    fun calculate_exp_reward(arg0: u16, arg1: u16) : u64 {
        let v0 = 10 * (arg1 as u64);
        if (arg1 >= arg0) {
            v0 + v0 * ((arg1 - arg0) as u64) / 10
        } else {
            let v2 = v0 * ((arg0 - arg1) as u64) / 20;
            if (v0 > v2) {
                v0 - v2
            } else {
                0
            }
        }
    }

    fun check_level_up(arg0: &0x5b301308c04d99b0163d6532e6af1be01c9490db6c17f26746dd68ca1106e624::registry::GameRegistry, arg1: &mut 0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::Character) {
        let v0 = 0x5b301308c04d99b0163d6532e6af1be01c9490db6c17f26746dd68ca1106e624::registry::borrow_data_cap(arg0);
        let v1 = false;
        let v2 = 0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::level(arg1);
        let v3 = 0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::exp(arg1);
        let v4 = 0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::max_hp(arg1);
        let v5 = 0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::attack(arg1);
        let v6 = 0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::max_ap(arg1);
        loop {
            if (v2 >= 256) {
                break
            };
            let v7 = (v2 as u64);
            let v8 = 100 * v7 + 80 * v7 * v7;
            if (v3 < v8) {
                break
            };
            v3 = v3 - v8;
            let v9 = v2 + 1;
            v2 = v9;
            v1 = true;
            let v10 = (v9 as u64);
            v4 = v4 + 50 * v10 * v10;
            v5 = v5 + 3 * v10 * v10;
            v6 = v6 + v10;
        };
        if (v1) {
            0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::set_exp(v0, arg1, v3);
            0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::set_level(v0, arg1, v2);
            0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::set_max_hp(v0, arg1, v4);
            0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::set_hp(v0, arg1, v4);
            0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::set_attack(v0, arg1, v5);
            0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::set_max_ap(v0, arg1, v6);
            0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::set_ap(v0, arg1, v6);
            let v11 = LevelUpEvent{
                character_id : 0x2::object::id<0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::Character>(arg1),
                new_level    : v2,
            };
            0x2::event::emit<LevelUpEvent>(v11);
        };
    }

    entry fun create_character(arg0: &0x5b301308c04d99b0163d6532e6af1be01c9490db6c17f26746dd68ca1106e624::registry::GameRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0x5b301308c04d99b0163d6532e6af1be01c9490db6c17f26746dd68ca1106e624::registry::assert_version(arg0);
        0x2::transfer::public_transfer<0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::Character>(0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::create_character(0x5b301308c04d99b0163d6532e6af1be01c9490db6c17f26746dd68ca1106e624::registry::borrow_data_cap(arg0), arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    entry fun update_image(arg0: &0x5b301308c04d99b0163d6532e6af1be01c9490db6c17f26746dd68ca1106e624::registry::GameRegistry, arg1: &mut 0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::Character, arg2: 0x1::string::String) {
        0x5b301308c04d99b0163d6532e6af1be01c9490db6c17f26746dd68ca1106e624::registry::assert_version(arg0);
        0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::update_image(0x5b301308c04d99b0163d6532e6af1be01c9490db6c17f26746dd68ca1106e624::registry::borrow_data_cap(arg0), arg1, arg2);
    }

    entry fun update_name(arg0: &0x5b301308c04d99b0163d6532e6af1be01c9490db6c17f26746dd68ca1106e624::registry::GameRegistry, arg1: &mut 0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::Character, arg2: 0x1::string::String) {
        0x5b301308c04d99b0163d6532e6af1be01c9490db6c17f26746dd68ca1106e624::registry::assert_version(arg0);
        0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character::update_name(0x5b301308c04d99b0163d6532e6af1be01c9490db6c17f26746dd68ca1106e624::registry::borrow_data_cap(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

