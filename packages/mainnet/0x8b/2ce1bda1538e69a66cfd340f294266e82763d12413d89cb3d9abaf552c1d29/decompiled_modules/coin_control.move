module 0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::coin_control {
    struct Control<phantom T0> has store, key {
        id: 0x2::object::UID,
        authority: 0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::authority::Authority,
        treasury: 0x2::coin::TreasuryCap<T0>,
        metadata_id: 0x2::object::ID,
        metadata_uri: 0x1::string::String,
        deny_cap: 0x1::option::Option<0x2::coin::DenyCapV2<T0>>,
        maximum_supply: u64,
        lifetime_cap: bool,
        minted: u64,
        mintable: bool,
        burnable: bool,
        metadata_mutable: bool,
        pause_allowed: bool,
        blocklist_allowed: bool,
        paused: bool,
        denied: 0x2::vec_set::VecSet<address>,
    }

    struct Created has copy, drop {
        id: 0x2::object::ID,
        creator: address,
        owner: address,
        metadata: 0x2::object::ID,
        initial_supply: u64,
        maximum_supply: u64,
        lifetime_cap: bool,
        mintable: bool,
        burnable: bool,
        metadata_mutable: bool,
        pause_allowed: bool,
        blocklist_allowed: bool,
        metadata_uri: 0x1::string::String,
    }

    struct SupplyChanged has copy, drop {
        id: 0x2::object::ID,
        minted: bool,
        amount: u64,
        supply: u64,
    }

    public fun burn<T0>(arg0: &mut Control<T0>, arg1: 0x2::coin::Coin<T0>) {
        assert!(arg0.burnable, 2);
        let v0 = SupplyChanged{
            id     : 0x2::object::id<Control<T0>>(arg0),
            minted : false,
            amount : 0x2::coin::burn<T0>(&mut arg0.treasury, arg1),
            supply : 0x2::coin::total_supply<T0>(&arg0.treasury),
        };
        0x2::event::emit<SupplyChanged>(v0);
    }

    public fun mint<T0>(arg0: &mut Control<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::authority::assert_role(&arg0.authority, 0x2::tx_context::sender(arg3), 1);
        assert!(arg0.mintable && !arg0.paused, 2);
        assert!(arg1 > 0 && arg2 != @0x0, 4);
        let v0 = if (arg0.lifetime_cap) {
            arg0.minted
        } else {
            0x2::coin::total_supply<T0>(&arg0.treasury)
        };
        assert!((v0 as u128) + (arg1 as u128) <= (arg0.maximum_supply as u128), 3);
        if (arg0.lifetime_cap) {
            arg0.minted = arg0.minted + arg1;
        };
        let v1 = SupplyChanged{
            id     : 0x2::object::id<Control<T0>>(arg0),
            minted : true,
            amount : arg1,
            supply : 0x2::coin::total_supply<T0>(&arg0.treasury),
        };
        0x2::event::emit<SupplyChanged>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut arg0.treasury, arg1, arg3), arg2);
    }

    public fun new<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::CoinMetadata<T0>, arg2: 0x1::option::Option<0x2::coin::DenyCapV2<T0>>, arg3: address, arg4: vector<address>, arg5: vector<u64>, arg6: u64, arg7: u64, arg8: bool, arg9: bool, arg10: bool, arg11: bool, arg12: bool, arg13: bool, arg14: 0x1::string::String, arg15: &mut 0x2::tx_context::TxContext) : (Control<T0>, 0x2::coin::Coin<T0>) {
        let v0 = if (0x2::coin::total_supply<T0>(&arg0) == 0) {
            if (arg6 > 0) {
                if (arg7 >= arg6) {
                    0x1::option::is_some<0x2::coin::DenyCapV2<T0>>(&arg2) || !arg12 && !arg13
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        let v1 = if (arg3 != @0x0) {
            true
        } else if (!arg9) {
            if (!arg11) {
                if (!arg12) {
                    if (!arg13) {
                        if (0x1::vector::is_empty<address>(&arg4)) {
                            0x1::vector::is_empty<u64>(&arg5)
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 1);
        let v2 = 0x2::object::id<0x2::coin::CoinMetadata<T0>>(&arg1);
        if (arg11) {
            0x2::transfer::public_share_object<0x2::coin::CoinMetadata<T0>>(arg1);
        } else {
            0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(arg1);
        };
        let v3 = if (arg3 == @0x0) {
            0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::authority::renounced()
        } else {
            0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::authority::with_roles(arg3, arg4, arg5)
        };
        let v4 = Control<T0>{
            id                : 0x2::object::new(arg15),
            authority         : v3,
            treasury          : arg0,
            metadata_id       : v2,
            metadata_uri      : arg14,
            deny_cap          : arg2,
            maximum_supply    : arg7,
            lifetime_cap      : arg8,
            minted            : arg6,
            mintable          : arg9,
            burnable          : arg10,
            metadata_mutable  : arg11,
            pause_allowed     : arg12,
            blocklist_allowed : arg13,
            paused            : false,
            denied            : 0x2::vec_set::empty<address>(),
        };
        let v5 = Created{
            id                : 0x2::object::id<Control<T0>>(&v4),
            creator           : 0x2::tx_context::sender(arg15),
            owner             : arg3,
            metadata          : v2,
            initial_supply    : arg6,
            maximum_supply    : arg7,
            lifetime_cap      : arg8,
            mintable          : arg9,
            burnable          : arg10,
            metadata_mutable  : arg11,
            pause_allowed     : arg12,
            blocklist_allowed : arg13,
            metadata_uri      : arg14,
        };
        0x2::event::emit<Created>(v5);
        (v4, 0x2::coin::mint<T0>(&mut arg0, arg6, arg15))
    }

    public fun cancel_nomination<T0>(arg0: &mut Control<T0>, arg1: &0x2::tx_context::TxContext) {
        0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::authority::cancel_nomination(&mut arg0.authority, 0x2::tx_context::sender(arg1));
    }

    public fun owner<T0>(arg0: &Control<T0>) : address {
        0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::authority::owner(&arg0.authority)
    }

    public fun set_role<T0>(arg0: &mut Control<T0>, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::authority::set_role(&mut arg0.authority, 0x2::tx_context::sender(arg3), arg1, arg2);
    }

    public fun accept_owner<T0>(arg0: &mut Control<T0>, arg1: &0x2::tx_context::TxContext) {
        0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::authority::accept(&mut arg0.authority, 0x2::tx_context::sender(arg1));
    }

    public fun freeze_metadata<T0>(arg0: &mut Control<T0>, arg1: &0x2::tx_context::TxContext) {
        0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::authority::assert_owner(&arg0.authority, 0x2::tx_context::sender(arg1));
        arg0.metadata_mutable = false;
    }

    public fun maximum_supply<T0>(arg0: &Control<T0>) : u64 {
        arg0.maximum_supply
    }

    public fun metadata_mutable<T0>(arg0: &Control<T0>) : bool {
        arg0.metadata_mutable
    }

    public fun mintable<T0>(arg0: &Control<T0>) : bool {
        arg0.mintable
    }

    public fun nominate_owner<T0>(arg0: &mut Control<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::authority::nominate(&mut arg0.authority, 0x2::tx_context::sender(arg2), arg1);
    }

    public fun renounce_owner<T0>(arg0: &mut Control<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused && 0x2::vec_set::is_empty<address>(&arg0.denied), 6);
        0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::authority::renounce(&mut arg0.authority, 0x2::tx_context::sender(arg1));
        arg0.mintable = false;
        arg0.metadata_mutable = false;
        arg0.pause_allowed = false;
        arg0.blocklist_allowed = false;
    }

    public fun revoke_mint<T0>(arg0: &mut Control<T0>, arg1: &0x2::tx_context::TxContext) {
        0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::authority::assert_owner(&arg0.authority, 0x2::tx_context::sender(arg1));
        arg0.mintable = false;
    }

    public fun revoke_regulation<T0>(arg0: &mut Control<T0>, arg1: &0x2::tx_context::TxContext) {
        0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::authority::assert_owner(&arg0.authority, 0x2::tx_context::sender(arg1));
        assert!(!arg0.paused && 0x2::vec_set::is_empty<address>(&arg0.denied), 6);
        arg0.pause_allowed = false;
        arg0.blocklist_allowed = false;
    }

    public fun set_blocked<T0>(arg0: &mut Control<T0>, arg1: &mut 0x2::deny_list::DenyList, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::authority::assert_role(&arg0.authority, 0x2::tx_context::sender(arg4), 8);
        assert!(arg0.blocklist_allowed && 0x1::option::is_some<0x2::coin::DenyCapV2<T0>>(&arg0.deny_cap), 2);
        assert!(arg2 != @0x0, 1);
        if (arg3) {
            0x2::coin::deny_list_v2_add<T0>(arg1, 0x1::option::borrow_mut<0x2::coin::DenyCapV2<T0>>(&mut arg0.deny_cap), arg2, arg4);
            if (!0x2::vec_set::contains<address>(&arg0.denied, &arg2)) {
                0x2::vec_set::insert<address>(&mut arg0.denied, arg2);
            };
        } else {
            0x2::coin::deny_list_v2_remove<T0>(arg1, 0x1::option::borrow_mut<0x2::coin::DenyCapV2<T0>>(&mut arg0.deny_cap), arg2, arg4);
            if (0x2::vec_set::contains<address>(&arg0.denied, &arg2)) {
                0x2::vec_set::remove<address>(&mut arg0.denied, &arg2);
            };
        };
    }

    public fun set_paused<T0>(arg0: &mut Control<T0>, arg1: &mut 0x2::deny_list::DenyList, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::authority::assert_role(&arg0.authority, 0x2::tx_context::sender(arg3), 4);
        assert!(arg0.pause_allowed && 0x1::option::is_some<0x2::coin::DenyCapV2<T0>>(&arg0.deny_cap), 2);
        if (arg2) {
            0x2::coin::deny_list_v2_enable_global_pause<T0>(arg1, 0x1::option::borrow_mut<0x2::coin::DenyCapV2<T0>>(&mut arg0.deny_cap), arg3);
        } else {
            0x2::coin::deny_list_v2_disable_global_pause<T0>(arg1, 0x1::option::borrow_mut<0x2::coin::DenyCapV2<T0>>(&mut arg0.deny_cap), arg3);
        };
        arg0.paused = arg2;
    }

    public fun supply<T0>(arg0: &Control<T0>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.treasury)
    }

    public fun update_metadata<T0>(arg0: &mut Control<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x1::string::String, arg5: 0x1::ascii::String, arg6: 0x1::string::String, arg7: &0x2::tx_context::TxContext) {
        0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::authority::assert_role(&arg0.authority, 0x2::tx_context::sender(arg7), 2);
        assert!(arg0.metadata_mutable, 2);
        assert!(0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg1) == arg0.metadata_id, 5);
        let v0 = if (0x1::string::length(&arg2) > 0) {
            if (0x1::string::length(&arg2) <= 32) {
                if (0x1::ascii::length(&arg3) > 0) {
                    if (0x1::ascii::length(&arg3) <= 10) {
                        if (0x1::string::length(&arg4) <= 2000) {
                            if (0x1::ascii::length(&arg5) <= 500) {
                                0x1::string::length(&arg6) <= 600
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        0x2::coin::update_name<T0>(&arg0.treasury, arg1, arg2);
        0x2::coin::update_symbol<T0>(&arg0.treasury, arg1, arg3);
        0x2::coin::update_description<T0>(&arg0.treasury, arg1, arg4);
        0x2::coin::update_icon_url<T0>(&arg0.treasury, arg1, arg5);
        arg0.metadata_uri = arg6;
    }

    // decompiled from Move bytecode v7
}

