module 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::direct_rule {
    struct DirectRule has drop {
        dummy_field: bool,
    }

    public fun consume_deposit_direct<T0>(arg0: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::DepositRequest<T0>) {
        let (v0, v1, _) = 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::consume_deposit<T0, DirectRule>(arg0, arg1, witness());
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::put<T0, DirectRule>(arg0, v0, v1, witness());
    }

    public fun consume_withdraw_direct<T0>(arg0: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::WithdrawRequest<T0>) {
        let (_, v1, v2, _) = 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::consume_withdraw<T0, DirectRule>(arg0, arg1, witness());
        0x2::balance::send_funds<T0>(v1, v2);
    }

    public(friend) fun witness() : DirectRule {
        DirectRule{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

