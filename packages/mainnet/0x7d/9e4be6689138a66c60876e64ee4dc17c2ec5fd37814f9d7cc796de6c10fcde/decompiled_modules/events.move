module 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::events {
    struct ItemEquipEvent has copy, drop {
        character_id: 0x2::object::ID,
        slot: 0x1::string::String,
        kiosk_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
    }

    struct ItemUnequipEvent has copy, drop {
        character_id: 0x2::object::ID,
        slot: 0x1::string::String,
        kiosk_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
    }

    struct ItemMintEvent has copy, drop {
        item_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
    }

    struct ItemWithdrawEvent has copy, drop {
        item_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
    }

    struct ItemDestroyEvent has copy, drop {
        item_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
    }

    struct CharacterCreateEvent has copy, drop {
        character_id: 0x2::object::ID,
    }

    struct CharacterSelectEvent has copy, drop {
        character_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
    }

    struct CharacterUnselectEvent has copy, drop {
        character_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
    }

    struct CharacterDeleteEvent has copy, drop {
        character_id: 0x2::object::ID,
    }

    struct PetFeedEvent has copy, drop {
        pet_id: 0x2::object::ID,
    }

    struct AresRpgExtensionInstallEvent has copy, drop {
        kiosk_id: 0x2::object::ID,
    }

    struct RecipeCreateEvent has copy, drop {
        recipe_id: 0x2::object::ID,
    }

    struct RecipeDeleteEvent has copy, drop {
        recipe_id: 0x2::object::ID,
    }

    struct ItemMergeEvent has copy, drop {
        target_item_id: 0x2::object::ID,
        target_kiosk_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        final_amount: u32,
        kiosk_id: 0x2::object::ID,
    }

    struct ItemSplitEvent has copy, drop {
        item_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        new_item_id: 0x2::object::ID,
        amount: u32,
    }

    struct FinishedCraftEvent has copy, drop {
        id: 0x2::object::ID,
        recipe_id: 0x2::object::ID,
    }

    public(friend) fun emit_character_create_event(arg0: 0x2::object::ID) {
        let v0 = CharacterCreateEvent{character_id: arg0};
        0x2::event::emit<CharacterCreateEvent>(v0);
    }

    public(friend) fun emit_character_delete_event(arg0: 0x2::object::ID) {
        let v0 = CharacterDeleteEvent{character_id: arg0};
        0x2::event::emit<CharacterDeleteEvent>(v0);
    }

    public(friend) fun emit_character_select_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = CharacterSelectEvent{
            character_id : arg0,
            kiosk_id     : arg1,
        };
        0x2::event::emit<CharacterSelectEvent>(v0);
    }

    public(friend) fun emit_character_unselect_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = CharacterUnselectEvent{
            character_id : arg0,
            kiosk_id     : arg1,
        };
        0x2::event::emit<CharacterUnselectEvent>(v0);
    }

    public(friend) fun emit_extension_install_event(arg0: 0x2::object::ID) {
        let v0 = AresRpgExtensionInstallEvent{kiosk_id: arg0};
        0x2::event::emit<AresRpgExtensionInstallEvent>(v0);
    }

    public(friend) fun emit_finished_craft_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = FinishedCraftEvent{
            id        : arg0,
            recipe_id : arg1,
        };
        0x2::event::emit<FinishedCraftEvent>(v0);
    }

    public(friend) fun emit_item_destroy_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = ItemDestroyEvent{
            item_id  : arg0,
            kiosk_id : arg1,
        };
        0x2::event::emit<ItemDestroyEvent>(v0);
    }

    public(friend) fun emit_item_equip_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        let v0 = ItemEquipEvent{
            character_id : arg0,
            slot         : arg1,
            kiosk_id     : arg2,
            item_id      : arg3,
        };
        0x2::event::emit<ItemEquipEvent>(v0);
    }

    public(friend) fun emit_item_merge_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u32, arg4: 0x2::object::ID) {
        let v0 = ItemMergeEvent{
            target_item_id  : arg0,
            target_kiosk_id : arg1,
            item_id         : arg2,
            final_amount    : arg3,
            kiosk_id        : arg4,
        };
        0x2::event::emit<ItemMergeEvent>(v0);
    }

    public(friend) fun emit_item_mint_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = ItemMintEvent{
            item_id  : arg0,
            kiosk_id : arg1,
        };
        0x2::event::emit<ItemMintEvent>(v0);
    }

    public(friend) fun emit_item_split_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u32) {
        let v0 = ItemSplitEvent{
            item_id     : arg0,
            kiosk_id    : arg1,
            new_item_id : arg2,
            amount      : arg3,
        };
        0x2::event::emit<ItemSplitEvent>(v0);
    }

    public(friend) fun emit_item_unequip_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        let v0 = ItemUnequipEvent{
            character_id : arg0,
            slot         : arg1,
            kiosk_id     : arg2,
            item_id      : arg3,
        };
        0x2::event::emit<ItemUnequipEvent>(v0);
    }

    public(friend) fun emit_item_withdraw_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = ItemWithdrawEvent{
            item_id  : arg0,
            kiosk_id : arg1,
        };
        0x2::event::emit<ItemWithdrawEvent>(v0);
    }

    public(friend) fun emit_pet_feed_event(arg0: 0x2::object::ID) {
        let v0 = PetFeedEvent{pet_id: arg0};
        0x2::event::emit<PetFeedEvent>(v0);
    }

    public(friend) fun emit_recipe_create_event(arg0: 0x2::object::ID) {
        let v0 = RecipeCreateEvent{recipe_id: arg0};
        0x2::event::emit<RecipeCreateEvent>(v0);
    }

    public(friend) fun emit_recipe_delete_event(arg0: 0x2::object::ID) {
        let v0 = RecipeDeleteEvent{recipe_id: arg0};
        0x2::event::emit<RecipeDeleteEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

