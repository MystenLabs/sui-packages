module 0x15f29668bc8a8168975f6de8da926ea398619cfff5894bb71d31a777fa7ea18e::github {
    struct GithubInfo has copy, drop, store {
        repository: 0x1::string::String,
        path: 0x1::string::String,
        tag: 0x1::string::String,
    }

    public fun new(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String) : GithubInfo {
        GithubInfo{
            repository : arg0,
            path       : arg1,
            tag        : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

