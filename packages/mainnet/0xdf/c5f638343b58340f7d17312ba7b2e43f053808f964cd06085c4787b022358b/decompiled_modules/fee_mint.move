module 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::fee_mint {
    public fun mint_on_loss<T0, T1>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::Account<T0>, arg2: 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::fees::LossTicket, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, address, u64, u64, 0x2::coin::Coin<T1>) {
        let v0 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::auth::issue(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::uid<T0>(arg0));
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::assert_version<T0>(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::assert_exchange<T0>(arg1, 0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>>(arg0));
        let v1 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::fees::account_id(&arg2);
        assert!(0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::Account<T0>>(arg1) == v1, 13835058338750005249);
        let v2 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::fees::settle_loss_ticket(arg2);
        let v3 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::owner<T0>(arg1);
        let v4 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::account::take_mint<T0>(&v0, arg1, minted_out(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::tracked_lp<T0>(arg0), 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::tail_progress<T0>(arg0), v2), arg3);
        let v5 = if (v4 == 0) {
            0x2::coin::zero<T1>(arg4)
        } else {
            0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::mint_reward<T0, T1>(&v0, arg0, v4, arg4)
        };
        if (v4 > 0 && 0x2::tx_context::sender(arg4) != v3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v5, v3);
            return (v1, v3, v2, v4, 0x2::coin::zero<T1>(arg4))
        };
        (v1, v3, v2, v4, v5)
    }

    public fun minted_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        if (arg0 < 2000000000000) {
            let v0 = (arg2 as u128) * (100000 as u128);
            assert!(v0 <= (18446744073709551615 as u128), 13835339693467762691);
            return (v0 as u64)
        };
        let v1 = (120000000000000 as u256);
        let v2 = v1 + (arg1 as u256);
        let v3 = (arg2 as u256) * (100000 as u256) * v1 * v1 / v2 * v2;
        assert!(v3 <= (18446744073709551615 as u256), 13835339719237566467);
        (v3 as u64)
    }

    // decompiled from Move bytecode v7
}

