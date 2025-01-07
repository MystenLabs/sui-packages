module 0x87fa3558c3ab84ac0dac1793f5ef0a05e897fa5f83b53b393467a7586f869bbc::sn {
    struct SN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SN, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SN>(arg0, 4871591134684026432, b"Paul Le Roux(Satoshi Nakamoto)", b"SN", b"The former programmer and criminal cartel boss, Paul Calder Le Roux, became a Satoshi Nakamoto suspect in the spring of 2019.", b"https://images.hop.ag/ipfs/QmRtE81jQ8C43CvnC8aUfa5s7Y5T7pDmgSnm8AjJmmXkYp", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

