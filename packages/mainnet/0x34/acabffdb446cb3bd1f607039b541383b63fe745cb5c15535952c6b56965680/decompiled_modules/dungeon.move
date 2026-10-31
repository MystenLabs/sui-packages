module 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::dungeon {
    struct DungeonRunKey has copy, drop, store {
        dummy_field: bool,
    }

    struct DungeonRun has copy, drop, store {
        dungeon: 0x1::string::String,
        room: u64,
        seed: u64,
    }

    struct DungeonEntered has copy, drop {
        character: 0x2::object::ID,
        world: 0x1::string::String,
        x: u32,
        z: u32,
    }

    struct DungeonRoomCleared has copy, drop {
        character: 0x2::object::ID,
        world: 0x1::string::String,
        room: u64,
    }

    struct DungeonEnded has copy, drop {
        character: 0x2::object::ID,
        world: 0x1::string::String,
        room: u64,
        won: bool,
    }

    public(friend) fun abandon_run(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::kiosk::borrow_mut<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>(arg0, arg1, arg2);
        let (_, v2, _) = read_run(v0);
        let v4 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::world::current_world(v0);
        end_run(v0, arg3);
        let v5 = DungeonEnded{
            character : arg2,
            world     : v4,
            room      : v2,
            won       : false,
        };
        0x2::event::emit<DungeonEnded>(v5);
    }

    fun assert_same_dungeon_room(arg0: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::Fight, arg1: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character) {
        let (v0, v1, _) = read_run(arg1);
        let v3 = dungeon_tag(arg0);
        assert!(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::dungeon_name(&v3) == v0 && 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::dungeon_room(&v3) == v1, 2705);
        assert!(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::fight_world(arg0) == 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::world::current_world(arg1), 2706);
    }

    fun dungeon_city(arg0: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::world::World, arg1: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::WorldContent, arg2: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::dungeon_content::DungeonContent) : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::City {
        assert!(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::name(arg1) == 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::world::name(arg0), 2706);
        let v0 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::cities(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::data(arg1));
        let v1 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::city_for_dungeon(&v0, 0x2::object::id<0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::dungeon_content::DungeonContent>(arg2));
        assert!(0x1::option::is_some<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::City>(&v1), 2701);
        *0x1::option::borrow<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::City>(&v1)
    }

    fun dungeon_tag(arg0: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::Fight) : 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::DungeonTag {
        let v0 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::dungeon_tag(arg0);
        assert!(0x1::option::is_some<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::DungeonTag>(&v0), 2707);
        *0x1::option::borrow<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::DungeonTag>(&v0)
    }

    fun end_run(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character, arg1: &0x2::clock::Clock) {
        let v0 = DungeonRunKey{dummy_field: false};
        let DungeonRun {
            dungeon : _,
            room    : _,
            seed    : _,
        } = 0x2::dynamic_field::remove<DungeonRunKey, DungeonRun>(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::uid_mut(arg0), v0);
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::world::delay_checkpoint(arg0, 0, arg1);
    }

    public(friend) fun engage_room(arg0: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::world::World, arg1: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::WorldContent, arg2: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::dungeon_content::DungeonContent, arg3: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::protected_policy::AresRPG_TransferPolicy<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: 0x2::object::ID, arg7: u8, arg8: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::board_catalog::BoardCatalog, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::FightBuild {
        let (v0, v1, v2) = read_run(0x2::kiosk::borrow<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>(arg4, arg5, arg6));
        assert!(v0 == 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::dungeon_content::name(arg2), 2705);
        let v3 = dungeon_city(arg0, arg1, arg2);
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::dungeon_build(arg3, arg4, arg5, arg6, arg0, arg2, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::x(&v3), 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::z(&v3), 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::mix(v2, v1), v1, arg7, arg8, arg9, arg10)
    }

    public(friend) fun enter(arg0: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::world::World, arg1: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::WorldContent, arg2: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::dungeon_content::DungeonContent, arg3: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::protected_policy::AresRPG_TransferPolicy<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: 0x2::object::ID, arg7: 0x2::object::ID, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = dungeon_city(arg0, arg1, arg2);
        let v1 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::x(&v0);
        let v2 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::z(&v0);
        assert!(!has_run(0x2::kiosk::borrow<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>(arg4, arg5, arg6)), 2703);
        assert!(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::dungeon_data::key(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::dungeon_content::data(arg2)) == 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::item_type(0x2::kiosk::borrow<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>(arg4, arg5, arg7)), 2702);
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::burn(arg4, arg5, arg3, arg7, 1, arg10);
        let v3 = 0x2::kiosk::borrow_mut<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>(arg4, arg5, arg6);
        assert!(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::world::prove_move(v3, v1, v2, arg9) == 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::world::name(arg0), 2706);
        let v4 = DungeonRun{
            dungeon : 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::dungeon_content::name(arg2),
            room    : 1,
            seed    : arg8,
        };
        write_run(v3, v4);
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::world::delay_checkpoint(v3, 3153600000000, arg9);
        let v5 = DungeonEntered{
            character : arg6,
            world     : 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::world::name(arg0),
            x         : v1,
            z         : v2,
        };
        0x2::event::emit<DungeonEntered>(v5);
    }

    public(friend) fun give_up_room(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::Fight, arg1: u64, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>, arg5: &mut 0x2::random::RandomGenerator, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        let v0 = dungeon_tag(arg0);
        let v1 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::fighter_character(arg0, arg1);
        let (v2, v3, _) = read_run(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::fighter_character_ref(arg0, arg1));
        assert!(v2 == 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::dungeon_name(&v0) && v3 == 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::dungeon_room(&v0), 2705);
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::forfeit(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v5 = 0x2::kiosk::borrow_mut<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>(arg2, arg3, v1);
        end_run(v5, arg6);
        let v6 = DungeonEnded{
            character : v1,
            world     : 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::fight_world(arg0),
            room      : v3,
            won       : false,
        };
        0x2::event::emit<DungeonEnded>(v6);
    }

    public fun has_run(arg0: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character) : bool {
        let v0 = DungeonRunKey{dummy_field: false};
        0x2::dynamic_field::exists<DungeonRunKey>(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::uid(arg0), v0)
    }

    public(friend) fun join_room(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::Fight, arg1: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::protected_policy::AresRPG_TransferPolicy<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_same_dungeon_room(arg0, 0x2::kiosk::borrow<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>(arg2, arg3, arg4));
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::join(arg0, arg1, arg2, arg3, arg4, 0, 0, false, arg5, arg6);
    }

    public(friend) fun join_room_grouped(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::Fight, arg1: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::protected_policy::AresRPG_TransferPolicy<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::party::Party, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_same_dungeon_room(arg0, 0x2::kiosk::borrow<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>(arg2, arg3, arg4));
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::join_grouped(arg0, arg1, arg2, arg3, arg4, 0, arg5, false, arg6, arg7);
    }

    fun read_run(arg0: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character) : (0x1::string::String, u64, u64) {
        let v0 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::uid(arg0);
        let v1 = DungeonRunKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<DungeonRunKey>(v0, v1), 2704);
        let v2 = DungeonRunKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow<DungeonRunKey, DungeonRun>(v0, v2);
        (v3.dungeon, v3.room, v3.seed)
    }

    public(friend) fun settle_many_rooms(arg0: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::dungeon_content::DungeonContent, arg1: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::Fight, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::PM>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &0x2::transfer_policy::TransferPolicy<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>, arg8: &0x2::transfer_policy::TransferPolicy<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>, arg9: &mut 0x2::random::RandomGenerator, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::is_empty<u64>(&arg2) && 0x1::vector::length<u64>(&arg2) == 0x1::vector::length<u64>(&arg3), 2705);
        while (!0x1::vector::is_empty<u64>(&arg2)) {
            let v0 = 0x1::vector::empty<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::PM>();
            let v1 = 0x1::vector::pop_back<u64>(&mut arg3);
            assert!(v1 <= 0x1::vector::length<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::PM>(&arg4), 2705);
            while (v1 > 0) {
                0x1::vector::push_back<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::PM>(&mut v0, 0x1::vector::pop_back<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::PM>(&mut arg4));
                v1 = v1 - 1;
            };
            settle_room(arg0, arg1, 0x1::vector::pop_back<u64>(&mut arg2), arg5, arg6, arg7, arg8, v0, arg9, arg10, arg11);
        };
        assert!(0x1::vector::is_empty<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::PM>(&arg4), 2705);
    }

    public(friend) fun settle_room(arg0: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::dungeon_content::DungeonContent, arg1: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::Fight, arg2: u64, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>, arg6: &0x2::transfer_policy::TransferPolicy<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>, arg7: vector<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::PM>, arg8: &mut 0x2::random::RandomGenerator, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = dungeon_tag(arg1);
        let v1 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::dungeon_name(&v0);
        assert!(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::dungeon_content::name(arg0) == v1, 2705);
        let v2 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::fighter_character(arg1, arg2);
        let v3 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::fighter_won(arg1, arg2);
        let (v4, v5, v6) = read_run(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::fighter_character_ref(arg1, arg2));
        assert!(v4 == v1 && v5 == 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::dungeon_room(&v0), 2705);
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::settle(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v7 = 0x2::kiosk::borrow_mut<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character>(arg3, arg4, v2);
        if (v3 && v5 < 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::dungeon_data::room_count(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::dungeon_content::data(arg0))) {
            let v8 = DungeonRun{
                dungeon : v4,
                room    : v5 + 1,
                seed    : v6,
            };
            write_run(v7, v8);
            0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::world::delay_checkpoint(v7, 3153600000000, arg9);
            let v9 = DungeonRoomCleared{
                character : v2,
                world     : 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::fight_world(arg1),
                room      : v5,
            };
            0x2::event::emit<DungeonRoomCleared>(v9);
        } else {
            end_run(v7, arg9);
            let v10 = DungeonEnded{
                character : v2,
                world     : 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::fight_world(arg1),
                room      : v5,
                won       : v3,
            };
            0x2::event::emit<DungeonEnded>(v10);
        };
    }

    fun write_run(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character, arg1: DungeonRun) {
        let v0 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::uid_mut(arg0);
        let v1 = DungeonRunKey{dummy_field: false};
        if (0x2::dynamic_field::exists<DungeonRunKey>(v0, v1)) {
            let v2 = DungeonRunKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<DungeonRunKey, DungeonRun>(v0, v2) = arg1;
        } else {
            let v3 = DungeonRunKey{dummy_field: false};
            0x2::dynamic_field::add<DungeonRunKey, DungeonRun>(v0, v3, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

