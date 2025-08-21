module 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types {
    struct ItemType has drop, store {
        id: u64,
        name: 0x1::string::String,
    }

    struct ItemInfo has drop, store {
        item_id: u64,
        type_id: u64,
        name: 0x1::string::String,
        drop_rate: u64,
        max_supply: u64,
        current_count: u64,
        faction: 0x1::option::Option<u64>,
    }

    struct ItemSelectionResult has drop, store {
        item_id: u64,
        type_id: u64,
    }

    public(friend) fun decrement_current_count(arg0: &mut ItemInfo) {
        if (arg0.current_count > 0) {
            arg0.current_count = arg0.current_count - 1;
        };
    }

    public(friend) fun increment_current_count(arg0: &mut ItemInfo) {
        arg0.current_count = arg0.current_count + 1;
    }

    public(friend) fun item_info_current_count(arg0: &ItemInfo) : u64 {
        arg0.current_count
    }

    public(friend) fun item_info_drop_rate(arg0: &ItemInfo) : u64 {
        arg0.drop_rate
    }

    public(friend) fun item_info_faction(arg0: &ItemInfo) : &0x1::option::Option<u64> {
        &arg0.faction
    }

    public(friend) fun item_info_id(arg0: &ItemInfo) : u64 {
        arg0.item_id
    }

    public(friend) fun item_info_max_supply(arg0: &ItemInfo) : u64 {
        arg0.max_supply
    }

    public(friend) fun item_info_name(arg0: &ItemInfo) : &0x1::string::String {
        &arg0.name
    }

    public(friend) fun item_info_type_id(arg0: &ItemInfo) : u64 {
        arg0.type_id
    }

    public(friend) fun item_type_id(arg0: &ItemType) : u64 {
        arg0.id
    }

    public(friend) fun item_type_name(arg0: &ItemType) : &0x1::string::String {
        &arg0.name
    }

    public(friend) fun new_item_info(arg0: u64, arg1: u64, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::option::Option<u64>) : ItemInfo {
        ItemInfo{
            item_id       : arg0,
            type_id       : arg1,
            name          : arg2,
            drop_rate     : arg3,
            max_supply    : arg4,
            current_count : arg5,
            faction       : arg6,
        }
    }

    public(friend) fun new_item_selection_result(arg0: u64, arg1: u64) : ItemSelectionResult {
        ItemSelectionResult{
            item_id : arg0,
            type_id : arg1,
        }
    }

    public(friend) fun new_item_type(arg0: u64, arg1: 0x1::string::String) : ItemType {
        ItemType{
            id   : arg0,
            name : arg1,
        }
    }

    public(friend) fun selection_result_item_id(arg0: &ItemSelectionResult) : u64 {
        arg0.item_id
    }

    // decompiled from Move bytecode v6
}

