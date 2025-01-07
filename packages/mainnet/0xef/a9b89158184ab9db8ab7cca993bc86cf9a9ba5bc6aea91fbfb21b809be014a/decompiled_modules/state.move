module 0xefa9b89158184ab9db8ab7cca993bc86cf9a9ba5bc6aea91fbfb21b809be014a::state {
    struct STATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STATE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<STATE>(arg0, 16686455347220580559, b"New World Order", b"STATE", b"NWO STATE Ecosystem Governance Token", b"https://images.hop.ag/ipfs/Qmcz9K8m2EueUY5LQk11g48iEB3ygZiSyKwnN5yVTh57Mz", 0x1::string::utf8(b"https://twitter.com/PublicaeOrg"), 0x1::string::utf8(b"https://nwo.capital/"), 0x1::string::utf8(b"https://t.me/Publicae"), arg1);
    }

    // decompiled from Move bytecode v6
}

