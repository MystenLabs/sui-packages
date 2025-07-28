module 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::item_types {
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

    public fun decrement_current_count(arg0: &mut ItemInfo) {
        if (arg0.current_count > 0) {
            arg0.current_count = arg0.current_count - 1;
        };
    }

    public fun increment_current_count(arg0: &mut ItemInfo) {
        arg0.current_count = arg0.current_count + 1;
    }

    public fun item_info_current_count(arg0: &ItemInfo) : u64 {
        arg0.current_count
    }

    public fun item_info_drop_rate(arg0: &ItemInfo) : u64 {
        arg0.drop_rate
    }

    public fun item_info_faction(arg0: &ItemInfo) : &0x1::option::Option<u64> {
        &arg0.faction
    }

    public fun item_info_id(arg0: &ItemInfo) : u64 {
        arg0.item_id
    }

    public fun item_info_max_supply(arg0: &ItemInfo) : u64 {
        arg0.max_supply
    }

    public fun item_info_name(arg0: &ItemInfo) : &0x1::string::String {
        &arg0.name
    }

    public fun item_info_type_id(arg0: &ItemInfo) : u64 {
        arg0.type_id
    }

    public fun item_type_id(arg0: &ItemType) : u64 {
        arg0.id
    }

    public fun item_type_name(arg0: &ItemType) : &0x1::string::String {
        &arg0.name
    }

    public fun new_item_info(arg0: u64, arg1: u64, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::option::Option<u64>) : ItemInfo {
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

    public fun new_item_selection_result(arg0: u64, arg1: u64) : ItemSelectionResult {
        ItemSelectionResult{
            item_id : arg0,
            type_id : arg1,
        }
    }

    public fun new_item_type(arg0: u64, arg1: 0x1::string::String) : ItemType {
        ItemType{
            id   : arg0,
            name : arg1,
        }
    }

    public fun selection_result_item_id(arg0: &ItemSelectionResult) : u64 {
        arg0.item_id
    }

    public fun selection_result_type_id(arg0: &ItemSelectionResult) : u64 {
        arg0.type_id
    }

    // decompiled from Move bytecode v6
}

