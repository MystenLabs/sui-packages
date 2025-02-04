module 0xcfb49af8b467c2dadfd6cd983a83a927c03493c4fbd308972299c4018d8c5ef5::claim {
    struct Event has copy, drop, store {
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        uri: 0x1::string::String,
    }

    public fun create<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<T0>(&mut arg0, 1000000000, arg5, arg6);
        let v0 = Event{
            name        : arg1,
            symbol      : arg2,
            description : arg3,
            uri         : arg4,
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg0, @0x0);
        0x2::event::emit<Event>(v0);
    }

    // decompiled from Move bytecode v6
}

