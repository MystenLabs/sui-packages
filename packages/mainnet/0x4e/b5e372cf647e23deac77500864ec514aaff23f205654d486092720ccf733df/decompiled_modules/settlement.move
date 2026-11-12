module 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::settlement {
    public(friend) fun get_margin_left(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position, arg1: u128, arg2: u128) : u128 {
        0xaf6a713d4881d3f8061740dcd18b7cc0c1cb52d9776a3619db3b937719838174::settlement_math::margin_left(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::is_long(arg0), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::margin(arg0), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::oi_open(arg0), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::compute_average_entry_price(arg0), arg1, arg2)
    }

    public(friend) fun get_max_removeable_margin(arg0: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position, arg1: u128) : u128 {
        0xaf6a713d4881d3f8061740dcd18b7cc0c1cb52d9776a3619db3b937719838174::settlement_math::max_removable_margin(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::is_long(&arg0), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::mro(&arg0), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::margin(&arg0), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::oi_open(&arg0), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::size(&arg0), arg1)
    }

    public(friend) fun get_target_margin(arg0: &0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::Position, arg1: u128, arg2: u128) : u128 {
        0xaf6a713d4881d3f8061740dcd18b7cc0c1cb52d9776a3619db3b937719838174::settlement_math::target_margin(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::is_long(arg0), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::oi_open(arg0), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::position::size(arg0), arg1, arg2)
    }

    public(friend) fun trade_margin_settlement<T0>(arg0: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg1: address, arg2: address, arg3: address, arg4: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::S128, arg5: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::S128, arg6: u128) {
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::exists_account<T0>(arg0, arg2), 605);
        assert!(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::exists_account<T0>(arg0, arg3), 605);
        if (0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::gte_u128(arg4, 0)) {
            transfer_based_on_fundsflow<T0>(arg0, arg1, arg2, arg4, 0, arg6);
            transfer_based_on_fundsflow<T0>(arg0, arg1, arg3, arg5, 1, arg6);
        } else {
            transfer_based_on_fundsflow<T0>(arg0, arg1, arg3, arg5, 1, arg6);
            transfer_based_on_fundsflow<T0>(arg0, arg1, arg2, arg4, 0, arg6);
        };
    }

    fun transfer_based_on_fundsflow<T0>(arg0: &mut 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::Bank<T0>, arg1: address, arg2: address, arg3: 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::S128, arg4: u64, arg5: u128) {
        if (0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::value(arg3) == 0) {
            return
        };
        let (v0, v1, v2) = if (0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::gt_u128(arg3, 0)) {
            (arg1, arg4, arg2)
        } else {
            (arg2, 2, arg1)
        };
        0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::bank::transfer<T0>(arg0, v2, v0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::s128::value(arg3), v1, arg5);
    }

    // decompiled from Move bytecode v7
}

