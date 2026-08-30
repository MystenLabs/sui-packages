module 0x1fca25b65de011b4cafec5ee02fd590dc4cc12cda17d8602d9c7327a66eb285a::mcae0480805163ab91fcddd2a {
    public fun f3b81b86108f9c21823907935<T0>(arg0: T0) : vector<T0> {
        0x1::vector::singleton<T0>(arg0)
    }

    public fun f5f850f3214ca2dcc6454223d<T0>() : 0x1::type_name::TypeName {
        0x1::type_name::get<T0>()
    }

    public fun ff540b6aa0edeb9c8de4b2dd7<T0>(arg0: T0) : 0x1::option::Option<T0> {
        0x1::option::some<T0>(arg0)
    }

    // decompiled from Move bytecode v7
}

