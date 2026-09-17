module 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::forgemagie {
    struct CrushClaim has key {
        id: 0x2::object::UID,
        seed: u64,
        raws: vector<u64>,
        revealed: bool,
        owed: vector<u64>,
    }

    struct RuneScribed has copy, drop {
        item: 0x2::object::ID,
        stat: u8,
        tier: u8,
        outcome: u8,
        applied_value: u64,
        lost_amounts: vector<u64>,
        new_puits: u64,
    }

    struct GearCrushed has copy, drop {
        crusher: address,
        items: u64,
    }

    struct CrushRevealed has copy, drop {
        claim: 0x2::object::ID,
        owed: vector<u64>,
    }

    fun assert_crushable(arg0: 0x1::string::String, arg1: bool) {
        assert!(arg1, 2710);
        let v0 = if (!0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::content_rules::is_stackable(&arg0)) {
            let v1 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::content_rules::craft_job_of(&arg0);
            0x1::option::is_some<0x1::string::String>(&v1)
        } else {
            false
        };
        assert!(v0, 2705);
    }

    fun assert_owed_empty(arg0: &vector<u64>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            assert!(*0x1::vector::borrow<u64>(arg0, v0) == 0, 2709);
            v0 = v0 + 1;
        };
    }

    fun assert_rune_identity(arg0: 0x1::string::String, arg1: u8, arg2: u8) {
        assert!(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::has_rune(arg1, arg2) && 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::slug(arg1, arg2) == arg0, 2711);
    }

    public(friend) fun crush(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: vector<0x2::object::ID>, arg3: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::protected_policy::AresRPG_TransferPolicy<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>, arg4: &mut 0x2::random::RandomGenerator, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = vector[];
        let v1 = 0x1::vector::length<0x2::object::ID>(&arg2);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&arg2, v2);
            let v4 = 0x2::kiosk::borrow<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>(arg0, arg1, v3);
            assert_crushable(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::category(v4), 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::has_stats(v4));
            let v5 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::stats(v4);
            0x1::vector::append<u64>(&mut v0, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::to_raw(&v5));
            0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::burn(arg0, arg1, arg3, v3, 1, arg5);
            v2 = v2 + 1;
        };
        let v6 = GearCrushed{
            crusher : 0x2::tx_context::sender(arg5),
            items   : v1,
        };
        0x2::event::emit<GearCrushed>(v6);
        let v7 = CrushClaim{
            id       : 0x2::object::new(arg5),
            seed     : 0x2::random::generate_u64(arg4),
            raws     : v0,
            revealed : false,
            owed     : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::forge::zero_counts(),
        };
        0x2::transfer::transfer<CrushClaim>(v7, 0x2::tx_context::sender(arg5));
    }

    public(friend) fun discard_claim(arg0: CrushClaim) {
        let v0 = &mut arg0;
        ensure_revealed(v0);
        let CrushClaim {
            id       : v1,
            seed     : _,
            raws     : _,
            revealed : _,
            owed     : v5,
        } = arg0;
        let v6 = v5;
        assert_owed_empty(&v6);
        0x2::object::delete(v1);
    }

    fun ensure_revealed(arg0: &mut CrushClaim) {
        if (arg0.revealed) {
            return
        };
        let v0 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::rune_catalog::stat_count();
        let v1 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::rng_seed(arg0.seed);
        let v2 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::forge::zero_counts();
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg0.raws)) {
            let v4 = vector[];
            let v5 = 0;
            while (v5 < v0) {
                0x1::vector::push_back<u64>(&mut v4, *0x1::vector::borrow<u64>(&arg0.raws, v3 + v5));
                v5 = v5 + 1;
            };
            let v6 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::forge::crush_lines(&v4, &mut v1);
            0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::forge::add_counts(&mut v2, &v6);
            v3 = v3 + v0;
        };
        arg0.owed = v2;
        arg0.revealed = true;
    }

    fun forgery_job(arg0: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character, arg1: 0x1::string::String) : 0x1::string::String {
        let v0 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::content_rules::craft_job_of(&arg1);
        assert!(0x1::option::is_some<0x1::string::String>(&v0), 2705);
        let v1 = 0x1::option::destroy_some<0x1::string::String>(v0);
        assert!(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::progression::job_level_of(arg0, v1) >= 1, 2701);
        v1
    }

    public(friend) fun redeem_rune(arg0: &mut CrushClaim, arg1: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::ItemTemplate, arg2: u8, arg3: u8, arg4: 0x1::option::Option<0x2::object::ID>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &0x2::transfer_policy::TransferPolicy<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>, arg8: &mut 0x2::tx_context::TxContext) {
        ensure_revealed(arg0);
        assert_rune_identity(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::template_type(arg1), arg2, arg3);
        let v0 = (arg2 as u64) * 3 + (arg3 as u64) - 1;
        let v1 = *0x1::vector::borrow<u64>(&arg0.owed, v0);
        if (v1 == 0) {
            return
        };
        *0x1::vector::borrow_mut<u64>(&mut arg0.owed, v0) = 0;
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::deposit(arg5, arg6, arg7, arg4, 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::mint_plain(arg1, (v1 as u32), arg8));
    }

    public(friend) fun reveal_claim(arg0: &mut CrushClaim) {
        ensure_revealed(arg0);
        let v0 = CrushRevealed{
            claim : 0x2::object::uid_to_inner(&arg0.id),
            owed  : arg0.owed,
        };
        0x2::event::emit<CrushRevealed>(v0);
    }

    public(friend) fun scribe(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::ItemTemplate, arg5: 0x2::object::ID, arg6: u8, arg7: u8, arg8: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::protected_policy::AresRPG_TransferPolicy<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>, arg9: &mut 0x2::random::RandomGenerator, arg10: &mut 0x2::tx_context::TxContext) {
        assert_rune_identity(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::item_type(0x2::kiosk::borrow<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>(arg0, arg1, arg5)), arg6, arg7);
        forgery_job(0x2::kiosk::borrow<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>(arg0, arg1, arg2), 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::template_category(arg4));
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::burn(arg0, arg1, arg8, arg5, 1, arg10);
        let v0 = 0x2::kiosk::borrow_mut<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>(arg0, arg1, arg3);
        assert!(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::template(v0) == 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::template_id(arg4), 2704);
        assert!(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::has_stats(v0), 2704);
        let v1 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::stats(v0);
        let v2 = 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::stats_max(arg4);
        assert!(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::forge::can_apply_rune(&v1, &v2, arg6, arg7), 2703);
        let v3 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::rng_seed(0x2::random::generate_u64(arg9));
        let v4 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::forge::apply_rune(v1, 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::stats_min(arg4), v2, arg6, arg7, 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::puits(v0), &mut v3);
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::set_stats(v0, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::forge::new_stats(&v4), 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::forge::new_puits(&v4));
        let v5 = RuneScribed{
            item          : arg3,
            stat          : arg6,
            tier          : arg7,
            outcome       : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::forge::outcome(&v4),
            applied_value : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::forge::applied_value(&v4),
            lost_amounts  : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::forge::lost_amounts(&v4),
            new_puits     : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::forge::new_puits(&v4),
        };
        0x2::event::emit<RuneScribed>(v5);
    }

    // decompiled from Move bytecode v7
}

