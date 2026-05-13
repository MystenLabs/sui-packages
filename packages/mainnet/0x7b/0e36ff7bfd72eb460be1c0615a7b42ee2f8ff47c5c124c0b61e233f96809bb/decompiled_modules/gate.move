module 0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::gate {
    struct ProfitRealized has copy, drop {
        coin_type: 0x1::ascii::String,
        profit: u64,
        min_required: u64,
    }

    public fun assert_profit<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::asserts::must_amount(arg2);
        0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::asserts::must_profit_at_least(0x2::balance::value<T0>(&arg1), arg2);
        0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::tools::join_into<T0>(arg0, 0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::tools::coin_from_balance<T0>(arg1, arg3));
    }

    public fun assert_profit_and_emit<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_profit<T0>(arg0, arg1, arg2, arg3);
        emit_profit_realized<T0>(0x2::balance::value<T0>(&arg1), arg2);
    }

    public fun assert_profit_and_emit_to_recipient<T0>(arg0: address, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_profit_to_recipient<T0>(arg0, arg1, arg2, arg3);
        emit_profit_realized<T0>(0x2::balance::value<T0>(&arg1), arg2);
    }

    public fun assert_profit_and_emit_to_vault<T0>(arg0: &mut 0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::wallet::Vault<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64) {
        assert_profit_to_vault<T0>(arg0, arg1, arg2);
        emit_profit_realized<T0>(0x2::balance::value<T0>(&arg1), arg2);
    }

    public fun assert_profit_to_recipient<T0>(arg0: address, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::asserts::must_amount(arg2);
        0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::asserts::must_profit_at_least(0x2::balance::value<T0>(&arg1), arg2);
        0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::tools::transfer_balance<T0>(arg1, arg0, arg3);
    }

    public fun assert_profit_to_vault<T0>(arg0: &mut 0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::wallet::Vault<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64) {
        0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::asserts::must_amount(arg2);
        0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::asserts::must_profit_at_least(0x2::balance::value<T0>(&arg1), arg2);
        0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::wallet::destroy_or_deposit_balance<T0>(arg0, arg1);
    }

    fun emit_profit_realized<T0>(arg0: u64, arg1: u64) {
        0x2::event::emit<ProfitRealized>(make_profit_realized<T0>(arg0, arg1));
    }

    fun make_profit_realized<T0>(arg0: u64, arg1: u64) : ProfitRealized {
        ProfitRealized{
            coin_type    : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            profit       : arg0,
            min_required : arg1,
        }
    }

    // decompiled from Move bytecode v7
}

