module 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::chest {
    struct Chest has store, key {
        id: 0x2::object::UID,
        defense: u64,
        gems: vector<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::gem::Gem>,
    }

    public(friend) fun new(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : Chest {
        Chest{
            id      : 0x2::object::new(arg1),
            defense : arg0,
            gems    : 0x1::vector::empty<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::gem::Gem>(),
        }
    }

    public fun add_gem(arg0: &mut Chest, arg1: &0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::config::Config, arg2: 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::gem::Gem) {
        assert!(0x1::vector::length<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::gem::Gem>(&arg0.gems) <= 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::config::gem_amount(arg1), 0);
        0x1::vector::push_back<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::gem::Gem>(&mut arg0.gems, arg2);
    }

    public fun defense(arg0: &Chest) : u64 {
        arg0.defense
    }

    public fun remove_equipment_gem_gem(arg0: &mut Chest, arg1: u64) : 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::gem::Gem {
        assert!(0x1::vector::length<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::gem::Gem>(&arg0.gems) > 0, 1);
        0x1::vector::swap_remove<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::gem::Gem>(&mut arg0.gems, arg1)
    }

    public fun switch_gem(arg0: &mut Chest, arg1: u64, arg2: 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::gem::Gem) : 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::gem::Gem {
        assert!(0x1::vector::length<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::gem::Gem>(&arg0.gems) > 0, 1);
        assert!(arg1 < 0x1::vector::length<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::gem::Gem>(&arg0.gems), 2);
        0x1::vector::push_back<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::gem::Gem>(&mut arg0.gems, arg2);
        0x1::vector::swap_remove<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::gem::Gem>(&mut arg0.gems, arg1)
    }

    public fun total_extra(arg0: &Chest) : u64 {
        if (0x1::vector::length<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::gem::Gem>(&arg0.gems) == 0) {
            0
        } else {
            let v1 = 0;
            let v2 = 0;
            while (v2 < 0x1::vector::length<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::gem::Gem>(&arg0.gems)) {
                v1 = v1 + 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::gem::extra(0x1::vector::borrow<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::gem::Gem>(&arg0.gems, v2));
                v2 = v2 + 1;
            };
            v1
        }
    }

    // decompiled from Move bytecode v6
}

