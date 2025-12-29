module 0x6fb2ecfe3c83a60b727d371ba27c9890ed0c9ef4db322301ae7f41b55f2df34a::chan_lottery {
    struct Lottery has store, key {
        id: 0x2::object::UID,
        admin: address,
        p: u64,
        alpha: u64,
        ticket_price: u64,
        pot: 0x2::balance::Balance<0x2::sui::SUI>,
        admin_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        total_tickets_sold: u64,
        total_payouts_count: u64,
        total_sui_won: u64,
    }

    struct ScratchTicket has store, key {
        id: 0x2::object::UID,
        lottery_id: 0x2::object::ID,
        owner: address,
        p: u64,
        alpha: u64,
        x0: u64,
        x1: u64,
        x2: u64,
        x3: u64,
    }

    struct WinReceipt has store, key {
        id: 0x2::object::UID,
        lottery_id: 0x2::object::ID,
        winner: address,
    }

    struct TicketPurchasedEvent has copy, drop {
        lottery_id: 0x2::object::ID,
        buyer: address,
        ticket_price: u64,
    }

    struct TicketScratchedEvent has copy, drop {
        lottery_id: 0x2::object::ID,
        player: address,
        win: bool,
    }

    struct JackpotWonEvent has copy, drop {
        lottery_id: 0x2::object::ID,
        winner: address,
        total_pot: u64,
        winner_share: u64,
        admin_fee: u64,
    }

    entry fun admin_withdraw_pot(arg0: &mut Lottery, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.pot, arg1, arg2), arg0.admin);
    }

    fun apply_rank1_matrix(arg0: &vector<u64>, arg1: &vector<u64>, arg2: &vector<u64>, arg3: u64) : vector<u64> {
        let v0 = dot4(arg2, arg0, arg3);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, (*0x1::vector::borrow<u64>(arg0, 0) + mul_mod(*0x1::vector::borrow<u64>(arg1, 0), v0, arg3)) % arg3);
        0x1::vector::push_back<u64>(v2, (*0x1::vector::borrow<u64>(arg0, 1) + mul_mod(*0x1::vector::borrow<u64>(arg1, 1), v0, arg3)) % arg3);
        0x1::vector::push_back<u64>(v2, (*0x1::vector::borrow<u64>(arg0, 2) + mul_mod(*0x1::vector::borrow<u64>(arg1, 2), v0, arg3)) % arg3);
        0x1::vector::push_back<u64>(v2, (*0x1::vector::borrow<u64>(arg0, 3) + mul_mod(*0x1::vector::borrow<u64>(arg1, 3), v0, arg3)) % arg3);
        v1
    }

    entry fun buy_ticket(arg0: &mut Lottery, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg1, arg4);
        let v1 = &mut v0;
        let v2 = &mut arg2;
        buy_ticket_internal(arg0, v1, v2, arg3, arg4);
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
    }

    fun buy_ticket_internal(arg0: &mut Lottery, arg1: &mut 0x2::random::RandomGenerator, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.p;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= arg0.ticket_price, 1);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.pot, 0x2::coin::split<0x2::sui::SUI>(arg2, arg0.ticket_price, arg4));
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = ScratchTicket{
            id         : 0x2::object::new(arg4),
            lottery_id : 0x2::object::id<Lottery>(arg0),
            owner      : v1,
            p          : arg0.p,
            alpha      : arg0.alpha,
            x0         : (0x2::random::generate_u64(arg1) ^ arg3 ^ 11574427654092267680) % v0,
            x1         : (0x2::random::generate_u64(arg1) ^ arg3 ^ 12804210592339571121) % v0,
            x2         : (0x2::random::generate_u64(arg1) ^ arg3 ^ 14033993530586874562) % v0,
            x3         : (0x2::random::generate_u64(arg1) ^ arg3 ^ 15263776468834178003) % v0,
        };
        arg0.total_tickets_sold = arg0.total_tickets_sold + 1;
        let v3 = TicketPurchasedEvent{
            lottery_id   : 0x2::object::id<Lottery>(arg0),
            buyer        : v1,
            ticket_price : arg0.ticket_price,
        };
        0x2::event::emit<TicketPurchasedEvent>(v3);
        0x2::transfer::transfer<ScratchTicket>(v2, v1);
    }

    entry fun claim_admin_fees(arg0: &mut Lottery, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.admin_fees, 0x2::balance::value<0x2::sui::SUI>(&arg0.admin_fees), arg1), arg0.admin);
    }

    entry fun claim_prize(arg0: WinReceipt, arg1: &mut Lottery, arg2: &mut 0x2::tx_context::TxContext) {
        let WinReceipt {
            id         : v0,
            lottery_id : v1,
            winner     : v2,
        } = arg0;
        assert!(v1 == 0x2::object::id<Lottery>(arg1), 5);
        0x2::object::delete(v0);
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&arg1.pot);
        assert!(v3 > 0, 2);
        let v4 = (((v3 as u128) * (2000 as u128) / 10000) as u64);
        let v5 = v3 - v4;
        0x2::coin::put<0x2::sui::SUI>(&mut arg1.admin_fees, 0x2::coin::take<0x2::sui::SUI>(&mut arg1.pot, v4, arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.pot, v5, arg2), v2);
        arg1.total_payouts_count = arg1.total_payouts_count + 1;
        arg1.total_sui_won = arg1.total_sui_won + v5;
        let v6 = JackpotWonEvent{
            lottery_id   : v1,
            winner       : v2,
            total_pot    : v3,
            winner_share : v5,
            admin_fee    : v4,
        };
        0x2::event::emit<JackpotWonEvent>(v6);
    }

    public fun create(arg0: u64, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Lottery {
        assert!(arg0 > 2, 0);
        assert!(arg1 > 0 && arg1 < arg0, 0);
        assert!(arg2 > 0, 0);
        Lottery{
            id                  : 0x2::object::new(arg3),
            admin               : 0x2::tx_context::sender(arg3),
            p                   : arg0,
            alpha               : arg1,
            ticket_price        : arg2,
            pot                 : 0x2::balance::zero<0x2::sui::SUI>(),
            admin_fees          : 0x2::balance::zero<0x2::sui::SUI>(),
            total_tickets_sold  : 0,
            total_payouts_count : 0,
            total_sui_won       : 0,
        }
    }

    entry fun create_default_and_share(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Lottery>(create(31, 3, arg0, arg1));
    }

    fun dot4(arg0: &vector<u64>, arg1: &vector<u64>, arg2: u64) : u64 {
        ((((0 + mul_mod(*0x1::vector::borrow<u64>(arg0, 0), *0x1::vector::borrow<u64>(arg1, 0), arg2)) % arg2 + mul_mod(*0x1::vector::borrow<u64>(arg0, 1), *0x1::vector::borrow<u64>(arg1, 1), arg2)) % arg2 + mul_mod(*0x1::vector::borrow<u64>(arg0, 2), *0x1::vector::borrow<u64>(arg1, 2), arg2)) % arg2 + mul_mod(*0x1::vector::borrow<u64>(arg0, 3), *0x1::vector::borrow<u64>(arg1, 3), arg2)) % arg2
    }

    entry fun fund(arg0: &mut Lottery, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.pot, arg1);
    }

    public fun get_stats(arg0: &Lottery) : (u64, u64, u64, u64, u64, u64) {
        (arg0.ticket_price, 0x2::balance::value<0x2::sui::SUI>(&arg0.pot), 0x2::balance::value<0x2::sui::SUI>(&arg0.admin_fees), arg0.total_tickets_sold, arg0.total_payouts_count, arg0.total_sui_won)
    }

    fun is_all_zero4(arg0: &vector<u64>) : bool {
        if (*0x1::vector::borrow<u64>(arg0, 0) == 0) {
            if (*0x1::vector::borrow<u64>(arg0, 1) == 0) {
                if (*0x1::vector::borrow<u64>(arg0, 2) == 0) {
                    *0x1::vector::borrow<u64>(arg0, 3) == 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    fun is_blue_at(arg0: &vector<u64>, arg1: u64, arg2: u64, arg3: u64) : bool {
        let v0 = *0x1::vector::borrow<u64>(arg0, 0);
        let v1 = *0x1::vector::borrow<u64>(arg0, 1);
        let v2 = *0x1::vector::borrow<u64>(arg0, 2);
        let v3 = *0x1::vector::borrow<u64>(arg0, 3);
        let v4 = if (arg1 == 0) {
            if (v1 == 0) {
                if (v2 == 0) {
                    v3 == 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v5 = if (v4) {
            true
        } else {
            let v6 = if (arg1 == 1) {
                if (v0 == 0) {
                    if (v2 == 0) {
                        v3 == 0
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v6) {
                true
            } else {
                let v7 = if (arg1 == 2) {
                    if (v0 == 0) {
                        if (v1 == 0) {
                            v3 == 0
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v7) {
                    true
                } else if (arg1 == 3) {
                    if (v0 == 0) {
                        if (v1 == 0) {
                            v2 == 0
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            }
        };
        if (!v5) {
            return false
        };
        let v8 = if (arg1 == 0) {
            v0
        } else if (arg1 == 1) {
            v1
        } else if (arg1 == 2) {
            v2
        } else {
            v3
        };
        let v9 = 0;
        let v10 = 1;
        while (v9 <= arg1) {
            if (v8 == v10) {
                return true
            };
            v9 = v9 + 1;
            v10 = mul_mod(v10, arg3, arg2);
        };
        false
    }

    fun is_blue_vec4(arg0: &vector<u64>, arg1: u64, arg2: u64) : bool {
        if (is_blue_at(arg0, 0, arg1, arg2)) {
            true
        } else if (is_blue_at(arg0, 1, arg1, arg2)) {
            true
        } else if (is_blue_at(arg0, 2, arg1, arg2)) {
            true
        } else {
            is_blue_at(arg0, 3, arg1, arg2)
        }
    }

    fun mul_mod(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) % (arg2 as u128)) as u64)
    }

    fun sample_rank1_matrix_params(arg0: &mut 0x2::random::RandomGenerator, arg1: u64) : (vector<u64>, vector<u64>) {
        let v0 = 0;
        while (v0 < 16) {
            v0 = v0 + 1;
            let v1 = sample_vec4(arg0, arg1);
            let v2 = sample_vec4(arg0, arg1);
            if (!is_all_zero4(&v1) && !is_all_zero4(&v2)) {
                if ((1 + dot4(&v2, &v1, arg1)) % arg1 != 0) {
                    return (v1, v2)
                };
            };
        };
        abort 4
    }

    fun sample_vec4(arg0: &mut 0x2::random::RandomGenerator, arg1: u64) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, 0x2::random::generate_u64(arg0) % arg1);
        0x1::vector::push_back<u64>(v1, 0x2::random::generate_u64(arg0) % arg1);
        0x1::vector::push_back<u64>(v1, 0x2::random::generate_u64(arg0) % arg1);
        0x1::vector::push_back<u64>(v1, 0x2::random::generate_u64(arg0) % arg1);
        v0
    }

    entry fun scratch(arg0: ScratchTicket, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg1, arg2);
        let v1 = &mut v0;
        scratch_internal(arg0, v1, arg2);
    }

    fun scratch_internal(arg0: ScratchTicket, arg1: &mut 0x2::random::RandomGenerator, arg2: &mut 0x2::tx_context::TxContext) {
        let ScratchTicket {
            id         : v0,
            lottery_id : v1,
            owner      : v2,
            p          : v3,
            alpha      : v4,
            x0         : v5,
            x1         : v6,
            x2         : v7,
            x3         : v8,
        } = arg0;
        0x2::object::delete(v0);
        let v9 = 0x1::vector::empty<u64>();
        let v10 = &mut v9;
        0x1::vector::push_back<u64>(v10, v5);
        0x1::vector::push_back<u64>(v10, v6);
        0x1::vector::push_back<u64>(v10, v7);
        0x1::vector::push_back<u64>(v10, v8);
        let (v11, v12) = sample_rank1_matrix_params(arg1, v3);
        let v13 = v12;
        let v14 = v11;
        let v15 = apply_rank1_matrix(&v9, &v14, &v13, v3);
        let v16 = is_blue_vec4(&v15, v3, v4);
        let v17 = TicketScratchedEvent{
            lottery_id : v1,
            player     : v2,
            win        : v16,
        };
        0x2::event::emit<TicketScratchedEvent>(v17);
        if (v16) {
            let v18 = WinReceipt{
                id         : 0x2::object::new(arg2),
                lottery_id : v1,
                winner     : v2,
            };
            0x2::transfer::transfer<WinReceipt>(v18, v2);
        };
    }

    entry fun set_ticket_price(arg0: &mut Lottery, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3);
        arg0.ticket_price = arg1;
    }

    // decompiled from Move bytecode v6
}

