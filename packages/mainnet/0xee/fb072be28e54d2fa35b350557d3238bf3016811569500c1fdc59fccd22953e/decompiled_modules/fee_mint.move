module 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::fee_mint {
    public fun mint_on_loss<T0, T1, T2: drop>(arg0: T2, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg3: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>, arg4: 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::fees::LossTicket, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, address, u64, u64, 0x2::coin::Coin<T1>) {
        let v0 = 0x1::type_name::with_original_ids<T2>();
        let v1 = 0x1::type_name::with_original_ids<T1>();
        assert!(0x1::type_name::address_string(&v0) == 0x1::type_name::address_string(&v1), 13835621383192969221);
        let v2 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid<T0>(arg1));
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::assert_version<T0>(arg1);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::assert_exchange<T0>(arg3, 0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>>(arg1));
        let v3 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::fees::account_id(&arg4);
        assert!(0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::Account<T0>>(arg3) == v3, 13835058459009089537);
        let v4 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::fees::settle_loss_ticket(arg4);
        let v5 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::account::owner<T0>(arg3);
        if (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::category_paused(arg2, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::pause_fee_mint())) {
            if (v4 > 0) {
                0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::add_pending_basis<T0>(&v2, arg1, v3, v4);
            };
            return (v3, v5, 0, 0, 0x2::coin::zero<T1>(arg6))
        };
        let v6 = (0x1::u256::min(minted_out_wide(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::tail_progress<T0>(arg1), v4), ((18446744073709551615 - 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::reward_supply<T0, T1>(arg1)) as u256)) as u64);
        let v7 = if (v6 == 0) {
            0x2::coin::zero<T1>(arg6)
        } else {
            0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::mint_reward<T0, T1>(&v2, arg1, v6, arg6)
        };
        if (v6 > 0 && 0x2::tx_context::sender(arg6) != v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v7, v5);
            return (v3, v5, v4, v6, 0x2::coin::zero<T1>(arg6))
        };
        (v3, v5, v4, v6, v7)
    }

    public fun minted_out(arg0: u64, arg1: u64) : u64 {
        let v0 = minted_out_wide(arg0, arg1);
        assert!(v0 <= (18446744073709551615 as u256), 13835339706352664579);
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

    // decompiled from Move bytecode v7
}

