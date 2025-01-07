module 0x9664b1e243682f6db0d103cb972da6bf95927737d50d8e333ab53c2b3ed64f28::git {
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

