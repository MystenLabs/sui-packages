module 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::inventory_item {
    struct InventoryItem has drop, store {
        instance_id: u64,
        item_id: u64,
        type_id: u64,
        agility_bonus: u64,
        endurance_bonus: u64,
        stealth_bonus: u64,
        luck_bonus: u64,
        enchantment_rarity: u8,
    }

    public(friend) fun agility_bonus(arg0: &InventoryItem) : u64 {
        arg0.agility_bonus
    }

    public(friend) fun enchantment_rarity(arg0: &InventoryItem) : u8 {
        arg0.enchantment_rarity
    }

    public(friend) fun endurance_bonus(arg0: &InventoryItem) : u64 {
        arg0.endurance_bonus
    }

    public(friend) fun instance_id(arg0: &InventoryItem) : u64 {
        arg0.instance_id
    }

    public(friend) fun item_id(arg0: &InventoryItem) : u64 {
        arg0.item_id
    }

    public(friend) fun luck_bonus(arg0: &InventoryItem) : u64 {
        arg0.luck_bonus
    }

    public(friend) fun new_basic_item(arg0: u64, arg1: u64, arg2: u64) : InventoryItem {
        InventoryItem{
            instance_id        : arg0,
            item_id            : arg1,
            type_id            : arg2,
            agility_bonus      : 0,
            endurance_bonus    : 0,
            stealth_bonus      : 0,
            luck_bonus         : 0,
            enchantment_rarity : 0,
        }
    }

    public(friend) fun new_item_with_bonuses(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u8) : InventoryItem {
        InventoryItem{
            instance_id        : arg0,
            item_id            : arg1,
            type_id            : arg2,
            agility_bonus      : arg3,
            endurance_bonus    : arg4,
            stealth_bonus      : arg5,
            luck_bonus         : arg6,
            enchantment_rarity : arg7,
        }
    }

    public(friend) fun set_bonuses(arg0: &mut InventoryItem, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u8) {
        arg0.agility_bonus = arg1;
        arg0.endurance_bonus = arg2;
        arg0.stealth_bonus = arg3;
        arg0.luck_bonus = arg4;
        arg0.enchantment_rarity = arg5;
    }

    public(friend) fun stealth_bonus(arg0: &InventoryItem) : u64 {
        arg0.stealth_bonus
    }

    public(friend) fun type_id(arg0: &InventoryItem) : u64 {
        arg0.type_id
    }

    // decompiled from Move bytecode v6
}

