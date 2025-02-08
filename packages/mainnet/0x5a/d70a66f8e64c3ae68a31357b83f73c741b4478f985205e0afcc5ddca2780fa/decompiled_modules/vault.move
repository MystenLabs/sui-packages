module 0x80a7e3d73ac1f379c921906392bfff4563081f5a4d2a458bf30838d5784df045::vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        position: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>,
        strap: 0x1::option::Option<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::BottleStrap<T0>>,
        neutral_coll_rate: u64,
        lower_tick_deviation: u32,
        upper_tick_deviation: u32,
        precision: u64,
        is_running: bool,
    }

    public(friend) fun borrow_position<T0>(arg0: &Vault<T0>) : &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position)
    }

    public(friend) fun borrow_strap<T0>(arg0: &Vault<T0>) : &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::BottleStrap<T0> {
        0x1::option::borrow<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::BottleStrap<T0>>(&arg0.strap)
    }

    public entry fun create<T0>(arg0: &AdminCap, arg1: u64, arg2: u32, arg3: u32, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id                   : 0x2::object::new(arg5),
            position             : 0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(),
            strap                : 0x1::option::none<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::BottleStrap<T0>>(),
            neutral_coll_rate    : arg1,
            lower_tick_deviation : arg2,
            upper_tick_deviation : arg3,
            precision            : arg4,
            is_running           : false,
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    public fun getValue<T0>(arg0: &Vault<T0>) : u64 {
        0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, @0x1db18cc9611bd9fcfa79f4954dc6ee5920818fb8f87c87320e2535ec560ed9d1);
    }

    public fun is_running<T0>(arg0: &Vault<T0>) : bool {
        arg0.is_running
    }

    public fun lower_tick_deviation<T0>(arg0: &Vault<T0>) : u32 {
        arg0.lower_tick_deviation
    }

    public fun neutral_coll_rate<T0>(arg0: &Vault<T0>) : u64 {
        arg0.neutral_coll_rate
    }

    public fun precision<T0>(arg0: &Vault<T0>) : u64 {
        arg0.precision
    }

    public(friend) fun put_in_position<T0>(arg0: &mut Vault<T0>, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) {
        0x1::option::fill<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.position, arg1);
    }

    public(friend) fun put_in_strap<T0>(arg0: &mut Vault<T0>, arg1: 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::BottleStrap<T0>) {
        0x1::option::fill<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::BottleStrap<T0>>(&mut arg0.strap, arg1);
    }

    public(friend) fun run<T0>(arg0: &mut Vault<T0>) {
        arg0.is_running = true;
    }

    public(friend) fun stop<T0>(arg0: &mut Vault<T0>) {
        arg0.is_running = false;
    }

    public(friend) fun take_out_position<T0>(arg0: &mut Vault<T0>) : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        0x1::option::extract<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.position)
    }

    public(friend) fun take_out_strap<T0>(arg0: &mut Vault<T0>) : 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::BottleStrap<T0> {
        0x1::option::extract<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::strap::BottleStrap<T0>>(&mut arg0.strap)
    }

    public fun upper_tick_deviation<T0>(arg0: &Vault<T0>) : u32 {
        arg0.upper_tick_deviation
    }

    // decompiled from Move bytecode v6
}

