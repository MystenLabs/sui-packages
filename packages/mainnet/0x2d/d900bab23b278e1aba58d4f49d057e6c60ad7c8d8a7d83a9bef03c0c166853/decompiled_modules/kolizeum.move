module 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::kolizeum {
    struct Kolizeum has key {
        id: 0x2::object::UID,
        pot: 0x2::balance::Balance<0x2::sui::SUI>,
        pledge: u64,
        fight: 0x2::object::ID,
        format: u64,
        level_min: u16,
        level_max: u16,
        allowed: 0x1::option::Option<0x2::vec_set::VecSet<address>>,
    }

    struct KolizeumCreated has copy, drop {
        kolizeum: 0x2::object::ID,
        fight: 0x2::object::ID,
        pledge: u64,
        format: u64,
    }

    struct KolizeumPaid has copy, drop {
        kolizeum: 0x2::object::ID,
        winner: address,
        amount: u64,
    }

    fun destroy_empty(arg0: Kolizeum) {
        let Kolizeum {
            id        : v0,
            pot       : v1,
            pledge    : _,
            fight     : _,
            format    : _,
            level_min : _,
            level_max : _,
            allowed   : _,
        } = arg0;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        0x2::object::delete(v0);
    }

    public(friend) fun join(arg0: &mut Kolizeum, arg1: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::Fight, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u8, arg4: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::protected_policy::AresRPG_TransferPolicy<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: 0x2::object::ID, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::Fight>(arg1) == arg0.fight, 2808);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == arg0.pledge, 2802);
        if (0x1::option::is_some<0x2::vec_set::VecSet<address>>(&arg0.allowed)) {
            let v0 = 0x2::tx_context::sender(arg9);
            assert!(0x2::vec_set::contains<address>(0x1::option::borrow<0x2::vec_set::VecSet<address>>(&arg0.allowed), &v0), 2806);
        };
        assert_eligible_character(arg5, arg6, arg7, arg0.level_min, arg0.level_max, arg8);
        assert!(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::side_players(arg1, arg3) < arg0.format, 2805);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pot, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::join(arg1, arg4, arg5, arg6, arg7, arg3, 0, false, arg8, arg9);
        let v1 = placement_clock(arg0.format, 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::side_players(arg1, 0), 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::side_players(arg1, 1), 0x2::clock::timestamp_ms(arg8));
        if (v1 != 0) {
            0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::set_placement_clock(arg1, v1);
        };
    }

    public(friend) fun close(arg0: Kolizeum, arg1: 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::Fight, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::Fight>(&arg1) == arg0.fight, 2808);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.pot) == 0, 2809);
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::close(arg1, arg2);
        destroy_empty(arg0);
    }

    public(friend) fun forfeit(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::Fight, arg1: u64, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>, arg5: &mut 0x2::random::RandomGenerator, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::assert_kolizeum_controlled(arg0);
        assert!(!0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::in_placement(arg0), 2808);
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::forfeit(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public(friend) fun start(arg0: &mut Kolizeum, arg1: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::Fight, arg2: &mut 0x2::random::RandomGenerator, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::Fight>(arg1) == arg0.fight, 2808);
        let v0 = (((0x2::balance::value<0x2::sui::SUI>(&arg0.pot) as u128) * (1000 as u128) / 10000) as u64);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.pot, v0, arg4), @0x37cf46b499f740e653644bd2f7a8ed97f248e8b3c69d5d12c97d7845a54c0cd8);
        };
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::start(arg1, arg2, arg3);
    }

    fun assert_eligible_character(arg0: &0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u16, arg4: u16, arg5: &0x2::clock::Clock) {
        let v0 = 0x2::kiosk::borrow<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>(arg0, arg1, arg2);
        let v1 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::level(v0);
        assert!(v1 >= arg3 && v1 <= arg4, 2803);
        assert!(!0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::world::is_rooted(v0, arg5), 2804);
        assert!(!0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::dungeon::has_run(v0), 2804);
    }

    public(friend) fun create(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u16, arg3: u16, arg4: u8, arg5: 0x1::option::Option<0x2::vec_set::VecSet<address>>, arg6: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::protected_policy::AresRPG_TransferPolicy<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: 0x2::object::ID, arg10: u64, arg11: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::board_catalog::BoardCatalog, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg1 == 1) {
            true
        } else if (arg1 == 3) {
            true
        } else {
            arg1 == 6
        };
        assert!(v0, 2801);
        assert!(arg2 <= arg3, 2803);
        assert_eligible_character(arg7, arg8, arg9, arg2, arg3, arg12);
        if (0x1::option::is_some<0x2::vec_set::VecSet<address>>(&arg5)) {
            let v1 = 0x1::option::borrow_mut<0x2::vec_set::VecSet<address>>(&mut arg5);
            let v2 = 0x2::tx_context::sender(arg13);
            if (!0x2::vec_set::contains<address>(v1, &v2)) {
                0x2::vec_set::insert<address>(v1, 0x2::tx_context::sender(arg13));
            };
        };
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v4 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::kolizeum_birth(arg6, arg7, arg8, arg9, arg10, arg4, arg11, arg12, arg13);
        let v5 = Kolizeum{
            id        : 0x2::object::new(arg13),
            pot       : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            pledge    : v3,
            fight     : v4,
            format    : arg1,
            level_min : arg2,
            level_max : arg3,
            allowed   : arg5,
        };
        let v6 = KolizeumCreated{
            kolizeum : 0x2::object::uid_to_inner(&v5.id),
            fight    : v4,
            pledge   : v3,
            format   : arg1,
        };
        0x2::event::emit<KolizeumCreated>(v6);
        0x2::transfer::share_object<Kolizeum>(v5);
    }

    public(friend) fun exit(arg0: &mut Kolizeum, arg1: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::Fight, arg2: u64, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::Fight>(arg1) == arg0.fight, 2808);
        assert!(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::in_placement(arg1), 2808);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.pot, arg0.pledge, arg7), 0x2::tx_context::sender(arg7));
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::forfeit_placement(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::set_placement_clock(arg1, 0);
    }

    fun placement_clock(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg1 == arg0 && arg2 == arg0) {
            arg3
        } else {
            0
        }
    }

    public(friend) fun settle(arg0: &mut Kolizeum, arg1: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::Fight, arg2: u64, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::Fight>(arg1) == arg0.fight, 2808);
        if (0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::fighter_won(arg1, arg2)) {
            let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.pot) / 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::winners_remaining(arg1);
            if (v0 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.pot, v0, arg7), 0x2::tx_context::sender(arg7));
                let v1 = KolizeumPaid{
                    kolizeum : 0x2::object::uid_to_inner(&arg0.id),
                    winner   : 0x2::tx_context::sender(arg7),
                    amount   : v0,
                };
                0x2::event::emit<KolizeumPaid>(v1);
            };
        };
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::settle_pvp(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    // decompiled from Move bytecode v7
}

