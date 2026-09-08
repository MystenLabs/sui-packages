module 0xc975241310ca7dbd25481d1cc06058d7d5a086e68b675ee3ecdeae0d29c0137::custody {
    struct XToken<phantom T0> has drop {
        dummy_field: bool,
    }

    struct YToken<phantom T0> has drop {
        dummy_field: bool,
    }

    struct Custody<phantom T0, phantom T1> has store {
        idle_x: 0x2::balance::Balance<T0>,
        idle_y: 0x2::balance::Balance<T1>,
        deployed_x: u64,
        deployed_y: u64,
        supply_x: 0x2::balance::Supply<XToken<T0>>,
        supply_y: 0x2::balance::Supply<YToken<T1>>,
    }

    public(friend) fun abandon_deployed<T0, T1>(arg0: &mut Custody<T0, T1>) : (u64, u64) {
        arg0.deployed_x = 0;
        arg0.deployed_y = 0;
        (arg0.deployed_x, arg0.deployed_y)
    }

    fun assert_u64_headroom(arg0: u64, arg1: u64) {
        assert!(arg0 <= 18446744073709551615 - arg1, 704);
    }

    public fun backing_u128_x<T0, T1>(arg0: &Custody<T0, T1>) : u128 {
        (0x2::balance::value<T0>(&arg0.idle_x) as u128) + (arg0.deployed_x as u128)
    }

    public fun backing_u128_y<T0, T1>(arg0: &Custody<T0, T1>) : u128 {
        (0x2::balance::value<T1>(&arg0.idle_y) as u128) + (arg0.deployed_y as u128)
    }

    public(friend) fun burn_existing_claims_x<T0, T1>(arg0: &mut Custody<T0, T1>, arg1: 0x2::balance::Balance<XToken<T0>>) : u64 {
        0x2::balance::decrease_supply<XToken<T0>>(&mut arg0.supply_x, arg1)
    }

    public(friend) fun burn_existing_claims_y<T0, T1>(arg0: &mut Custody<T0, T1>, arg1: 0x2::balance::Balance<YToken<T1>>) : u64 {
        0x2::balance::decrease_supply<YToken<T1>>(&mut arg0.supply_y, arg1)
    }

    public fun claims_value_x<T0, T1>(arg0: &Custody<T0, T1>) : u64 {
        0x2::balance::supply_value<XToken<T0>>(&arg0.supply_x)
    }

    public fun claims_value_y<T0, T1>(arg0: &Custody<T0, T1>) : u64 {
        0x2::balance::supply_value<YToken<T1>>(&arg0.supply_y)
    }

    public(friend) fun credit_deployed_x<T0, T1>(arg0: &mut Custody<T0, T1>, arg1: u64) {
        assert_u64_headroom(arg0.deployed_x, arg1);
        arg0.deployed_x = arg0.deployed_x + arg1;
    }

    public(friend) fun credit_deployed_y<T0, T1>(arg0: &mut Custody<T0, T1>, arg1: u64) {
        assert_u64_headroom(arg0.deployed_y, arg1);
        arg0.deployed_y = arg0.deployed_y + arg1;
    }

    public(friend) fun credit_existing_yield_x<T0, T1>(arg0: &mut Custody<T0, T1>, arg1: u64) : 0x2::balance::Balance<XToken<T0>> {
        assert_u64_headroom(0x2::balance::supply_value<XToken<T0>>(&arg0.supply_x), arg1);
        0x2::balance::increase_supply<XToken<T0>>(&mut arg0.supply_x, arg1)
    }

    public(friend) fun credit_existing_yield_y<T0, T1>(arg0: &mut Custody<T0, T1>, arg1: u64) : 0x2::balance::Balance<YToken<T1>> {
        assert_u64_headroom(0x2::balance::supply_value<YToken<T1>>(&arg0.supply_y), arg1);
        0x2::balance::increase_supply<YToken<T1>>(&mut arg0.supply_y, arg1)
    }

    public(friend) fun deploy_x<T0, T1>(arg0: &mut Custody<T0, T1>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::balance::value<T0>(&arg0.idle_x) >= arg1, 701);
        assert_u64_headroom(arg0.deployed_x, arg1);
        arg0.deployed_x = arg0.deployed_x + arg1;
        0x2::balance::split<T0>(&mut arg0.idle_x, arg1)
    }

    public(friend) fun deploy_y<T0, T1>(arg0: &mut Custody<T0, T1>, arg1: u64) : 0x2::balance::Balance<T1> {
        assert!(0x2::balance::value<T1>(&arg0.idle_y) >= arg1, 701);
        assert_u64_headroom(arg0.deployed_y, arg1);
        arg0.deployed_y = arg0.deployed_y + arg1;
        0x2::balance::split<T1>(&mut arg0.idle_y, arg1)
    }

    public fun deployed_x<T0, T1>(arg0: &Custody<T0, T1>) : u64 {
        arg0.deployed_x
    }

    public fun deployed_y<T0, T1>(arg0: &Custody<T0, T1>) : u64 {
        arg0.deployed_y
    }

    public(friend) fun deposit_x<T0, T1>(arg0: &mut Custody<T0, T1>, arg1: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<XToken<T0>> {
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert_u64_headroom(0x2::balance::value<T0>(&arg0.idle_x), v0);
        assert_u64_headroom(0x2::balance::supply_value<XToken<T0>>(&arg0.supply_x), v0);
        0x2::balance::join<T0>(&mut arg0.idle_x, arg1);
        0x2::balance::increase_supply<XToken<T0>>(&mut arg0.supply_x, v0)
    }

    public(friend) fun deposit_y<T0, T1>(arg0: &mut Custody<T0, T1>, arg1: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<YToken<T1>> {
        let v0 = 0x2::balance::value<T1>(&arg1);
        assert_u64_headroom(0x2::balance::value<T1>(&arg0.idle_y), v0);
        assert_u64_headroom(0x2::balance::supply_value<YToken<T1>>(&arg0.supply_y), v0);
        0x2::balance::join<T1>(&mut arg0.idle_y, arg1);
        0x2::balance::increase_supply<YToken<T1>>(&mut arg0.supply_y, v0)
    }

    public fun idle_value_x<T0, T1>(arg0: &Custody<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.idle_x)
    }

    public fun idle_value_y<T0, T1>(arg0: &Custody<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.idle_y)
    }

    public fun new<T0, T1>() : Custody<T0, T1> {
        let v0 = XToken<T0>{dummy_field: false};
        let v1 = YToken<T1>{dummy_field: false};
        Custody<T0, T1>{
            idle_x     : 0x2::balance::zero<T0>(),
            idle_y     : 0x2::balance::zero<T1>(),
            deployed_x : 0,
            deployed_y : 0,
            supply_x   : 0x2::balance::create_supply<XToken<T0>>(v0),
            supply_y   : 0x2::balance::create_supply<YToken<T1>>(v1),
        }
    }

    public(friend) fun realize_loss_x<T0, T1>(arg0: &mut Custody<T0, T1>, arg1: 0x2::balance::Balance<XToken<T0>>) : u64 {
        let v0 = 0x2::balance::decrease_supply<XToken<T0>>(&mut arg0.supply_x, arg1);
        let v1 = if (arg0.deployed_x >= v0) {
            arg0.deployed_x - v0
        } else {
            0
        };
        arg0.deployed_x = v1;
        v0
    }

    public(friend) fun realize_loss_y<T0, T1>(arg0: &mut Custody<T0, T1>, arg1: 0x2::balance::Balance<YToken<T1>>) : u64 {
        let v0 = 0x2::balance::decrease_supply<YToken<T1>>(&mut arg0.supply_y, arg1);
        let v1 = if (arg0.deployed_y >= v0) {
            arg0.deployed_y - v0
        } else {
            0
        };
        arg0.deployed_y = v1;
        v0
    }

    public(friend) fun recall_x<T0, T1>(arg0: &mut Custody<T0, T1>, arg1: 0x2::balance::Balance<T0>) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert_u64_headroom(0x2::balance::value<T0>(&arg0.idle_x), v0);
        let v1 = if (v0 > arg0.deployed_x) {
            v0 - arg0.deployed_x
        } else {
            0
        };
        let v2 = if (arg0.deployed_x >= v0) {
            arg0.deployed_x - v0
        } else {
            0
        };
        arg0.deployed_x = v2;
        0x2::balance::join<T0>(&mut arg0.idle_x, arg1);
        v1
    }

    public(friend) fun recall_y<T0, T1>(arg0: &mut Custody<T0, T1>, arg1: 0x2::balance::Balance<T1>) : u64 {
        let v0 = 0x2::balance::value<T1>(&arg1);
        assert_u64_headroom(0x2::balance::value<T1>(&arg0.idle_y), v0);
        let v1 = if (v0 > arg0.deployed_y) {
            v0 - arg0.deployed_y
        } else {
            0
        };
        let v2 = if (arg0.deployed_y >= v0) {
            arg0.deployed_y - v0
        } else {
            0
        };
        arg0.deployed_y = v2;
        0x2::balance::join<T1>(&mut arg0.idle_y, arg1);
        v1
    }

    public(friend) fun reduce_deployed_x<T0, T1>(arg0: &mut Custody<T0, T1>, arg1: u64) {
        assert!(arg0.deployed_x >= arg1, 702);
        arg0.deployed_x = arg0.deployed_x - arg1;
    }

    public(friend) fun reduce_deployed_y<T0, T1>(arg0: &mut Custody<T0, T1>, arg1: u64) {
        assert!(arg0.deployed_y >= arg1, 702);
        arg0.deployed_y = arg0.deployed_y - arg1;
    }

    public(friend) fun withdraw_reserved_yield_x<T0, T1>(arg0: &mut Custody<T0, T1>, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T0>(&arg0.idle_x);
        let v1 = 0x2::balance::supply_value<XToken<T0>>(&arg0.supply_x);
        assert!(v0 >= v1 && arg1 <= v0 - v1, 701);
        0x2::balance::split<T0>(&mut arg0.idle_x, arg1)
    }

    public(friend) fun withdraw_reserved_yield_y<T0, T1>(arg0: &mut Custody<T0, T1>, arg1: u64) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T1>(&arg0.idle_y);
        let v1 = 0x2::balance::supply_value<YToken<T1>>(&arg0.supply_y);
        assert!(v0 >= v1 && arg1 <= v0 - v1, 701);
        0x2::balance::split<T1>(&mut arg0.idle_y, arg1)
    }

    public fun withdraw_x<T0, T1>(arg0: &mut Custody<T0, T1>, arg1: 0x2::balance::Balance<XToken<T0>>) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::decrease_supply<XToken<T0>>(&mut arg0.supply_x, arg1);
        assert!(0x2::balance::value<T0>(&arg0.idle_x) >= v0, 701);
        0x2::balance::split<T0>(&mut arg0.idle_x, v0)
    }

    public fun withdraw_y<T0, T1>(arg0: &mut Custody<T0, T1>, arg1: 0x2::balance::Balance<YToken<T1>>) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::decrease_supply<YToken<T1>>(&mut arg0.supply_y, arg1);
        assert!(0x2::balance::value<T1>(&arg0.idle_y) >= v0, 701);
        0x2::balance::split<T1>(&mut arg0.idle_y, v0)
    }

    // decompiled from Move bytecode v7
}

