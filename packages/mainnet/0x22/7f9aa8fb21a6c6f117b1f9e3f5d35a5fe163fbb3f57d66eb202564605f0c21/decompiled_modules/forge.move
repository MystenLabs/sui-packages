module 0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::forge {
    struct WeaponLeveled has copy, drop {
        weapon_id: 0x2::object::ID,
        kind: u8,
        new_level: u8,
        burned: u64,
        owner: address,
    }

    public fun level_from_units(arg0: u64) : u8 {
        let v0 = 1;
        while (v0 < 5 && units_for_level(v0 + 1) <= arg0) {
            v0 = v0 + 1;
        };
        v0
    }

    public fun level_up(arg0: &mut 0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::Weapon, arg1: vector<0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::Weapon>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::level(arg0);
        assert!(v0 < 5, 1);
        assert!(!0x1::vector::is_empty<0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::Weapon>(&arg1), 2);
        let v1 = 0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::kind(arg0);
        let v2 = 0;
        while (!0x1::vector::is_empty<0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::Weapon>(&arg1)) {
            let v3 = 0x1::vector::pop_back<0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::Weapon>(&mut arg1);
            assert!(0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::kind(&v3) == v1, 3);
            v2 = v2 + 0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::units(&v3);
            0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::burn(v3);
        };
        0x1::vector::destroy_empty<0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::Weapon>(arg1);
        let v4 = 0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::units(arg0) + v2;
        assert!(v4 <= units_for_level(5), 5);
        0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::set_units(arg0, v4);
        let v5 = level_from_units(v4);
        if (v5 > v0) {
            0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::set_level(arg0, v5);
        };
        let v6 = WeaponLeveled{
            weapon_id : 0x2::object::id<0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::Weapon>(arg0),
            kind      : v1,
            new_level : v5,
            burned    : v2,
            owner     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<WeaponLeveled>(v6);
    }

    public fun required_for(arg0: u8) : u64 {
        (arg0 as u64)
    }

    public fun units_for_level(arg0: u8) : u64 {
        let v0 = (arg0 as u64);
        v0 * (v0 + 1) / 2
    }

    // decompiled from Move bytecode v7
}

