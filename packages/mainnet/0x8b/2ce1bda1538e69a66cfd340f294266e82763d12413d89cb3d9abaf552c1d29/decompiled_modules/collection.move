module 0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::collection {
    struct Collection<phantom T0> has store, key {
        id: 0x2::object::UID,
        authority: 0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::authority::Authority,
        policy_cap: 0x2::transfer_policy::TransferPolicyCap<T0>,
        policy_id: 0x2::object::ID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        metadata_uri: 0x1::string::String,
        maximum_supply: u64,
        minted: u64,
        mintable: bool,
        burnable: bool,
        metadata_mutable: bool,
        paused: bool,
        royalty_mutable: bool,
        maximum_royalty_bps: u16,
    }

    struct MintTicket<phantom T0> {
        collection: 0x2::object::ID,
        serial: u64,
    }

    struct Created has copy, drop {
        id: 0x2::object::ID,
        creator: address,
        owner: address,
        policy: 0x2::object::ID,
        maximum_supply: u64,
        burnable: bool,
        metadata_mutable: bool,
        royalty_bps: u16,
        royalty_recipient: address,
        maximum_royalty_bps: u16,
        royalty_mutable: bool,
    }

    public fun new<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: 0x2::transfer_policy::TransferPolicyCap<T0>, arg2: address, arg3: vector<address>, arg4: vector<u64>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: u64, arg11: bool, arg12: bool, arg13: u16, arg14: address, arg15: u16, arg16: bool, arg17: &mut 0x2::tx_context::TxContext) : Collection<T0> {
        let v0 = if (0x1::string::length(&arg5) > 0) {
            if (0x1::string::length(&arg5) <= 32) {
                if (0x1::string::length(&arg6) > 0) {
                    if (0x1::string::length(&arg6) <= 10) {
                        if (0x1::string::length(&arg7) <= 2000) {
                            if (0x1::string::length(&arg8) <= 500) {
                                if (0x1::string::length(&arg9) <= 600) {
                                    if (arg10 > 0) {
                                        if (arg10 <= 1000000) {
                                            if (arg13 <= arg15) {
                                                arg15 <= 10000
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
        0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::royalty::set<T0>(arg0, &arg1, arg13, arg14);
        let v1 = 0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg0);
        let v2 = Collection<T0>{
            id                  : 0x2::object::new(arg17),
            authority           : 0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::authority::with_roles(arg2, arg3, arg4),
            policy_cap          : arg1,
            policy_id           : v1,
            name                : arg5,
            symbol              : arg6,
            description         : arg7,
            image_url           : arg8,
            metadata_uri        : arg9,
            maximum_supply      : arg10,
            minted              : 0,
            mintable            : true,
            burnable            : arg11,
            metadata_mutable    : arg12,
            paused              : false,
            royalty_mutable     : arg16,
            maximum_royalty_bps : arg15,
        };
        let v3 = Created{
            id                  : 0x2::object::id<Collection<T0>>(&v2),
            creator             : 0x2::tx_context::sender(arg17),
            owner               : arg2,
            policy              : v1,
            maximum_supply      : arg10,
            burnable            : arg11,
            metadata_mutable    : arg12,
            royalty_bps         : arg13,
            royalty_recipient   : arg14,
            maximum_royalty_bps : arg15,
            royalty_mutable     : arg16,
        };
        0x2::event::emit<Created>(v3);
        v2
    }

    public fun cancel_nomination<T0>(arg0: &mut Collection<T0>, arg1: &0x2::tx_context::TxContext) {
        0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::authority::cancel_nomination(&mut arg0.authority, 0x2::tx_context::sender(arg1));
    }

    public fun owner<T0>(arg0: &Collection<T0>) : address {
        0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::authority::owner(&arg0.authority)
    }

    public fun set_role<T0>(arg0: &mut Collection<T0>, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::authority::set_role(&mut arg0.authority, 0x2::tx_context::sender(arg3), arg1, arg2);
    }

    public fun accept_owner<T0>(arg0: &mut Collection<T0>, arg1: &0x2::tx_context::TxContext) {
        0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::authority::accept(&mut arg0.authority, 0x2::tx_context::sender(arg1));
    }

    public fun assert_metadata<T0>(arg0: &Collection<T0>, arg1: &0x2::tx_context::TxContext) {
        0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::authority::assert_role(&arg0.authority, 0x2::tx_context::sender(arg1), 2);
        assert!(arg0.metadata_mutable, 4);
    }

    public fun authorize_mint<T0>(arg0: &mut Collection<T0>, arg1: &0x2::tx_context::TxContext) : MintTicket<T0> {
        0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::authority::assert_role(&arg0.authority, 0x2::tx_context::sender(arg1), 1);
        assert!(arg0.mintable && !arg0.paused, 2);
        assert!(arg0.minted < arg0.maximum_supply, 3);
        arg0.minted = arg0.minted + 1;
        MintTicket<T0>{
            collection : 0x2::object::id<Collection<T0>>(arg0),
            serial     : arg0.minted,
        }
    }

    public fun burnable<T0>(arg0: &Collection<T0>) : bool {
        arg0.burnable
    }

    public fun consume_ticket<T0>(arg0: MintTicket<T0>) : (0x2::object::ID, u64) {
        let MintTicket {
            collection : v0,
            serial     : v1,
        } = arg0;
        (v0, v1)
    }

    public fun freeze_metadata<T0>(arg0: &mut Collection<T0>, arg1: &0x2::tx_context::TxContext) {
        0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::authority::assert_owner(&arg0.authority, 0x2::tx_context::sender(arg1));
        arg0.metadata_mutable = false;
    }

    public fun freeze_royalty<T0>(arg0: &mut Collection<T0>, arg1: &0x2::tx_context::TxContext) {
        0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::authority::assert_owner(&arg0.authority, 0x2::tx_context::sender(arg1));
        arg0.royalty_mutable = false;
    }

    public fun metadata_mutable<T0>(arg0: &Collection<T0>) : bool {
        arg0.metadata_mutable
    }

    public fun minted<T0>(arg0: &Collection<T0>) : u64 {
        arg0.minted
    }

    public fun nominate_owner<T0>(arg0: &mut Collection<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::authority::nominate(&mut arg0.authority, 0x2::tx_context::sender(arg2), arg1);
    }

    public fun renounce_owner<T0>(arg0: &mut Collection<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 7);
        0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::authority::renounce(&mut arg0.authority, 0x2::tx_context::sender(arg1));
        arg0.mintable = false;
        arg0.metadata_mutable = false;
        arg0.royalty_mutable = false;
    }

    public fun revoke_mint<T0>(arg0: &mut Collection<T0>, arg1: &0x2::tx_context::TxContext) {
        0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::authority::assert_owner(&arg0.authority, 0x2::tx_context::sender(arg1));
        arg0.mintable = false;
    }

    public fun set_paused<T0>(arg0: &mut Collection<T0>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::authority::assert_role(&arg0.authority, 0x2::tx_context::sender(arg2), 4);
        arg0.paused = arg1;
    }

    public fun set_royalty<T0>(arg0: &mut Collection<T0>, arg1: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg2: u16, arg3: address, arg4: &0x2::tx_context::TxContext) {
        0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::authority::assert_role(&arg0.authority, 0x2::tx_context::sender(arg4), 8);
        assert!(arg0.royalty_mutable && arg2 <= arg0.maximum_royalty_bps, 5);
        assert!(0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg1) == arg0.policy_id, 6);
        0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::royalty::set<T0>(arg1, &arg0.policy_cap, arg2, arg3);
    }

    public fun update_metadata<T0>(arg0: &mut Collection<T0>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::tx_context::TxContext) {
        assert_metadata<T0>(arg0, arg5);
        let v0 = if (0x1::string::length(&arg1) > 0) {
            if (0x1::string::length(&arg1) <= 32) {
                if (0x1::string::length(&arg2) <= 2000) {
                    if (0x1::string::length(&arg3) <= 500) {
                        0x1::string::length(&arg4) <= 600
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
        arg0.name = arg1;
        arg0.description = arg2;
        arg0.image_url = arg3;
        arg0.metadata_uri = arg4;
    }

    // decompiled from Move bytecode v7
}

