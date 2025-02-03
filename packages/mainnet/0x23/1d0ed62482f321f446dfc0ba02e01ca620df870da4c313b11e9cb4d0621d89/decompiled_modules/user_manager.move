module 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::user_manager {
    struct UserManagerInfo has store, key {
        id: 0x2::object::UID,
        user_address_catalog: UserAddressCatalog,
        chain_id_to_group: 0x2::table::Table<u16, u16>,
    }

    struct UserAddressCatalog has store {
        user_address_to_user_id: 0x2::table::Table<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress, u64>,
        user_id_to_addresses: 0x2::table::Table<u64, vector<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress>>,
    }

    struct BindUser has copy, drop {
        dola_user_address: 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress,
        dola_user_id: u64,
    }

    struct UnbindUser has copy, drop {
        dola_user_address: 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress,
        dola_user_id: u64,
    }

    public(friend) fun bind_user_address(arg0: &mut UserManagerInfo, arg1: 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress, arg2: 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress) {
        let v0 = get_dola_user_id(arg0, arg1);
        let v1 = process_group_id(arg0, arg2);
        let v2 = &mut arg0.user_address_catalog;
        assert!(!0x2::table::contains<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress, u64>(&mut v2.user_address_to_user_id, v1), 0);
        0x2::table::add<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress, u64>(&mut v2.user_address_to_user_id, v1, v0);
        0x1::vector::push_back<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress>(0x2::table::borrow_mut<u64, vector<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress>>(&mut v2.user_id_to_addresses, v0), v1);
        let v3 = BindUser{
            dola_user_address : v1,
            dola_user_id      : v0,
        };
        0x2::event::emit<BindUser>(v3);
    }

    public fun get_dola_user_id(arg0: &UserManagerInfo, arg1: 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress) : u64 {
        let v0 = process_group_id(arg0, arg1);
        let v1 = &arg0.user_address_catalog;
        assert!(0x2::table::contains<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress, u64>(&v1.user_address_to_user_id, v0), 1);
        *0x2::table::borrow<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress, u64>(&v1.user_address_to_user_id, v0)
    }

    public fun get_user_addresses(arg0: &UserManagerInfo, arg1: u64) : vector<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress> {
        let v0 = &arg0.user_address_catalog;
        assert!(0x2::table::contains<u64, vector<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress>>(&v0.user_id_to_addresses, arg1), 1);
        *0x2::table::borrow<u64, vector<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress>>(&v0.user_id_to_addresses, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UserAddressCatalog{
            user_address_to_user_id : 0x2::table::new<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress, u64>(arg0),
            user_id_to_addresses    : 0x2::table::new<u64, vector<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress>>(arg0),
        };
        let v1 = UserManagerInfo{
            id                   : 0x2::object::new(arg0),
            user_address_catalog : v0,
            chain_id_to_group    : 0x2::table::new<u16, u16>(arg0),
        };
        0x2::transfer::share_object<UserManagerInfo>(v1);
    }

    public fun is_dola_user(arg0: &UserManagerInfo, arg1: 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress) : bool {
        0x2::table::contains<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress, u64>(&arg0.user_address_catalog.user_address_to_user_id, process_group_id(arg0, arg1))
    }

    public fun process_group_id(arg0: &UserManagerInfo, arg1: 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress) : 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress {
        let v0 = 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::get_dola_chain_id(&arg1);
        let v1 = &arg0.chain_id_to_group;
        if (0x2::table::contains<u16, u16>(v1, v0)) {
            0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::update_dola_chain_id(arg1, *0x2::table::borrow<u16, u16>(v1, v0))
        } else {
            arg1
        }
    }

    public fun register_dola_chain_id(arg0: &0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceCap, arg1: &mut UserManagerInfo, arg2: u16, arg3: u16) {
        let v0 = &mut arg1.chain_id_to_group;
        assert!(!0x2::table::contains<u16, u16>(v0, arg2), 3);
        0x2::table::add<u16, u16>(v0, arg2, arg3);
    }

    public(friend) fun register_dola_user_id(arg0: &mut UserManagerInfo, arg1: 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress) {
        let v0 = process_group_id(arg0, arg1);
        let v1 = &mut arg0.user_address_catalog;
        assert!(!0x2::table::contains<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress, u64>(&mut v1.user_address_to_user_id, v0), 0);
        let v2 = 0x2::table::length<u64, vector<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress>>(&v1.user_id_to_addresses) + 1;
        let v3 = 0x1::vector::empty<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress>();
        0x2::table::add<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress, u64>(&mut v1.user_address_to_user_id, v0, v2);
        0x1::vector::push_back<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress>(&mut v3, v0);
        0x2::table::add<u64, vector<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress>>(&mut v1.user_id_to_addresses, v2, v3);
        let v4 = BindUser{
            dola_user_address : v0,
            dola_user_id      : v2,
        };
        0x2::event::emit<BindUser>(v4);
    }

    public(friend) fun unbind_user_address(arg0: &mut UserManagerInfo, arg1: 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress, arg2: 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress) {
        let v0 = get_dola_user_id(arg0, arg1);
        let v1 = get_dola_user_id(arg0, arg2);
        assert!(v0 == v1, 5);
        let v2 = process_group_id(arg0, arg2);
        let v3 = &mut arg0.user_address_catalog;
        let v4 = 0x2::table::borrow_mut<u64, vector<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress>>(&mut v3.user_id_to_addresses, v1);
        assert!(0x1::vector::length<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress>(v4) >= 2, 2);
        let (_, v6) = 0x1::vector::index_of<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress>(v4, &v2);
        0x2::table::remove<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress, u64>(&mut v3.user_address_to_user_id, v2);
        0x1::vector::remove<0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::dola_address::DolaAddress>(v4, v6);
        let v7 = UnbindUser{
            dola_user_address : v2,
            dola_user_id      : v0,
        };
        0x2::event::emit<UnbindUser>(v7);
    }

    public fun unregister_dola_chain_id(arg0: &0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceCap, arg1: &mut UserManagerInfo, arg2: u16) {
        let v0 = &mut arg1.chain_id_to_group;
        assert!(0x2::table::contains<u16, u16>(v0, arg2), 4);
        0x2::table::remove<u16, u16>(v0, arg2);
    }

    // decompiled from Move bytecode v6
}

