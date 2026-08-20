module 0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::forge {
    struct WeaponLeveled has copy, drop {
        weapon_id: 0x2::object::ID,
        kind: u8,
        new_level: u8,
        burned: u64,
        owner: address,
    }

    public fun level_up(arg0: &mut 0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::Weapon, arg1: vector<0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::Weapon>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::level(arg0);
        assert!(v0 < 5, 1);
        let v1 = v0 + 1;
        assert!(0x1::vector::length<0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::Weapon>(&arg1) == required_for(v1), 2);
        let v2 = 0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::kind(arg0);
        while (!0x1::vector::is_empty<0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::Weapon>(&arg1)) {
            let v3 = 0x1::vector::pop_back<0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::Weapon>(&mut arg1);
            assert!(0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::kind(&v3) == v2, 3);
            assert!(0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::level(&v3) == 1, 4);
            0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::burn(v3);
        };
        0x1::vector::destroy_empty<0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::Weapon>(arg1);
        0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::set_level(arg0, v1);
        let v4 = WeaponLeveled{
            weapon_id : 0x2::object::id<0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::Weapon>(arg0),
            kind      : v2,
            new_level : v1,
            burned    : required_for(v1),
            owner     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<WeaponLeveled>(v4);
    }

    public fun required_for(arg0: u8) : u64 {
        (arg0 as u64)
    }

    // decompiled from Move bytecode v7
}

