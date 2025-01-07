module 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::bond_depository44 {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Terms<phantom T0> has key {
        id: 0x2::object::UID,
        pause: bool,
        control_variable: u64,
        vesting_term: u64,
        minimum_price: u64,
        max_payout: u64,
        fee: u64,
        max_debt: u64,
        total_debt: u64,
        last_decay: u64,
        dao: address,
        adjust: Adjust<T0>,
    }

    struct Adjust<phantom T0> has store {
        add: bool,
        rate: u64,
        target: u64,
    }

    struct Bond<phantom T0> has drop, store {
        payout: u64,
        vesting: u64,
        last_timestamp: u64,
        price_paid: u64,
    }

    struct BondDepository44<phantom T0> has key {
        id: 0x2::object::UID,
        user_bond_info: 0x2::table::Table<address, Bond<T0>>,
        svim_balance: 0x2::balance::Balance<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>,
    }

    struct InitBondEvent<phantom T0> has copy, drop {
        sender: address,
        bond_depository44_id: 0x2::object::ID,
        terms_id: 0x2::object::ID,
    }

    struct ControlVariableAdjustEvent<phantom T0> has copy, drop {
        initial_bsv: u64,
        new_bsv: u64,
        adjust: u64,
        add: bool,
    }

    struct BondCreatedEvent<phantom T0> has copy, drop {
        deposit: u64,
        payout: u64,
        expires: u64,
        price_in_usd: u64,
        depositor_address: address,
        sender: address,
    }

    struct BondRedeemedEvent<phantom T0> has copy, drop {
        recipient: address,
        payout: u64,
        remaining: u64,
        sender: address,
    }

    struct SetTermsEvent<phantom T0> has copy, drop {
        type: u8,
        input: u64,
    }

    struct SetAdjustEvent<phantom T0> has copy, drop {
        add: bool,
        rate: u64,
        target: u64,
    }

    struct SetDaoEvent<phantom T0> has copy, drop {
        dao: address,
    }

    struct SetPauseEvent<phantom T0> has copy, drop {
        pause: bool,
    }

    fun adjust<T0>(arg0: &mut Terms<T0>) {
        if (arg0.adjust.rate > 0) {
            if (arg0.adjust.add) {
                arg0.control_variable = arg0.control_variable + arg0.adjust.rate;
                if (arg0.control_variable >= arg0.adjust.target) {
                    arg0.adjust.rate = 0;
                };
            } else {
                if (arg0.control_variable < arg0.adjust.rate) {
                    arg0.control_variable = 0;
                } else {
                    arg0.control_variable = arg0.control_variable - arg0.adjust.rate;
                };
                if (arg0.control_variable <= arg0.adjust.target) {
                    arg0.adjust.rate = 0;
                };
            };
            let v0 = ControlVariableAdjustEvent<T0>{
                initial_bsv : arg0.control_variable,
                new_bsv     : arg0.control_variable,
                adjust      : arg0.adjust.rate,
                add         : arg0.adjust.add,
            };
            0x2::event::emit<ControlVariableAdjustEvent<T0>>(v0);
        };
    }

    public fun bond_price<T0>(arg0: &Terms<T0>, arg1: &0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::TreasuryLock<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::math::add(0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::math::safe_mul_u64(arg0.control_variable, debt_ratio<T0>(arg0, arg1, arg2)), 1000000) / 10000;
        let v1 = v0;
        if (v0 < arg0.minimum_price) {
            v1 = arg0.minimum_price;
        };
        v1
    }

    fun bond_price_<T0>(arg0: &mut Terms<T0>, arg1: &0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::TreasuryLock<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::math::add(0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::math::safe_mul_u64(arg0.control_variable, debt_ratio<T0>(arg0, arg1, arg2)), 1000000) / 10000;
        let v1 = v0;
        if (v0 < arg0.minimum_price) {
            v1 = arg0.minimum_price;
        } else if (arg0.minimum_price > 0) {
            arg0.minimum_price = 0;
        };
        v1
    }

    public fun bond_price_in_usd<T0>(arg0: &Terms<T0>, arg1: &0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::treasury::DepoisitToken<T0>, arg2: &0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::TreasuryLock<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>, arg3: &0x2::clock::Clock) : u64 {
        0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::math::safe_mul_div_u64(bond_price<T0>(arg0, arg2, arg3), 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::math::pow(10, 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::treasury::decimals<T0>(arg1)), 100)
    }

    public fun current_debt<T0>(arg0: &Terms<T0>, arg1: &0x2::clock::Clock) : u64 {
        arg0.total_debt - debt_decay<T0>(arg0, arg1)
    }

    public fun debt_decay<T0>(arg0: &Terms<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::math::safe_mul_div_u64(arg0.total_debt, 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::math::sub(0x2::clock::timestamp_ms(arg1) / 1000, arg0.last_decay), arg0.vesting_term);
        let v1 = v0;
        if (v0 > arg0.total_debt) {
            v1 = arg0.total_debt;
        };
        v1
    }

    public fun debt_ratio<T0>(arg0: &Terms<T0>, arg1: &0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::TreasuryLock<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::total_supply<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(arg1);
        if (v0 == 0) {
            return 0
        };
        0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::math::fraction(current_debt<T0>(arg0, arg2), v0)
    }

    fun decay_debt<T0>(arg0: &mut Terms<T0>, arg1: &0x2::clock::Clock) {
        arg0.total_debt = arg0.total_debt - debt_decay<T0>(arg0, arg1);
        arg0.last_decay = 0x2::clock::timestamp_ms(arg1) / 1000;
    }

    public entry fun deposit<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: address, arg4: &mut Terms<T0>, arg5: &mut BondDepository44<T0>, arg6: &mut 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::treasury::Treasury, arg7: &mut 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::treasury::DepoisitToken<T0>, arg8: &mut 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::staking::Staking, arg9: &mut 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::staking_distributor::StakingDistributorConfig, arg10: &mut 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::TreasuryLock<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>, arg11: &mut 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::TreasuryCap<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg4.pause == false, 7);
        decay_debt<T0>(arg4, arg12);
        assert!(arg4.total_debt <= arg4.max_debt, 4);
        let v0 = bond_price_in_usd<T0>(arg4, arg7, arg10, arg12);
        let v1 = bond_price_<T0>(arg4, arg10, arg12);
        assert!(arg2 >= v1, 5);
        let v2 = 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::treasury::value_of<T0>(arg7, arg1);
        let v3 = payout_for<T0>(v2, arg4, arg10, arg12);
        assert!(v3 >= 10000, 6);
        assert!(v3 <= max_payout<T0>(arg10, arg4), 1);
        let v4 = 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::math::safe_mul_div_u64(v3, arg4.fee, 10000);
        let v5 = 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::treasury::deposit<T0>(arg6, arg7, arg0, arg1, 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::math::sub(v2, v3 + v4), arg10, arg13);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>>(0x2::coin::from_balance<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(0x2::balance::split<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(&mut v5, v4), arg13), arg4.dao);
        };
        arg4.total_debt = arg4.total_debt + v2;
        if (0x2::table::contains<address, Bond<T0>>(&arg5.user_bond_info, arg3)) {
            let v6 = 0x2::table::borrow_mut<address, Bond<T0>>(&mut arg5.user_bond_info, arg3);
            v6.payout = v6.payout + 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::gons_from_value<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>(arg11, v3);
            v6.vesting = arg4.vesting_term;
            v6.last_timestamp = 0x2::clock::timestamp_ms(arg12) / 1000;
            v6.price_paid = v0;
        } else {
            let v7 = Bond<T0>{
                payout         : 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::gons_from_value<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>(arg11, v3),
                vesting        : arg4.vesting_term,
                last_timestamp : 0x2::clock::timestamp_ms(arg12) / 1000,
                price_paid     : v0,
            };
            0x2::table::add<address, Bond<T0>>(&mut arg5.user_bond_info, arg3, v7);
        };
        0x2::balance::join<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>(&mut arg5.svim_balance, 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::staking::stake_balance(arg8, v5, arg10, arg11, arg9, arg6, arg12));
        adjust<T0>(arg4);
        let v8 = BondCreatedEvent<T0>{
            deposit           : arg1,
            payout            : v3,
            expires           : 0x2::clock::timestamp_ms(arg12) / 1000 + arg4.vesting_term,
            price_in_usd      : v0,
            depositor_address : arg3,
            sender            : 0x2::tx_context::sender(arg13),
        };
        0x2::event::emit<BondCreatedEvent<T0>>(v8);
        v3
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun init_bond<T0>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = Adjust<T0>{
            add    : false,
            rate   : 0,
            target : 0,
        };
        let v1 = Terms<T0>{
            id               : 0x2::object::new(arg10),
            pause            : false,
            control_variable : arg1,
            vesting_term     : arg2,
            minimum_price    : arg3,
            max_payout       : arg4,
            fee              : arg5,
            max_debt         : arg6,
            total_debt       : arg7,
            last_decay       : 0x2::clock::timestamp_ms(arg9) / 1000,
            dao              : arg8,
            adjust           : v0,
        };
        0x2::transfer::share_object<Terms<T0>>(v1);
        let v2 = BondDepository44<T0>{
            id             : 0x2::object::new(arg10),
            user_bond_info : 0x2::table::new<address, Bond<T0>>(arg10),
            svim_balance   : 0x2::balance::zero<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>(),
        };
        0x2::transfer::share_object<BondDepository44<T0>>(v2);
        let v3 = InitBondEvent<T0>{
            sender               : 0x2::tx_context::sender(arg10),
            bond_depository44_id : 0x2::object::id<BondDepository44<T0>>(&v2),
            terms_id             : 0x2::object::id<Terms<T0>>(&v1),
        };
        0x2::event::emit<InitBondEvent<T0>>(v3);
    }

    public fun max_payout<T0>(arg0: &0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::TreasuryLock<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>, arg1: &Terms<T0>) : u64 {
        0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::math::safe_mul_div_u64(0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::total_supply<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(arg0), arg1.max_payout, 100000)
    }

    public fun payout_for<T0>(arg0: u64, arg1: &Terms<T0>, arg2: &0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::TreasuryLock<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>, arg3: &0x2::clock::Clock) : u64 {
        0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::math::fraction(arg0, bond_price<T0>(arg1, arg2, arg3)) / 10000
    }

    public fun pending_payout_for<T0>(arg0: address, arg1: &BondDepository44<T0>, arg2: &0x2::clock::Clock, arg3: &0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::TreasuryCap<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>) : u64 {
        if (!0x2::table::contains<address, Bond<T0>>(&arg1.user_bond_info, arg0)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, Bond<T0>>(&arg1.user_bond_info, arg0);
        let v1 = percent_vested_for<T0>(v0, arg2);
        let v2 = v0.payout;
        let v3 = v2;
        if (v1 < 100000000) {
            v3 = 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::math::safe_mul_div_u64(v2, v1, 100000000);
        };
        0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::value_from_gons<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>(arg3, v3)
    }

    fun percent_vested_for<T0>(arg0: &Bond<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = arg0.vesting;
        if (v0 > 0) {
            return 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::math::safe_mul_div_u64(0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::math::sub(0x2::clock::timestamp_ms(arg1) / 1000, arg0.last_timestamp), 100000000, v0)
        };
        0
    }

    public entry fun redeem<T0>(arg0: address, arg1: &mut BondDepository44<T0>, arg2: &mut 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::TreasuryCap<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, Bond<T0>>(&arg1.user_bond_info, arg0), 8);
        let v0 = 0x2::table::borrow_mut<address, Bond<T0>>(&mut arg1.user_bond_info, arg0);
        let v1 = percent_vested_for<T0>(v0, arg3);
        if (v1 >= 100000000) {
            let v2 = &mut arg1.svim_balance;
            transfer_svim(v2, arg0, v0.payout, arg4);
            let v3 = BondRedeemedEvent<T0>{
                recipient : arg0,
                payout    : 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::value_from_gons<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>(arg2, v0.payout),
                remaining : 0,
                sender    : 0x2::tx_context::sender(arg4),
            };
            0x2::event::emit<BondRedeemedEvent<T0>>(v3);
            0x2::table::remove<address, Bond<T0>>(&mut arg1.user_bond_info, arg0);
        } else {
            let v4 = 0x2::clock::timestamp_ms(arg3) / 1000;
            let v5 = 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::math::safe_mul_div_u64(v0.payout, v1, 100000000);
            v0.payout = v0.payout - v5;
            v0.vesting = v0.vesting - v4 - v0.last_timestamp;
            v0.last_timestamp = v4;
            let v6 = &mut arg1.svim_balance;
            transfer_svim(v6, arg0, v5, arg4);
            let v7 = BondRedeemedEvent<T0>{
                recipient : arg0,
                payout    : 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::value_from_gons<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>(arg2, v5),
                remaining : 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::value_from_gons<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>(arg2, v0.payout),
                sender    : 0x2::tx_context::sender(arg4),
            };
            0x2::event::emit<BondRedeemedEvent<T0>>(v7);
        };
    }

    public entry fun set_adjust<T0>(arg0: &AdminCap, arg1: &mut Terms<T0>, arg2: bool, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 <= arg1.control_variable * 100 / 1000, 3);
        arg1.adjust.add = arg2;
        arg1.adjust.rate = arg3;
        arg1.adjust.target = arg4;
        let v0 = SetAdjustEvent<T0>{
            add    : arg2,
            rate   : arg3,
            target : arg4,
        };
        0x2::event::emit<SetAdjustEvent<T0>>(v0);
    }

    public entry fun set_bond_terms<T0>(arg0: &AdminCap, arg1: &mut Terms<T0>, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0) {
            assert!(arg3 >= 43200, 0);
            arg1.vesting_term = arg3;
        } else if (arg2 == 1) {
            assert!(arg3 <= 1000, 1);
            arg1.max_payout = arg3;
        } else if (arg2 == 2) {
            assert!(arg3 <= 10000, 2);
            arg1.fee = arg3;
        } else if (arg2 == 3) {
            arg1.max_debt = arg3;
        } else if (arg2 == 4) {
            arg1.minimum_price = arg3;
        };
        let v0 = SetTermsEvent<T0>{
            type  : arg2,
            input : arg3,
        };
        0x2::event::emit<SetTermsEvent<T0>>(v0);
    }

    public entry fun set_dao<T0>(arg0: &AdminCap, arg1: &mut Terms<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.dao = arg2;
        let v0 = SetDaoEvent<T0>{dao: arg2};
        0x2::event::emit<SetDaoEvent<T0>>(v0);
    }

    public entry fun set_pause<T0>(arg0: &AdminCap, arg1: &mut Terms<T0>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.pause = arg2;
        let v0 = SetPauseEvent<T0>{pause: arg2};
        0x2::event::emit<SetPauseEvent<T0>>(v0);
    }

    fun transfer_svim(arg0: &mut 0x2::balance::Balance<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>(arg0) >= arg2, 9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>>(0x2::coin::from_balance<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>(0x2::balance::split<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>(arg0, arg2), arg3), arg1);
    }

    public fun unclaim_payout_for<T0>(arg0: address, arg1: &BondDepository44<T0>, arg2: &0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::TreasuryCap<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>) : u64 {
        if (!0x2::table::contains<address, Bond<T0>>(&arg1.user_bond_info, arg0)) {
            return 0
        };
        0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::value_from_gons<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::svim::SVIM>(arg2, 0x2::table::borrow<address, Bond<T0>>(&arg1.user_bond_info, arg0).payout)
    }

    // decompiled from Move bytecode v6
}

