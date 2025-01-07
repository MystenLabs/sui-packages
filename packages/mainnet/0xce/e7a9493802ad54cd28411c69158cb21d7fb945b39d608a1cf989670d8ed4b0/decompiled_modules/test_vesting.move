module 0xcee7a9493802ad54cd28411c69158cb21d7fb945b39d608a1cf989670d8ed4b0::test_vesting {
    struct VestedTokens has store, key {
        id: 0x2::object::UID,
        coin: 0x2::coin::Coin<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>,
    }

    struct RescueTokens<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Owner has store, key {
        id: 0x2::object::UID,
        owner_address: address,
        already_vested: bool,
    }

    struct StartVesting has store, key {
        id: 0x2::object::UID,
        start_time: u64,
        vesting_started: bool,
    }

    struct UpgradeVersion has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct AvailableAmount has copy, drop {
        available_amount: u64,
        released_amount: u64,
        elapsed_month: u64,
    }

    struct VestingStart has copy, drop {
        start_time_in_sec: u64,
    }

    struct WithdrawDetails has copy, drop {
        recipient: vector<address>,
        amount: vector<u64>,
    }

    struct EmergencyWithdrawDetails has copy, drop {
        recipient: address,
        amount: u64,
    }

    struct VestedAmount has copy, drop {
        amount: u64,
    }

    struct ChangedOwner has copy, drop {
        current_owner: address,
        new_owner: address,
    }

    struct CategoryDetails has copy, drop {
        category_name: 0x1::string::String,
        available_amount: u64,
        released_amount: u64,
        elapsed_month: u64,
    }

    struct TEST_VESTING has drop {
        dummy_field: bool,
    }

    fun accept_rescue_token<T0>(arg0: &mut VestedTokens, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) {
        let v0 = RescueTokens<T0>{dummy_field: false};
        let v1 = &mut arg0.id;
        if (0x2::dynamic_field::exists_<RescueTokens<T0>>(v1, v0)) {
            0x2::coin::join<T0>(0x2::dynamic_field::borrow_mut<RescueTokens<T0>, 0x2::coin::Coin<T0>>(v1, v0), 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1));
        } else {
            0x2::dynamic_field::add<RescueTokens<T0>, 0x2::coin::Coin<T0>>(v1, v0, 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1));
        };
    }

    public entry fun available_amount(arg0: &mut 0xcee7a9493802ad54cd28411c69158cb21d7fb945b39d608a1cf989670d8ed4b0::test_vesting_schedule::Category, arg1: &StartVesting, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &UpgradeVersion, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg4.version == 0, 8);
        let v0 = 0xcee7a9493802ad54cd28411c69158cb21d7fb945b39d608a1cf989670d8ed4b0::test_vesting_schedule::locker(arg0, arg2);
        let (v1, v2, v3) = get_available_amount(v0, arg1, arg3);
        let v4 = AvailableAmount{
            available_amount : v1,
            released_amount  : v2,
            elapsed_month    : v3,
        };
        0x2::event::emit<AvailableAmount>(v4);
        v1
    }

    public entry fun change_owner(arg0: Owner, arg1: 0x2::package::UpgradeCap, arg2: VestedTokens, arg3: 0xcee7a9493802ad54cd28411c69158cb21d7fb945b39d608a1cf989670d8ed4b0::test_vesting_schedule::Category, arg4: StartVesting, arg5: address, arg6: &UpgradeVersion, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.owner_address;
        assert!(arg6.version == 0, 8);
        assert!(@0x0 != arg5, 10);
        assert!(0x2::tx_context::sender(arg7) == v0, 11);
        assert!(arg5 != v0, 12);
        arg0.owner_address = arg5;
        0x2::transfer::public_transfer<Owner>(arg0, arg5);
        0x2::transfer::public_transfer<VestedTokens>(arg2, arg5);
        0x2::transfer::public_transfer<0xcee7a9493802ad54cd28411c69158cb21d7fb945b39d608a1cf989670d8ed4b0::test_vesting_schedule::Category>(arg3, arg5);
        0x2::transfer::public_transfer<StartVesting>(arg4, arg5);
        0x2::transfer::public_transfer<0x2::package::UpgradeCap>(arg1, arg5);
        let v1 = ChangedOwner{
            current_owner : v0,
            new_owner     : arg5,
        };
        0x2::event::emit<ChangedOwner>(v1);
    }

    public entry fun emergency_withdraw(arg0: &Owner, arg1: &StartVesting, arg2: &mut VestedTokens, arg3: address, arg4: &UpgradeVersion, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg4.version == 0, 8);
        assert!(0x2::tx_context::sender(arg5) == arg0.owner_address, 1);
        assert!(arg1.vesting_started == true, 7);
        let v0 = 0x2::coin::balance<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(&arg2.coin);
        assert!(0x2::coin::value<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(&arg2.coin) != 0, 13);
        let v1 = 0x2::balance::value<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>>(0x2::coin::split<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(&mut arg2.coin, v1, arg5), arg3);
        let v2 = EmergencyWithdrawDetails{
            recipient : arg3,
            amount    : v1,
        };
        0x2::event::emit<EmergencyWithdrawDetails>(v2);
    }

    fun get_available_amount(arg0: &mut 0xcee7a9493802ad54cd28411c69158cb21d7fb945b39d608a1cf989670d8ed4b0::test_vesting_schedule::Locker, arg1: &StartVesting, arg2: &0x2::clock::Clock) : (u64, u64, u64) {
        assert!(arg1.vesting_started == true, 7);
        let v0 = time_in_months(time_in_secs(arg2) - arg1.start_time);
        let v1 = 0xcee7a9493802ad54cd28411c69158cb21d7fb945b39d608a1cf989670d8ed4b0::test_vesting_schedule::scheme(arg0);
        let v2 = 0x1::vector::length<u64>(&v1);
        let v3 = 0;
        let v4 = 0;
        let v5 = v4;
        let v6 = 0xcee7a9493802ad54cd28411c69158cb21d7fb945b39d608a1cf989670d8ed4b0::test_vesting_schedule::scheme(arg0);
        if (v0 < v2) {
            while (v3 <= v0) {
                v5 = v5 + *0x1::vector::borrow<u64>(&v6, v3);
                v3 = v3 + 1;
            };
        } else if (v2 == 1) {
            v5 = v4 + *0x1::vector::borrow<u64>(&v6, 0);
        } else {
            while (v3 < v2) {
                v5 = v5 + *0x1::vector::borrow<u64>(&v6, v3);
                v3 = v3 + 1;
            };
        };
        let v7 = v5 - 0xcee7a9493802ad54cd28411c69158cb21d7fb945b39d608a1cf989670d8ed4b0::test_vesting_schedule::spent_amount(arg0);
        0xcee7a9493802ad54cd28411c69158cb21d7fb945b39d608a1cf989670d8ed4b0::test_vesting_schedule::set_available_amount(arg0, v7);
        0xcee7a9493802ad54cd28411c69158cb21d7fb945b39d608a1cf989670d8ed4b0::test_vesting_schedule::set_released_amount(arg0, v5);
        (v7, v5, v0)
    }

    fun init(arg0: TEST_VESTING, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xcee7a9493802ad54cd28411c69158cb21d7fb945b39d608a1cf989670d8ed4b0::test_vesting_schedule::Category>(0xcee7a9493802ad54cd28411c69158cb21d7fb945b39d608a1cf989670d8ed4b0::test_vesting_schedule::cagtegory_init(arg1), 0x2::tx_context::sender(arg1));
        let v0 = Owner{
            id             : 0x2::object::new(arg1),
            owner_address  : 0x2::tx_context::sender(arg1),
            already_vested : false,
        };
        0x2::transfer::public_transfer<Owner>(v0, 0x2::tx_context::sender(arg1));
        let v1 = StartVesting{
            id              : 0x2::object::new(arg1),
            start_time      : 0,
            vesting_started : false,
        };
        0x2::transfer::public_transfer<StartVesting>(v1, 0x2::tx_context::sender(arg1));
        let v2 = UpgradeVersion{
            id      : 0x2::object::new(arg1),
            version : 0,
        };
        0x2::transfer::share_object<UpgradeVersion>(v2);
        let v3 = VestedTokens{
            id   : 0x2::object::new(arg1),
            coin : 0x2::coin::zero<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(arg1),
        };
        0x2::transfer::public_transfer<VestedTokens>(v3, 0x2::tx_context::sender(arg1));
    }

    entry fun migrate(arg0: &Owner, arg1: &mut UpgradeVersion, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner_address, 1);
        assert!(arg1.version < 0, 8);
        arg1.version = 0;
    }

    public entry fun multiple_withdraw(arg0: &Owner, arg1: &mut 0xcee7a9493802ad54cd28411c69158cb21d7fb945b39d608a1cf989670d8ed4b0::test_vesting_schedule::Category, arg2: &mut VestedTokens, arg3: &StartVesting, arg4: vector<address>, arg5: vector<u64>, arg6: 0x1::string::String, arg7: &0x2::clock::Clock, arg8: &UpgradeVersion, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg8.version == 0, 8);
        assert!(0x2::tx_context::sender(arg9) == arg0.owner_address, 1);
        assert!(arg3.vesting_started == true, 7);
        assert!(0x1::vector::length<address>(&arg4) == 0x1::vector::length<u64>(&arg5), 2);
        let v0 = 0xcee7a9493802ad54cd28411c69158cb21d7fb945b39d608a1cf989670d8ed4b0::test_vesting_schedule::locker(arg1, arg6);
        let v1 = 0;
        let (v2, v3, _) = get_available_amount(v0, arg3, arg7);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&arg5)) {
            assert!(*0x1::vector::borrow<u64>(&arg5, v5) != 0, 13);
            v1 = v1 + *0x1::vector::borrow<u64>(&arg5, v5);
            v5 = v5 + 1;
        };
        assert!(v1 <= v2, 4);
        let v6 = 0;
        while (v6 < 0x1::vector::length<address>(&arg4)) {
            withdraw(arg2, arg3, *0x1::vector::borrow<address>(&arg4, v6), *0x1::vector::borrow<u64>(&arg5, v6), v2, arg9);
            v6 = v6 + 1;
        };
        0xcee7a9493802ad54cd28411c69158cb21d7fb945b39d608a1cf989670d8ed4b0::test_vesting_schedule::set_released_amount(v0, v3);
        0xcee7a9493802ad54cd28411c69158cb21d7fb945b39d608a1cf989670d8ed4b0::test_vesting_schedule::set_spent_amount(v0, 0xcee7a9493802ad54cd28411c69158cb21d7fb945b39d608a1cf989670d8ed4b0::test_vesting_schedule::spent_amount(v0) + v1);
        let (v7, v8, v9) = get_available_amount(v0, arg3, arg7);
        let v10 = CategoryDetails{
            category_name    : arg6,
            available_amount : v7,
            released_amount  : v8,
            elapsed_month    : v9,
        };
        0x2::event::emit<CategoryDetails>(v10);
        let v11 = WithdrawDetails{
            recipient : arg4,
            amount    : arg5,
        };
        0x2::event::emit<WithdrawDetails>(v11);
    }

    public entry fun rescue_token<T0>(arg0: &Owner, arg1: &mut VestedTokens, arg2: address, arg3: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg4: &UpgradeVersion, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg4.version == 0, 8);
        assert!(0x2::tx_context::sender(arg5) == arg0.owner_address, 1);
        accept_rescue_token<T0>(arg1, arg3);
        let v0 = RescueTokens<T0>{dummy_field: false};
        let v1 = &mut arg1.id;
        assert!(0x2::dynamic_field::exists_<RescueTokens<T0>>(v1, v0), 6);
        let v2 = 0x2::dynamic_field::borrow_mut<RescueTokens<T0>, 0x2::coin::Coin<T0>>(v1, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(v2, 0x2::balance::value<T0>(0x2::coin::balance<T0>(v2)), arg5), arg2);
    }

    public entry fun start_vesting(arg0: &mut Owner, arg1: &mut 0x2::coin::Coin<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>, arg2: u64, arg3: &mut StartVesting, arg4: &mut 0xcee7a9493802ad54cd28411c69158cb21d7fb945b39d608a1cf989670d8ed4b0::test_vesting_schedule::Category, arg5: &mut VestedTokens, arg6: &0x2::clock::Clock, arg7: &UpgradeVersion, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg7.version == 0, 8);
        assert!(0x2::tx_context::sender(arg8) == arg0.owner_address, 1);
        assert!(arg3.vesting_started == false, 9);
        vest_token(arg0, arg1, arg5, arg2, arg8);
        arg3.start_time = time_in_secs(arg6);
        0xcee7a9493802ad54cd28411c69158cb21d7fb945b39d608a1cf989670d8ed4b0::test_vesting_schedule::seed_initial_release(arg4);
        0xcee7a9493802ad54cd28411c69158cb21d7fb945b39d608a1cf989670d8ed4b0::test_vesting_schedule::strategic_initial_release(arg4);
        0xcee7a9493802ad54cd28411c69158cb21d7fb945b39d608a1cf989670d8ed4b0::test_vesting_schedule::institutional_initial_release(arg4);
        0xcee7a9493802ad54cd28411c69158cb21d7fb945b39d608a1cf989670d8ed4b0::test_vesting_schedule::public_round_initial_release(arg4);
        0xcee7a9493802ad54cd28411c69158cb21d7fb945b39d608a1cf989670d8ed4b0::test_vesting_schedule::ecosystem_initial_release(arg4);
        0xcee7a9493802ad54cd28411c69158cb21d7fb945b39d608a1cf989670d8ed4b0::test_vesting_schedule::foundation_initial_release(arg4);
        0xcee7a9493802ad54cd28411c69158cb21d7fb945b39d608a1cf989670d8ed4b0::test_vesting_schedule::marketing_initial_release(arg4);
        0xcee7a9493802ad54cd28411c69158cb21d7fb945b39d608a1cf989670d8ed4b0::test_vesting_schedule::liquidity_initial_release(arg4);
        0xcee7a9493802ad54cd28411c69158cb21d7fb945b39d608a1cf989670d8ed4b0::test_vesting_schedule::employeetokenoption_initial_release(arg4);
        arg3.vesting_started = true;
        let v0 = VestingStart{start_time_in_sec: arg3.start_time};
        0x2::event::emit<VestingStart>(v0);
    }

    public fun time_in_months(arg0: u64) : u64 {
        arg0 / 60
    }

    public fun time_in_secs(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    fun vest_token(arg0: &mut Owner, arg1: &mut 0x2::coin::Coin<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>, arg2: &mut VestedTokens, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 == 951250000000000000, 5);
        0x2::coin::join<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(&mut arg2.coin, 0x2::coin::split<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(arg1, arg3, arg4));
        arg0.already_vested = true;
        let v0 = VestedAmount{amount: arg3};
        0x2::event::emit<VestedAmount>(v0);
    }

    fun withdraw(arg0: &mut VestedTokens, arg1: &StartVesting, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 >= arg3, 3);
        assert!(arg1.vesting_started == true, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>>(0x2::coin::split<0xf29428618abe285833214f7041e60462465b323b9ef7e4793cf25fdc3aeda674::test_token::TEST_TOKEN>(&mut arg0.coin, arg3, arg5), arg2);
    }

    // decompiled from Move bytecode v6
}

