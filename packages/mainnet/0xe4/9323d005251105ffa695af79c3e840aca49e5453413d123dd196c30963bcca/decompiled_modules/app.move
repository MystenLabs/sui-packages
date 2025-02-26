module 0xe49323d005251105ffa695af79c3e840aca49e5453413d123dd196c30963bcca::app {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Acl has key {
        id: 0x2::object::UID,
    }

    public fun get_pool_admin(arg0: &Acl) : address {
        *0x2::dynamic_field::borrow<u64, address>(&arg0.id, 0xe49323d005251105ffa695af79c3e840aca49e5453413d123dd196c30963bcca::constants::pool_admin_df_key())
    }

    public fun get_rewarder_admin(arg0: &Acl) : address {
        *0x2::dynamic_field::borrow<u64, address>(&arg0.id, 0xe49323d005251105ffa695af79c3e840aca49e5453413d123dd196c30963bcca::constants::rewarder_admin_df_key())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Acl{id: 0x2::object::new(arg0)};
        0x2::dynamic_field::add<u64, address>(&mut v1.id, 0xe49323d005251105ffa695af79c3e840aca49e5453413d123dd196c30963bcca::constants::rewarder_admin_df_key(), 0x2::tx_context::sender(arg0));
        0x2::dynamic_field::add<u64, address>(&mut v1.id, 0xe49323d005251105ffa695af79c3e840aca49e5453413d123dd196c30963bcca::constants::pool_admin_df_key(), 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Acl>(v1);
    }

    public fun set_pool_admin(arg0: &AdminCap, arg1: &mut Acl, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        *0x2::dynamic_field::borrow_mut<u64, address>(&mut arg1.id, 0xe49323d005251105ffa695af79c3e840aca49e5453413d123dd196c30963bcca::constants::pool_admin_df_key()) = arg2;
    }

    public fun set_rewarder_admin(arg0: &AdminCap, arg1: &mut Acl, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        *0x2::dynamic_field::borrow_mut<u64, address>(&mut arg1.id, 0xe49323d005251105ffa695af79c3e840aca49e5453413d123dd196c30963bcca::constants::rewarder_admin_df_key()) = arg2;
    }

    // decompiled from Move bytecode v6
}

