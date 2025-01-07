module 0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::inscription {
    struct Inscription has copy, drop, store {
        p: 0x1::string::String,
        tick: 0x1::string::String,
        amt: u64,
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

    public fun new(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64) : Inscription {
        assert!(arg0 == protocol_suirc20(), 1);
        new_suirc20(arg0, arg1, arg2)
    }

    fun new_suirc20(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64) : Inscription {
        Inscription{
            p    : arg0,
            tick : arg1,
            amt  : arg2,
        }
    }

    public fun protocol_suirc20() : 0x1::string::String {
        0x1::string::utf8(b"suirc-20")
    }

    public fun transfer(arg0: &0xcb5bd7a29f458a1b1e0221516fbfaeb182be027033eb8dcb4f33dd540d20bb87::config::Account, arg1: &Inscription, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg1.p == protocol_suirc20(), 1);
        0xcb5bd7a29f458a1b1e0221516fbfaeb182be027033eb8dcb4f33dd540d20bb87::suirc20::transfer(arg1.tick, arg1.amt, 0x2::object::id_address<0xcb5bd7a29f458a1b1e0221516fbfaeb182be027033eb8dcb4f33dd540d20bb87::config::Account>(arg0), arg2)
    }

    public fun transfer_from(arg0: &0xcb5bd7a29f458a1b1e0221516fbfaeb182be027033eb8dcb4f33dd540d20bb87::config::Account, arg1: &Inscription, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg1.p == protocol_suirc20(), 1);
        0xcb5bd7a29f458a1b1e0221516fbfaeb182be027033eb8dcb4f33dd540d20bb87::suirc20::transfer_from(arg1.tick, arg1.amt, arg0, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

