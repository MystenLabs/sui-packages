module 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_metadata {
    struct ItemMetadata has copy, drop, store {
        item_type: 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_type::ItemType,
        name: 0x1::ascii::String,
        description: 0x1::ascii::String,
        is_transferable: bool,
    }

    public fun get(arg0: &ItemMetadata) : (0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_type::ItemType, 0x1::ascii::String, 0x1::ascii::String, bool) {
        (arg0.item_type, arg0.name, arg0.description, arg0.is_transferable)
    }

    public fun get_description(arg0: &ItemMetadata) : 0x1::ascii::String {
        arg0.description
    }

    public fun get_is_transferable(arg0: &ItemMetadata) : bool {
        arg0.is_transferable
    }

    public fun get_item_type(arg0: &ItemMetadata) : 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_type::ItemType {
        arg0.item_type
    }

    public fun get_name(arg0: &ItemMetadata) : 0x1::ascii::String {
        arg0.name
    }

    public fun new(arg0: 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_type::ItemType, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: bool) : ItemMetadata {
        ItemMetadata{
            item_type       : arg0,
            name            : arg1,
            description     : arg2,
            is_transferable : arg3,
        }
    }

    public(friend) fun set(arg0: &mut ItemMetadata, arg1: 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_type::ItemType, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: bool) {
        arg0.item_type = arg1;
        arg0.name = arg2;
        arg0.description = arg3;
        arg0.is_transferable = arg4;
    }

    public(friend) fun set_description(arg0: &mut ItemMetadata, arg1: 0x1::ascii::String) {
        arg0.description = arg1;
    }

    public(friend) fun set_is_transferable(arg0: &mut ItemMetadata, arg1: bool) {
        arg0.is_transferable = arg1;
    }

    public(friend) fun set_item_type(arg0: &mut ItemMetadata, arg1: 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_type::ItemType) {
        arg0.item_type = arg1;
    }

    public(friend) fun set_name(arg0: &mut ItemMetadata, arg1: 0x1::ascii::String) {
        arg0.name = arg1;
    }

    // decompiled from Move bytecode v6
}

