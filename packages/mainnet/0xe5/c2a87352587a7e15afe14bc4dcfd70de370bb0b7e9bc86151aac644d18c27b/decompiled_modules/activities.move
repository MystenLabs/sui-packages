module 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::activities {
    struct ActionStarted has copy, drop {
        player_id: 0x2::object::ID,
        kind: u8,
        params: vector<u64>,
        started_at_ms: u64,
    }

    struct TravelResolved has copy, drop {
        player_id: 0x2::object::ID,
        destination: u16,
        arrived: bool,
    }

    struct ActionResolved has copy, drop {
        player_id: 0x2::object::ID,
        kind: u8,
        cycles: u64,
        skill: u8,
        xp_gained: u64,
        output_kind: u16,
        output_qty: u64,
    }

    fun resolve_craft(arg0: &mut 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::Player, arg1: &0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::Registry, arg2: &0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::ActiveAction, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::action_params(arg2);
        let v1 = *0x1::vector::borrow<u64>(&v0, 1);
        let v2 = 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::recipe(arg1, (*0x1::vector::borrow<u64>(&v0, 0) as u16));
        let v3 = (0x1::u64::min(0x1::u64::max(0x2::clock::timestamp_ms(arg3), 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::action_started_at_ms(arg2)), 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::action_started_at_ms(arg2) + 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::max_offline_ms(arg1)) - 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::action_started_at_ms(arg2)) / 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::recipe_duration_ms(&v2);
        let v4 = v3;
        if (0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::recipe_fuel_kind(&v2) != 0) {
            v4 = 0x1::u64::min(v3, *0x1::vector::borrow<u64>(&v0, 2) * 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::recipe_fuel_burn_ms(&v2) / 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::recipe_duration_ms(&v2));
        };
        if (v1 > 0) {
            v4 = 0x1::u64::min(v4, v1);
        };
        let v5 = 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::recipe_input_kinds(&v2);
        let v6 = 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::recipe_input_qtys(&v2);
        let v7 = 0;
        while (v7 < 0x1::vector::length<u16>(&v5)) {
            let v8 = *0x1::vector::borrow<u64>(&v6, v7);
            if (v8 > 0) {
                v4 = 0x1::u64::min(v4, 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::item_qty(arg0, *0x1::vector::borrow<u16>(&v5, v7)) / v8);
            };
            v7 = v7 + 1;
        };
        let v9 = 0;
        while (v9 < 0x1::vector::length<u16>(&v5)) {
            0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::debit_item(arg0, *0x1::vector::borrow<u16>(&v5, v9), v4 * *0x1::vector::borrow<u64>(&v6, v9));
            v9 = v9 + 1;
        };
        let v10 = v4 * 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::recipe_xp(&v2);
        0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::credit_xp(arg0, 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::recipe_skill(&v2), v10);
        let v11 = 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::recipe_output_kind(&v2);
        let v12 = v11;
        let v13 = v4 * 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::recipe_output_qty(&v2);
        let v14 = v13;
        if (0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::recipe_output_equipment(&v2) != 0) {
            v12 = 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::recipe_output_equipment(&v2);
            v14 = v4;
            let v15 = 0;
            while (v15 < v4) {
                0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::equipment::mint_into_armory(arg0, arg1, 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::recipe_output_equipment(&v2), arg4);
                v15 = v15 + 1;
            };
        } else {
            0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::credit_item(arg0, v11, v13);
        };
        let v16 = ActionResolved{
            player_id   : 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::id(arg0),
            kind        : 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::kind_craft(),
            cycles      : v4,
            skill       : 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::recipe_skill(&v2),
            xp_gained   : v10,
            output_kind : v12,
            output_qty  : v14,
        };
        0x2::event::emit<ActionResolved>(v16);
    }

    fun resolve_gather(arg0: &mut 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::Player, arg1: &0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::Registry, arg2: &0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::ActiveAction, arg3: &0x2::clock::Clock) {
        let v0 = 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::action_params(arg2);
        let v1 = 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::activity(arg1, (*0x1::vector::borrow<u64>(&v0, 0) as u16));
        let v2 = (0x1::u64::min(0x1::u64::max(0x2::clock::timestamp_ms(arg3), 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::action_started_at_ms(arg2)), 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::action_started_at_ms(arg2) + 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::max_offline_ms(arg1)) - 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::action_started_at_ms(arg2)) / 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::activity_duration_ms(&v1);
        let v3 = v2;
        if (0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::activity_input_kind(&v1) != 0) {
            let v4 = 0x1::u64::min(v2, 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::item_qty(arg0, 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::activity_input_kind(&v1)) / 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::activity_input_qty(&v1));
            v3 = v4;
            0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::debit_item(arg0, 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::activity_input_kind(&v1), v4 * 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::activity_input_qty(&v1));
        };
        let v5 = v3 * 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::activity_output_qty(&v1);
        let v6 = v3 * 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::activity_xp(&v1);
        0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::credit_item(arg0, 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::activity_output_kind(&v1), v5);
        0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::credit_xp(arg0, 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::activity_skill(&v1), v6);
        let v7 = ActionResolved{
            player_id   : 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::id(arg0),
            kind        : 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::kind_gather(),
            cycles      : v3,
            skill       : 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::activity_skill(&v1),
            xp_gained   : v6,
            output_kind : 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::activity_output_kind(&v1),
            output_qty  : v5,
        };
        0x2::event::emit<ActionResolved>(v7);
    }

    fun resolve_travel(arg0: &mut 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::Player, arg1: &0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::ActiveAction, arg2: &0x2::clock::Clock) {
        let v0 = 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::action_params(arg1);
        let v1 = (*0x1::vector::borrow<u64>(&v0, 0) as u16);
        let v2 = 0x2::clock::timestamp_ms(arg2) >= *0x1::vector::borrow<u64>(&v0, 1);
        if (v2) {
            0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::set_location(arg0, v1);
        };
        let v3 = TravelResolved{
            player_id   : 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::id(arg0),
            destination : v1,
            arrived     : v2,
        };
        0x2::event::emit<TravelResolved>(v3);
    }

    public fun start_crafting(arg0: &mut 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::Player, arg1: &0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::Registry, arg2: u16, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::assert_can_play(arg0, arg5, arg6);
        let v0 = 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::recipe(arg1, arg2);
        assert!(0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::skill_level(arg0, 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::recipe_skill(&v0)) >= 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::recipe_level_req(&v0), 13906834608135208963);
        if (0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::recipe_output_equipment(&v0) != 0) {
            assert!(arg3 >= 1 && arg3 <= 5, 13906834629610569739);
        };
        if (0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::recipe_fuel_kind(&v0) != 0) {
            assert!(arg4 > 0, 13906834646790176775);
            0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::debit_item(arg0, 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::recipe_fuel_kind(&v0), arg4);
        } else {
            assert!(arg4 == 0, 13906834659675209737);
        };
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, (arg2 as u64));
        0x1::vector::push_back<u64>(v2, arg3);
        0x1::vector::push_back<u64>(v2, arg4);
        0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::start_action(arg0, 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::kind_craft(), v1, arg5);
        let v3 = ActionStarted{
            player_id     : 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::id(arg0),
            kind          : 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::kind_craft(),
            params        : v1,
            started_at_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ActionStarted>(v3);
    }

    public fun start_gathering(arg0: &mut 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::Player, arg1: &0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::Registry, arg2: u16, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::assert_can_play(arg0, arg3, arg4);
        let v0 = 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::activity(arg1, arg2);
        assert!(0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::activity_location(&v0) == 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::location(arg0), 13906834462106189825);
        assert!(0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::skill_level(arg0, 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::activity_skill(&v0)) >= 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::activity_level_req(&v0), 13906834474991222787);
        let v1 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v1, (arg2 as u64));
        0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::start_action(arg0, 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::kind_gather(), v1, arg3);
        let v2 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v2, (arg2 as u64));
        let v3 = ActionStarted{
            player_id     : 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::id(arg0),
            kind          : 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::kind_gather(),
            params        : v2,
            started_at_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ActionStarted>(v3);
    }

    public fun stop_action(arg0: &mut 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::Player, arg1: &0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::Registry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::assert_can_play(arg0, arg2, arg3);
        let v0 = 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::take_action(arg0);
        let v1 = 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::action_kind(&v0);
        if (v1 == 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::kind_gather()) {
            resolve_gather(arg0, arg1, &v0, arg2);
        } else if (v1 == 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::kind_craft()) {
            resolve_craft(arg0, arg1, &v0, arg2, arg3);
        } else if (v1 == 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::kind_travel()) {
            resolve_travel(arg0, &v0, arg2);
        } else {
            assert!(v1 == 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::kind_hunt(), 13906834809998802949);
            0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::combat::resolve_hunt(arg0, arg1, 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::player::action_started_at_ms(&v0), arg2);
        };
    }

    // decompiled from Move bytecode v7
}

