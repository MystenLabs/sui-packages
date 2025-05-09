module 0x4078fe9f8e60191b1ec85d4092b4ec070736dd7c4a3b0c69b1f121c4c6aee910::dummy {
    struct Witness has drop {
        dummy_field: bool,
    }

    public fun migrate<T0, T1>(arg0: 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::MemezMigrator<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        let (v1, v2) = 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_fun::destroy<T0, T1, Witness>(arg0, v0);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg1), v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg1), v3);
    }

    // decompiled from Move bytecode v6
}

