module 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::id_util {
    public fun address_placeholder() : address {
        0x2::address::from_bytes(b"DDDAppp+++++++++++++++++++++++++")
    }

    public fun hash_placeholder() : vector<u8> {
        b"dddappp*************************"
    }

    public fun id_placeholder() : 0x2::object::ID {
        0x2::object::id_from_bytes(b"dddaPPP-------------------------")
    }

    // decompiled from Move bytecode v6
}

