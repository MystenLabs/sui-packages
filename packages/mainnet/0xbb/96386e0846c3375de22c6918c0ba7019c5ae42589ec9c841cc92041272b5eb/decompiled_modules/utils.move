module 0xbb96386e0846c3375de22c6918c0ba7019c5ae42589ec9c841cc92041272b5eb::utils {
    public fun check_nft(arg0: 0x1::type_name::TypeName) : bool {
        0x1::type_name::into_string(arg0) == 0x1::ascii::string(b"449d6a4d13e5ddf4392d5fa395cb2a30eeadfe888fbd4656995fcfee142a3121::tocen_collection::MasterKeyNFT")
    }

    public fun get_end_time() : u64 {
        2
    }

    public fun get_nft() : vector<u8> {
        b"449d6a4d13e5ddf4392d5fa395cb2a30eeadfe888fbd4656995fcfee142a3121::tocen_collection::MasterKeyNFT"
    }

    public fun get_start_time() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

