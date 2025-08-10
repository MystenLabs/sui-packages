module 0x5a1be1a62c21d9dab3bfd4d453ebf6dc1df8984285a68eedd6b3c27139b84115::account {
    struct Account has store {
        balances: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        bag: 0x2::bag::Bag,
    }

    // decompiled from Move bytecode v6
}

