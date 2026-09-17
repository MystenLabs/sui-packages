module 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::consumable {
    fun assert_available(arg0: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character, arg1: &0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::consumable_effect::Effect, arg2: &0x2::clock::Clock) {
        let v0 = if (0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::dungeon::has_run(arg0)) {
            let v1 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::consumable_effect::heal_amount(arg1);
            if (0x1::option::is_some<u32>(&v1)) {
                true
            } else if (0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::consumable_effect::is_reset_stats(arg1)) {
                true
            } else {
                0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::consumable_effect::is_reset_spells(arg1)
            }
        } else {
            !0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::world::is_rooted(arg0, arg2)
        };
        assert!(v0, 2603);
    }

    fun burn_one(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::protected_policy::AresRPG_TransferPolicy<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::ItemTemplate, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::consumable_effect::Effect {
        assert!(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::template(0x2::kiosk::borrow<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>(arg0, arg1, arg4)) == 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::template_id(arg5), 2601);
        let v0 = 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::consumable_effect(arg5);
        assert!(0x1::option::is_some<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::consumable_effect::Effect>(&v0), 2601);
        let v1 = 0x1::option::destroy_some<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::consumable_effect::Effect>(v0);
        assert_available(0x2::kiosk::borrow<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>(arg0, arg1, arg3), &v1, arg6);
        assert!(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::burn(arg0, arg1, arg2, arg4, 1, arg7) == 0x1::string::utf8(b"consumable"), 2601);
        v1
    }

    public(friend) fun consume(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::protected_policy::AresRPG_TransferPolicy<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::ItemTemplate, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = burn_one(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        assert!(!0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::consumable_effect::is_loot_box(&v0), 2604);
        let v1 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::consumable_effect::city_name(&v0);
        assert!(0x1::option::is_none<0x1::string::String>(&v1), 2605);
        let v2 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::consumable_effect::heal_amount(&v0);
        if (0x1::option::is_some<u32>(&v2)) {
            0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::progression::heal(0x2::kiosk::borrow_mut<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>(arg0, arg1, arg3), (0x1::option::destroy_some<u32>(v2) as u64), arg6);
        } else if (0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::consumable_effect::is_reset_stats(&v0)) {
            0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::reset_stats(0x2::kiosk::borrow_mut<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>(arg0, arg1, arg3));
        } else if (0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::consumable_effect::is_reset_spells(&v0)) {
            0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::progression::reset_spells(0x2::kiosk::borrow_mut<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>(arg0, arg1, arg3));
        } else {
            0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::world::teleport_center(0x2::kiosk::borrow_mut<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>(arg0, arg1, arg3), arg6);
        };
    }

    public(friend) fun consume_city(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::protected_policy::AresRPG_TransferPolicy<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::ItemTemplate, arg6: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::WorldContent, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = burn_one(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg8);
        let v1 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::consumable_effect::city_name(&v0);
        assert!(0x1::option::is_some<0x1::string::String>(&v1), 2605);
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::world::teleport_city(0x2::kiosk::borrow_mut<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>(arg0, arg1, arg3), arg6, 0x1::option::borrow<0x1::string::String>(&v1), arg7);
    }

    // decompiled from Move bytecode v7
}

