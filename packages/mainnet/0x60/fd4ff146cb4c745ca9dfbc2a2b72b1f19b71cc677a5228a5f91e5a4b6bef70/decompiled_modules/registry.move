module 0x60fd4ff146cb4c745ca9dfbc2a2b72b1f19b71cc677a5228a5f91e5a4b6bef70::registry {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CoinDecimalsRegistry has key {
        id: 0x2::object::UID,
        coin_decimals_table: 0x2::table::Table<0x1::type_name::TypeName, u8>,
    }

    public fun get_coin_decimals(arg0: &CoinDecimalsRegistry, arg1: 0x1::type_name::TypeName) : u8 {
        *0x2::table::borrow<0x1::type_name::TypeName, u8>(&arg0.coin_decimals_table, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinDecimalsRegistry{
            id                  : 0x2::object::new(arg0),
            coin_decimals_table : 0x2::table::new<0x1::type_name::TypeName, u8>(arg0),
        };
        0x2::transfer::share_object<CoinDecimalsRegistry>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun set_coin_decimals<T0>(arg0: &AdminCap, arg1: &mut CoinDecimalsRegistry, arg2: u8) {
        0x2::table::add<0x1::type_name::TypeName, u8>(&mut arg1.coin_decimals_table, 0x1::type_name::get<T0>(), arg2);
    }

    // decompiled from Move bytecode v6
}

