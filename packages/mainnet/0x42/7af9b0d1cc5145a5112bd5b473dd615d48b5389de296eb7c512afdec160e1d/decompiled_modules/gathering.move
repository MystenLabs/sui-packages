module 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::gathering {
    struct AmbushKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PendingAmbush has copy, drop, store {
        fires: bool,
        protector: 0x1::string::String,
        x: u32,
        z: u32,
        scalar: u8,
        board_seed: u64,
        hp: u64,
    }

    struct ResourceGathered has copy, drop {
        world: 0x1::string::String,
        x: u32,
        z: u32,
        gatherer: address,
        item_type: 0x1::string::String,
        tier: u8,
        quantity: u64,
        job_xp_gained: u64,
        protector: bool,
    }

    struct RareGathered has copy, drop {
        world: 0x1::string::String,
        x: u32,
        z: u32,
        gatherer: address,
        item_type: 0x1::string::String,
        rare_item_type: 0x1::string::String,
    }

    public(friend) fun gather(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::zone::Zone, arg1: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::WorldContent, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: u64, arg6: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::ItemTemplate, arg7: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::ItemTemplate, arg8: 0x1::option::Option<0x2::object::ID>, arg9: 0x1::option::Option<0x2::object::ID>, arg10: &0x2::transfer_policy::TransferPolicy<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>, arg11: &mut 0x2::random::RandomGenerator, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::zone::resource_pack_at(arg0, arg1, arg5);
        let v1 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::zone_math::pack_item_type(&v0);
        let v2 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::resource_row_of(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::data(arg1), v1);
        assert!(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::template_type(arg6) == v1, 2202);
        let v3 = 0x2::kiosk::borrow_mut<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>(arg2, arg3, arg4);
        assert!(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::world::prove_move(v3, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::zone_math::pack_x(&v0), 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::zone_math::pack_z(&v0), arg12) == 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::zone::world_name(arg0), 2201);
        let v4 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::resource_row_job(&v2);
        assert!(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::equipment::tool_of(v3) == 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::job_xp::gathering_tool(&v4), 2203);
        let v5 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::progression::job_level_of(v3, v4);
        let v6 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::job_xp::tier_to_level((0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::resource_row_tier(&v2) as u64));
        assert!(v5 >= v6, 2204);
        let (v7, v8) = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::job_xp::gather_quantity_bounds(v5, v6);
        let v9 = 0x2::random::generate_u64_in_range(arg11, v7, v8);
        let v10 = if (0x2::random::generate_u64_in_range(arg11, 0, 9999) < 200) {
            let v11 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::resource_row_protector(&v2);
            !0x1::string::is_empty(&v11)
        } else {
            false
        };
        let (v12, v13) = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::zone::level_bounds(arg0);
        let v14 = PendingAmbush{
            fires      : v10,
            protector  : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::resource_row_protector(&v2),
            x          : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::zone_math::pack_x(&v0),
            z          : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::zone_math::pack_z(&v0),
            scalar     : ((v12 + 0x2::random::generate_u64_in_range(arg11, 0, v13 - v12)) as u8),
            board_seed : 0x2::random::generate_u64(arg11),
            hp         : 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::progression::touch(v3, arg12),
        };
        write_ambush_verdict(v3, v14);
        let v15 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::job_xp::gather_xp(v6);
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::progression::bank_job_xp(v3, v4, v15);
        let v16 = if (v10) {
            3153600000000
        } else {
            0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::job_xp::gather_time_ms(v5)
        };
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::world::delay_checkpoint(v3, v16, arg12);
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::zone::consume_resource_node(arg0, arg1, arg5);
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::deposit(arg2, arg3, arg10, arg8, 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::mint(arg6, (v9 as u32), arg11, arg13));
        let v17 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::resource_row_rare(&v2);
        if (!0x1::string::is_empty(&v17)) {
            assert!(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::template_type(arg7) == v17, 2205);
            if (0x2::random::generate_u64_in_range(arg11, 0, 9999) < 10) {
                0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::deposit(arg2, arg3, arg10, arg9, 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::mint(arg7, 1, arg11, arg13));
                let v18 = RareGathered{
                    world          : 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::zone::world_name(arg0),
                    x              : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::zone_math::pack_x(&v0),
                    z              : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::zone_math::pack_z(&v0),
                    gatherer       : 0x2::tx_context::sender(arg13),
                    item_type      : v1,
                    rare_item_type : v17,
                };
                0x2::event::emit<RareGathered>(v18);
            };
        };
        let v19 = ResourceGathered{
            world         : 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::zone::world_name(arg0),
            x             : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::zone_math::pack_x(&v0),
            z             : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::zone_math::pack_z(&v0),
            gatherer      : 0x2::tx_context::sender(arg13),
            item_type     : v1,
            tier          : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::resource_row_tier(&v2),
            quantity      : v9,
            job_xp_gained : v15,
            protector     : v10,
        };
        0x2::event::emit<ResourceGathered>(v19);
    }

    public(friend) fun has_fired_verdict(arg0: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character) : bool {
        let v0 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::uid(arg0);
        let v1 = AmbushKey{dummy_field: false};
        if (0x2::dynamic_field::exists<AmbushKey>(v0, v1)) {
            let v3 = AmbushKey{dummy_field: false};
            0x2::dynamic_field::borrow<AmbushKey, PendingAmbush>(v0, v3).fires
        } else {
            false
        }
    }

    public(friend) fun resolve_ambush(arg0: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::protected_policy::AresRPG_TransferPolicy<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::mob_rows::MobTemplate, arg5: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::board_catalog::BoardCatalog, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::borrow_mut<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>(arg1, arg2, arg3);
        let v1 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::uid_mut(v0);
        let v2 = AmbushKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<AmbushKey>(v1, v2), 2207);
        let v3 = AmbushKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::borrow_mut<AmbushKey, PendingAmbush>(v1, v3);
        assert!(v4.fires, 2207);
        v4.fires = false;
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::world::delay_checkpoint(v0, 0, arg6);
        let v5 = *v4;
        assert!(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::mob_data::mob_type(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::mob_rows::data(arg4)) == v5.protector, 2206);
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::ambush(arg0, arg1, arg2, arg3, v5.x, v5.z, arg4, (v5.scalar as u64), v5.board_seed, v5.hp, arg5, arg6, arg7);
    }

    fun write_ambush_verdict(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character, arg1: PendingAmbush) {
        let v0 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::uid_mut(arg0);
        let v1 = AmbushKey{dummy_field: false};
        if (0x2::dynamic_field::exists<AmbushKey>(v0, v1)) {
            let v2 = AmbushKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<AmbushKey, PendingAmbush>(v0, v2) = arg1;
        } else {
            let v3 = AmbushKey{dummy_field: false};
            0x2::dynamic_field::add<AmbushKey, PendingAmbush>(v0, v3, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

