module 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::coin_decimals_registry {
    struct COIN_DECIMALS_REGISTRY has drop {
        dummy_field: bool,
    }

    struct CoinDecimalsRegistry has store, key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<0x1::type_name::TypeName, u8>,
    }

    public fun decimals(arg0: &CoinDecimalsRegistry, arg1: 0x1::type_name::TypeName) : u8 {
        assert!(0x2::table::contains<0x1::type_name::TypeName, u8>(&arg0.table, arg1), 999);
        *0x2::table::borrow<0x1::type_name::TypeName, u8>(&arg0.table, arg1)
    }

    fun init(arg0: COIN_DECIMALS_REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<COIN_DECIMALS_REGISTRY>(arg0, arg1);
        let v0 = CoinDecimalsRegistry{
            id    : 0x2::object::new(arg1),
            table : 0x2::table::new<0x1::type_name::TypeName, u8>(arg1),
        };
        0x2::transfer::public_share_object<CoinDecimalsRegistry>(v0);
    }

    public(friend) fun register_decimals<T0>(arg0: &mut CoinDecimalsRegistry, arg1: &0x2::coin::CoinMetadata<T0>) : u8 {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::coin::get_decimals<T0>(arg1);
        assert!(!0x2::table::contains<0x1::type_name::TypeName, u8>(&arg0.table, v0), 0x8e4d801f5a5991c5b5ff852242ae9ad0112e104c2f8f8298f3678ee2ef228044::error::coin_decimals_registry_already_registered());
        0x2::table::add<0x1::type_name::TypeName, u8>(&mut arg0.table, v0, v1);
        v1
    }

    // decompiled from Move bytecode v6
}

