module 0x55a151305f444f8a39e761298cbd468fa613174447eb4ab5a8139c57b15e7fa3::tipping {
    struct TipSent has copy, drop {
        from: address,
        to: address,
        amount: u64,
        fee: u64,
        net_amount: u64,
        message: vector<u8>,
        timestamp: u64,
    }

    public fun get_min_tip_amount() : u64 {
        1000000
    }

    public fun tip<T0>(arg0: &mut 0x55a151305f444f8a39e761298cbd468fa613174447eb4ab5a8139c57b15e7fa3::platform::Platform, arg1: &mut 0x55a151305f444f8a39e761298cbd468fa613174447eb4ab5a8139c57b15e7fa3::creator::CreatorProfile<T0>, arg2: 0x2::coin::Coin<T0>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x55a151305f444f8a39e761298cbd468fa613174447eb4ab5a8139c57b15e7fa3::creator::get_owner<T0>(arg1);
        assert!(v0 != v1, 1);
        let v2 = 0x2::coin::value<T0>(&arg2);
        assert!(v2 >= 1000000, 0);
        let v3 = 0x55a151305f444f8a39e761298cbd468fa613174447eb4ab5a8139c57b15e7fa3::platform::calculate_fee(arg0, v2);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v3, arg5), @0x0);
        };
        0x55a151305f444f8a39e761298cbd468fa613174447eb4ab5a8139c57b15e7fa3::platform::record_tip(arg0, v2, v3);
        0x55a151305f444f8a39e761298cbd468fa613174447eb4ab5a8139c57b15e7fa3::creator::receive_tip<T0>(arg1, 0x2::coin::into_balance<T0>(arg2));
        let v4 = TipSent{
            from       : v0,
            to         : v1,
            amount     : v2,
            fee        : v3,
            net_amount : v2 - v3,
            message    : arg3,
            timestamp  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<TipSent>(v4);
    }

    public fun tip_amount<T0>(arg0: &mut 0x55a151305f444f8a39e761298cbd468fa613174447eb4ab5a8139c57b15e7fa3::platform::Platform, arg1: &mut 0x55a151305f444f8a39e761298cbd468fa613174447eb4ab5a8139c57b15e7fa3::creator::CreatorProfile<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg3 >= 1000000, 0);
        assert!(0x2::coin::value<T0>(&arg2) >= arg3, 0);
        let v0 = 0x2::coin::split<T0>(&mut arg2, arg3, arg6);
        tip<T0>(arg0, arg1, v0, arg4, arg5, arg6);
        arg2
    }

    // decompiled from Move bytecode v6
}

