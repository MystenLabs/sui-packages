module 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::finds {
    struct ChestsOpened has copy, drop {
        wallet: address,
        chests: u64,
        scrap: u64,
        fragments: u64,
    }

    struct Rolled has copy, drop {
        wallet: address,
        season: u64,
        rolls: u64,
        specials: u64,
        fallback_scrap: u64,
    }

    entry fun set_names(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::admin_ok(arg0, arg1);
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::set_names(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::book_mut(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::uid_mut(arg1)), arg2, arg3);
    }

    entry fun set_open(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg2: bool) {
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::admin_ok(arg0, arg1);
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::set_open(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::book_mut(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::uid_mut(arg1)), arg2);
    }

    entry fun set_rules(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::admin_ok(arg0, arg1);
        let v0 = if (arg2 > 0) {
            if (arg3 <= 20) {
                arg4 <= 5
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 545);
        assert!(arg5 >= 1 && arg5 <= 20, 545);
        let v1 = if (arg6 <= 5000) {
            if (arg7 <= 666) {
                arg8 <= 20
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 545);
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::set_rules(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::book_mut(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::uid_mut(arg1)), arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    entry fun claim_common(arg0: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg1: &mut 0x2::tx_context::TxContext) {
        claim_common_now(arg0, arg1);
    }

    public fun claim_common_now(arg0: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = claim_common_out(arg0, arg1);
        0x2::transfer::public_transfer<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::Discovery>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun claim_common_out(arg0: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg1: &mut 0x2::tx_context::TxContext) : 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::Discovery {
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::assert_current(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2, v3) = 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::finish_state(arg0, v0);
        assert!(v1 == 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::season_now(arg0), 542);
        let v4 = 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::book_mut(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::uid_mut(arg0));
        assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::is_open(v4), 541);
        let v5 = if (v1 > 0) {
            if (v3 != v1) {
                v2 >= 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::finish_line(v4)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v5, 542);
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::mark_finished(arg0, v0, v1);
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::mint_common(v4, v1, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::by_finishing(), v0, arg1)
    }

    entry fun craft_common(arg0: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg1: &mut 0x2::tx_context::TxContext) {
        craft_common_now(arg0, arg1);
    }

    public fun craft_common_now(arg0: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = craft_common_out(arg0, arg1);
        0x2::transfer::public_transfer<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::Discovery>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun craft_common_out(arg0: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg1: &mut 0x2::tx_context::TxContext) : 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::Discovery {
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::assert_current(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::book_mut(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::uid_mut(arg0));
        assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::is_open(v1), 541);
        assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::take_fragments(v1, v0, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::fragments_for_common(v1)), 543);
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::mint_common(v1, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::season_now(arg0), 1, v0, arg1)
    }

    entry fun open_chests(arg0: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg1: &0x2::tx_context::TxContext) {
        open_chests_now(arg0, arg1);
    }

    public fun open_chests_now(arg0: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg1: &0x2::tx_context::TxContext) {
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::assert_current(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::is_open(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::book(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::uid(arg0))), 541);
        let v1 = 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::take_chests(arg0, v0);
        let v2 = 0x1::vector::length<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Chest>(&v1);
        assert!(v2 > 0, 546);
        let (v3, v4) = 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::chest_gift(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::book(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::uid(arg0)));
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::add_scrap(arg0, v0, v2 * v3);
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::add_fragments(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::book_mut(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::uid_mut(arg0)), v0, v2 * v4);
        let v5 = ChestsOpened{
            wallet    : v0,
            chests    : v2,
            scrap     : v2 * v3,
            fragments : v2 * v4,
        };
        0x2::event::emit<ChestsOpened>(v5);
    }

    entry fun open_finds(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg2: &mut 0x2::tx_context::TxContext) {
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::admin_ok(arg0, arg1);
        assert!(!0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::has_book(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::uid(arg1)), 540);
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::add_book(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::uid_mut(arg1), 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::new_book(arg2));
    }

    entry fun roll_chances(arg0: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::assert_current(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::season_now(arg0);
        assert!(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::is_open(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::book(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::uid(arg0))), 541);
        let v2 = 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::take_chances(arg0, v0, 10);
        assert!(v2 > 0, 544);
        let v3 = 0x2::random::new_generator(arg1, arg2);
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        while (v6 < v2) {
            let v7 = 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::book_mut(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::uid_mut(arg0));
            let (v8, v9, v10) = 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::odds(v7);
            if (0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::specials_found(v7, v1) >= v9) {
                v4 = v4 + v10;
            } else if (0x2::random::generate_u64_in_range(&mut v3, 0, 10000 - 1) < v8) {
                0x2::transfer::public_transfer<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::Discovery>(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::mint_special(v7, v1, v0, arg2), v0);
                v5 = v5 + 1;
            };
            v6 = v6 + 1;
        };
        if (v4 > 0) {
            0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::add_scrap(arg0, v0, v4);
        };
        let v11 = Rolled{
            wallet         : v0,
            season         : v1,
            rolls          : v2,
            specials       : v5,
            fallback_scrap : v4,
        };
        0x2::event::emit<Rolled>(v11);
    }

    public fun state(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg1: address) : (bool, u64, u64, u64, u64) {
        if (!0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::has_book(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::uid(arg0))) {
            return (false, 0, 0, 0, 0)
        };
        let v0 = 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::book(0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::uid(arg0));
        let (_, v2, _) = 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::odds(v0);
        (0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::is_open(v0), 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::fragments_of(v0, arg1), 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::fragments_for_common(v0), 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::discovery::specials_found(v0, 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::season_now(arg0)), v2)
    }

    // decompiled from Move bytecode v7
}

