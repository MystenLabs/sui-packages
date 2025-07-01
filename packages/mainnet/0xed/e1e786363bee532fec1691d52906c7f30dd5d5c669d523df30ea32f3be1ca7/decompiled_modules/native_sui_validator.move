module 0xede1e786363bee532fec1691d52906c7f30dd5d5c669d523df30ea32f3be1ca7::native_sui_validator {
    public fun emergency_type_check<T0>() : bool {
        0x1::type_name::get<T0>() == 0x1::type_name::get<0x2::sui::SUI>()
    }

    public fun get_native_sui_type() : 0x1::type_name::TypeName {
        0x1::type_name::get<0x2::sui::SUI>()
    }

    public fun get_validated_sui_value(arg0: &0x2::coin::Coin<0x2::sui::SUI>) : u64 {
        validate_native_sui_coin<0x2::sui::SUI>(arg0);
        0x2::coin::value<0x2::sui::SUI>(arg0)
    }

    public fun is_native_sui<T0>() : bool {
        0x1::type_name::get<T0>() == 0x1::type_name::get<0x2::sui::SUI>()
    }

    public fun safe_split_sui(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        validate_native_sui_coin<0x2::sui::SUI>(arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= arg1, 102);
        0x2::coin::split<0x2::sui::SUI>(arg0, arg1, arg2)
    }

    public fun safe_transfer_sui(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address) {
        validate_native_sui_coin<0x2::sui::SUI>(&arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1);
    }

    public fun validate_atomic_swap_types<T0, T1>() {
        validate_native_sui_type(0x1::type_name::get<T0>());
        validate_native_sui_type(0x1::type_name::get<T1>());
    }

    public fun validate_native_sui_coin<T0>(arg0: &0x2::coin::Coin<T0>) {
        validate_native_sui_type(0x1::type_name::get<T0>());
        assert!(0x2::coin::value<T0>(arg0) > 0, 102);
    }

    public fun validate_native_sui_type(arg0: 0x1::type_name::TypeName) {
        assert!(arg0 == 0x1::type_name::get<0x2::sui::SUI>(), 100);
    }

    // decompiled from Move bytecode v6
}

