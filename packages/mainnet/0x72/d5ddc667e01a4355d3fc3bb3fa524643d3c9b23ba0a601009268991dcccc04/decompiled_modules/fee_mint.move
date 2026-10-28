module 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fee_mint {
    public fun mint_on_loss<T0, T1, T2: drop>(arg0: T2, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg4: 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fees::LossTicket, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, address, u64, u64, 0x2::coin::Coin<T1>) {
        let v0 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::reward_supply<T0, T1>(arg1);
        let v1 = 0x1::type_name::with_original_ids<T2>();
        let v2 = 0x1::type_name::with_original_ids<T1>();
        assert!(0x1::type_name::address_string(&v1) == 0x1::type_name::address_string(&v2), 13835621434732576773);
        let v3 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg1));
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg1);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::assert_exchange<T0>(arg3, 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>>(arg1));
        let v4 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fees::account_id(&arg4);
        assert!(0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>>(arg3) == v4, 13835058510548697089);
        let (v5, v6) = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::fees::settle_parked(arg4);
        let v7 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::owner<T0>(arg3);
        if (0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::category_paused(arg2, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::pause_fee_mint())) {
            if (v6) {
                0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::add_pending_basis<T0>(&v3, arg1, v4, v5);
            } else {
                park<T0>(&v3, arg1, v4, v5, 0x2::clock::timestamp_ms(arg5));
            };
            return (v4, v7, 0, 0, 0x2::coin::zero<T1>(arg6))
        };
        let v8 = (0x1::u256::min(ticket_mint(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::tail_progress<T0>(arg1), v5), ((18446744073709551615 - v0) as u256)) as u64);
        let v9 = v8;
        if (v6) {
            let (v10, v11) = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::locked_mint::take_reserve<T0>(&v3, arg1, v4, v8);
            let v12 = v10;
            let v13 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::locked_mint::parts_total(&v12);
            v9 = v13;
            if (v13 > 0) {
                0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::locked_mint::lock_reserved<T0, T1>(&v3, arg1, v7, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::mint_reward<T0, T1>(&v3, arg1, v13, arg6), v5, v12, v11, 0x2::clock::timestamp_ms(arg5), arg6);
            };
        } else if (v8 > 0) {
            0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::locked_mint::lock_loss<T0, T1>(&v3, arg1, v7, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::mint_reward<T0, T1>(&v3, arg1, v8, arg6), v5, 0x2::clock::timestamp_ms(arg5), arg6);
        };
        (v4, v7, v5, v9, 0x2::coin::zero<T1>(arg6))
    }

    public fun minted_out(arg0: u64, arg1: u64) : u64 {
        let v0 = minted_out_wide(arg0, arg1);
        assert!(v0 <= (18446744073709551615 as u256), 13835339710647631875);
        (v0 as u64)
    }

    fun minted_out_wide(arg0: u64, arg1: u64) : u256 {
        if (arg1 == 0) {
            return 0
        };
        if (arg0 == 0) {
            return (arg1 as u256) * (100000 as u256)
        };
        let v0 = (120000000000000 as u256);
        let v1 = v0 + (arg0 as u256);
        (arg1 as u256) * (100000 as u256) * v0 * v0 / v1 * v1
    }

    public(friend) fun park<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: u64) {
        if (arg3 == 0) {
            return
        };
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::add_pending_basis<T0>(arg0, arg1, arg2, arg3);
        0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::locked_mint::reserve<T0>(arg0, arg1, arg2, (0x1::u256::min(ticket_mint(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::tail_progress<T0>(arg1), arg3), (18446744073709551615 as u256)) as u64), arg3, arg4);
    }

    fun ticket_mint(arg0: u64, arg1: u64) : u256 {
        minted_out_wide(arg0, arg1)
    }

    // decompiled from Move bytecode v7
}

