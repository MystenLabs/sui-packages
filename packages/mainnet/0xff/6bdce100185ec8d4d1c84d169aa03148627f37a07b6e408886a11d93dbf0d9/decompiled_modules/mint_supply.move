module 0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::mint_supply {
    struct MintSupply<phantom T0> has store {
        frozen: bool,
        mint_cap: 0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::mint_cap::MintCap<T0>,
        supply: 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils_supply::Supply,
    }

    public fun new<T0>(arg0: 0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::mint_cap::MintCap<T0>, arg1: u64, arg2: bool) : MintSupply<T0> {
        MintSupply<T0>{
            frozen   : arg2,
            mint_cap : arg0,
            supply   : 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils_supply::new(arg1),
        }
    }

    public fun add_domain<T0>(arg0: &mut 0x2::object::UID, arg1: MintSupply<T0>) {
        assert_unregulated<T0>(arg0);
        0x2::dynamic_field::add<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<MintSupply<T0>>, MintSupply<T0>>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<MintSupply<T0>>(), arg1);
    }

    public fun assert_frozen<T0>(arg0: &MintSupply<T0>) {
        assert!(is_frozen<T0>(arg0), 4);
    }

    public fun assert_not_frozen<T0>(arg0: &MintSupply<T0>) {
        assert!(!is_frozen<T0>(arg0), 3);
    }

    public fun assert_regulated<T0>(arg0: &0x2::object::UID) {
        assert!(has_domain<T0>(arg0), 1);
    }

    public fun assert_unregulated<T0>(arg0: &0x2::object::UID) {
        assert!(!has_domain<T0>(arg0), 2);
    }

    public fun borrow_domain<T0>(arg0: &0x2::object::UID) : &MintSupply<T0> {
        assert_regulated<T0>(arg0);
        0x2::dynamic_field::borrow<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<MintSupply<T0>>, MintSupply<T0>>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<MintSupply<T0>>())
    }

    public fun borrow_domain_mut<T0>(arg0: &mut 0x2::object::UID) : &mut MintSupply<T0> {
        assert_regulated<T0>(arg0);
        0x2::dynamic_field::borrow_mut<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<MintSupply<T0>>, MintSupply<T0>>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<MintSupply<T0>>())
    }

    public fun decrease_max_supply<T0>(arg0: &mut MintSupply<T0>, arg1: u64) {
        assert_not_frozen<T0>(arg0);
        0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils_supply::decrease_maximum(&mut arg0.supply, arg1);
    }

    public fun delegate<T0>(arg0: &mut MintSupply<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::mint_cap::MintCap<T0> {
        0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils_supply::increment(&mut arg0.supply, arg1);
        0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::mint_cap::split<T0>(&mut arg0.mint_cap, arg1, arg2)
    }

    public fun delegate_and_transfer<T0>(arg0: &mut MintSupply<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = delegate<T0>(arg0, arg1, arg3);
        0x2::transfer::public_transfer<0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::mint_cap::MintCap<T0>>(v0, arg2);
        0x2::object::id<0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::mint_cap::MintCap<T0>>(&v0)
    }

    public fun delete<T0>(arg0: MintSupply<T0>) : 0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::mint_cap::MintCap<T0> {
        assert_not_frozen<T0>(&arg0);
        let MintSupply {
            frozen   : _,
            mint_cap : v1,
            supply   : _,
        } = arg0;
        v1
    }

    public fun freeze_supply<T0>(arg0: &mut MintSupply<T0>) {
        arg0.frozen = true;
    }

    public fun get_supply<T0>(arg0: &MintSupply<T0>) : &0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils_supply::Supply {
        &arg0.supply
    }

    public fun has_domain<T0>(arg0: &0x2::object::UID) : bool {
        0x2::dynamic_field::exists_with_type<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<MintSupply<T0>>, MintSupply<T0>>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<MintSupply<T0>>())
    }

    public fun increase_max_supply<T0>(arg0: &mut MintSupply<T0>, arg1: u64) {
        assert_not_frozen<T0>(arg0);
        0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils_supply::increase_maximum(&mut arg0.supply, arg1);
    }

    public fun is_frozen<T0>(arg0: &MintSupply<T0>) : bool {
        arg0.frozen
    }

    public fun merge_delegated<T0>(arg0: &mut MintSupply<T0>, arg1: 0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::mint_cap::MintCap<T0>) {
        0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils_supply::decrement(&mut arg0.supply, 0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::mint_cap::supply<T0>(&arg1));
        0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::mint_cap::merge<T0>(&mut arg0.mint_cap, arg1);
    }

    public fun remove_domain<T0>(arg0: &mut 0x2::object::UID) : MintSupply<T0> {
        assert_regulated<T0>(arg0);
        0x2::dynamic_field::remove<0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::Marker<MintSupply<T0>>, MintSupply<T0>>(arg0, 0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::marker<MintSupply<T0>>())
    }

    // decompiled from Move bytecode v6
}

