module 0x259e9a6b98c503f64d28fadca377956639a68691c59a0fa6090769a5e83ec1cb::place {
    struct Place<phantom T0> has store, key {
        id: 0x2::object::UID,
        fee: u64,
        odds: u64,
        admin: address,
        receiver: address,
        prize_pool: 0x2::balance::Balance<T0>,
    }

    entry fun create<T0>(arg0: u64, arg1: u64, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 <= 10000, 0);
        let v0 = Place<T0>{
            id         : 0x2::object::new(arg4),
            fee        : arg0,
            odds       : arg1,
            admin      : arg2,
            receiver   : arg3,
            prize_pool : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Place<T0>>(v0);
    }

    public fun fee<T0>(arg0: &Place<T0>) : u64 {
        arg0.fee
    }

    entry fun inject<T0>(arg0: &mut Place<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 1);
        0x2::balance::join<T0>(&mut arg0.prize_pool, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, arg2, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg3));
    }

    public fun odds<T0>(arg0: &Place<T0>) : u64 {
        arg0.odds
    }

    public fun prize_pool<T0>(arg0: &Place<T0>) : &0x2::balance::Balance<T0> {
        &arg0.prize_pool
    }

    public(friend) fun prize_pool_mut<T0>(arg0: &mut Place<T0>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.prize_pool
    }

    public fun receiver<T0>(arg0: &Place<T0>) : address {
        arg0.receiver
    }

    entry fun update<T0>(arg0: &mut Place<T0>, arg1: u64, arg2: u64, arg3: address, arg4: address, arg5: &0x2::tx_context::TxContext) {
        assert!(arg1 <= 10000, 0);
        assert!(0x2::tx_context::sender(arg5) == arg0.admin, 2);
        arg0.fee = arg1;
        arg0.odds = arg2;
        arg0.admin = arg3;
        arg0.receiver = arg4;
    }

    // decompiled from Move bytecode v6
}

