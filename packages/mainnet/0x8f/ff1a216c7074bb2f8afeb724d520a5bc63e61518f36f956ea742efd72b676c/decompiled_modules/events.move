module 0x8fff1a216c7074bb2f8afeb724d520a5bc63e61518f36f956ea742efd72b676c::events {
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

