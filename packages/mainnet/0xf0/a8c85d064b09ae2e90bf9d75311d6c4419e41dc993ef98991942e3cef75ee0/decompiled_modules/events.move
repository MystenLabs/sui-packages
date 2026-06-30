module 0xf0a8c85d064b09ae2e90bf9d75311d6c4419e41dc993ef98991942e3cef75ee0::events {
    struct Migrated has copy, drop {
        source: 0x1::string::String,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun emit_migrated<T0>(arg0: &0x2::coin::Coin<T0>, arg1: 0x1::string::String) {
        let v0 = Migrated{
            source    : arg1,
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : 0x2::coin::value<T0>(arg0),
        };
        0x2::event::emit<Migrated>(v0);
    }

    // decompiled from Move bytecode v7
}

