module 0x76841ebd0d78e71e8aa1eab06443b91c2ef0498e0675a2119e11bc05c2f570a8::lottery_management {
    struct Lottery has store {
        ticket_price_sui: u64,
        ticket_price_token: u64,
        tickets_sold_sui: u64,
        tickets_sold_token: u64,
        dev_wallet: address,
        token_project: address,
        sui_token: address,
        fee_percentage: u64,
        prize_pool_sui: u64,
        prize_pool_token: u64,
        winners_sui: vector<address>,
        winners_token: vector<address>,
        end_time: u64,
        marketing_pool_sui: u64,
        marketing_pool_token: u64,
    }

    public fun buy_ticket_sui(arg0: &mut Lottery, arg1: address, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(is_lottery_active(arg0, arg3), 0);
        let v0 = arg2 * arg0.ticket_price_sui;
        assert!(v0 > 0, 1);
        let v1 = v0 * arg0.fee_percentage / 100;
        arg0.tickets_sold_sui = arg0.tickets_sold_sui + arg2;
        arg0.prize_pool_sui = arg0.prize_pool_sui + v0 - v1;
        arg0.marketing_pool_sui = arg0.marketing_pool_sui + v1;
        transfer_to_dev(arg0, arg0.dev_wallet, 0, 0);
    }

    public fun buy_ticket_token(arg0: &mut Lottery, arg1: address, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(is_lottery_active(arg0, arg3), 0);
        let v0 = arg2 * arg0.ticket_price_token;
        assert!(v0 > 0, 1);
        let v1 = v0 * arg0.fee_percentage / 100;
        arg0.tickets_sold_token = arg0.tickets_sold_token + arg2;
        arg0.prize_pool_token = arg0.prize_pool_token + v0 - v1;
        arg0.marketing_pool_token = arg0.marketing_pool_token + v1;
        transfer_to_dev(arg0, arg0.dev_wallet, 0, 0);
    }

    public fun create_lottery(arg0: address, arg1: address, arg2: address, arg3: u64, arg4: u64) : Lottery {
        Lottery{
            ticket_price_sui     : 1,
            ticket_price_token   : 10000000,
            tickets_sold_sui     : 0,
            tickets_sold_token   : 0,
            dev_wallet           : arg0,
            token_project        : arg1,
            sui_token            : arg2,
            fee_percentage       : arg3,
            prize_pool_sui       : 0,
            prize_pool_token     : 0,
            winners_sui          : 0x1::vector::empty<address>(),
            winners_token        : 0x1::vector::empty<address>(),
            end_time             : arg4,
            marketing_pool_sui   : 0,
            marketing_pool_token : 0,
        }
    }

    public fun draw_winners(arg0: &mut Lottery, arg1: vector<address>, arg2: vector<address>) {
        assert!(0x1::vector::length<address>(&arg1) == 3, 2);
        assert!(0x1::vector::length<address>(&arg2) == 3, 3);
        let v0 = arg0.prize_pool_sui * 10 / 100;
        let v1 = arg0.prize_pool_token * 10 / 100;
        let v2 = (arg0.prize_pool_sui - v0) / 3;
        let v3 = (arg0.prize_pool_token - v1) / 3;
        0x1::vector::push_back<address>(&mut arg0.winners_sui, *0x1::vector::borrow<address>(&arg1, 0));
        0x1::vector::push_back<address>(&mut arg0.winners_sui, *0x1::vector::borrow<address>(&arg1, 1));
        0x1::vector::push_back<address>(&mut arg0.winners_sui, *0x1::vector::borrow<address>(&arg1, 2));
        0x1::vector::push_back<address>(&mut arg0.winners_token, *0x1::vector::borrow<address>(&arg2, 0));
        0x1::vector::push_back<address>(&mut arg0.winners_token, *0x1::vector::borrow<address>(&arg2, 1));
        0x1::vector::push_back<address>(&mut arg0.winners_token, *0x1::vector::borrow<address>(&arg2, 2));
        transfer_to_winner(*0x1::vector::borrow<address>(&arg1, 0), v2, 0);
        transfer_to_winner(*0x1::vector::borrow<address>(&arg1, 1), v2, 0);
        transfer_to_winner(*0x1::vector::borrow<address>(&arg1, 2), v2, 0);
        transfer_to_winner(*0x1::vector::borrow<address>(&arg2, 0), 0, v3);
        transfer_to_winner(*0x1::vector::borrow<address>(&arg2, 1), 0, v3);
        transfer_to_winner(*0x1::vector::borrow<address>(&arg2, 2), 0, v3);
        transfer_to_dev(arg0, arg0.dev_wallet, v0, v1);
    }

    public fun get_current_timestamp(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0)
    }

    public fun is_dev(arg0: &Lottery, arg1: address) : bool {
        arg1 == arg0.dev_wallet
    }

    public fun is_lottery_active(arg0: &Lottery, arg1: &0x2::clock::Clock) : bool {
        get_current_timestamp(arg1) < arg0.end_time
    }

    public fun transfer_to_dev(arg0: &Lottery, arg1: address, arg2: u64, arg3: u64) {
        assert!(is_dev(arg0, arg1), 100);
        transfer_to_dev_pool(arg1, arg2, arg3);
    }

    public fun transfer_to_dev_pool(arg0: address, arg1: u64, arg2: u64) {
    }

    public fun transfer_to_winner(arg0: address, arg1: u64, arg2: u64) {
    }

    // decompiled from Move bytecode v6
}

