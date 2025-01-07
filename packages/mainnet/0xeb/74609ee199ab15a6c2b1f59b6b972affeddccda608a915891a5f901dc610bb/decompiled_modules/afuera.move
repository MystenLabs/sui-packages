module 0xeb74609ee199ab15a6c2b1f59b6b972affeddccda608a915891a5f901dc610bb::afuera {
    struct AFUERA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFUERA, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<AFUERA>(arg0, 9910213878764326499, b"AFUERA", b"AFUERA", b"Buy AFUERA", b"https://images.hop.ag/ipfs/QmRpxUtdVUwaUW9pbR52g7wzKW6ATomsMNR6CydMfX95Jd", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

