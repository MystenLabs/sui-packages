module 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::ve_token {
    struct VE_TOKEN has drop {
        dummy_field: bool,
    }

    struct VeToken has store, key {
        id: 0x2::object::UID,
        bond_mode: u8,
        unbond_at: u64,
        balance: 0x2::balance::Balance<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>,
    }

    public fun balance(arg0: &VeToken) : u64 {
        0x2::balance::value<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>(&arg0.balance)
    }

    public(friend) fun split(arg0: &mut VeToken, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : VeToken {
        assert!(arg1 > 0 && arg1 < 0x2::balance::value<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>(&arg0.balance), 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::error::e_invalid_split_amount());
        VeToken{
            id        : 0x2::object::new(arg2),
            bond_mode : arg0.bond_mode,
            unbond_at : arg0.unbond_at,
            balance   : 0x2::balance::split<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>(&mut arg0.balance, arg1),
        }
    }

    public fun bond_info(arg0: &VeToken) : (u64, u8, u64) {
        (0x2::balance::value<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>(&arg0.balance), arg0.bond_mode, arg0.unbond_at)
    }

    public fun bond_mode(arg0: &VeToken) : u8 {
        arg0.bond_mode
    }

    public fun bond_mode_max_bond() : u8 {
        2
    }

    public fun bond_mode_normal() : u8 {
        1
    }

    public fun calculate_ve_vote_power(arg0: &VeToken, arg1: &0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::ve_mmt::VeMMT, arg2: u64, arg3: u64) : u64 {
        if (unbond_at(arg0) == max_bond_unbond_at()) {
            0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::vote_power::vote_power_for_max_bond(arg2)
        } else {
            0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::vote_power::vote_power_for_range(0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::ve_mmt::vp_config(arg1), 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::ve_mmt::ep_config(arg1), arg2, arg3, unbond_at(arg0))
        }
    }

    public(friend) fun check_merge_allowed(arg0: &VeToken, arg1: &VeToken) : bool {
        arg0.bond_mode == 2 || arg1.bond_mode == 2 && false || arg0.unbond_at >= arg1.unbond_at
    }

    public(friend) fun create(arg0: &0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::ve_mmt::VeMMT, arg1: 0x2::balance::Balance<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>, arg2: u64, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : VeToken {
        assert!(arg3 == 1 || arg3 == 2, 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::error::e_invalid_bond_mode());
        if (arg3 == 2) {
            assert!(arg2 == 18446744073709551615, 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::error::e_invalid_unbond_at());
        };
        if (arg3 == 1) {
            let v0 = if (arg2 > 0x2::clock::timestamp_ms(arg4)) {
                if (arg2 <= get_normal_max_unbond_at(arg0, arg4)) {
                    0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::epoch::is_epoch_start(0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::ve_mmt::ep_config(arg0), arg2)
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v0, 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::error::e_invalid_unbond_at());
        };
        VeToken{
            id        : 0x2::object::new(arg5),
            bond_mode : arg3,
            unbond_at : arg2,
            balance   : arg1,
        }
    }

    public(friend) fun deposit(arg0: &mut VeToken, arg1: 0x2::balance::Balance<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>) {
        0x2::balance::join<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>(&mut arg0.balance, arg1);
    }

    public(friend) fun extend(arg0: &mut VeToken, arg1: &0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::ve_mmt::VeMMT, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = if (arg2 > arg0.unbond_at) {
            if (arg2 > 0x2::clock::timestamp_ms(arg3)) {
                if (arg2 <= get_normal_max_unbond_at(arg1, arg3)) {
                    bond_mode(arg0) != 2
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::error::e_invalid_unbond_at());
        arg0.unbond_at = arg2;
    }

    public fun get_dynamic_field<T0: drop + store>(arg0: &VeToken) : &T0 {
        0x2::dynamic_field::borrow<0x1::type_name::TypeName, T0>(&arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    public(friend) fun get_dynamic_field_mut<T0: drop + store>(arg0: &mut VeToken) : &mut T0 {
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, T0>(&mut arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    fun get_normal_max_unbond_at(arg0: &0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::ve_mmt::VeMMT, arg1: &0x2::clock::Clock) : u64 {
        let (v0, v1) = 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::ve_mmt::config_fields(arg0);
        0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::epoch::epoch_start(v1, 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::epoch::epoch_id(v1, 0x2::clock::timestamp_ms(arg1)) + 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::vote_power::max_bond_epochs(v0))
    }

    public(friend) fun has_dynamic_field<T0: drop + store>(arg0: &VeToken) : bool {
        0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, T0>(&arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun id(arg0: &VeToken) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    fun init(arg0: VE_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"veMMT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"veMMT is the governance and utility token of Momentum, granting holders the ability to direct emissions toward preferred pools, earn a share of swap fees and incentives as well as take part in key ecosystem governance decisions."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://momentum-statics.s3.us-west-1.amazonaws.com/ve_mmt.png"));
        let v4 = 0x2::package::claim<VE_TOKEN>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<VeToken>(&v4, v0, v2, arg1);
        0x2::display::update_version<VeToken>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<VeToken>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun max_bond_unbond_at() : u64 {
        18446744073709551615
    }

    public(friend) fun merge(arg0: &mut VeToken, arg1: VeToken) {
        assert!(check_merge_allowed(arg0, &arg1), 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::error::e_invalid_merge());
        let VeToken {
            id        : v0,
            bond_mode : _,
            unbond_at : _,
            balance   : v3,
        } = arg1;
        0x2::object::delete(v0);
        0x2::balance::join<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>(&mut arg0.balance, v3);
    }

    public(friend) fun remove_dynamic_field<T0: drop + store>(arg0: &mut VeToken) {
        0x2::dynamic_field::remove<0x1::type_name::TypeName, T0>(&mut arg0.id, 0x1::type_name::with_defining_ids<T0>());
    }

    public(friend) fun set_max_bond(arg0: &mut VeToken) {
        assert!(bond_mode(arg0) == 1, 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::error::e_invalid_bond_mode());
        arg0.bond_mode = 2;
        arg0.unbond_at = 18446744073709551615;
    }

    public(friend) fun set_normal(arg0: &mut VeToken, arg1: &0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::ve_mmt::VeMMT, arg2: &0x2::clock::Clock) {
        assert!(bond_mode(arg0) == 2, 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::error::e_invalid_bond_mode());
        arg0.bond_mode = 1;
        arg0.unbond_at = get_normal_max_unbond_at(arg1, arg2);
    }

    public(friend) fun unbond(arg0: VeToken, arg1: &0x2::clock::Clock) : 0x2::balance::Balance<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT> {
        assert!(0x2::clock::timestamp_ms(arg1) >= unbond_at(&arg0), 0xdb4f99394cb32de5f48e0be6435c1a6b01552bd10607a7a249f14a3a1faf09f5::error::e_not_unbond_yet());
        let VeToken {
            id        : v0,
            bond_mode : _,
            unbond_at : _,
            balance   : v3,
        } = arg0;
        0x2::object::delete(v0);
        v3
    }

    public fun unbond_at(arg0: &VeToken) : u64 {
        arg0.unbond_at
    }

    public(friend) fun update_dynamic_field<T0: drop + store>(arg0: &mut VeToken, arg1: T0) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, T0>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<0x1::type_name::TypeName, T0>(&mut arg0.id, v0);
        };
        0x2::dynamic_field::add<0x1::type_name::TypeName, T0>(&mut arg0.id, v0, arg1);
    }

    // decompiled from Move bytecode v6
}

