module 0xbd84dc8b419f380ec4f3cb82a8f27b6a88bdfd5d7578dd868a6aea9bdf88bcfd::party_platform_link {
    struct LinkSetEvent<phantom T0> has copy, drop {
        party_id: 0x2::object::ID,
    }

    struct LinkClearedEvent<phantom T0> has copy, drop {
        party_id: 0x2::object::ID,
    }

    public fun clear_link<T0: copy + drop + store>(arg0: &mut 0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party, arg1: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::PartyAdminCap) {
        let v0 = 0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid_mut(arg0, arg1);
        if (0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::exists_<T0>(v0)) {
            0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::clear<T0>(v0);
        };
    }

    public fun has_link<T0: copy + drop + store>(arg0: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party) : bool {
        0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::exists_<T0>(0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid(arg0))
    }

    public fun link<T0: copy + drop + store>(arg0: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party) : 0x1::option::Option<0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::PlatformLink<T0>> {
        0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::get<T0>(0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid(arg0))
    }

    public fun set_link<T0: copy + drop + store>(arg0: &mut 0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::Party, arg1: &0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::PartyAdminCap, arg2: 0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::PlatformLink<T0>) {
        0xd438098fe8368939389d7bea35641b81273fed38ff44aeeb1c887ae8e4575609::platform_link::set<T0>(0x8625400639b03bcb16478721d1d6992a719f230000bfcee426f5c760e082b173::party::uid_mut(arg0, arg1), arg2);
    }

    // decompiled from Move bytecode v7
}

