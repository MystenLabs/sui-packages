module 0x3f5c6e30deb96d053a0bc16203453faee93b34514e59af1746895981fbb4a4a::djwm {
    struct DJWM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DJWM, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<DJWM>(arg0, 5874519839809227664, b"don't joke with me", b"DJWM", b"don't joke with me", b"https://images.hop.ag/ipfs/QmeZRywWUW466wmuBeYsiwWy25ALs9b16Ffkj1Uw1hKzEs", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

