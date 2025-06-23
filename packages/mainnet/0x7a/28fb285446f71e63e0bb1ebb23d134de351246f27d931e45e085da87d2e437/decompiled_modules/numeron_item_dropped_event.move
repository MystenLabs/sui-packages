module 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_item_dropped_event {
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

