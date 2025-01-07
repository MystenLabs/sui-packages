module 0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr {
    struct Lock has key {
        id: 0x2::object::UID,
        ostr_amount: u64,
        ostr_amount_redeemed: u64,
        created_at_ms: u64,
        unlocked_at_ms: u64,
    }

    struct Mint has copy, drop {
        amount: u64,
        to: address,
        minter: address,
    }

    struct Burn has copy, drop {
        amount: u64,
        from: address,
        minter: address,
    }

    public fun balance_of(arg0: &0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr_state::State, arg1: address) : u64 {
        *0x2::table::borrow<address, u64>(0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr_state::borrow_balances(arg0), arg1)
    }

    public fun burn(arg0: &mut 0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr_state::State, arg1: &0x25bd36e9963b8f1687d5f6c39678cb846032cfe2cc89def86bc7491083b52269::access_control::Role<0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr_minter_role::OSTR_MINTER_ROLE>, arg2: &0x25bd36e9963b8f1687d5f6c39678cb846032cfe2cc89def86bc7491083b52269::access_control::Member<0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr_minter_role::OSTR_MINTER_ROLE>, arg3: address, arg4: u64) {
        0x25bd36e9963b8f1687d5f6c39678cb846032cfe2cc89def86bc7491083b52269::access_control::check_role<0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr_minter_role::OSTR_MINTER_ROLE>(arg1, arg2);
        0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr_state::assert_registerd(arg0, arg3);
        0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr_state::decrease_supply(arg0, arg4);
        decrease_balance(arg0, arg3, arg4);
        let v0 = Burn{
            amount : arg4,
            from   : arg3,
            minter : 0x2::object::id_address<0x25bd36e9963b8f1687d5f6c39678cb846032cfe2cc89def86bc7491083b52269::access_control::Member<0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr_minter_role::OSTR_MINTER_ROLE>>(arg2),
        };
        0x2::event::emit<Burn>(v0);
    }

    fun calculate_amount_redeemed(arg0: u64, arg1: u64) : u64 {
        ((((arg0 as u256) * 1000000000000 / 10 + (arg0 as u256) * (arg1 as u256) * (arg1 as u256) * 1000000000000 / 67184640000000000000) / 1000000000000) as u64)
    }

    entry fun cancel(arg0: &mut 0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr_state::State, arg1: Lock, arg2: &mut 0x2::tx_context::TxContext) {
        let Lock {
            id                   : v0,
            ostr_amount          : v1,
            ostr_amount_redeemed : _,
            created_at_ms        : _,
            unlocked_at_ms       : _,
        } = arg1;
        increase_balance(arg0, 0x2::tx_context::sender(arg2), v1);
        0x2::object::delete(v0);
    }

    fun create_lock(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Lock {
        Lock{
            id                   : 0x2::object::new(arg4),
            ostr_amount          : arg0,
            ostr_amount_redeemed : arg1,
            created_at_ms        : arg2,
            unlocked_at_ms       : arg3,
        }
    }

    fun decrease_balance(arg0: &mut 0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr_state::State, arg1: address, arg2: u64) {
        let v0 = 0x2::table::borrow_mut<address, u64>(0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr_state::borrow_mut_balances(arg0), arg1);
        assert!(*v0 >= arg2, 0);
        *v0 = *v0 - arg2;
    }

    fun increase_balance(arg0: &mut 0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr_state::State, arg1: address, arg2: u64) {
        let v0 = 0x2::table::borrow_mut<address, u64>(0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr_state::borrow_mut_balances(arg0), arg1);
        *v0 = *v0 + arg2;
    }

    public fun mint(arg0: &mut 0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr_state::State, arg1: &0x25bd36e9963b8f1687d5f6c39678cb846032cfe2cc89def86bc7491083b52269::access_control::Role<0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr_minter_role::OSTR_MINTER_ROLE>, arg2: &0x25bd36e9963b8f1687d5f6c39678cb846032cfe2cc89def86bc7491083b52269::access_control::Member<0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr_minter_role::OSTR_MINTER_ROLE>, arg3: address, arg4: u64) {
        0x25bd36e9963b8f1687d5f6c39678cb846032cfe2cc89def86bc7491083b52269::access_control::check_role<0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr_minter_role::OSTR_MINTER_ROLE>(arg1, arg2);
        if (!0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr_state::is_registerd(arg0, arg3)) {
            0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr_state::register(arg0, arg3);
        };
        0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr_state::increase_supply(arg0, arg4);
        increase_balance(arg0, arg3, arg4);
        let v0 = Mint{
            amount : arg4,
            to     : arg3,
            minter : 0x2::object::id_address<0x25bd36e9963b8f1687d5f6c39678cb846032cfe2cc89def86bc7491083b52269::access_control::Member<0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr_minter_role::OSTR_MINTER_ROLE>>(arg2),
        };
        0x2::event::emit<Mint>(v0);
    }

    entry fun redeem(arg0: &mut 0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr_state::State, arg1: u64, arg2: u64, arg3: &mut 0xe2fcd8d4ffeedac76f127b024fdc420fdea2bdb7bb2eb99b5ec87af2a10bf10f::prl::TreasuryManagement, arg4: &0x25bd36e9963b8f1687d5f6c39678cb846032cfe2cc89def86bc7491083b52269::access_control::Role<0xe2fcd8d4ffeedac76f127b024fdc420fdea2bdb7bb2eb99b5ec87af2a10bf10f::pearl_minter_role::PEARL_MINTER_ROLE>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 7776000000, 2);
        let v0 = 0x2::tx_context::sender(arg6);
        0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr_state::assert_registerd(arg0, v0);
        decrease_balance(arg0, v0, arg1);
        let v1 = create_lock(arg1, calculate_amount_redeemed(arg1, arg2), 0x2::clock::timestamp_ms(arg5), 0x2::clock::timestamp_ms(arg5) + arg2, arg6);
        if (arg2 == 0) {
            release(arg0, v1, arg3, arg4, arg5, arg6);
        } else {
            0x2::transfer::transfer<Lock>(v1, v0);
        };
    }

    entry fun release(arg0: &0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr_state::State, arg1: Lock, arg2: &mut 0xe2fcd8d4ffeedac76f127b024fdc420fdea2bdb7bb2eb99b5ec87af2a10bf10f::prl::TreasuryManagement, arg3: &0x25bd36e9963b8f1687d5f6c39678cb846032cfe2cc89def86bc7491083b52269::access_control::Role<0xe2fcd8d4ffeedac76f127b024fdc420fdea2bdb7bb2eb99b5ec87af2a10bf10f::pearl_minter_role::PEARL_MINTER_ROLE>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) >= arg1.unlocked_at_ms, 1);
        let Lock {
            id                   : v0,
            ostr_amount          : v1,
            ostr_amount_redeemed : v2,
            created_at_ms        : _,
            unlocked_at_ms       : _,
        } = arg1;
        let v5 = v2;
        0x2::object::delete(v0);
        if (v2 > v1) {
            v5 = v1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe2fcd8d4ffeedac76f127b024fdc420fdea2bdb7bb2eb99b5ec87af2a10bf10f::prl::PRL>>(0xe2fcd8d4ffeedac76f127b024fdc420fdea2bdb7bb2eb99b5ec87af2a10bf10f::prl::mint(arg2, arg3, 0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr_state::borrow_pearl_minter(arg0), v5, arg5), 0x2::tx_context::sender(arg5));
    }

    public fun total_supply(arg0: &0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr_state::State) : u64 {
        0x79b7c7e43ffb5518a13e56569b731e22dd422728585a9e51c325b52745f09aa5::ostr_state::total_supply(arg0)
    }

    // decompiled from Move bytecode v6
}

