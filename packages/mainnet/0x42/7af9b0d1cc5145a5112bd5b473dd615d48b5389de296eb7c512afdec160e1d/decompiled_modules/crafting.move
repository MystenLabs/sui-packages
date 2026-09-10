module 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::crafting {
    struct Crafted has copy, drop {
        recipe: 0x2::object::ID,
        character: 0x2::object::ID,
        crafter: address,
        output_template: 0x2::object::ID,
        attempts: u16,
        successes: u16,
        job_xp_gained: u64,
    }

    public(friend) fun craft(arg0: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::recipe_rows::Recipe, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: vector<0x2::object::ID>, arg5: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::ItemTemplate, arg6: 0x1::option::Option<0x2::object::ID>, arg7: u16, arg8: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::protected_policy::AresRPG_TransferPolicy<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>, arg9: &0x2::transfer_policy::TransferPolicy<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>, arg10: &mut 0x2::random::RandomGenerator, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::recipe_rows::active_data(arg0);
        let v1 = 0x2::object::id<0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::ItemTemplate>(arg5);
        let v2 = 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::template_category(arg5);
        let (v3, v4, v5) = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::craft_batch::shape(v0, v1, &v2, arg7, 0x1::vector::length<0x2::object::ID>(&arg4));
        let v6 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::progression::job_xp_of(0x2::kiosk::borrow<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>(arg1, arg2, arg3), v3);
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::craft_batch::assert_level(v0, v6);
        let (v7, v8, v9, v10) = if (0x1::option::is_some<0x2::object::ID>(&arg6)) {
            let v11 = *0x1::option::borrow<0x2::object::ID>(&arg6);
            let v12 = 0x2::kiosk::borrow<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>(arg1, arg2, v11);
            (0x1::option::some<0x2::object::ID>(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::template(v12)), (0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::amount(v12) as u64), 0x2::kiosk::is_listed(arg1, v11), 0x1::vector::contains<0x2::object::ID>(&arg4, &v11))
        } else {
            (0x1::option::none<0x2::object::ID>(), 0, false, false)
        };
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::craft_batch::assert_output_target(v4, arg7, v1, v7, v8, v9, v10);
        let v13 = 0;
        while (v13 < v5) {
            let v14 = *0x1::vector::borrow<0x2::object::ID>(&arg4, v13);
            let v15 = 0x2::kiosk::borrow<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>(arg1, arg2, v14);
            0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::burn(arg1, arg2, arg8, v14, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::craft_batch::input_quantity(v0, v13, 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::template(v15), arg7, (0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::amount(v15) as u64)), arg11);
            v13 = v13 + 1;
        };
        let (v16, v17) = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::craft_batch::resolve(v5, v6, arg7, 0x2::random::generate_u16_in_range(arg10, 0, 9999), 0x2::random::generate_u16_in_range(arg10, 0, 9999));
        if (v16 > 0) {
            0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::deposit(arg1, arg2, arg9, arg6, 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::mint(arg5, (v16 as u32), arg10, arg11));
        };
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::progression::bank_job_xp(0x2::kiosk::borrow_mut<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>(arg1, arg2, arg3), v3, v17);
        let v18 = Crafted{
            recipe          : 0x2::object::id<0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::recipe_rows::Recipe>(arg0),
            character       : arg3,
            crafter         : 0x2::tx_context::sender(arg11),
            output_template : v1,
            attempts        : arg7,
            successes       : v16,
            job_xp_gained   : v17,
        };
        0x2::event::emit<Crafted>(v18);
    }

    // decompiled from Move bytecode v7
}

