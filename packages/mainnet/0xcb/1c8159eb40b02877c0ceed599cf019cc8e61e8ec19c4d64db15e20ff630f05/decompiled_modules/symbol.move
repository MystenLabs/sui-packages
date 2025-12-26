module 0xcb1c8159eb40b02877c0ceed599cf019cc8e61e8ec19c4d64db15e20ff630f05::symbol {
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

    public(friend) fun quote_token(arg0: &Symbol) : 0x1::type_name::TypeName {
        arg0.quote_token
    }

    // decompiled from Move bytecode v6
}

