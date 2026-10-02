module 0x587481a92ca750bbad564621c37faa8acedf9f7272eca7d05a55ccacacac7e86::launchpad {
    struct Pad has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        owner: address,
        launches: u64,
    }

    struct PadCap has store, key {
        id: 0x2::object::UID,
        pad: 0x2::object::ID,
    }

    struct Locked<phantom T0> has key {
        id: 0x2::object::UID,
        pad: 0x2::object::ID,
        index: u64,
        pool: 0x2::object::ID,
        position: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>,
        position_id: 0x2::object::ID,
        supply: u64,
        reserve: u64,
        reserve_to: address,
        created_ms: u64,
    }

    struct Ticket<phantom T0> {
        pad: 0x2::object::ID,
        supply: u64,
        reserve: u64,
        reserve_to: address,
    }

    struct Loan<phantom T0> {
        locked: 0x2::object::ID,
        position_id: 0x2::object::ID,
        liquidity: u128,
    }

    struct PadCreated has copy, drop {
        pad: 0x2::object::ID,
        name: 0x1::string::String,
        owner: address,
    }

    struct Launched has copy, drop {
        pad: 0x2::object::ID,
        index: u64,
        coin_type: 0x1::string::String,
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
        locked: 0x2::object::ID,
        supply: u64,
        reserve: u64,
        reserve_to: address,
        liquidity: u128,
        metadata: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct FeeBorrowed has copy, drop {
        pad: 0x2::object::ID,
        locked: 0x2::object::ID,
        pool: 0x2::object::ID,
    }

    public fun fee_borrow<T0>(arg0: &mut Locked<T0>, arg1: &Pad, arg2: &PadCap) : (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, Loan<T0>) {
        assert!(arg2.pad == 0x2::object::id<Pad>(arg1) && arg0.pad == 0x2::object::id<Pad>(arg1), 1);
        let v0 = 0x1::option::extract<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.position);
        let v1 = FeeBorrowed{
            pad    : arg0.pad,
            locked : 0x2::object::id<Locked<T0>>(arg0),
            pool   : arg0.pool,
        };
        0x2::event::emit<FeeBorrowed>(v1);
        let v2 = Loan<T0>{
            locked      : 0x2::object::id<Locked<T0>>(arg0),
            position_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0),
            liquidity   : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v0),
        };
        (v0, v2)
    }

    public fun fee_return<T0>(arg0: &mut Locked<T0>, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: Loan<T0>) {
        let Loan {
            locked      : v0,
            position_id : v1,
            liquidity   : v2,
        } = arg2;
        assert!(v0 == 0x2::object::id<Locked<T0>>(arg0) && v1 == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1), 4);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg1) >= v2, 5);
        0x1::option::fill<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.position, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Pad{
            id       : 0x2::object::new(arg0),
            name     : 0x1::string::utf8(b"TurbosHub"),
            owner    : v0,
            launches : 0,
        };
        let v2 = 0x2::object::id<Pad>(&v1);
        let v3 = PadCreated{
            pad   : v2,
            name  : v1.name,
            owner : v0,
        };
        0x2::event::emit<PadCreated>(v3);
        0x2::transfer::share_object<Pad>(v1);
        let v4 = PadCap{
            id  : 0x2::object::new(arg0),
            pad : v2,
        };
        0x2::transfer::public_transfer<PadCap>(v4, v0);
    }

    public fun launch_begin<T0>(arg0: &mut Pad, arg1: &PadCap, arg2: 0x2::coin::Coin<T0>, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Ticket<T0>) {
        assert!(arg1.pad == 0x2::object::id<Pad>(arg0), 1);
        assert!(arg4 <= 9000, 2);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 6);
        let v1 = (((v0 as u128) * (arg4 as u128) / (10000 as u128)) as u64);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v1, arg5), arg3);
        };
        let v2 = Ticket<T0>{
            pad        : 0x2::object::id<Pad>(arg0),
            supply     : v0,
            reserve    : v1,
            reserve_to : arg3,
        };
        (arg2, v2)
    }

    public fun launch_lock<T0>(arg0: &mut Pad, arg1: Ticket<T0>, arg2: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let Ticket {
            pad        : v0,
            supply     : v1,
            reserve    : v2,
            reserve_to : v3,
        } = arg1;
        assert!(v0 == 0x2::object::id<Pad>(arg0), 1);
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg2);
        assert!(v4 > 0, 3);
        if (0x2::coin::value<T0>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v3);
        } else {
            0x2::coin::destroy_zero<T0>(arg3);
        };
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg2);
        let v6 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg2);
        let v7 = arg0.launches;
        arg0.launches = v7 + 1;
        let v8 = Locked<T0>{
            id          : 0x2::object::new(arg6),
            pad         : v0,
            index       : v7,
            pool        : v5,
            position    : 0x1::option::some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg2),
            position_id : v6,
            supply      : v1,
            reserve     : v2,
            reserve_to  : v3,
            created_ms  : 0x2::clock::timestamp_ms(arg5),
        };
        let v9 = Launched{
            pad          : v0,
            index        : v7,
            coin_type    : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            pool         : v5,
            position     : v6,
            locked       : 0x2::object::id<Locked<T0>>(&v8),
            supply       : v1,
            reserve      : v2,
            reserve_to   : v3,
            liquidity    : v4,
            metadata     : arg4,
            timestamp_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<Launched>(v9);
        0x2::transfer::share_object<Locked<T0>>(v8);
    }

    public fun launches(arg0: &Pad) : u64 {
        arg0.launches
    }

    public fun locked_liquidity<T0>(arg0: &Locked<T0>) : u128 {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position))
    }

    public fun locked_pad<T0>(arg0: &Locked<T0>) : 0x2::object::ID {
        arg0.pad
    }

    public fun locked_pool<T0>(arg0: &Locked<T0>) : 0x2::object::ID {
        arg0.pool
    }

    public fun locked_position_id<T0>(arg0: &Locked<T0>) : 0x2::object::ID {
        arg0.position_id
    }

    public fun pad_name(arg0: &Pad) : 0x1::string::String {
        arg0.name
    }

    public fun pad_owner(arg0: &Pad) : address {
        arg0.owner
    }

    public fun set_name(arg0: &mut Pad, arg1: &PadCap, arg2: 0x1::string::String) {
        assert!(arg1.pad == 0x2::object::id<Pad>(arg0), 1);
        arg0.name = arg2;
        let v0 = PadCreated{
            pad   : 0x2::object::id<Pad>(arg0),
            name  : arg2,
            owner : arg0.owner,
        };
        0x2::event::emit<PadCreated>(v0);
    }

    // decompiled from Move bytecode v7
}

