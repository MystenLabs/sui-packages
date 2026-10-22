module 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::lending_state {
    struct FToken<phantom T0> has key {
        id: 0x2::object::UID,
    }

    struct LendingState<phantom T0> has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<FToken<T0>>,
        reserve_id: 0x2::object::ID,
        rewards_writer: 0x1::option::Option<0x2::object::ID>,
        token_exchange_price: u64,
        liquidity_exchange_price: u64,
        last_update_s: 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::TimestampS,
    }

    public(friend) fun assert_bound<T0>(arg0: &LendingState<T0>, arg1: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>) {
        assert!(0x2::object::id<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>>(arg1) == arg0.reserve_id, 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::wrong_reserve());
    }

    public(friend) fun borrow_liquidity_cap<T0>(arg0: &LendingState<T0>) : &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::user_cap::UserCap<T0> {
        0x2::dynamic_field::borrow<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::keys::LiquidityCapKey, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::user_cap::UserCap<T0>>(&arg0.id, 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::keys::liquidity_cap_key())
    }

    public(friend) fun borrow_rewards<T0>(arg0: &LendingState<T0>) : &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsSchedule {
        0x2::dynamic_field::borrow<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::keys::RewardsKey, 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsSchedule>(&arg0.id, 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::keys::rewards_key())
    }

    public(friend) fun burn_share_balance<T0>(arg0: &mut LendingState<T0>, arg1: 0x2::balance::Balance<FToken<T0>>) : u64 {
        0x2::balance::decrease_supply<FToken<T0>>(&mut arg0.supply, arg1)
    }

    public(friend) fun clear_rewards<T0>(arg0: &mut LendingState<T0>) {
        0x2::dynamic_field::remove<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::keys::RewardsKey, 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsSchedule>(&mut arg0.id, 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::keys::rewards_key());
    }

    public(friend) fun create<T0>(arg0: &mut 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::LendingRegistry, arg1: &mut 0x2::coin_registry::CoinRegistry, arg2: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg3: &0x2::coin_registry::Currency<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : LendingState<T0> {
        create_internal<T0>(arg0, arg1, arg2, 0x2::coin_registry::decimals<T0>(arg3), 0x2::coin_registry::symbol<T0>(arg3), 0x2::coin_registry::name<T0>(arg3), arg4, arg5)
    }

    fun create_internal<T0>(arg0: &mut 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::LendingRegistry, arg1: &mut 0x2::coin_registry::CoinRegistry, arg2: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg3: u8, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : LendingState<T0> {
        let v0 = 0x1::string::utf8(b"f");
        0x1::string::append(&mut v0, arg4);
        let v1 = 0x1::string::utf8(b"Fluid ");
        0x1::string::append(&mut v1, arg5);
        let v2 = 0x1::string::to_ascii(v0);
        let v3 = 0x1::ascii::to_lowercase(&v2);
        let v4 = 0x1::string::utf8(b"https://cdn.instadapp.io/sui/tokens/icons/");
        0x1::string::append(&mut v4, 0x1::string::from_ascii(v3));
        0x1::string::append(&mut v4, 0x1::string::utf8(b".png"));
        let v5 = 0x1::string::utf8(b"Fluid ");
        0x1::string::append(&mut v5, 0x1::string::from_ascii(v3));
        0x1::string::append(&mut v5, 0x1::string::utf8(b" token."));
        let (v6, v7) = 0x2::coin_registry::new_currency<FToken<T0>>(arg1, arg3, v0, v1, v5, v4, arg7);
        let v8 = 0x2::derived_object::claim<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::keys::LendingStateKey<T0>>(0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::uid_mut(arg0), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::keys::lending_state_key<T0>());
        0x2::dynamic_field::add<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::keys::ShareMetadataKey, 0x2::coin_registry::MetadataCap<FToken<T0>>>(&mut v8, 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::keys::share_metadata_key(), 0x2::coin_registry::finalize<FToken<T0>>(v6, arg7));
        let (v9, _) = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::get_exchange_prices<T0>(arg2, arg6);
        LendingState<T0>{
            id                       : v8,
            supply                   : 0x2::coin::treasury_into_supply<FToken<T0>>(v7),
            reserve_id               : 0x2::object::id<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>>(arg2),
            rewards_writer           : 0x1::option::none<0x2::object::ID>(),
            token_exchange_price     : (0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::constants::exchange_prices_precision() as u64),
            liquidity_exchange_price : (v9 as u64),
            last_update_s            : 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::from_clock(arg6),
        }
    }

    public(friend) fun create_with_metadata<T0>(arg0: &mut 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::LendingRegistry, arg1: &mut 0x2::coin_registry::CoinRegistry, arg2: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : LendingState<T0> {
        create_internal<T0>(arg0, arg1, arg2, 0x2::coin::get_decimals<T0>(arg3), 0x1::string::from_ascii(0x2::coin::get_symbol<T0>(arg3)), 0x2::coin::get_name<T0>(arg3), arg4, arg5)
    }

    public fun exchange_prices<T0>(arg0: &LendingState<T0>) : (u64, u64) {
        (arg0.token_exchange_price, arg0.liquidity_exchange_price)
    }

    public fun has_liquidity_cap<T0>(arg0: &LendingState<T0>) : bool {
        0x2::dynamic_field::exists_with_type<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::keys::LiquidityCapKey, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::user_cap::UserCap<T0>>(&arg0.id, 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::keys::liquidity_cap_key())
    }

    public fun has_rewards<T0>(arg0: &LendingState<T0>) : bool {
        0x2::dynamic_field::exists<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::keys::RewardsKey>(&arg0.id, 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::keys::rewards_key())
    }

    public fun holder<T0>(arg0: &LendingState<T0>) : 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::keys::Holder {
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::keys::holder_object(0x2::object::id<LendingState<T0>>(arg0))
    }

    public fun install_liquidity_cap<T0>(arg0: &mut LendingState<T0>, arg1: &0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::LendingRegistry, arg2: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::user_cap::UserCap<T0>) {
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::registry::assert_version(arg1);
        assert!(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::user_cap::get_user_cap_holder<T0>(&arg2) == holder<T0>(arg0), 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::errors::cap_holder_mismatch());
        0x2::dynamic_field::add<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::keys::LiquidityCapKey, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::user_cap::UserCap<T0>>(&mut arg0.id, 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::keys::liquidity_cap_key(), arg2);
        0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::events::emit_log_install_liquidity_cap(0x2::object::id<LendingState<T0>>(arg0), 0x2::object::id<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::user_cap::UserCap<T0>>(&arg2));
    }

    public fun last_update_s<T0>(arg0: &LendingState<T0>) : 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::TimestampS {
        arg0.last_update_s
    }

    public(friend) fun mint_share_balance<T0>(arg0: &mut LendingState<T0>, arg1: u64) : 0x2::balance::Balance<FToken<T0>> {
        0x2::balance::increase_supply<FToken<T0>>(&mut arg0.supply, arg1)
    }

    public fun rewards_schedule<T0>(arg0: &LendingState<T0>) : 0x1::option::Option<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsSchedule> {
        if (has_rewards<T0>(arg0)) {
            0x1::option::some<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsSchedule>(*borrow_rewards<T0>(arg0))
        } else {
            0x1::option::none<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsSchedule>()
        }
    }

    public fun rewards_writer<T0>(arg0: &LendingState<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.rewards_writer
    }

    public(friend) fun set_rewards<T0>(arg0: &mut LendingState<T0>, arg1: 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsSchedule) {
        if (0x2::dynamic_field::exists<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::keys::RewardsKey>(&arg0.id, 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::keys::rewards_key())) {
            0x2::dynamic_field::remove<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::keys::RewardsKey, 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsSchedule>(&mut arg0.id, 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::keys::rewards_key());
        };
        0x2::dynamic_field::add<0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::keys::RewardsKey, 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::rewards::RewardsSchedule>(&mut arg0.id, 0xf4b57b2ee765289cf8cc9ab5b56aadb6ef49c516db266e4ee765f1ad9756736::keys::rewards_key(), arg1);
    }

    public(friend) fun set_rewards_writer<T0>(arg0: &mut LendingState<T0>, arg1: 0x1::option::Option<0x2::object::ID>) {
        arg0.rewards_writer = arg1;
    }

    public(friend) fun share<T0>(arg0: LendingState<T0>) {
        0x2::transfer::share_object<LendingState<T0>>(arg0);
    }

    public(friend) fun store_prices<T0>(arg0: &mut LendingState<T0>, arg1: u64, arg2: u64, arg3: 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::TimestampS) {
        arg0.token_exchange_price = arg1;
        arg0.liquidity_exchange_price = arg2;
        arg0.last_update_s = arg3;
    }

    public fun total_shares<T0>(arg0: &LendingState<T0>) : u64 {
        0x2::balance::supply_value<FToken<T0>>(&arg0.supply)
    }

    // decompiled from Move bytecode v7
}

