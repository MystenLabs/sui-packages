module 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::fee_mint {
    public fun mint_on_loss<T0, T1, T2: drop>(arg0: T2, arg1: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::Exchange<T0>, arg2: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>, arg3: 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::fees::LossTicket, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, address, u64, u64, 0x2::coin::Coin<T1>) {
        let v0 = 0x1::type_name::with_original_ids<T2>();
        let v1 = 0x1::type_name::with_original_ids<T1>();
        assert!(0x1::type_name::address_string(&v0) == 0x1::type_name::address_string(&v1), 13835621340243296261);
        let v2 = 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::auth::issue(0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::uid<T0>(arg1));
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::assert_version<T0>(arg1);
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::assert_exchange<T0>(arg2, 0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::Exchange<T0>>(arg1));
        let v3 = 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::fees::account_id(&arg3);
        assert!(0x2::object::id<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::Account<T0>>(arg2) == v3, 13835058416059416577);
        let v4 = 0xa353c0dda52b6527a6e0e9d42d069faa525b7cf9b067cc509eeb4c43417607d4::fees::settle_loss_ticket(arg3);
        let v5 = 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::account::owner<T0>(arg2);
        let v6 = 0x1::u64::min(minted_out(0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::tracked_lp<T0>(arg1), 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::tail_progress<T0>(arg1), v4), 18446744073709551615 - 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::reward_supply<T0, T1>(arg1));
        let v7 = if (v6 == 0) {
            0x2::coin::zero<T1>(arg5)
        } else {
            0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::mint_reward<T0, T1>(&v2, arg1, v6, arg5)
        };
        if (v6 > 0 && 0x2::tx_context::sender(arg5) != v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v7, v5);
            return (v3, v5, v4, v6, 0x2::coin::zero<T1>(arg5))
        };
        (v3, v5, v4, v6, v7)
    }

    public fun minted_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        if (arg0 < 2000000000000) {
            let v0 = (arg2 as u128) * (100000 as u128);
            assert!(v0 <= (18446744073709551615 as u128), 13835339706352664579);
            return (v0 as u64)
        };
        let v1 = (120000000000000 as u256);
        let v2 = v1 + (arg1 as u256);
        let v3 = (arg2 as u256) * (100000 as u256) * v1 * v1 / v2 * v2;
        assert!(v3 <= (18446744073709551615 as u256), 13835339732122468355);
        (v3 as u64)
    }

    // decompiled from Move bytecode v7
}

