module 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::inscription {
    struct Inscription has copy, drop, store {
        p: 0x1::string::String,
        tick: 0x1::string::String,
        amt: u64,
        extends: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public fun get_amt(arg0: &Inscription) : u64 {
        arg0.amt
    }

    public fun get_p(arg0: &Inscription) : 0x1::string::String {
        arg0.p
    }

    public fun get_tick(arg0: &Inscription) : 0x1::string::String {
        arg0.tick
    }

    public fun new(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) : Inscription {
        assert!(arg0 == protocol_suirc20(), 1);
        new_suirc20(arg0, arg1, arg2)
    }

    fun new_suirc20(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64) : Inscription {
        Inscription{
            p       : arg0,
            tick    : arg1,
            amt     : arg2,
            extends : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        }
    }

    public fun protocol_suirc20() : 0x1::string::String {
        0x1::string::utf8(b"suirc-20")
    }

    public fun transfer(arg0: &0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::config::Account, arg1: &Inscription, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg1.p == protocol_suirc20(), 1);
        0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::suirc20::transfer(arg1.tick, arg1.amt, 0x2::object::id_address<0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::config::Account>(arg0), arg2)
    }

    public fun transfer_from(arg0: &0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::config::Account, arg1: &Inscription, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg1.p == protocol_suirc20(), 1);
        0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::suirc20::transfer_from(arg1.tick, arg1.amt, arg0, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

