module 0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::wilderness {
    struct Wilderness has store, key {
        id: 0x2::object::UID,
    }

    fun gen_rand(arg0: &0x2::random::Random, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::random::new_generator(arg0, arg3);
        0x2::random::generate_u64_in_range(&mut v0, arg1, arg2)
    }

    entry fun hunt_for_chest(arg0: &0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::Role, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = gen_rand(arg1, 1, 100, arg2);
        0x2::transfer::public_transfer<0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::chest::Chest>(0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::chest::new(v0, arg2), 0x2::tx_context::sender(arg2));
    }

    entry fun hunt_for_gem(arg0: &0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::Role, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = gen_rand(arg1, 1, 30, arg2);
        0x2::transfer::public_transfer<0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::gem::Gem>(0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::gem::new(v0, arg2), 0x2::tx_context::sender(arg2));
    }

    entry fun hunt_for_head(arg0: &0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::Role, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = gen_rand(arg1, 1, 100, arg2);
        0x2::transfer::public_transfer<0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::head::Head>(0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::head::new(v0, arg2), 0x2::tx_context::sender(arg2));
    }

    entry fun hunt_for_legs(arg0: &0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::Role, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = gen_rand(arg1, 1, 100, arg2);
        0x2::transfer::public_transfer<0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::legs::Legs>(0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::legs::new(v0, arg2), 0x2::tx_context::sender(arg2));
    }

    entry fun hunt_for_shoes(arg0: &0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::Role, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = gen_rand(arg1, 1, 100, arg2);
        0x2::transfer::public_transfer<0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::shoes::Shoes>(0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::shoes::new(v0, arg2), 0x2::tx_context::sender(arg2));
    }

    entry fun hunt_for_weapon(arg0: &0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::role::Role, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = gen_rand(arg1, 1, 400, arg2);
        0x2::transfer::public_transfer<0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::weapon::Weapon>(0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::weapon::new(v0, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

