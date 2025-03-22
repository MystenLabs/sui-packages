module 0x9fc1f544fda3f56af7a9b5a9dff63f5b904409d2ff73fa2c2785af6d86c965e5::checker {
    struct Event has copy, drop {
        id: 0x2::object::ID,
    }

    struct EventClock has copy, drop {
        id: 0x2::object::ID,
        ts: u64,
    }

    public fun check1<T0, T1>(arg0: &mut 0xdca9d032a62241d631c48afd003d309d7d0b65efdee717785c0253370b01d5ba::scallop_vault::ScallopVault<T0, T1>) {
        let v0 = Event{id: 0x2::object::id<0xdca9d032a62241d631c48afd003d309d7d0b65efdee717785c0253370b01d5ba::scallop_vault::ScallopVault<T0, T1>>(arg0)};
        0x2::event::emit<Event>(v0);
    }

    public fun check2<T0, T1>(arg0: &mut 0xdca9d032a62241d631c48afd003d309d7d0b65efdee717785c0253370b01d5ba::scallop_vault::ScallopVault<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = EventClock{
            id : 0x2::object::id<0xdca9d032a62241d631c48afd003d309d7d0b65efdee717785c0253370b01d5ba::scallop_vault::ScallopVault<T0, T1>>(arg0),
            ts : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<EventClock>(v0);
    }

    public fun check3<T0, T1>(arg0: &mut 0xdca9d032a62241d631c48afd003d309d7d0b65efdee717785c0253370b01d5ba::scallop_vault::ScallopVault<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) {
        let v0 = EventClock{
            id : 0x2::object::id<0xdca9d032a62241d631c48afd003d309d7d0b65efdee717785c0253370b01d5ba::scallop_vault::ScallopVault<T0, T1>>(arg0),
            ts : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<EventClock>(v0);
    }

    public fun check4<T0, T1>(arg0: &mut 0xdca9d032a62241d631c48afd003d309d7d0b65efdee717785c0253370b01d5ba::scallop_vault::ScallopVault<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version) {
        let v0 = EventClock{
            id : 0x2::object::id<0xdca9d032a62241d631c48afd003d309d7d0b65efdee717785c0253370b01d5ba::scallop_vault::ScallopVault<T0, T1>>(arg0),
            ts : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<EventClock>(v0);
    }

    // decompiled from Move bytecode v6
}

