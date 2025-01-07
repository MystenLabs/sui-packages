module 0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::alpha_vault {
    struct AdminCap<phantom T0> has key {
        id: 0x2::object::UID,
    }

    struct TokenInfo<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        fee: 0x2::balance::Balance<T0>,
    }

    struct AlphaVault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        version: u64,
        nominal_deposit_value: u64,
        lp_supply: 0x2::balance::Supply<T1>,
        reward_ratio: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u128>,
        token_infos: 0x2::bag::Bag,
        assets: 0x2::bag::Bag,
        round: Round,
        swap_fee_rate: u64,
    }

    struct Round has store {
        deposit_start_time: u64,
        deposit_end_time: u64,
        unlock_time: u64,
        expire_time: u64,
        min_deposit: u64,
        total_max_deposit: 0x1::option::Option<u64>,
    }

    struct WithdrawReceipt<phantom T0, phantom T1> {
        lp_bal: 0x2::balance::Balance<T1>,
        reward_ratio: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u128>,
    }

    public fun balance<T0>(arg0: &TokenInfo<T0>) : &0x2::balance::Balance<T0> {
        &arg0.balance
    }

    public fun add_new_token<T0, T1, T2>(arg0: &mut AlphaVault<T0, T1>) {
        assert_version<T0, T1>(arg0);
        let v0 = TokenInfo<T2>{
            balance : 0x2::balance::zero<T2>(),
            fee     : 0x2::balance::zero<T2>(),
        };
        0x2::bag::add<0x1::type_name::TypeName, TokenInfo<T2>>(&mut arg0.token_infos, 0x1::type_name::get<T2>(), v0);
    }

    fun assert_deposit_time(arg0: &Round, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.deposit_start_time && v0 < arg0.deposit_end_time, 102);
    }

    public(friend) fun assert_expired_period<T0, T1>(arg0: &AlphaVault<T0, T1>, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.round.expire_time, 110);
    }

    public(friend) fun assert_locked_period<T0, T1>(arg0: &AlphaVault<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.round.deposit_end_time && v0 < arg0.round.unlock_time, 106);
    }

    fun assert_max_cap<T0, T1>(arg0: &AlphaVault<T0, T1>) {
        if (0x1::option::is_some<u64>(&arg0.round.total_max_deposit)) {
            assert!(arg0.nominal_deposit_value <= *0x1::option::borrow<u64>(&arg0.round.total_max_deposit), 105);
        };
    }

    fun assert_min_deposit(arg0: &Round, arg1: u64) {
        assert!(arg1 >= arg0.min_deposit, 104);
    }

    fun assert_reward_ratio_settled<T0, T1>(arg0: &AlphaVault<T0, T1>) {
        assert!(0x2::vec_map::size<0x1::type_name::TypeName, u128>(&arg0.reward_ratio) == 0x2::bag::length(&arg0.token_infos), 108);
    }

    fun assert_valid_round(arg0: &Round, arg1: &0x2::clock::Clock) {
        let v0 = if (0x2::clock::timestamp_ms(arg1) < arg0.deposit_start_time) {
            if (arg0.deposit_start_time < arg0.deposit_end_time) {
                if (arg0.deposit_end_time < arg0.unlock_time) {
                    arg0.unlock_time < arg0.expire_time
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 101);
    }

    fun assert_version<T0, T1>(arg0: &AlphaVault<T0, T1>) {
        assert!(arg0.version == 1, 1);
    }

    public(friend) fun assert_withdraw_time<T0, T1>(arg0: &AlphaVault<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.round.unlock_time && v0 < arg0.round.expire_time, 103);
    }

    public(friend) fun assets<T0, T1>(arg0: &AlphaVault<T0, T1>) : &0x2::bag::Bag {
        &arg0.assets
    }

    public(friend) fun assets_mut<T0, T1>(arg0: &mut AlphaVault<T0, T1>) : &mut 0x2::bag::Bag {
        &mut arg0.assets
    }

    public fun balance_mut<T0>(arg0: &mut TokenInfo<T0>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.balance
    }

    public fun calculate_reward<T0, T1, T2>(arg0: &mut AlphaVault<T0, T1>) {
        assert_version<T0, T1>(arg0);
        assert!(0x2::bag::is_empty(&arg0.assets), 107);
        let v0 = token_infos_mut<T0, T1, T2>(arg0);
        0x2::vec_map::insert<0x1::type_name::TypeName, u128>(&mut arg0.reward_ratio, 0x1::type_name::get<T2>(), (0x2::balance::value<T2>(&v0.balance) as u128) * (1000000000 as u128) / (0x2::balance::supply_value<T1>(&arg0.lp_supply) as u128));
    }

    public fun deposit<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_version<T0, T1>(arg0);
        assert_deposit_time(&arg0.round, arg2);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert_min_deposit(&arg0.round, v0);
        let v1 = token_infos_mut<T0, T1, T0>(arg0);
        0x2::balance::join<T0>(&mut v1.balance, 0x2::coin::into_balance<T0>(arg1));
        arg0.nominal_deposit_value = arg0.nominal_deposit_value + v0;
        assert_max_cap<T0, T1>(arg0);
        0x599439d28d0bd9c0233ef6fd007b44c85ab2e784c5b34a5551680c24a110b25::event::deposit<T0>(0x2::tx_context::sender(arg3), v0);
        0x2::coin::from_balance<T1>(0x2::balance::increase_supply<T1>(&mut arg0.lp_supply, v0), arg3)
    }

    public fun deposit_end_time<T0, T1>(arg0: &AlphaVault<T0, T1>) : u64 {
        arg0.round.deposit_end_time
    }

    public fun deposit_start_time<T0, T1>(arg0: &AlphaVault<T0, T1>) : u64 {
        arg0.round.deposit_start_time
    }

    public fun expire_time<T0, T1>(arg0: &AlphaVault<T0, T1>) : u64 {
        arg0.round.expire_time
    }

    public fun fee<T0>(arg0: &TokenInfo<T0>) : &0x2::balance::Balance<T0> {
        &arg0.fee
    }

    public fun fee_mut<T0>(arg0: &mut TokenInfo<T0>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.fee
    }

    public fun finalize_withdraw<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: WithdrawReceipt<T0, T1>) {
        assert_version<T0, T1>(arg0);
        let WithdrawReceipt {
            lp_bal       : v0,
            reward_ratio : v1,
        } = arg1;
        let v2 = v1;
        assert!(0x2::vec_map::is_empty<0x1::type_name::TypeName, u128>(&v2), 109);
        0x2::balance::decrease_supply<T1>(&mut arg0.lp_supply, v0);
    }

    public fun initialize_withdraw<T0, T1>(arg0: &mut AlphaVault<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock) : WithdrawReceipt<T0, T1> {
        assert_version<T0, T1>(arg0);
        assert_withdraw_time<T0, T1>(arg0, arg2);
        assert_reward_ratio_settled<T0, T1>(arg0);
        WithdrawReceipt<T0, T1>{
            lp_bal       : 0x2::coin::into_balance<T1>(arg1),
            reward_ratio : arg0.reward_ratio,
        }
    }

    public fun is_token_exists<T0, T1, T2>(arg0: &AlphaVault<T0, T1>) : bool {
        0x2::bag::contains<0x1::type_name::TypeName>(&arg0.token_infos, 0x1::type_name::get<T2>())
    }

    public fun min_deposit<T0, T1>(arg0: &AlphaVault<T0, T1>) : u64 {
        arg0.round.min_deposit
    }

    public fun new_vault<T0, T1>(arg0: 0x2::coin::TreasuryCap<T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::option::Option<u64>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap<T1>{id: 0x2::object::new(arg9)};
        0x2::transfer::transfer<AdminCap<T1>>(v0, 0x2::tx_context::sender(arg9));
        let v1 = Round{
            deposit_start_time : arg1,
            deposit_end_time   : arg2,
            unlock_time        : arg3,
            expire_time        : arg4,
            min_deposit        : arg5,
            total_max_deposit  : arg6,
        };
        assert_valid_round(&v1, arg8);
        let v2 = AlphaVault<T0, T1>{
            id                    : 0x2::object::new(arg9),
            version               : 1,
            nominal_deposit_value : 0,
            lp_supply             : 0x2::coin::treasury_into_supply<T1>(arg0),
            reward_ratio          : 0x2::vec_map::empty<0x1::type_name::TypeName, u128>(),
            token_infos           : 0x2::bag::new(arg9),
            assets                : 0x2::bag::new(arg9),
            round                 : v1,
            swap_fee_rate         : arg7,
        };
        let v3 = &mut v2;
        add_new_token<T0, T1, T0>(v3);
        0x2::transfer::public_share_object<AlphaVault<T0, T1>>(v2);
    }

    public fun swap_fee_rate<T0, T1>(arg0: &AlphaVault<T0, T1>) : u64 {
        arg0.swap_fee_rate
    }

    public fun token_infos<T0, T1, T2>(arg0: &AlphaVault<T0, T1>) : &TokenInfo<T2> {
        0x2::bag::borrow<0x1::type_name::TypeName, TokenInfo<T2>>(&arg0.token_infos, 0x1::type_name::get<T2>())
    }

    public(friend) fun token_infos_mut<T0, T1, T2>(arg0: &mut AlphaVault<T0, T1>) : &mut TokenInfo<T2> {
        0x2::bag::borrow_mut<0x1::type_name::TypeName, TokenInfo<T2>>(&mut arg0.token_infos, 0x1::type_name::get<T2>())
    }

    public fun total_max_deposit<T0, T1>(arg0: &AlphaVault<T0, T1>) : 0x1::option::Option<u64> {
        arg0.round.total_max_deposit
    }

    public fun unlock_time<T0, T1>(arg0: &AlphaVault<T0, T1>) : u64 {
        arg0.round.unlock_time
    }

    public fun update_deposit_end_time<T0, T1>(arg0: &AdminCap<T1>, arg1: &mut AlphaVault<T0, T1>, arg2: u64) {
        assert_version<T0, T1>(arg1);
        arg1.round.deposit_start_time = arg2;
    }

    public fun update_deposit_start_time<T0, T1>(arg0: &AdminCap<T1>, arg1: &mut AlphaVault<T0, T1>, arg2: u64) {
        assert_version<T0, T1>(arg1);
        arg1.round.deposit_start_time = arg2;
    }

    public fun update_expire_time<T0, T1>(arg0: &AdminCap<T1>, arg1: &mut AlphaVault<T0, T1>, arg2: u64) {
        assert_version<T0, T1>(arg1);
        arg1.round.expire_time = arg2;
    }

    public fun update_min_deposit<T0, T1>(arg0: &AdminCap<T1>, arg1: &mut AlphaVault<T0, T1>, arg2: u64) {
        assert_version<T0, T1>(arg1);
        arg1.round.min_deposit = arg2;
    }

    public fun update_total_max_deposit<T0, T1>(arg0: &AdminCap<T1>, arg1: &mut AlphaVault<T0, T1>, arg2: 0x1::option::Option<u64>) {
        assert_version<T0, T1>(arg1);
        arg1.round.total_max_deposit = arg2;
    }

    public fun update_unlock_time<T0, T1>(arg0: &AdminCap<T1>, arg1: &mut AlphaVault<T0, T1>, arg2: u64) {
        assert_version<T0, T1>(arg1);
        arg1.round.unlock_time = arg2;
    }

    public fun withdraw<T0, T1, T2>(arg0: &mut AlphaVault<T0, T1>, arg1: &mut WithdrawReceipt<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_version<T0, T1>(arg0);
        let v0 = 0x1::type_name::get<T2>();
        let (_, v2) = 0x2::vec_map::remove<0x1::type_name::TypeName, u128>(&mut arg1.reward_ratio, &v0);
        0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut token_infos_mut<T0, T1, T2>(arg0).balance, (((0x2::balance::value<T1>(&arg1.lp_bal) as u128) * v2 / (1000000000 as u128)) as u64)), arg2)
    }

    public fun withdraw_expired_funds<T0, T1, T2>(arg0: &AdminCap<T1>, arg1: &mut AlphaVault<T0, T1>, arg2: u64) : 0x2::balance::Balance<T2> {
        assert_version<T0, T1>(arg1);
        let v0 = token_infos_mut<T0, T1, T2>(arg1);
        0x2::balance::split<T2>(balance_mut<T2>(v0), arg2)
    }

    public fun withdraw_fee<T0, T1, T2>(arg0: &AdminCap<T1>, arg1: &mut AlphaVault<T0, T1>, arg2: u64) : 0x2::balance::Balance<T2> {
        assert_version<T0, T1>(arg1);
        let v0 = token_infos_mut<T0, T1, T2>(arg1);
        0x2::balance::split<T2>(fee_mut<T2>(v0), arg2)
    }

    // decompiled from Move bytecode v6
}

