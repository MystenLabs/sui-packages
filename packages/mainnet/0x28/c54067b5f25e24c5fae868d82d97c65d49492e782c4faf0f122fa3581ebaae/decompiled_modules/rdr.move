module 0x28c54067b5f25e24c5fae868d82d97c65d49492e782c4faf0f122fa3581ebaae::rdr {
    struct RDR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RDR, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<RDR>(arg0, 7562627093540260152, b"Ape Riders SUI", b"RDR", b"Ghost Rider is a cursed soul burning with a desire for justice.", b"https://images.hop.ag/ipfs/QmUzx7yVfLkv61aFKmEbKb97Zjp1mVNpK1jyjAZjr1asJX", 0x1::string::utf8(b"https://x.com/Aperidersonsui"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/ApeRiders"), arg1);
    }

    // decompiled from Move bytecode v6
}

