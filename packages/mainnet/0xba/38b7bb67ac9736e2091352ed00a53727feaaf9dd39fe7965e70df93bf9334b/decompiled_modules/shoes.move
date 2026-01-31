module 0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::shoes {
    struct Shoes has store, key {
        id: 0x2::object::UID,
        defense: u64,
        gems: vector<0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::gem::Gem>,
    }

    public(friend) fun new(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : Shoes {
        Shoes{
            id      : 0x2::object::new(arg1),
            defense : arg0,
            gems    : 0x1::vector::empty<0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::gem::Gem>(),
        }
    }

    public fun add_gem(arg0: &mut Shoes, arg1: &0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::config::Config, arg2: 0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::gem::Gem) {
        assert!(0x1::vector::length<0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::gem::Gem>(&arg0.gems) < 0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::config::gem_amount(arg1), 0);
        0x1::vector::push_back<0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::gem::Gem>(&mut arg0.gems, arg2);
    }

    public fun defense(arg0: &Shoes) : u64 {
        arg0.defense
    }

    public fun remove_equipment_gem_gem(arg0: &mut Shoes, arg1: u64) : 0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::gem::Gem {
        assert!(0x1::vector::length<0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::gem::Gem>(&arg0.gems) > 0, 1);
        0x1::vector::swap_remove<0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::gem::Gem>(&mut arg0.gems, arg1)
    }

    public fun switch_gem(arg0: &mut Shoes, arg1: u64, arg2: 0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::gem::Gem) : 0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::gem::Gem {
        assert!(0x1::vector::length<0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::gem::Gem>(&arg0.gems) > 0, 1);
        assert!(arg1 < 0x1::vector::length<0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::gem::Gem>(&arg0.gems), 2);
        0x1::vector::push_back<0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::gem::Gem>(&mut arg0.gems, arg2);
        0x1::vector::swap_remove<0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::gem::Gem>(&mut arg0.gems, arg1)
    }

    public fun total_extra(arg0: &Shoes) : u64 {
        if (0x1::vector::length<0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::gem::Gem>(&arg0.gems) == 0) {
            0
        } else {
            let v1 = 0;
            let v2 = 0;
            while (v2 < 0x1::vector::length<0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::gem::Gem>(&arg0.gems)) {
                v1 = v1 + 0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::gem::extra(0x1::vector::borrow<0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::gem::Gem>(&arg0.gems, v2));
                v2 = v2 + 1;
            };
            v1
        }
    }

    // decompiled from Move bytecode v6
}

