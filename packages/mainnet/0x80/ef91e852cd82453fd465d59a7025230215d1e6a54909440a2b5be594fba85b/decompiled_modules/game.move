module 0x80ef91e852cd82453fd465d59a7025230215d1e6a54909440a2b5be594fba85b::game {
    struct GamePool<phantom T0> has key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<T0>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit<T0>(arg0: &mut GamePool<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.pool, 0x2::coin::into_balance<T0>(arg1));
    }

    fun getRandomPoints(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        0x2::random::generate_u64_in_range(&mut v0, 1000000, 10000000)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun init_pool<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GamePool<T0>{
            id   : 0x2::object::new(arg1),
            pool : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<GamePool<T0>>(v0);
    }

    public entry fun play<T0>(arg0: &mut GamePool<T0>, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(0x2::coin::balance<T0>(&arg2)) > 999999, 0);
        let v0 = getRandomPoints(arg1, arg3);
        let v1 = getRandomPoints(arg1, arg3);
        0x2::balance::join<T0>(&mut arg0.pool, 0x2::coin::into_balance<T0>(arg2));
        if (v0 > 5000000) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pool, v1), arg3), 0x2::tx_context::sender(arg3));
        };
    }

    public entry fun withdraw<T0>(arg0: &AdminCap, arg1: &mut GamePool<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.pool, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

