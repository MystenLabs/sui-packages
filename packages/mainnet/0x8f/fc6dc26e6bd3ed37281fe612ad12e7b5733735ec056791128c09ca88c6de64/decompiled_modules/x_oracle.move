module 0x8ffc6dc26e6bd3ed37281fe612ad12e7b5733735ec056791128c09ca88c6de64::x_oracle {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BaseToken has copy, drop, store {
        id: u8,
    }

    struct XOracle has key {
        id: 0x2::object::UID,
        price_delay_tolerance_ms: u64,
        prices: 0x2::table::Table<BaseToken, 0x2::table::Table<0x1::type_name::TypeName, 0x8ffc6dc26e6bd3ed37281fe612ad12e7b5733735ec056791128c09ca88c6de64::price_feed::PriceFeed>>,
    }

    // decompiled from Move bytecode v6
}

