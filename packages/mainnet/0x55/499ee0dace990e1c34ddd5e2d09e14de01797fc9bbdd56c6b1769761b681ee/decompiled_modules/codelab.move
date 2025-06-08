module 0x55499ee0dace990e1c34ddd5e2d09e14de01797fc9bbdd56c6b1769761b681ee::codelab {
    struct Global {
        id: 0x2::object::UID,
        vault_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        vault_bag: 0x2::bag::Bag,
    }

    struct Swaping {
        from_coin_type: 0x1::type_name::TypeName,
        total_from_amount: u64,
        remaining_from_amount: u64,
        to_coin_type: 0x1::type_name::TypeName,
        accumulated_to_amount: u64,
        min_to_amount: u64,
        middle_coin_type: 0x1::type_name::TypeName,
        middle_amount: u64,
    }

    struct SwapEvent has copy, drop {
        sender: address,
        from_coin: 0x1::type_name::TypeName,
        from_amount: u64,
        middle_coin: 0x1::type_name::TypeName,
        middle_amount: u64,
        min_profit: u64,
        profit: u64,
    }

    // decompiled from Move bytecode v6
}

