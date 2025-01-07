module 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::clmm {
    public fun close_position<T0, T1>(arg0: &0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::config::FeeConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::fee::pay_fee_2<T0, T1, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_clmm::ClosePositionEvent>(arg0, arg1, arg2, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::constant::clmm_fee_type(), arg4);
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T0>(arg1));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T1>(arg2));
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_clmm::emit_close_position_event(0x2::tx_context::sender(arg4), v0, v2, arg3);
    }

    public fun create_position<T0, T1>(arg0: &0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::config::FeeConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::fee::pay_fee_2<T0, T1, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_clmm::CreatePositionEvent>(arg0, arg1, arg2, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::constant::clmm_fee_type(), arg4);
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T0>(arg1));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T1>(arg2));
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_clmm::emit_create_position_event(0x2::tx_context::sender(arg4), v0, v2, arg3);
    }

    public fun decrease_position<T0, T1>(arg0: &0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::config::FeeConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::fee::pay_fee_2<T0, T1, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_clmm::DecreasePositionEvent>(arg0, arg1, arg2, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::constant::clmm_fee_type(), arg4);
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T0>(arg1));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T1>(arg2));
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_clmm::emit_decrease_position_event(0x2::tx_context::sender(arg4), v0, v2, arg3);
    }

    public fun harvest_position<T0, T1>(arg0: &0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::config::FeeConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::fee::pay_fee_2<T0, T1, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_clmm::HarvestPositionEvent>(arg0, arg1, arg2, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::constant::clmm_fee_type(), arg4);
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T0>(arg1));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T1>(arg2));
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_clmm::emit_harvest_position_event(0x2::tx_context::sender(arg4), v0, v2, arg3);
    }

    public fun increase_position<T0, T1>(arg0: &0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::config::FeeConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::fee::pay_fee_2<T0, T1, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_clmm::IncreasePositionEvent>(arg0, arg1, arg2, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::constant::clmm_fee_type(), arg4);
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T0>(arg1));
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<T1>(arg2));
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_clmm::emit_increase_position_event(0x2::tx_context::sender(arg4), v0, v2, arg3);
    }

    // decompiled from Move bytecode v6
}

