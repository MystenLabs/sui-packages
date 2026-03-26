module 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::metadata {
    struct Metadata has copy, drop, store {
        inner: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public fun empty() : Metadata {
        Metadata{inner: 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>()}
    }

    public fun from_keys_values(arg0: vector<0x1::string::String>, arg1: vector<0x1::string::String>) : Metadata {
        assert!(0x1::vector::length<0x1::string::String>(&arg0) == 0x1::vector::length<0x1::string::String>(&arg1), 0);
        Metadata{inner: 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg0, arg1)}
    }

    public fun get(arg0: &Metadata, arg1: 0x1::string::String) : 0x1::string::String {
        *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg0.inner, &arg1)
    }

    public fun get_entry_by_idx(arg0: &Metadata, arg1: u64) : (0x1::string::String, 0x1::string::String) {
        let (v0, v1) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, 0x1::string::String>(&arg0.inner, arg1);
        (*v0, *v1)
    }

    public fun size(arg0: &Metadata) : u64 {
        0x2::vec_map::length<0x1::string::String, 0x1::string::String>(&arg0.inner)
    }

    // decompiled from Move bytecode v6
}

