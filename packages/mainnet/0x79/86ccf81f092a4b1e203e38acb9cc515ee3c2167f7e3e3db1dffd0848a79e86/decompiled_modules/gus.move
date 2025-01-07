module 0x7986ccf81f092a4b1e203e38acb9cc515ee3c2167f7e3e3db1dffd0848a79e86::gus {
    struct GUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<GUS>(arg0, 10594051558136178104, b"Gus the Traveler", b"GUS", b"Gus the traveling penguin. Stranded on the sui blockchain. Now wants to stay because he has never seen such a good blockchain.", b"https://images.hop.ag/ipfs/QmNuFFH8HwjdmgRCaBMbPRNvrFmF1EKhaUFmyFNxsHHStH", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

