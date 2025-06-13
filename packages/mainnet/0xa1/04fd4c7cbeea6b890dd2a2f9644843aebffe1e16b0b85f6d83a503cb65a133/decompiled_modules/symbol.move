module 0x390e0f6824b66844de3763c00afb9d70718097e0f09108a6da6939c37b2bf8ff::symbol {
    struct Symbol has copy, drop, store {
        base_token: 0x1::type_name::TypeName,
        quote_token: 0x1::type_name::TypeName,
    }

    public(friend) fun base_token(arg0: &Symbol) : 0x1::type_name::TypeName {
        arg0.base_token
    }

    public(friend) fun create(arg0: 0x1::type_name::TypeName, arg1: 0x1::type_name::TypeName) : Symbol {
        Symbol{
            base_token  : arg0,
            quote_token : arg1,
        }
    }

    public(friend) fun new<T0, T1>() : Symbol {
        Symbol{
            base_token  : 0x1::type_name::get<T0>(),
            quote_token : 0x1::type_name::get<T1>(),
        }
    }

    public(friend) fun quote_token(arg0: &Symbol) : 0x1::type_name::TypeName {
        arg0.quote_token
    }

    // decompiled from Move bytecode v6
}

