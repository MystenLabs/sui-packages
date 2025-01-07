module 0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::registered_tokens {
    struct RegisteredTokens has store, key {
        id: 0x2::object::UID,
        num_tokens: u64,
    }

    struct Key<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    fun add<T0>(arg0: &mut RegisteredTokens, arg1: 0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::token_info::TokenInfo<T0>) {
        let v0 = Key<T0>{dummy_field: false};
        0x2::dynamic_field::add<Key<T0>, 0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::token_info::TokenInfo<T0>>(&mut arg0.id, v0, arg1);
        arg0.num_tokens = arg0.num_tokens + 1;
    }

    fun remove<T0>(arg0: &mut RegisteredTokens) {
        let v0 = Key<T0>{dummy_field: false};
        0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::token_info::destroy<T0>(0x2::dynamic_field::remove<Key<T0>, 0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::token_info::TokenInfo<T0>>(&mut arg0.id, v0));
        arg0.num_tokens = arg0.num_tokens - 1;
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : RegisteredTokens {
        RegisteredTokens{
            id         : 0x2::object::new(arg0),
            num_tokens : 0,
        }
    }

    public(friend) fun add_token<T0>(arg0: &mut RegisteredTokens, arg1: u64, arg2: u64, arg3: bool) {
        assert!(!has<T0>(arg0), 1);
        assert!(arg1 > 0, 2);
        add<T0>(arg0, 0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::token_info::new<T0>(arg1, arg2, arg3));
    }

    fun borrow_token_info<T0>(arg0: &RegisteredTokens) : &0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::token_info::TokenInfo<T0> {
        let v0 = Key<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<Key<T0>, 0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::token_info::TokenInfo<T0>>(&arg0.id, v0)
    }

    fun borrow_token_info_mut<T0>(arg0: &mut RegisteredTokens) : &mut 0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::token_info::TokenInfo<T0> {
        let v0 = Key<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<Key<T0>, 0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::token_info::TokenInfo<T0>>(&mut arg0.id, v0)
    }

    public fun has<T0>(arg0: &RegisteredTokens) : bool {
        let v0 = Key<T0>{dummy_field: false};
        0x2::dynamic_field::exists_<Key<T0>>(&arg0.id, v0)
    }

    public fun is_swap_enabled<T0>(arg0: &RegisteredTokens) : bool {
        0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::token_info::is_swap_enabled<T0>(borrow_token_info<T0>(arg0))
    }

    public fun max_native_swap_amount<T0>(arg0: &RegisteredTokens) : u64 {
        assert!(has<T0>(arg0), 0);
        0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::token_info::max_native_swap_amount<T0>(borrow_token_info<T0>(arg0))
    }

    public fun num_tokens(arg0: &RegisteredTokens) : u64 {
        arg0.num_tokens
    }

    public(friend) fun remove_token<T0>(arg0: &mut RegisteredTokens) {
        assert!(has<T0>(arg0), 0);
        remove<T0>(arg0);
    }

    public fun swap_rate<T0>(arg0: &RegisteredTokens) : u64 {
        assert!(has<T0>(arg0), 0);
        0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::token_info::swap_rate<T0>(borrow_token_info<T0>(arg0))
    }

    public(friend) fun toggle_swap_enabled<T0>(arg0: &mut RegisteredTokens, arg1: bool) {
        if (arg1) {
            0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::token_info::enable_swap<T0>(borrow_token_info_mut<T0>(arg0));
        } else {
            0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::token_info::disable_swap<T0>(borrow_token_info_mut<T0>(arg0));
        };
    }

    public(friend) fun update_max_native_swap_amount<T0>(arg0: &mut RegisteredTokens, arg1: u64) {
        assert!(has<T0>(arg0), 0);
        0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::token_info::update_max_native_swap_amount<T0>(borrow_token_info_mut<T0>(arg0), arg1);
    }

    public(friend) fun update_swap_rate<T0>(arg0: &mut RegisteredTokens, arg1: u64) {
        assert!(has<T0>(arg0), 0);
        assert!(arg1 > 0, 2);
        0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::token_info::update_swap_rate<T0>(borrow_token_info_mut<T0>(arg0), arg1);
    }

    // decompiled from Move bytecode v6
}

