module 0xc03a8903d5bd6e6b07603f6f837ff92c089bb1d8cc7b6bee44cca32efc0d1d3e::peer {
    struct Peer has store {
        address: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress,
        token_decimals: u8,
        inbound_rate_limit: 0xc03a8903d5bd6e6b07603f6f837ff92c089bb1d8cc7b6bee44cca32efc0d1d3e::rate_limit::RateLimitState,
    }

    public fun borrow_address(arg0: &Peer) : &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress {
        &arg0.address
    }

    public fun borrow_inbound_rate_limit_mut(arg0: &mut Peer) : &mut 0xc03a8903d5bd6e6b07603f6f837ff92c089bb1d8cc7b6bee44cca32efc0d1d3e::rate_limit::RateLimitState {
        &mut arg0.inbound_rate_limit
    }

    public fun get_token_decimals(arg0: &Peer) : u8 {
        arg0.token_decimals
    }

    public fun new(arg0: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress, arg1: u8, arg2: u64) : Peer {
        Peer{
            address            : arg0,
            token_decimals     : arg1,
            inbound_rate_limit : 0xc03a8903d5bd6e6b07603f6f837ff92c089bb1d8cc7b6bee44cca32efc0d1d3e::rate_limit::new(arg2),
        }
    }

    public fun set_address(arg0: &mut Peer, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress) {
        arg0.address = arg1;
    }

    public fun set_token_decimals(arg0: &mut Peer, arg1: u8) {
        arg0.token_decimals = arg1;
    }

    // decompiled from Move bytecode v6
}

