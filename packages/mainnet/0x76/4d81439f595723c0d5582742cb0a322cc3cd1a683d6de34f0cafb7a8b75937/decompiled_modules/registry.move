module 0x764d81439f595723c0d5582742cb0a322cc3cd1a683d6de34f0cafb7a8b75937::registry {
    struct CoinDecimalsRegistry has key {
        id: 0x2::object::UID,
        coin_decimals_table: 0x2::table::Table<0x1::type_name::TypeName, u8>,
    }

    public fun get_coin_decimals<T0>(arg0: &CoinDecimalsRegistry) : u8 {
        *0x2::table::borrow<0x1::type_name::TypeName, u8>(&arg0.coin_decimals_table, 0x1::type_name::get<T0>())
    }

    public fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinDecimalsRegistry{
            id                  : 0x2::object::new(arg0),
            coin_decimals_table : 0x2::table::new<0x1::type_name::TypeName, u8>(arg0),
        };
        0x2::transfer::share_object<CoinDecimalsRegistry>(v0);
    }

    public fun set_coin_decimals<T0>(arg0: &mut CoinDecimalsRegistry, arg1: u8) {
        0x2::table::add<0x1::type_name::TypeName, u8>(&mut arg0.coin_decimals_table, 0x1::type_name::get<T0>(), arg1);
    }

    // decompiled from Move bytecode v6
}

