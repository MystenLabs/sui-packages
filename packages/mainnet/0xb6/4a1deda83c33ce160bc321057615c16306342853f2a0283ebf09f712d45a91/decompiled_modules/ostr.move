module 0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr {
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

    public fun mint(arg0: &mut 0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_state::State, arg1: &0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Role<0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_minter_role::OSTR_MINTER_ROLE>, arg2: &0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Member<0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_minter_role::OSTR_MINTER_ROLE>, arg3: address, arg4: u64) {
        0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::check_role<0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_minter_role::OSTR_MINTER_ROLE>(arg1, arg2);
        if (!0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_state::is_registerd(arg0, arg3)) {
            0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_state::register(arg0, arg3);
        };
        0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_state::increase_supply(arg0, arg4);
        increase_balance(arg0, arg3, arg4);
        let v0 = Mint{
            amount : arg4,
            to     : arg3,
            minter : 0x2::object::id_address<0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Member<0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_minter_role::OSTR_MINTER_ROLE>>(arg2),
        };
        0x2::event::emit<Mint>(v0);
    }

    public fun balance_of(arg0: &0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_state::State, arg1: address) : u64 {
        *0x2::table::borrow<address, u64>(0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_state::borrow_balances(arg0), arg1)
    }

    public fun burn(arg0: &mut 0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_state::State, arg1: &0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Role<0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_minter_role::OSTR_MINTER_ROLE>, arg2: &0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Member<0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_minter_role::OSTR_MINTER_ROLE>, arg3: address, arg4: u64) {
        0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::check_role<0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_minter_role::OSTR_MINTER_ROLE>(arg1, arg2);
        0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_state::assert_registerd(arg0, arg3);
        0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_state::decrease_supply(arg0, arg4);
        decrease_balance(arg0, arg3, arg4);
        let v0 = Burn{
            amount : arg4,
            from   : arg3,
            minter : 0x2::object::id_address<0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Member<0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_minter_role::OSTR_MINTER_ROLE>>(arg2),
        };
        0x2::event::emit<Burn>(v0);
    }

    fun calculate_amount_redeemed(arg0: u64, arg1: u64) : u64 {
        ((((arg0 as u256) * 1000000000000 / 10 + (arg0 as u256) * (arg1 as u256) * (arg1 as u256) * 1000000000000 / 67184640000000000000) / 1000000000000) as u64)
    }

    entry fun cancel(arg0: &mut 0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_state::State, arg1: Lock, arg2: &mut 0x2::tx_context::TxContext) {
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

    fun decrease_balance(arg0: &mut 0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_state::State, arg1: address, arg2: u64) {
        let v0 = 0x2::table::borrow_mut<address, u64>(0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_state::borrow_mut_balances(arg0), arg1);
        assert!(*v0 >= arg2, 0);
        *v0 = *v0 - arg2;
    }

    fun increase_balance(arg0: &mut 0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_state::State, arg1: address, arg2: u64) {
        let v0 = 0x2::table::borrow_mut<address, u64>(0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_state::borrow_mut_balances(arg0), arg1);
        *v0 = *v0 + arg2;
    }

    entry fun redeem(arg0: &mut 0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_state::State, arg1: u64, arg2: u64, arg3: &mut 0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::prl::TreasuryManagement, arg4: &0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Role<0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::pearl_minter_role::PEARL_MINTER_ROLE>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_state::assert_registerd(arg0, v0);
        decrease_balance(arg0, v0, arg1);
        let v1 = create_lock(arg1, calculate_amount_redeemed(arg1, arg2), 0x2::clock::timestamp_ms(arg5), 0x2::clock::timestamp_ms(arg5) + arg2, arg6);
        if (arg2 == 0) {
            release(arg0, v1, arg3, arg4, arg5, arg6);
        } else {
            0x2::transfer::transfer<Lock>(v1, v0);
        };
    }

    entry fun release(arg0: &0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_state::State, arg1: Lock, arg2: &mut 0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::prl::TreasuryManagement, arg3: &0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control::Role<0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::pearl_minter_role::PEARL_MINTER_ROLE>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) >= arg1.unlocked_at_ms, 1);
        let Lock {
            id                   : v0,
            ostr_amount          : _,
            ostr_amount_redeemed : v2,
            created_at_ms        : _,
            unlocked_at_ms       : _,
        } = arg1;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::prl::PRL>>(0x4e56b39acd75721999cf833062dfb77b1d51e749b02d90f049a5688e21919a64::prl::mint(arg2, arg3, 0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_state::borrow_pearl_minter(arg0), v2, arg5), 0x2::tx_context::sender(arg5));
    }

    public fun total_supply(arg0: &0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_state::State) : u64 {
        0xb64a1deda83c33ce160bc321057615c16306342853f2a0283ebf09f712d45a91::ostr_state::total_supply(arg0)
    }

    // decompiled from Move bytecode v6
}

