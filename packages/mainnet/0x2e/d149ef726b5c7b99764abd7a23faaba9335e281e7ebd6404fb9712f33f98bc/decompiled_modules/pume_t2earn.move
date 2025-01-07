module 0xfe6dceb23063c78e95a01a0b2ef2baf328b2b84bbcc437f28f535d24e765ec9e::pume_t2earn {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GameConfig has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        claimable_status: bool,
        referral_reward: u64,
        referral_fee: u64,
        register_fee: u64,
        next_tap_diff: u64,
        total_tap: u64,
        total_user: u64,
        max_tap_per_session: u64,
    }

    struct UserConfig has store, key {
        id: 0x2::object::UID,
        total_tap: u64,
        nominated_by: 0x1::option::Option<address>,
        last_tap: u64,
    }

    fun add_child(arg0: &mut GameConfig, arg1: UserConfig, arg2: address) {
        assert!(!0x2::dynamic_object_field::exists_<address>(&arg0.id, arg2), 0);
        0x2::dynamic_object_field::add<address, UserConfig>(&mut arg0.id, arg2, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = GameConfig{
            id                  : 0x2::object::new(arg0),
            balance             : 0x2::balance::zero<0x2::sui::SUI>(),
            claimable_status    : false,
            referral_reward     : 20,
            referral_fee        : 50,
            register_fee        : 1000000000,
            next_tap_diff       : 7200000,
            total_tap           : 0,
            total_user          : 0,
            max_tap_per_session : 1000,
        };
        0x2::transfer::share_object<GameConfig>(v1);
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun register_with_ref(arg0: &mut GameConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: &mut 0x35faa299a1cd11c8666251726e9254a7565b7163961311fcadcce52369330948::pume_lfg::RootConfig, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_object_field::exists_<address>(&arg0.id, 0x2::tx_context::sender(arg4)), 0);
        assert!(0x2::dynamic_object_field::exists_<address>(&arg0.id, arg2), 1);
        take_register_fee(arg0, arg1);
        transfer_register_fee_to_ref(arg0, arg2, arg4);
        if (0x35faa299a1cd11c8666251726e9254a7565b7163961311fcadcce52369330948::pume_lfg::get_mintable(arg3)) {
            0x35faa299a1cd11c8666251726e9254a7565b7163961311fcadcce52369330948::pume_lfg::mint_lfg(arg3, arg4);
        };
        let v0 = UserConfig{
            id           : 0x2::object::new(arg4),
            total_tap    : 100000,
            nominated_by : 0x1::option::some<address>(arg2),
            last_tap     : 0,
        };
        add_child(arg0, v0, 0x2::tx_context::sender(arg4));
        arg0.total_tap = arg0.total_tap + 100000;
        arg0.total_user = arg0.total_user + 1;
    }

    public entry fun register_without_ref(arg0: &mut GameConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x35faa299a1cd11c8666251726e9254a7565b7163961311fcadcce52369330948::pume_lfg::RootConfig, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_object_field::exists_<address>(&arg0.id, 0x2::tx_context::sender(arg3)), 0);
        take_register_fee(arg0, arg1);
        if (0x35faa299a1cd11c8666251726e9254a7565b7163961311fcadcce52369330948::pume_lfg::get_mintable(arg2)) {
            0x35faa299a1cd11c8666251726e9254a7565b7163961311fcadcce52369330948::pume_lfg::mint_lfg(arg2, arg3);
        };
        let v0 = UserConfig{
            id           : 0x2::object::new(arg3),
            total_tap    : 1000,
            nominated_by : 0x1::option::none<address>(),
            last_tap     : 0,
        };
        add_child(arg0, v0, 0x2::tx_context::sender(arg3));
        arg0.total_tap = arg0.total_tap + 1000;
        arg0.total_user = arg0.total_user + 1;
    }

    public entry fun submit_tap(arg0: &mut GameConfig, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::dynamic_object_field::borrow_mut<address, UserConfig>(&mut arg0.id, 0x2::tx_context::sender(arg3));
        assert!(v0 - v1.last_tap >= arg0.next_tap_diff, 2);
        let v2 = if (arg1 > arg0.max_tap_per_session) {
            arg0.max_tap_per_session
        } else {
            arg1
        };
        v1.total_tap = v1.total_tap + v2;
        v1.last_tap = v0;
        arg0.total_tap = arg0.total_tap + v2;
        if (0x1::option::is_some<address>(&v1.nominated_by)) {
            let v3 = 0x2::dynamic_object_field::borrow_mut<address, UserConfig>(&mut arg0.id, *0x1::option::borrow<address>(&v1.nominated_by));
            let v4 = v2 * arg0.referral_reward / 100;
            v3.total_tap = v3.total_tap + v4;
            arg0.total_tap = arg0.total_tap + v4;
        };
    }

    fun take_register_fee(arg0: &mut GameConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.register_fee, 3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    fun transfer_register_fee_to_ref(arg0: &mut GameConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg0.register_fee * arg0.referral_fee / 100, arg2), arg1);
    }

    public entry fun update_claimable_status(arg0: &mut AdminCap, arg1: &mut GameConfig, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.claimable_status = arg2;
    }

    public entry fun update_max_tap_per_session(arg0: &mut AdminCap, arg1: &mut GameConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.max_tap_per_session = arg2;
    }

    public entry fun update_next_tap_diff(arg0: &mut AdminCap, arg1: &mut GameConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.next_tap_diff = arg2;
    }

    public entry fun update_referral_fee(arg0: &mut AdminCap, arg1: &mut GameConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.referral_fee = arg2;
    }

    public entry fun update_referral_reward(arg0: &mut AdminCap, arg1: &mut GameConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.referral_reward = arg2;
    }

    public entry fun update_register_fee(arg0: &mut AdminCap, arg1: &mut GameConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.register_fee = arg2;
    }

    public entry fun withdraw(arg0: &mut AdminCap, arg1: &mut GameConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

