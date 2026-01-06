module 0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::auth {
    struct Auth<phantom T0, phantom T1> has drop {
        pos0: address,
    }

    public fun addr<T0, T1: drop>(arg0: &Auth<T0, T1>) : address {
        arg0.pos0
    }

    public fun new<T0, T1: drop>(arg0: &mut 0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::TokenAuthority<T0>, arg1: &mut 0x2::tx_context::TxContext) : Auth<T0, T1> {
        0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::assert_is_valid_version<T0>(arg0);
        0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::roles::assert_is_authorized<T1>(0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::roles<T0>(arg0), 0x2::tx_context::sender(arg1));
        0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::roles::assert_is_not_paused<T1>(0x6b8df153d5e4804622084e284b81dc7586383024e556867b78360fa469af9652::token_authority::roles<T0>(arg0));
        Auth<T0, T1>{pos0: 0x2::tx_context::sender(arg1)}
    }

    // decompiled from Move bytecode v6
}

