module 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::mastery {
    struct MasteryKey has copy, drop, store {
        pos0: address,
    }

    struct MasteryOfferKey has copy, drop, store {
        pos0: 0x1::string::String,
    }

    struct Mastery has key {
        id: 0x2::object::UID,
        owner: address,
        points: u64,
        last_completed_epoch: 0x1::option::Option<u64>,
        quest_epoch: u64,
        quest_started_ms: u64,
        quest_world: 0x1::string::String,
        quest_dungeon: 0x2::object::ID,
        quest_reward: u8,
        quest_completed: bool,
    }

    struct MasteryOffer has key {
        id: 0x2::object::UID,
        item_type: 0x1::string::String,
        template: 0x2::object::ID,
        cost: u64,
        enabled: bool,
    }

    struct MasteryUpdated has copy, drop {
        mastery: 0x2::object::ID,
        owner: address,
        points: u64,
        last_completed_epoch: 0x1::option::Option<u64>,
        quest_epoch: u64,
        quest_started_ms: u64,
        quest_world: 0x1::string::String,
        quest_dungeon: 0x2::object::ID,
        quest_reward: u8,
        quest_completed: bool,
    }

    fun accumulated_points(arg0: u64, arg1: u8) : u64 {
        arg0 + (arg1 as u64)
    }

    fun assert_offer(arg0: &MasteryOffer, arg1: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::ItemTemplate) {
        assert!(arg0.enabled, 3107);
        assert!(0x2::object::id<0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::ItemTemplate>(arg1) == arg0.template, 3106);
    }

    fun assert_owner(arg0: &Mastery, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 3102);
    }

    fun assign(arg0: &mut Mastery, arg1: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::WorldContent, arg2: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character, arg3: &mut 0x2::random::RandomGenerator, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg5);
        assert!(arg0.quest_epoch != v0, 3103);
        let v1 = 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::entry_level(arg1);
        assert!(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::level(arg2) >= v1, 3105);
        let v2 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::cities(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::data(arg1));
        assert!(!0x1::vector::is_empty<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::City>(&v2), 3104);
        arg0.quest_epoch = v0;
        arg0.quest_started_ms = 0x2::clock::timestamp_ms(arg4);
        arg0.quest_world = 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::name(arg1);
        arg0.quest_dungeon = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::dungeon(0x1::vector::borrow<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::City>(&v2, 0x2::random::generate_u64_in_range(arg3, 0, 0x1::vector::length<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::City>(&v2) - 1)));
        arg0.quest_reward = reward(v1);
        arg0.quest_completed = false;
        emit_update(arg0);
    }

    public(friend) fun complete_if_eligible(arg0: &mut Mastery, arg1: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::Fight, arg2: u64, arg3: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::dungeon_content::DungeonContent, arg4: &0x2::tx_context::TxContext) : bool {
        assert_owner(arg0, arg4);
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::assert_controlled_character(arg1, arg2, 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::fighter_character(arg1, arg2), arg4);
        let v0 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::dungeon_tag(arg1);
        let v1 = if (arg0.quest_completed) {
            true
        } else if (arg0.quest_epoch != 0x2::tx_context::epoch(arg4)) {
            true
        } else {
            let v2 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::fight_world(arg1);
            if (!completion_started_after_assignment(arg0.quest_started_ms, &arg0.quest_world, 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::placement_started_ms(arg1), &v2)) {
                true
            } else if (!0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::fighter_won(arg1, arg2)) {
                true
            } else {
                0x1::option::is_none<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::DungeonTag>(&v0)
            }
        };
        if (v1) {
            return false
        };
        let v3 = 0x1::option::borrow<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::DungeonTag>(&v0);
        let v4 = if (arg0.quest_dungeon != 0x2::object::id<0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::dungeon_content::DungeonContent>(arg3)) {
            true
        } else if (0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::dungeon_name(v3) != 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::dungeon_content::name(arg3)) {
            true
        } else {
            0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::fight::dungeon_room(v3) != 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::dungeon_data::room_count(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::dungeon_content::data(arg3))
        };
        if (v4) {
            return false
        };
        arg0.points = accumulated_points(arg0.points, arg0.quest_reward);
        arg0.last_completed_epoch = 0x1::option::some<u64>(0x2::tx_context::epoch(arg4));
        arg0.quest_completed = true;
        emit_update(arg0);
        true
    }

    fun completion_started_after_assignment(arg0: u64, arg1: &0x1::string::String, arg2: u64, arg3: &0x1::string::String) : bool {
        arg2 > arg0 && arg3 == arg1
    }

    fun emit_update(arg0: &Mastery) {
        let v0 = MasteryUpdated{
            mastery              : 0x2::object::uid_to_inner(&arg0.id),
            owner                : arg0.owner,
            points               : arg0.points,
            last_completed_epoch : arg0.last_completed_epoch,
            quest_epoch          : arg0.quest_epoch,
            quest_started_ms     : arg0.quest_started_ms,
            quest_world          : arg0.quest_world,
            quest_dungeon        : arg0.quest_dungeon,
            quest_reward         : arg0.quest_reward,
            quest_completed      : arg0.quest_completed,
        };
        0x2::event::emit<MasteryUpdated>(v0);
    }

    public fun new_offer(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::ItemTemplate, arg3: u64, arg4: bool, arg5: &0x2::tx_context::TxContext) {
        assert!(arg3 > 0 && arg3 <= 18446744073709551615 / 0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::unit(), 3109);
        assert!(!0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::has_stats(arg2), 3110);
        let v0 = 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::template_type(arg2);
        let v1 = MasteryOfferKey{pos0: v0};
        let v2 = MasteryOffer{
            id        : 0x2::derived_object::claim<MasteryOfferKey>(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::uid_mut(arg0, arg1, arg5), v1),
            item_type : v0,
            template  : 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::template_id(arg2),
            cost      : arg3,
            enabled   : arg4,
        };
        0x2::transfer::share_object<MasteryOffer>(v2);
        0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"mastery_offers"), 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::template_type(arg2), arg5);
    }

    public(friend) fun redeem(arg0: &mut Mastery, arg1: &MasteryOffer, arg2: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::ItemTemplate, arg3: 0x1::option::Option<0x2::object::ID>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &0x2::transfer_policy::TransferPolicy<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>, arg7: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg7);
        assert_offer(arg1, arg2);
        assert!(arg0.points >= arg1.cost, 3108);
        arg0.points = arg0.points - arg1.cost;
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::deposit(arg4, arg5, arg6, arg3, 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::mint_plain(arg2, 1, arg7));
        emit_update(arg0);
    }

    public(friend) fun redeem_kares(arg0: &mut 0x2::coin_registry::Currency<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>, arg1: 0x2::coin::Coin<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>, arg2: &MasteryOffer, arg3: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::ItemTemplate, arg4: 0x1::option::Option<0x2::object::ID>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &0x2::transfer_policy::TransferPolicy<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>, arg8: &mut 0x2::tx_context::TxContext) {
        assert_offer(arg2, arg3);
        assert!(0x2::coin::value<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(&arg1) == arg2.cost * 0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::unit(), 3112);
        0x2::coin_registry::burn<0x9ec62f9d6a4b3ac73931f06392765e8e351b0ff299bfb4d7387a7869114a436::kares::KARES>(arg0, arg1);
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::deposit(arg5, arg6, arg7, arg4, 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::mint_plain(arg3, 1, arg8));
    }

    fun reward(arg0: u16) : u8 {
        if (arg0 >= 200) {
            5
        } else {
            ((1 + (arg0 - 1) / 50) as u8)
        }
    }

    public fun set_enabled(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: &mut MasteryOffer, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        arg2.enabled = arg3;
        0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"mastery_offers"), arg2.item_type, arg4);
    }

    public fun set_offer(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: &mut MasteryOffer, arg3: u64, arg4: bool, arg5: &0x2::tx_context::TxContext) {
        assert!(arg2.cost == arg3, 3111);
        set_enabled(arg0, arg1, arg2, arg4, arg5);
    }

    public(friend) fun start(arg0: &mut Mastery, arg1: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::WorldContent, arg2: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character, arg3: &mut 0x2::random::RandomGenerator, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg5);
        assign(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public(friend) fun start_first(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::friends::FriendRegistry, arg1: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content::WorldContent, arg2: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character, arg3: &mut 0x2::random::RandomGenerator, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = MasteryKey{pos0: v0};
        assert!(!0x2::derived_object::exists<MasteryKey>(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::friends::uid(arg0), v1), 3101);
        let v2 = MasteryKey{pos0: v0};
        let v3 = Mastery{
            id                   : 0x2::derived_object::claim<MasteryKey>(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::friends::uid_mut(arg0), v2),
            owner                : v0,
            points               : 0,
            last_completed_epoch : 0x1::option::none<u64>(),
            quest_epoch          : 0,
            quest_started_ms     : 0,
            quest_world          : 0x1::string::utf8(b""),
            quest_dungeon        : 0x2::object::id_from_address(@0x0),
            quest_reward         : 0,
            quest_completed      : false,
        };
        let v4 = &mut v3;
        assign(v4, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::transfer<Mastery>(v3, v0);
    }

    // decompiled from Move bytecode v7
}

