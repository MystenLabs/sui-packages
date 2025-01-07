module 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::coin_decimals {
    struct CoinDecimalsWitness has drop {
        dummy_field: bool,
    }

    struct Decimals has store {
        decimals: u8,
        scalar: u64,
    }

    struct CoinDecimals has store, key {
        id: 0x2::object::UID,
    }

    public fun add<T0>(arg0: &mut CoinDecimals, arg1: &0x2::coin::CoinMetadata<T0>) {
        if (contains<T0>(arg0)) {
            return
        };
        let v0 = 0x2::coin::get_decimals<T0>(arg1);
        let v1 = Decimals{
            decimals : v0,
            scalar   : 0x2::math::pow(10, v0),
        };
        0x2::dynamic_field::add<0x1::type_name::TypeName, Decimals>(&mut arg0.id, 0x1::type_name::get<T0>(), v1);
    }

    public fun new(arg0: &mut 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::owner::OwnerCap<CoinDecimalsWitness>, arg1: &mut 0x2::tx_context::TxContext) : CoinDecimals {
        let v0 = CoinDecimals{id: 0x2::object::new(arg1)};
        let v1 = CoinDecimalsWitness{dummy_field: false};
        0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::owner::add<CoinDecimalsWitness>(arg0, v1, 0x2::object::id<CoinDecimals>(&v0));
        v0
    }

    public fun contains<T0>(arg0: &CoinDecimals) : bool {
        0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T0>())
    }

    public fun decimals<T0>(arg0: &CoinDecimals) : u8 {
        0x2::dynamic_field::borrow<0x1::type_name::TypeName, Decimals>(&arg0.id, 0x1::type_name::get<T0>()).decimals
    }

    public fun destroy(arg0: CoinDecimals, arg1: &0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::owner::OwnerCap<CoinDecimalsWitness>) {
        0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::owner::assert_ownership<CoinDecimalsWitness>(arg1, 0x2::object::id<CoinDecimals>(&arg0));
        let CoinDecimals { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun new_cap(arg0: &mut 0x2::tx_context::TxContext) : 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::owner::OwnerCap<CoinDecimalsWitness> {
        let v0 = CoinDecimalsWitness{dummy_field: false};
        0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::owner::new<CoinDecimalsWitness>(v0, 0x1::vector::empty<0x2::object::ID>(), arg0)
    }

    public fun remove_and_destroy<T0>(arg0: &mut CoinDecimals, arg1: &0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::owner::OwnerCap<CoinDecimalsWitness>) {
        0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::owner::assert_ownership<CoinDecimalsWitness>(arg1, 0x2::object::id<CoinDecimals>(arg0));
        let Decimals {
            decimals : _,
            scalar   : _,
        } = 0x2::dynamic_field::remove<0x1::type_name::TypeName, Decimals>(&mut arg0.id, 0x1::type_name::get<T0>());
    }

    public fun scalar<T0>(arg0: &CoinDecimals) : u64 {
        0x2::dynamic_field::borrow<0x1::type_name::TypeName, Decimals>(&arg0.id, 0x1::type_name::get<T0>()).scalar
    }

    // decompiled from Move bytecode v6
}

