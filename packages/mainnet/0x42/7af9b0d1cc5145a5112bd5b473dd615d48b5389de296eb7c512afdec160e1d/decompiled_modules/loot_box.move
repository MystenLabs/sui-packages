module 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::loot_box {
    struct LootRegistry has key {
        id: 0x2::object::UID,
        tables: 0x2::table::Table<0x2::object::ID, vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::loot_table::LootEntry>>,
    }

    struct BoxClaim has key {
        id: 0x2::object::UID,
        box_template: 0x2::object::ID,
        rolled_template: 0x2::object::ID,
        amount: u32,
    }

    struct LootTableSet has copy, drop {
        box_template: 0x2::object::ID,
        rows: u64,
        weight_sum: u64,
    }

    struct LootBoxOpened has copy, drop {
        box_template: 0x2::object::ID,
        rolled_template: 0x2::object::ID,
        amount: u32,
        opener: address,
    }

    struct LootClaimed has copy, drop {
        box_template: 0x2::object::ID,
        rolled_template: 0x2::object::ID,
        amount: u32,
        opener: address,
    }

    public fun add_loot_reward(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: &mut LootRegistry, arg3: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::ItemTemplate, arg4: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::ItemTemplate, arg5: u64, arg6: u32, arg7: &0x2::tx_context::TxContext) {
        assert!(is_gacha_box(arg3), 2905);
        assert!(arg6 > 0, 2908);
        let v0 = if (arg6 == 1) {
            true
        } else {
            let v1 = 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::template_category(arg4);
            0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::content_rules::is_stackable(&v1)
        };
        assert!(v0, 2909);
        let v2 = 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::template_id(arg3);
        if (0x2::table::contains<0x2::object::ID, vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::loot_table::LootEntry>>(&arg2.tables, v2)) {
            0x1::vector::push_back<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::loot_table::LootEntry>(0x2::table::borrow_mut<0x2::object::ID, vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::loot_table::LootEntry>>(&mut arg2.tables, v2), 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::loot_table::new_entry(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::template_id(arg4), arg5, arg6));
        } else {
            let v3 = 0x1::vector::empty<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::loot_table::LootEntry>();
            0x1::vector::push_back<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::loot_table::LootEntry>(&mut v3, 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::loot_table::new_entry(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::template_id(arg4), arg5, arg6));
            0x2::table::add<0x2::object::ID, vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::loot_table::LootEntry>>(&mut arg2.tables, v2, v3);
        };
        let v4 = 0x2::table::borrow<0x2::object::ID, vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::loot_table::LootEntry>>(&arg2.tables, v2);
        let v5 = LootTableSet{
            box_template : v2,
            rows         : 0x1::vector::length<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::loot_table::LootEntry>(v4),
            weight_sum   : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::loot_table::total_weight(v4),
        };
        0x2::event::emit<LootTableSet>(v5);
        0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"loot_boxes"), 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::template_type(arg3), arg7);
    }

    public(friend) fun assert_valid_box(arg0: &LootRegistry, arg1: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::ItemTemplate) {
        assert!(is_gacha_box(arg1), 2905);
        assert!(has_valid_table(arg0, arg1), 2906);
    }

    public(friend) fun claim_loot(arg0: BoxClaim, arg1: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::ItemTemplate, arg2: 0x1::option::Option<0x2::object::ID>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>, arg6: &mut 0x2::random::RandomGenerator, arg7: &mut 0x2::tx_context::TxContext) {
        let BoxClaim {
            id              : v0,
            box_template    : v1,
            rolled_template : v2,
            amount          : v3,
        } = arg0;
        assert!(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::template_id(arg1) == v2, 2907);
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::deposit(arg3, arg4, arg5, arg2, 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::mint(arg1, v3, arg6, arg7));
        let v4 = LootClaimed{
            box_template    : v1,
            rolled_template : v2,
            amount          : v3,
            opener          : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<LootClaimed>(v4);
        0x2::object::delete(v0);
    }

    public fun clear_loot_table(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: &mut LootRegistry, arg3: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::ItemTemplate, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::template_id(arg3);
        if (0x2::table::contains<0x2::object::ID, vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::loot_table::LootEntry>>(&arg2.tables, v0)) {
            0x2::table::remove<0x2::object::ID, vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::loot_table::LootEntry>>(&mut arg2.tables, v0);
        };
        0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"loot_boxes"), 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::template_type(arg3), arg4);
    }

    public(friend) fun has_valid_table(arg0: &LootRegistry, arg1: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::ItemTemplate) : bool {
        let v0 = 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::template_id(arg1);
        0x2::table::contains<0x2::object::ID, vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::loot_table::LootEntry>>(&arg0.tables, v0) && 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::loot_table::total_weight(0x2::table::borrow<0x2::object::ID, vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::loot_table::LootEntry>>(&arg0.tables, v0)) > 0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LootRegistry{
            id     : 0x2::object::new(arg0),
            tables : 0x2::table::new<0x2::object::ID, vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::loot_table::LootEntry>>(arg0),
        };
        0x2::transfer::share_object<LootRegistry>(v0);
    }

    fun is_gacha_box(arg0: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::ItemTemplate) : bool {
        let v0 = 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::consumable_effect(arg0);
        0x1::option::is_some<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::consumable_effect::Effect>(&v0) && 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::consumable_effect::is_loot_box(0x1::option::borrow<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::consumable_effect::Effect>(&v0))
    }

    public(friend) fun open_box(arg0: &LootRegistry, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::ItemTemplate, arg5: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::protected_policy::AresRPG_TransferPolicy<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>, arg6: &mut 0x2::random::RandomGenerator, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(is_gacha_box(arg4), 2905);
        let v0 = 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::item_rows::template_id(arg4);
        assert!(0x2::table::contains<0x2::object::ID, vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::loot_table::LootEntry>>(&arg0.tables, v0), 2906);
        let v1 = *0x2::table::borrow<0x2::object::ID, vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::loot_table::LootEntry>>(&arg0.tables, v0);
        let v2 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::loot_table::total_weight(&v1);
        assert!(v2 > 0, 2904);
        assert!(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::template(0x2::kiosk::borrow<0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::Item>(arg1, arg2, arg3)) == v0, 2905);
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::item::burn(arg1, arg2, arg5, arg3, 1, arg7);
        let v3 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::loot_table::pick(&v1, 0x2::random::generate_u64_in_range(arg6, 0, v2 - 1));
        let v4 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::loot_table::template(&v3);
        let v5 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::loot_table::amount(&v3);
        let v6 = 0x2::tx_context::sender(arg7);
        let v7 = LootBoxOpened{
            box_template    : v0,
            rolled_template : v4,
            amount          : v5,
            opener          : v6,
        };
        0x2::event::emit<LootBoxOpened>(v7);
        let v8 = BoxClaim{
            id              : 0x2::object::new(arg7),
            box_template    : v0,
            rolled_template : v4,
            amount          : v5,
        };
        0x2::transfer::transfer<BoxClaim>(v8, v6);
    }

    // decompiled from Move bytecode v7
}

