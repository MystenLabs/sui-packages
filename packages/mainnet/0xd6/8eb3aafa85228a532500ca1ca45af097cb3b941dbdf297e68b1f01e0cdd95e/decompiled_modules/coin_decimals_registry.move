module 0xd68eb3aafa85228a532500ca1ca45af097cb3b941dbdf297e68b1f01e0cdd95e::coin_decimals_registry {
    struct CoinDecimalsRegistry has store, key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<0x1::type_name::TypeName, u8>,
    }

    public fun decimals(arg0: &CoinDecimalsRegistry, arg1: 0x1::type_name::TypeName) : u8 {
        *0x2::table::borrow<0x1::type_name::TypeName, u8>(&arg0.table, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinDecimalsRegistry{
            id    : 0x2::object::new(arg0),
            table : 0x2::table::new<0x1::type_name::TypeName, u8>(arg0),
        };
        0x2::table::add<0x1::type_name::TypeName, u8>(&mut v0.table, 0x1::type_name::get<0x2::sui::SUI>(), 9);
        0x2::transfer::public_share_object<CoinDecimalsRegistry>(v0);
    }

    public entry fun register_decimals<T0>(arg0: &mut CoinDecimalsRegistry, arg1: &0x2::coin::CoinMetadata<T0>) {
        0x2::table::add<0x1::type_name::TypeName, u8>(&mut arg0.table, 0x1::type_name::get<T0>(), 0x2::coin::get_decimals<T0>(arg1));
    }

    public fun registry_table(arg0: &CoinDecimalsRegistry) : &0x2::table::Table<0x1::type_name::TypeName, u8> {
        &arg0.table
    }

    // decompiled from Move bytecode v6
}

