module 0xde72a9a75251a99a63f318569763f7c520283f6a876851b42abf15c688c7221::internal_pair {
    struct RawPair has copy, drop, store {
        base: 0x1::type_name::TypeName,
        quote: 0x1::type_name::TypeName,
    }

    struct Pair<phantom T0, phantom T1> has drop {
        raw: RawPair,
    }

    public fun get_raw<T0, T1>(arg0: &Pair<T0, T1>) : RawPair {
        arg0.raw
    }

    public fun new_pair<T0, T1>() : Pair<T0, T1> {
        Pair<T0, T1>{raw: new_raw(0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>())}
    }

    public fun new_raw(arg0: 0x1::type_name::TypeName, arg1: 0x1::type_name::TypeName) : RawPair {
        RawPair{
            base  : arg0,
            quote : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

