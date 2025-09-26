module 0x89e17825a895ddba532a5aebbf5f790f22401dd014494a9a47c8a1600d1f4ec0::result {
    struct Result<T0> has copy, drop, store {
        is_ok: bool,
        ok: 0x1::option::Option<T0>,
        error: 0x1::option::Option<0x1::string::String>,
    }

    public fun borrow<T0>(arg0: &Result<T0>) : &T0 {
        assert!(arg0.is_ok, 0);
        0x1::option::borrow<T0>(&arg0.ok)
    }

    public fun borrow_err<T0>(arg0: &Result<T0>) : &0x1::string::String {
        assert!(!arg0.is_ok, 1);
        0x1::option::borrow<0x1::string::String>(&arg0.error)
    }

    public fun error<T0>(arg0: vector<u8>) : Result<T0> {
        Result<T0>{
            is_ok : false,
            ok    : 0x1::option::none<T0>(),
            error : 0x1::option::some<0x1::string::String>(0x1::string::utf8(arg0)),
        }
    }

    public fun is_ok<T0>(arg0: &Result<T0>) : bool {
        arg0.is_ok
    }

    public fun ok<T0>(arg0: T0) : Result<T0> {
        Result<T0>{
            is_ok : true,
            ok    : 0x1::option::some<T0>(arg0),
            error : 0x1::option::none<0x1::string::String>(),
        }
    }

    public fun unwrap<T0>(arg0: Result<T0>) : T0 {
        let Result {
            is_ok : v0,
            ok    : v1,
            error : _,
        } = arg0;
        assert!(v0, 0);
        0x1::option::destroy_some<T0>(v1)
    }

    public fun unwrap_err<T0>(arg0: Result<T0>) : 0x1::string::String {
        let Result {
            is_ok : v0,
            ok    : v1,
            error : v2,
        } = arg0;
        assert!(!v0, 1);
        0x1::option::destroy_none<T0>(v1);
        0x1::option::destroy_some<0x1::string::String>(v2)
    }

    public fun unwrap_or<T0: drop>(arg0: Result<T0>, arg1: T0) : T0 {
        let Result {
            is_ok : _,
            ok    : v1,
            error : _,
        } = arg0;
        0x1::option::destroy_with_default<T0>(v1, arg1)
    }

    // decompiled from Move bytecode v6
}

