module 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct TreasuryClaimEvent has copy, drop {
        pool: 0x1::string::String,
        pair_name: 0x1::string::String,
        pair_index: u32,
        amount: u64,
    }

    public entry fun claim_treasury<T0, T1>(arg0: &AdminCap, arg1: &0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::Configuration<T0, T1>, arg2: &mut 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::custodian::Custodian<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::custodian::get_treasury_value<T0, T1>(arg2);
        assert!(v0 > 0, 300);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::custodian::sub_treasury_balance<T0, T1>(arg2, v0), arg3), 0x2::tx_context::sender(arg3));
        let v1 = TreasuryClaimEvent{
            pool       : 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pool<T0, T1>(arg1),
            pair_name  : 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pair_name<T0, T1>(arg1),
            pair_index : 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::get_pair_index<T0, T1>(arg1),
            amount     : v0,
        };
        0x2::event::emit<TreasuryClaimEvent>(v1);
    }

    public entry fun create_pair<T0: drop, T1: drop>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u32, arg9: &mut 0x2::tx_context::TxContext) {
        0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration::new<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::state::new<T0, T1>(arg9);
        0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::custodian::new<T0, T1>(arg9);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, @0xfdab8ca73c9eecba705890f48293e57574f866fb5e59a1a3de4f33b0681ea368);
    }

    public entry fun set_admin(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<AdminCap>(v0, arg1);
    }

    public entry fun set_operator<T0, T1>(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::operator::new_operator<T0, T1>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

