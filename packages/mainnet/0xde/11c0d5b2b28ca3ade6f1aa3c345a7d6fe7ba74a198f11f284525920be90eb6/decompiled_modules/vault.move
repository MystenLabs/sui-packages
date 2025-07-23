module 0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::vault {
    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        referee_table: 0x2::object_table::ObjectTable<address, RefereeData<T0>>,
        referrer_table: 0x2::object_table::ObjectTable<address, ReferrerData<T0>>,
        referrer_rewards_ratio: u64,
        referee_rewards_ratio: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RefereeData<phantom T0> has store, key {
        id: 0x2::object::UID,
        referrer: address,
        referee_balance: 0x2::balance::Balance<T0>,
    }

    struct ReferrerData<phantom T0> has store, key {
        id: 0x2::object::UID,
        referrer_balance: 0x2::balance::Balance<T0>,
    }

    public fun withdraw_all<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>) : 0x2::balance::Balance<T0> {
        0x2::balance::withdraw_all<T0>(&mut arg1.balance)
    }

    public fun claim_referee_rewards<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = &mut arg0.referee_table;
        if (0x2::object_table::contains<address, RefereeData<T0>>(v1, v0) == false) {
            return
        };
        let v2 = 0x2::balance::withdraw_all<T0>(&mut 0x2::object_table::borrow_mut<address, RefereeData<T0>>(v1, v0).referee_balance);
        0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::events::emit_referee_rewards_claimed_event(0x2::balance::value<T0>(&v2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg1), v0);
    }

    public fun claim_referrer_rewards<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = &mut arg0.referrer_table;
        if (0x2::object_table::contains<address, ReferrerData<T0>>(v1, v0) == false) {
            return
        };
        let v2 = 0x2::balance::withdraw_all<T0>(&mut 0x2::object_table::borrow_mut<address, ReferrerData<T0>>(v1, v0).referrer_balance);
        0xde11c0d5b2b28ca3ade6f1aa3c345a7d6fe7ba74a198f11f284525920be90eb6::events::emit_referrer_rewards_claimed_event(0x2::balance::value<T0>(&v2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg1), v0);
    }

    public fun create_vault<T0>(arg0: &AdminCap, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id                     : 0x2::object::new(arg4),
            balance                : 0x2::coin::into_balance<T0>(arg1),
            referee_table          : 0x2::object_table::new<address, RefereeData<T0>>(arg4),
            referrer_table         : 0x2::object_table::new<address, ReferrerData<T0>>(arg4),
            referrer_rewards_ratio : arg2,
            referee_rewards_ratio  : arg3,
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
    }

    public(friend) fun distribute_referral_rewards<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: address) {
        if (0x2::object_table::contains<address, RefereeData<T0>>(&arg0.referee_table, arg2) == true) {
            let v0 = arg0.referrer_rewards_ratio;
            let v1 = arg0.referee_rewards_ratio;
            let v2 = if (v0 == 0) {
                0
            } else {
                0x1::u64::divide_and_round_up(arg1, v0)
            };
            let v3 = if (v1 == 0) {
                0
            } else {
                0x1::u64::divide_and_round_up(arg1, v1)
            };
            assert!(0x2::balance::value<T0>(&arg0.balance) >= v2 + v3, 2);
            let v4 = take_fund_balance<T0>(arg0, v2);
            let v5 = take_fund_balance<T0>(arg0, v3);
            0x2::balance::join<T0>(&mut 0x2::object_table::borrow_mut<address, RefereeData<T0>>(&mut arg0.referee_table, arg2).referee_balance, v4);
            0x2::balance::join<T0>(&mut 0x2::object_table::borrow_mut<address, ReferrerData<T0>>(&mut arg0.referrer_table, 0x2::object_table::borrow<address, RefereeData<T0>>(&arg0.referee_table, arg2).referrer).referrer_balance, v5);
        };
    }

    public fun edit_referal_ratios<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: u64, arg3: u64) {
        arg1.referrer_rewards_ratio = arg2;
        arg1.referee_rewards_ratio = arg3;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Vault<0x2::sui::SUI>{
            id                     : 0x2::object::new(arg0),
            balance                : 0x2::balance::zero<0x2::sui::SUI>(),
            referee_table          : 0x2::object_table::new<address, RefereeData<0x2::sui::SUI>>(arg0),
            referrer_table         : 0x2::object_table::new<address, ReferrerData<0x2::sui::SUI>>(arg0),
            referrer_rewards_ratio : 400,
            referee_rewards_ratio  : 400,
        };
        0x2::transfer::share_object<Vault<0x2::sui::SUI>>(v1);
    }

    public(friend) fun join_balance<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
    }

    public fun set_referer<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (v0 == arg1) {
            return
        };
        let v1 = &mut arg0.referee_table;
        let v2 = &mut arg0.referrer_table;
        if (0x2::object_table::contains<address, RefereeData<T0>>(v1, v0)) {
            return
        };
        let v3 = RefereeData<T0>{
            id              : 0x2::object::new(arg2),
            referrer        : arg1,
            referee_balance : 0x2::balance::zero<T0>(),
        };
        0x2::object_table::add<address, RefereeData<T0>>(v1, v0, v3);
        if (0x2::object_table::contains<address, ReferrerData<T0>>(v2, arg1)) {
            return
        };
        let v4 = ReferrerData<T0>{
            id               : 0x2::object::new(arg2),
            referrer_balance : 0x2::balance::zero<T0>(),
        };
        0x2::object_table::add<address, ReferrerData<T0>>(v2, arg1, v4);
    }

    public(friend) fun take_fund_balance<T0>(arg0: &mut Vault<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.balance, arg1)
    }

    public fun withdraw<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::take<T0>(&mut arg1.balance, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

