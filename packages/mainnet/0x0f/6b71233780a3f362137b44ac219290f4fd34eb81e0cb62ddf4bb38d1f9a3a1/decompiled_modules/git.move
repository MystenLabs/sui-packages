module 0xf6b71233780a3f362137b44ac219290f4fd34eb81e0cb62ddf4bb38d1f9a3a1::git {
    struct GitInfo has copy, drop, store {
        repository: 0x1::string::String,
        path: 0x1::string::String,
        tag: 0x1::string::String,
    }

    public fun new(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String) : GitInfo {
        GitInfo{
            repository : arg0,
            path       : arg1,
            tag        : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

