module 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::rewards {
    struct PotKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Pot<phantom T0> has key {
        id: 0x2::object::UID,
        index: 0x2::object::ID,
        version: u64,
        acc: u256,
        total: u64,
        undripped: u64,
        drip_ms: u64,
        funds: 0x2::balance::Balance<T0>,
        paid_in: u64,
        paid_out: u64,
    }

    struct Staked<phantom T0> has store, key {
        id: 0x2::object::UID,
        pot: 0x2::object::ID,
        position: 0x1::option::Option<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::governance::Position<T0>>,
        weight: u64,
        acc_at: u256,
        owed: u64,
    }

    struct Loan {
        staked: 0x2::object::ID,
        position: 0x2::object::ID,
    }

    struct PotCreated has copy, drop {
        index: 0x2::object::ID,
        pot: 0x2::object::ID,
    }

    struct Paid has copy, drop {
        pot: 0x2::object::ID,
        amount: u64,
        total: u64,
    }

    struct Enrolled has copy, drop {
        pot: 0x2::object::ID,
        staked: 0x2::object::ID,
        position: 0x2::object::ID,
        weight: u64,
    }

    struct Resized has copy, drop {
        pot: 0x2::object::ID,
        staked: 0x2::object::ID,
        position: 0x2::object::ID,
        weight: u64,
    }

    struct Claimed has copy, drop {
        pot: 0x2::object::ID,
        staked: 0x2::object::ID,
        position: 0x2::object::ID,
        amount: u64,
        compounded: bool,
    }

    struct Exited has copy, drop {
        pot: 0x2::object::ID,
        staked: 0x2::object::ID,
        position: 0x2::object::ID,
        weight: u64,
        paid: u64,
    }

    public fun merge<T0>(arg0: &mut Pot<T0>, arg1: &mut Staked<T0>, arg2: Staked<T0>, arg3: &0x2::clock::Clock) {
        live<T0>(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        settle<T0>(arg0, arg1, v0);
        let v1 = &mut arg2;
        settle<T0>(arg0, v1, v0);
        let Staked {
            id       : v2,
            pot      : v3,
            position : v4,
            weight   : v5,
            acc_at   : _,
            owed     : v7,
        } = arg2;
        assert!(v3 == 0x2::object::id<Pot<T0>>(arg0), 302);
        0x2::object::delete(v2);
        arg0.total = arg0.total - v5;
        arg1.owed = arg1.owed + v7;
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::governance::merge<T0>(0x1::option::borrow_mut<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::governance::Position<T0>>(&mut arg1.position), 0x1::option::destroy_some<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::governance::Position<T0>>(v4));
        resize<T0>(arg0, arg1);
    }

    public fun acc<T0>(arg0: &Pot<T0>) : u256 {
        arg0.acc
    }

    public fun checkin<T0>(arg0: &mut Pot<T0>, arg1: &mut Staked<T0>, arg2: 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::governance::Position<T0>, arg3: Loan, arg4: &0x2::clock::Clock) {
        live<T0>(arg0);
        let Loan {
            staked   : v0,
            position : v1,
        } = arg3;
        assert!(v0 == 0x2::object::id<Staked<T0>>(arg1), 305);
        assert!(0x2::object::id<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::governance::Position<T0>>(&arg2) == v1, 305);
        0x1::option::fill<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::governance::Position<T0>>(&mut arg1.position, arg2);
        settle<T0>(arg0, arg1, 0x2::clock::timestamp_ms(arg4));
    }

    public fun checkout<T0>(arg0: &mut Pot<T0>, arg1: &mut Staked<T0>) : (0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::governance::Position<T0>, Loan) {
        live<T0>(arg0);
        assert!(arg1.pot == 0x2::object::id<Pot<T0>>(arg0), 302);
        assert!(0x1::option::is_some<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::governance::Position<T0>>(&arg1.position), 308);
        let v0 = 0x1::option::extract<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::governance::Position<T0>>(&mut arg1.position);
        let v1 = Loan{
            staked   : 0x2::object::id<Staked<T0>>(arg1),
            position : 0x2::object::id<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::governance::Position<T0>>(&v0),
        };
        (v0, v1)
    }

    public fun claim<T0>(arg0: &mut Pot<T0>, arg1: &mut Staked<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        live<T0>(arg0);
        settle<T0>(arg0, arg1, 0x2::clock::timestamp_ms(arg2));
        let v0 = arg1.owed;
        arg1.owed = 0;
        let v1 = Claimed{
            pot        : 0x2::object::id<Pot<T0>>(arg0),
            staked     : 0x2::object::id<Staked<T0>>(arg1),
            position   : pos_id<T0>(arg1),
            amount     : v0,
            compounded : false,
        };
        0x2::event::emit<Claimed>(v1);
        payout<T0>(arg0, v0, arg3)
    }

    public fun compound<T0>(arg0: &mut Pot<T0>, arg1: &mut Staked<T0>, arg2: &0x2::clock::Clock) {
        live<T0>(arg0);
        settle<T0>(arg0, arg1, 0x2::clock::timestamp_ms(arg2));
        let v0 = arg1.owed;
        arg1.owed = 0;
        arg0.paid_out = arg0.paid_out + v0;
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::governance::top_up<T0>(0x1::option::borrow_mut<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::governance::Position<T0>>(&mut arg1.position), 0x2::balance::split<T0>(&mut arg0.funds, v0));
        resize<T0>(arg0, arg1);
        let v1 = Claimed{
            pot        : 0x2::object::id<Pot<T0>>(arg0),
            staked     : 0x2::object::id<Staked<T0>>(arg1),
            position   : pos_id<T0>(arg1),
            amount     : v0,
            compounded : true,
        };
        0x2::event::emit<Claimed>(v1);
    }

    public fun create_pot<T0>(arg0: &mut 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: &0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::assert_admin<T0>(arg0, arg1);
        let v0 = PotKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<PotKey>(0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::uid<T0>(arg0), v0), 304);
        let v1 = Pot<T0>{
            id        : 0x2::object::new(arg2),
            index     : 0x2::object::id<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>>(arg0),
            version   : 1,
            acc       : 0,
            total     : 0,
            undripped : 0,
            drip_ms   : 0,
            funds     : 0x2::balance::zero<T0>(),
            paid_in   : 0,
            paid_out  : 0,
        };
        let v2 = 0x2::object::id<Pot<T0>>(&v1);
        let v3 = PotKey{dummy_field: false};
        0x2::dynamic_field::add<PotKey, 0x2::object::ID>(0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::uid_mut<T0>(arg0), v3, v2);
        let v4 = PotCreated{
            index : 0x2::object::id<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>>(arg0),
            pot   : v2,
        };
        0x2::event::emit<PotCreated>(v4);
        0x2::transfer::share_object<Pot<T0>>(v1);
    }

    public fun deposit<T0>(arg0: &mut Pot<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock) {
        live<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 306);
        drip<T0>(arg0, 0x2::clock::timestamp_ms(arg2));
        0x2::balance::join<T0>(&mut arg0.funds, 0x2::coin::into_balance<T0>(arg1));
        arg0.paid_in = arg0.paid_in + v0;
        arg0.undripped = arg0.undripped + v0;
        let v1 = Paid{
            pot    : 0x2::object::id<Pot<T0>>(arg0),
            amount : v0,
            total  : arg0.total,
        };
        0x2::event::emit<Paid>(v1);
    }

    fun drip<T0>(arg0: &mut Pot<T0>, arg1: u64) {
        if (arg0.total == 0) {
            arg0.drip_ms = arg1;
            return
        };
        let v0 = if (arg1 > arg0.drip_ms) {
            arg1 - arg0.drip_ms
        } else {
            0
        };
        arg0.drip_ms = arg1;
        if (v0 == 0 || arg0.undripped == 0) {
            return
        };
        let v1 = if (v0 >= 604800000) {
            arg0.undripped
        } else {
            (((arg0.undripped as u128) * (v0 as u128) / (604800000 as u128)) as u64)
        };
        arg0.undripped = arg0.undripped - v1;
        arg0.acc = arg0.acc + (v1 as u256) * 1000000000000000000 / (arg0.total as u256);
    }

    fun earned(arg0: u256, arg1: u256, arg2: u64) : u64 {
        (((arg0 - arg1) * (arg2 as u256) / 1000000000000000000) as u64)
    }

    public fun enroll<T0>(arg0: &mut Pot<T0>, arg1: 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::governance::Position<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : Staked<T0> {
        live<T0>(arg0);
        drip<T0>(arg0, 0x2::clock::timestamp_ms(arg2));
        assert!(0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::governance::position_index<T0>(&arg1) == arg0.index, 301);
        let v0 = 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::governance::position_amount<T0>(&arg1);
        let v1 = Staked<T0>{
            id       : 0x2::object::new(arg3),
            pot      : 0x2::object::id<Pot<T0>>(arg0),
            position : 0x1::option::some<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::governance::Position<T0>>(arg1),
            weight   : v0,
            acc_at   : arg0.acc,
            owed     : 0,
        };
        arg0.total = arg0.total + v0;
        let v2 = Enrolled{
            pot      : 0x2::object::id<Pot<T0>>(arg0),
            staked   : 0x2::object::id<Staked<T0>>(&v1),
            position : pos_id<T0>(&v1),
            weight   : v0,
        };
        0x2::event::emit<Enrolled>(v2);
        v1
    }

    public fun exit<T0>(arg0: &mut Pot<T0>, arg1: Staked<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::governance::Position<T0>, 0x2::coin::Coin<T0>) {
        live<T0>(arg0);
        let v0 = &mut arg1;
        settle<T0>(arg0, v0, 0x2::clock::timestamp_ms(arg2));
        let Staked {
            id       : v1,
            pot      : _,
            position : v3,
            weight   : v4,
            acc_at   : _,
            owed     : v6,
        } = arg1;
        let v7 = v1;
        let v8 = 0x1::option::destroy_some<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::governance::Position<T0>>(v3);
        0x2::object::delete(v7);
        arg0.total = arg0.total - v4;
        let v9 = Exited{
            pot      : 0x2::object::id<Pot<T0>>(arg0),
            staked   : 0x2::object::uid_to_inner(&v7),
            position : 0x2::object::id<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::governance::Position<T0>>(&v8),
            weight   : v4,
            paid     : v6,
        };
        0x2::event::emit<Exited>(v9);
        (v8, payout<T0>(arg0, v6, arg3))
    }

    public fun funds<T0>(arg0: &Pot<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.funds)
    }

    fun live<T0>(arg0: &Pot<T0>) {
        assert!(arg0.version == 1, 303);
    }

    public fun paid<T0>(arg0: &Pot<T0>) : (u64, u64) {
        (arg0.paid_in, arg0.paid_out)
    }

    fun payout<T0>(arg0: &mut Pot<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (arg1 == 0) {
            return 0x2::coin::zero<T0>(arg2)
        };
        assert!(0x2::balance::value<T0>(&arg0.funds) >= arg1, 307);
        arg0.paid_out = arg0.paid_out + arg1;
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.funds, arg1), arg2)
    }

    public fun pending<T0>(arg0: &Pot<T0>, arg1: &Staked<T0>) : u64 {
        arg1.owed + earned(arg0.acc, arg1.acc_at, arg1.weight)
    }

    fun pos_id<T0>(arg0: &Staked<T0>) : 0x2::object::ID {
        0x2::object::id<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::governance::Position<T0>>(0x1::option::borrow<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::governance::Position<T0>>(&arg0.position))
    }

    public fun position<T0>(arg0: &Staked<T0>) : &0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::governance::Position<T0> {
        0x1::option::borrow<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::governance::Position<T0>>(&arg0.position)
    }

    public fun position_id<T0>(arg0: &Staked<T0>) : 0x2::object::ID {
        pos_id<T0>(arg0)
    }

    public fun pot_of<T0>(arg0: &0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>) : 0x1::option::Option<0x2::object::ID> {
        let v0 = PotKey{dummy_field: false};
        if (0x2::dynamic_field::exists<PotKey>(0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::uid<T0>(arg0), v0)) {
            let v2 = PotKey{dummy_field: false};
            0x1::option::some<0x2::object::ID>(*0x2::dynamic_field::borrow<PotKey, 0x2::object::ID>(0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::uid<T0>(arg0), v2))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    fun resize<T0>(arg0: &mut Pot<T0>, arg1: &mut Staked<T0>) {
        let v0 = 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::governance::position_amount<T0>(0x1::option::borrow<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::governance::Position<T0>>(&arg1.position));
        if (v0 == arg1.weight) {
            return
        };
        arg0.total = arg0.total - arg1.weight + v0;
        arg1.weight = v0;
        let v1 = Resized{
            pot      : 0x2::object::id<Pot<T0>>(arg0),
            staked   : 0x2::object::id<Staked<T0>>(arg1),
            position : pos_id<T0>(arg1),
            weight   : v0,
        };
        0x2::event::emit<Resized>(v1);
    }

    fun settle<T0>(arg0: &mut Pot<T0>, arg1: &mut Staked<T0>, arg2: u64) {
        assert!(arg1.pot == 0x2::object::id<Pot<T0>>(arg0), 302);
        drip<T0>(arg0, arg2);
        arg1.owed = arg1.owed + earned(arg0.acc, arg1.acc_at, arg1.weight);
        arg1.acc_at = arg0.acc;
        resize<T0>(arg0, arg1);
    }

    public fun total<T0>(arg0: &Pot<T0>) : u64 {
        arg0.total
    }

    public fun undripped<T0>(arg0: &Pot<T0>) : u64 {
        arg0.undripped
    }

    public fun weight<T0>(arg0: &Staked<T0>) : u64 {
        arg0.weight
    }

    // decompiled from Move bytecode v7
}

