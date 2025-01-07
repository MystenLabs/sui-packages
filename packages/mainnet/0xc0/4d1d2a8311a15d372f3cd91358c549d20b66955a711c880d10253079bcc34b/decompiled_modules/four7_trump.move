module 0xc04d1d2a8311a15d372f3cd91358c549d20b66955a711c880d10253079bcc34b::four7_trump {
    struct FOUR7_TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOUR7_TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<FOUR7_TRUMP>(arg0, 18095661199209741917, b"47TRUMP", b"47TRUMP", b"47TRUMP token celebrates the election of donald trump as the 47th president of the united states which brought us a new ATH for Bitcoin. A new wave in the crypto market and a brilliant future await us", b"https://images.hop.ag/ipfs/QmPorcNy59Tgh8QfKMQumwsfjNSQyfiBcJqNraBhTeZ6AH", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

