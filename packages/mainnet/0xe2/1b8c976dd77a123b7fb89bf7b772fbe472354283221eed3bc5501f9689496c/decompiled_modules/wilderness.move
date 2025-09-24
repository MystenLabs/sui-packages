module 0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::wilderness {
    struct Wilderness has store, key {
        id: 0x2::object::UID,
    }

    fun gen_rand(arg0: &0x2::random::Random, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::random::new_generator(arg0, arg3);
        0x2::random::generate_u64_in_range(&mut v0, arg1, arg2)
    }

    entry fun hunt_for_chest(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = gen_rand(arg0, 1, 100, arg1);
        0x2::transfer::public_transfer<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::chest::Chest>(0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::chest::new(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    entry fun hunt_for_gem(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = gen_rand(arg0, 1, 30, arg1);
        0x2::transfer::public_transfer<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::gem::Gem>(0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::gem::new(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    entry fun hunt_for_head(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = gen_rand(arg0, 1, 100, arg1);
        0x2::transfer::public_transfer<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::head::Head>(0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::head::new(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    entry fun hunt_for_legs(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = gen_rand(arg0, 1, 100, arg1);
        0x2::transfer::public_transfer<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::legs::Legs>(0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::legs::new(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    entry fun hunt_for_shoes(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = gen_rand(arg0, 1, 100, arg1);
        0x2::transfer::public_transfer<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::shoes::Shoes>(0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::shoes::new(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    entry fun hunt_for_weapon(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = gen_rand(arg0, 1, 400, arg1);
        0x2::transfer::public_transfer<0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::weapon::Weapon>(0xe21b8c976dd77a123b7fb89bf7b772fbe472354283221eed3bc5501f9689496c::weapon::new(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

