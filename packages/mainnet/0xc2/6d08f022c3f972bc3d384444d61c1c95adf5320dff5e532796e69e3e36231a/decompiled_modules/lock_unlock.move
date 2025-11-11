module 0xc26d08f022c3f972bc3d384444d61c1c95adf5320dff5e532796e69e3e36231a::lock_unlock {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Reserves<phantom T0> has key {
        id: 0x2::object::UID,
        coin_balance: 0x2::balance::Balance<T0>,
        fee_balance: 0x2::balance::Balance<T0>,
        total_locked: u64,
        total_nest_minted: u64,
        total_fees_collected: u64,
    }

    public fun create_reserves<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Reserves<T0>{
            id                   : 0x2::object::new(arg1),
            coin_balance         : 0x2::balance::zero<T0>(),
            fee_balance          : 0x2::balance::zero<T0>(),
            total_locked         : 0,
            total_nest_minted    : 0,
            total_fees_collected : 0,
        };
        0x2::transfer::share_object<Reserves<T0>>(v0);
    }

    public fun get_coin_balance<T0>(arg0: &Reserves<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.coin_balance)
    }

    public fun get_fee_balance<T0>(arg0: &Reserves<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.fee_balance)
    }

    public fun get_fees_collected<T0>(arg0: &Reserves<T0>) : u64 {
        arg0.total_fees_collected
    }

    public fun get_total_locked<T0>(arg0: &Reserves<T0>) : u64 {
        arg0.total_locked
    }

    public fun get_total_minted<T0>(arg0: &Reserves<T0>) : u64 {
        arg0.total_nest_minted
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun lock<T0>(arg0: &mut 0x2::coin::TreasuryCap<0xc26d08f022c3f972bc3d384444d61c1c95adf5320dff5e532796e69e3e36231a::nest::NEST>, arg1: &mut Reserves<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 % 3 == 0, 1);
        let v1 = v0 * 50 / 10000;
        let v2 = (v0 - v1) / 3;
        0x2::balance::join<T0>(&mut arg1.fee_balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v1, arg3)));
        0x2::balance::join<T0>(&mut arg1.coin_balance, 0x2::coin::into_balance<T0>(arg2));
        arg1.total_locked = arg1.total_locked + v0;
        arg1.total_nest_minted = arg1.total_nest_minted + v2;
        arg1.total_fees_collected = arg1.total_fees_collected + v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc26d08f022c3f972bc3d384444d61c1c95adf5320dff5e532796e69e3e36231a::nest::NEST>>(0x2::coin::mint<0xc26d08f022c3f972bc3d384444d61c1c95adf5320dff5e532796e69e3e36231a::nest::NEST>(arg0, v2, arg3), 0x2::tx_context::sender(arg3));
    }

    public fun unlock<T0>(arg0: &mut 0x2::coin::TreasuryCap<0xc26d08f022c3f972bc3d384444d61c1c95adf5320dff5e532796e69e3e36231a::nest::NEST>, arg1: &mut Reserves<T0>, arg2: 0x2::coin::Coin<0xc26d08f022c3f972bc3d384444d61c1c95adf5320dff5e532796e69e3e36231a::nest::NEST>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xc26d08f022c3f972bc3d384444d61c1c95adf5320dff5e532796e69e3e36231a::nest::NEST>(&arg2);
        let v1 = v0 * 3;
        let v2 = v1 * 50 / 10000;
        assert!(0x2::balance::value<T0>(&arg1.coin_balance) >= v1, 2);
        0x2::coin::burn<0xc26d08f022c3f972bc3d384444d61c1c95adf5320dff5e532796e69e3e36231a::nest::NEST>(arg0, arg2);
        0x2::balance::join<T0>(&mut arg1.fee_balance, 0x2::balance::split<T0>(&mut arg1.coin_balance, v2));
        arg1.total_locked = arg1.total_locked - v1;
        arg1.total_nest_minted = arg1.total_nest_minted - v0;
        arg1.total_fees_collected = arg1.total_fees_collected + v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.coin_balance, v1 - v2), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun withdraw_fees<T0>(arg0: &AdminCap, arg1: &mut Reserves<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.fee_balance), arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

