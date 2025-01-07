module 0xae469263cd4dde5053ef542659dd0cfa95a5a3093671a2db75cfa0789e2bb021::hophip {
    struct HOPHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPHIP, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<HOPHIP>(arg0, 10899234833743542627, b"HopHip", b"HOPHIP", b"fuck hiphop we are hophip", b"https://images.hop.ag/ipfs/QmWSeoFuneVvwAAVYKoZkvzX4TC389U5niQQYNVuZFY3mV", 0x1::string::utf8(b"https://x.com/hophip_sui"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

