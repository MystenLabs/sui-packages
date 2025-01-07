module 0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminStorage has store, key {
        id: 0x2::object::UID,
        setters: vector<address>,
    }

    public entry fun add_staking_package<T0>(arg0: &AdminStorage, arg1: &mut 0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::StakingStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: bool, arg13: bool, arg14: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg14);
        0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::add_staking_package<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    fun check_is_setter(arg0: &AdminStorage, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.setters, &v0), 2100);
    }

    public entry fun deposit_round<T0>(arg0: &AdminStorage, arg1: &mut 0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::StakingStorage, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg3);
        0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::vault::deposit<T0>(0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::get_mut_vault(arg1), arg2, arg3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, v0);
        let v2 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v2, v0);
        let v3 = AdminStorage{
            id      : 0x2::object::new(arg0),
            setters : v2,
        };
        0x2::transfer::share_object<AdminStorage>(v3);
    }

    public entry fun remove_staking_package<T0>(arg0: &AdminStorage, arg1: &mut 0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::StakingStorage, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg3);
        0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::remove_staking_package<T0>(arg1, arg2);
    }

    public entry fun set_access_range_limit(arg0: &AdminStorage, arg1: &mut 0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::StakingStorage, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg3);
        0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::set_access_range_limit(arg1, arg2);
    }

    public entry fun set_apr<T0>(arg0: &AdminStorage, arg1: &mut 0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::StakingStorage, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg4);
        0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::set_apr<T0>(arg1, arg2, arg3);
    }

    public entry fun set_days<T0>(arg0: &AdminStorage, arg1: &mut 0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::StakingStorage, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg4);
        0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::set_days<T0>(arg1, arg2, arg3);
    }

    public entry fun set_description<T0>(arg0: &AdminStorage, arg1: &mut 0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::StakingStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg4);
        0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::set_description<T0>(arg1, arg2, arg3);
    }

    public entry fun set_image<T0>(arg0: &AdminStorage, arg1: &mut 0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::StakingStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg4);
        0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::set_image<T0>(arg1, arg2, arg3);
    }

    public entry fun set_is_open<T0>(arg0: &AdminStorage, arg1: &mut 0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::StakingStorage, arg2: 0x1::string::String, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg4);
        0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::set_is_open<T0>(arg1, arg2, arg3);
    }

    public entry fun set_is_pause<T0>(arg0: &AdminStorage, arg1: &mut 0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::StakingStorage, arg2: 0x1::string::String, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg4);
        0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::set_is_pause<T0>(arg1, arg2, arg3);
    }

    public entry fun set_link<T0>(arg0: &AdminStorage, arg1: &mut 0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::StakingStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg4);
        0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::set_link<T0>(arg1, arg2, arg3);
    }

    public entry fun set_min_stake_amount<T0>(arg0: &AdminStorage, arg1: &mut 0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::StakingStorage, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg4);
        0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::set_min_stake_amount<T0>(arg1, arg2, arg3);
    }

    public entry fun set_name<T0>(arg0: &AdminStorage, arg1: &mut 0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::StakingStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg4);
        0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::set_name<T0>(arg1, arg2, arg3);
    }

    public entry fun set_unstake_soon_fee<T0>(arg0: &AdminStorage, arg1: &mut 0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::StakingStorage, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg4);
        0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::set_unstake_soon_fee<T0>(arg1, arg2, arg3);
    }

    public entry fun set_website<T0>(arg0: &AdminStorage, arg1: &mut 0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::StakingStorage, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg4);
        0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::set_website<T0>(arg1, arg2, arg3);
    }

    public entry fun withdraw_round<T0>(arg0: &AdminStorage, arg1: &mut 0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::StakingStorage, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_is_setter(arg0, arg3);
        0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::vault::withdraw<T0>(0xf0cdf14bcac51ef9f468600807f4224c97bc21e4480b34a9cfd51eeae63b297::staking::get_mut_vault(arg1), arg2, 0x2::tx_context::sender(arg3), arg3);
    }

    // decompiled from Move bytecode v6
}

