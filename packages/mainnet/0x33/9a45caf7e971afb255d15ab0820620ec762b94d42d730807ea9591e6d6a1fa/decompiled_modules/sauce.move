module 0x339a45caf7e971afb255d15ab0820620ec762b94d42d730807ea9591e6d6a1fa::sauce {
    struct SAUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAUCE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SAUCE>(arg0, 738124286131271602, b"SUI SAUCE", b"SAUCE", b"Pour SUI SAUCE on any Meme to make it instantly profitable.. I also feed it to my pet snail Gary!  #1 Choice of SPACEX astronauts!", b"https://images.hop.ag/ipfs/QmTb19mUkY5vqYJJsqvoMEckWfT3mYGRkNeYM2RMQ5BQis", 0x1::string::utf8(b"https://x.com/elonmusk"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

