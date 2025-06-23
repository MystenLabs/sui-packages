module 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_dropped_event {
    struct ItemDroppedEvent has copy, drop {
        name: 0x1::ascii::String,
        player: address,
        item_id: u256,
        quantities: u256,
        random: u256,
    }

    public fun new(arg0: 0x1::ascii::String, arg1: address, arg2: u256, arg3: u256, arg4: u256) : ItemDroppedEvent {
        ItemDroppedEvent{
            name       : arg0,
            player     : arg1,
            item_id    : arg2,
            quantities : arg3,
            random     : arg4,
        }
    }

    // decompiled from Move bytecode v6
}

