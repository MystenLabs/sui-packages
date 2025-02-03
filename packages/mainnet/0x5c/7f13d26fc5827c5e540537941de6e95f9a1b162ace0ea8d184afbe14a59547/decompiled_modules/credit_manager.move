module 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::credit_manager {
    struct CreditManager has store, key {
        id: 0x2::object::UID,
        whitelisted_tiers: 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::TableKeys<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x2::object::ID>>,
    }

    public(friend) fun add_whitelisted_tier(arg0: &mut CreditManager, arg1: 0x1::type_name::TypeName, arg2: 0x2::object::ID) {
        if (0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::is_present<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.whitelisted_tiers, arg1)) {
            0x2::vec_set::insert<0x2::object::ID>(0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::borrow_mut_table<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.whitelisted_tiers, arg1), arg2);
        } else {
            let v0 = 0x2::vec_set::empty<0x2::object::ID>();
            0x2::vec_set::insert<0x2::object::ID>(&mut v0, arg2);
            0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::add_key_value_pair<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.whitelisted_tiers, arg1, v0);
        };
    }

    public(friend) fun initialize(arg0: &mut 0x2::tx_context::TxContext) : CreditManager {
        CreditManager{
            id                : 0x2::object::new(arg0),
            whitelisted_tiers : 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::new<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x2::object::ID>>(arg0),
        }
    }

    public fun is_tier_whitelisted(arg0: &CreditManager, arg1: 0x1::type_name::TypeName, arg2: 0x2::object::ID) : bool {
        if (0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::is_present<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.whitelisted_tiers, arg1)) {
            return 0x2::vec_set::contains<0x2::object::ID>(0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::borrow_table<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.whitelisted_tiers, arg1), &arg2)
        };
        false
    }

    // decompiled from Move bytecode v6
}

