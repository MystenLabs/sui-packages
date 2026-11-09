module 0x9706b4bf932a2e4e27e858ea562262abe001db18121c0fd3afc6f16537f8de1d::parlay_router {
    struct ParlayBought has copy, drop {
        ticket_id: 0x2::object::ID,
        buyer: address,
        stake_mist: u64,
        payout_mist: u64,
        combined_price_wad: u64,
        leg_count: u8,
    }

    struct TicketSettled has copy, drop {
        ticket_id: 0x2::object::ID,
        owner: address,
        won: bool,
        payout_mist: u64,
    }

    fun build_leg_summary(arg0: &vector<u8>) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            if (v1 > 0) {
                0x1::string::append(&mut v0, 0x1::string::utf8(b", "));
            };
            if (*0x1::vector::borrow<u8>(arg0, v1) == 1) {
                0x1::string::append(&mut v0, 0x1::string::utf8(b"Home"));
            } else {
                0x1::string::append(&mut v0, 0x1::string::utf8(b"Away"));
            };
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun buy_parlay(arg0: vector<address>, arg1: vector<u64>, arg2: vector<u8>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &mut 0x9706b4bf932a2e4e27e858ea562262abe001db18121c0fd3afc6f16537f8de1d::parlay_vault::Treasury, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg0);
        assert!(v0 >= 1 && v0 <= 5, 0);
        assert!(0x1::vector::length<u64>(&arg1) == v0, 1);
        assert!(0x1::vector::length<u8>(&arg2) == v0, 1);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v1 > 0, 5);
        let v2 = (1000000000 as u128);
        let v3 = 0x1::vector::empty<0x9706b4bf932a2e4e27e858ea562262abe001db18121c0fd3afc6f16537f8de1d::parlay_vault::Leg>();
        let v4 = 0;
        while (v4 < v0) {
            let v5 = *0x1::vector::borrow<u8>(&arg2, v4);
            assert!(v5 == 1 || v5 == 2, 3);
            let v6 = *0x1::vector::borrow<u64>(&arg1, v4);
            assert!(v6 > 0 && v6 < 1000000000 * 100, 6);
            let v7 = v2 * (1000000000 as u128) * (1000000000 as u128) / (v6 as u128);
            v2 = v7 / (1000000000 as u128);
            0x1::vector::push_back<0x9706b4bf932a2e4e27e858ea562262abe001db18121c0fd3afc6f16537f8de1d::parlay_vault::Leg>(&mut v3, 0x9706b4bf932a2e4e27e858ea562262abe001db18121c0fd3afc6f16537f8de1d::parlay_vault::new_leg(0x2::object::id_from_address(*0x1::vector::borrow<address>(&arg0, v4)), v5, v6));
            v4 = v4 + 1;
        };
        let v8 = ((v2 * (100 as u128) / (110 as u128)) as u64);
        assert!(v8 > 0, 6);
        let v9 = (((v1 as u128) * (1000000000 as u128) / (v8 as u128)) as u64);
        assert!(v9 >= arg4, 4);
        assert!(v9 > v1, 7);
        let v10 = 0x2::tx_context::sender(arg8);
        let v11 = ParlayBought{
            ticket_id          : 0x9706b4bf932a2e4e27e858ea562262abe001db18121c0fd3afc6f16537f8de1d::parlay_vault::mint_ticket(arg5, arg3, v9, v3, arg6, build_leg_summary(&arg2), format_sui(v9), 0x2::clock::timestamp_ms(arg7), v10, arg8),
            buyer              : v10,
            stake_mist         : v1,
            payout_mist        : v9,
            combined_price_wad : (v2 as u64),
            leg_count          : (v0 as u8),
        };
        0x2::event::emit<ParlayBought>(v11);
    }

    public entry fun cash_out_ticket(arg0: 0x9706b4bf932a2e4e27e858ea562262abe001db18121c0fd3afc6f16537f8de1d::parlay_vault::Ticket, arg1: &mut 0x9706b4bf932a2e4e27e858ea562262abe001db18121c0fd3afc6f16537f8de1d::parlay_vault::Treasury, arg2: &mut 0x2::tx_context::TxContext) {
        0x9706b4bf932a2e4e27e858ea562262abe001db18121c0fd3afc6f16537f8de1d::parlay_vault::cash_out(arg1, arg0, 0x9706b4bf932a2e4e27e858ea562262abe001db18121c0fd3afc6f16537f8de1d::parlay_vault::ticket_stake(&arg0) / 2, arg2);
    }

    fun format_sui(arg0: u64) : 0x1::string::String {
        let v0 = arg0 % 1000000000 / 10000000;
        let v1 = to_string_u64(arg0 / 1000000000);
        0x1::string::append(&mut v1, 0x1::string::utf8(b"."));
        if (v0 < 10) {
            0x1::string::append(&mut v1, 0x1::string::utf8(b"0"));
        };
        0x1::string::append(&mut v1, to_string_u64(v0));
        0x1::string::append(&mut v1, 0x1::string::utf8(b" SUI"));
        v1
    }

    public fun quote_parlay(arg0: vector<u64>, arg1: vector<u8>, arg2: u64) : (u64, u64) {
        let v0 = 0x1::vector::length<u64>(&arg0);
        assert!(v0 == 0x1::vector::length<u8>(&arg1), 1);
        let v1 = (1000000000 as u128);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = v1 * (1000000000 as u128) * (1000000000 as u128) / (*0x1::vector::borrow<u64>(&arg0, v2) as u128);
            v1 = v3 / (1000000000 as u128);
            v2 = v2 + 1;
        };
        ((v1 as u64), (((arg2 as u128) * (1000000000 as u128) / v1 * (100 as u128) / (110 as u128)) as u64))
    }

    public entry fun settle_lost(arg0: &0x9706b4bf932a2e4e27e858ea562262abe001db18121c0fd3afc6f16537f8de1d::prediction_market::AdminCap, arg1: &mut 0x9706b4bf932a2e4e27e858ea562262abe001db18121c0fd3afc6f16537f8de1d::parlay_vault::Ticket) {
        0x9706b4bf932a2e4e27e858ea562262abe001db18121c0fd3afc6f16537f8de1d::parlay_vault::mark_lost(arg1);
        let v0 = TicketSettled{
            ticket_id   : 0x2::object::id<0x9706b4bf932a2e4e27e858ea562262abe001db18121c0fd3afc6f16537f8de1d::parlay_vault::Ticket>(arg1),
            owner       : 0x9706b4bf932a2e4e27e858ea562262abe001db18121c0fd3afc6f16537f8de1d::parlay_vault::ticket_owner(arg1),
            won         : false,
            payout_mist : 0,
        };
        0x2::event::emit<TicketSettled>(v0);
    }

    public entry fun settle_won(arg0: &0x9706b4bf932a2e4e27e858ea562262abe001db18121c0fd3afc6f16537f8de1d::prediction_market::AdminCap, arg1: &mut 0x9706b4bf932a2e4e27e858ea562262abe001db18121c0fd3afc6f16537f8de1d::parlay_vault::Ticket) {
        0x9706b4bf932a2e4e27e858ea562262abe001db18121c0fd3afc6f16537f8de1d::parlay_vault::mark_won(arg1);
        let v0 = TicketSettled{
            ticket_id   : 0x2::object::id<0x9706b4bf932a2e4e27e858ea562262abe001db18121c0fd3afc6f16537f8de1d::parlay_vault::Ticket>(arg1),
            owner       : 0x9706b4bf932a2e4e27e858ea562262abe001db18121c0fd3afc6f16537f8de1d::parlay_vault::ticket_owner(arg1),
            won         : true,
            payout_mist : 0x9706b4bf932a2e4e27e858ea562262abe001db18121c0fd3afc6f16537f8de1d::parlay_vault::ticket_payout(arg1),
        };
        0x2::event::emit<TicketSettled>(v0);
    }

    fun to_string_u64(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = b"";
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v7
}

