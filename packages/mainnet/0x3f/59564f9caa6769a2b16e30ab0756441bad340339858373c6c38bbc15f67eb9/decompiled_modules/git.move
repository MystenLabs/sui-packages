module 0x3f59564f9caa6769a2b16e30ab0756441bad340339858373c6c38bbc15f67eb9::git {
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

