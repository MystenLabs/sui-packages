module 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::role {
    struct Role has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        sex: bool,
        birth: u64,
        hp: u64,
        chest: 0x1::option::Option<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::chest::Chest>,
        legs: 0x1::option::Option<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::legs::Legs>,
        shoes: 0x1::option::Option<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::shoes::Shoes>,
        head: 0x1::option::Option<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::head::Head>,
        weapon: 0x1::option::Option<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::weapon::Weapon>,
        pending_to: u64,
    }

    entry fun new(arg0: &0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::config::Config, arg1: 0x1::string::String, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Role{
            id         : 0x2::object::new(arg4),
            name       : arg1,
            sex        : arg2,
            birth      : 0x2::clock::timestamp_ms(arg3),
            hp         : 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::config::init_hp(arg0),
            chest      : 0x1::option::none<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::chest::Chest>(),
            legs       : 0x1::option::none<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::legs::Legs>(),
            shoes      : 0x1::option::none<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::shoes::Shoes>(),
            head       : 0x1::option::none<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::head::Head>(),
            weapon     : 0x1::option::none<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::weapon::Weapon>(),
            pending_to : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::transfer::transfer<Role>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun attack_points(arg0: &Role) : u64 {
        if (0x1::option::is_none<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::weapon::Weapon>(&arg0.weapon)) {
            0
        } else {
            0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::weapon::attack(0x1::option::borrow<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::weapon::Weapon>(&arg0.weapon)) + 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::weapon::total_extra(0x1::option::borrow<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::weapon::Weapon>(&arg0.weapon))
        }
    }

    public(friend) fun check_pending(arg0: &Role, arg1: &0x2::clock::Clock) {
        assert!(arg0.pending_to <= 0x2::clock::timestamp_ms(arg1), 0);
    }

    public fun defense_points(arg0: &Role) : u64 {
        let v0 = if (0x1::option::is_none<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::chest::Chest>(&arg0.chest)) {
            0
        } else {
            0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::chest::defense(0x1::option::borrow<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::chest::Chest>(&arg0.chest)) + 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::chest::total_extra(0x1::option::borrow<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::chest::Chest>(&arg0.chest))
        };
        let v1 = if (0x1::option::is_none<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::shoes::Shoes>(&arg0.shoes)) {
            0
        } else {
            0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::shoes::defense(0x1::option::borrow<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::shoes::Shoes>(&arg0.shoes)) + 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::shoes::total_extra(0x1::option::borrow<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::shoes::Shoes>(&arg0.shoes))
        };
        let v2 = if (0x1::option::is_none<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::head::Head>(&arg0.head)) {
            0
        } else {
            0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::head::defense(0x1::option::borrow<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::head::Head>(&arg0.head)) + 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::head::total_extra(0x1::option::borrow<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::head::Head>(&arg0.head))
        };
        let v3 = if (0x1::option::is_none<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::legs::Legs>(&arg0.legs)) {
            0
        } else {
            0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::legs::defense(0x1::option::borrow<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::legs::Legs>(&arg0.legs)) + 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::legs::total_extra(0x1::option::borrow<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::legs::Legs>(&arg0.legs))
        };
        v0 + v1 + v2 + v3
    }

    public fun fill_chest(arg0: &mut Role, arg1: 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::chest::Chest, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_none<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::chest::Chest>(&arg0.chest)) {
            0x1::option::fill<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::chest::Chest>(&mut arg0.chest, arg1);
        } else {
            0x1::option::fill<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::chest::Chest>(&mut arg0.chest, arg1);
            0x2::transfer::public_transfer<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::chest::Chest>(0x1::option::extract<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::chest::Chest>(&mut arg0.chest), 0x2::tx_context::sender(arg2));
        };
    }

    public fun fill_head(arg0: &mut Role, arg1: 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::head::Head, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_none<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::head::Head>(&arg0.head)) {
            0x1::option::fill<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::head::Head>(&mut arg0.head, arg1);
        } else {
            0x1::option::fill<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::head::Head>(&mut arg0.head, arg1);
            0x2::transfer::public_transfer<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::chest::Chest>(0x1::option::extract<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::chest::Chest>(&mut arg0.chest), 0x2::tx_context::sender(arg2));
        };
    }

    public fun fill_legs(arg0: &mut Role, arg1: 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::legs::Legs, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_none<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::legs::Legs>(&arg0.legs)) {
            0x1::option::fill<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::legs::Legs>(&mut arg0.legs, arg1);
        } else {
            0x1::option::fill<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::legs::Legs>(&mut arg0.legs, arg1);
            0x2::transfer::public_transfer<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::legs::Legs>(0x1::option::extract<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::legs::Legs>(&mut arg0.legs), 0x2::tx_context::sender(arg2));
        };
    }

    public fun fill_shoes(arg0: &mut Role, arg1: 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::shoes::Shoes, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_none<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::shoes::Shoes>(&arg0.shoes)) {
            0x1::option::fill<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::shoes::Shoes>(&mut arg0.shoes, arg1);
        } else {
            0x1::option::fill<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::shoes::Shoes>(&mut arg0.shoes, arg1);
            0x2::transfer::public_transfer<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::chest::Chest>(0x1::option::extract<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::chest::Chest>(&mut arg0.chest), 0x2::tx_context::sender(arg2));
        };
    }

    public fun fill_weapon(arg0: &mut Role, arg1: 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::weapon::Weapon, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_none<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::weapon::Weapon>(&arg0.weapon)) {
            0x1::option::fill<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::weapon::Weapon>(&mut arg0.weapon, arg1);
        } else {
            0x1::option::fill<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::weapon::Weapon>(&mut arg0.weapon, arg1);
            0x2::transfer::public_transfer<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::weapon::Weapon>(0x1::option::extract<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::weapon::Weapon>(&mut arg0.weapon), 0x2::tx_context::sender(arg2));
        };
    }

    public fun hp(arg0: &Role) : u64 {
        arg0.hp
    }

    public(friend) fun hurt(arg0: &mut Role) {
        arg0.hp = arg0.hp - 10;
    }

    public fun pending_to(arg0: &Role) : u64 {
        arg0.pending_to
    }

    public(friend) fun recover(arg0: &mut Role, arg1: &0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::config::Config, arg2: &0x2::clock::Clock) {
        assert!(arg0.pending_to <= 0x2::clock::timestamp_ms(arg2), 0);
        arg0.hp = 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::config::init_hp(arg1);
    }

    public(friend) fun set_pending(arg0: &mut Role, arg1: &0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::config::Config, arg2: &0x2::clock::Clock) {
        arg0.pending_to = 0x2::clock::timestamp_ms(arg2) + 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::config::recovery_time(arg1);
    }

    // decompiled from Move bytecode v6
}

