module 0x47e2b8ae274759f3e355b19c4ab826fe5912a5e92ea0d700d2af6f912413daee::registry {
    struct CoinDecimalsRegistry has key {
        id: 0x2::object::UID,
        coin_decimals_table: 0x2::table::Table<0x1::type_name::TypeName, u8>,
    }

    public fun get_coin_decimals(arg0: &CoinDecimalsRegistry, arg1: 0x1::type_name::TypeName) : u8 {
        *0x2::table::borrow<0x1::type_name::TypeName, u8>(&arg0.coin_decimals_table, arg1)
    }

    public fun initialize(arg0: &mut 0x2::tx_context::TxContext) : CoinDecimalsRegistry {
        CoinDecimalsRegistry{
            id                  : 0x2::object::new(arg0),
            coin_decimals_table : 0x2::table::new<0x1::type_name::TypeName, u8>(arg0),
        }
    }

    public fun set_coin_decimals(arg0: &mut CoinDecimalsRegistry, arg1: 0x1::type_name::TypeName, arg2: u8) {
        0x2::table::add<0x1::type_name::TypeName, u8>(&mut arg0.coin_decimals_table, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

