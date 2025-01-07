module 0xa1ac2243743a04d1b826733ec86e8913c644d95465b67389e711af4b3b786c5f::drpsx {
    struct DRPSX has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRPSX, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<DRPSX>(arg0, 12940603251958070123, b"Dr Pussx", b"$DRPSX", b"Dr Pussx is a multi-chain, mental health project that explores, experiments and research the disorders and issues that arise from malfunctioning of the brain and neural network. Project is led by PhD Semir Poturak, expert in spatial psychology, psychogeography and psychoanalysis. Links at www.linktr.ee/3esign", b"https://images.hop.ag/ipfs/Qmb8eWZc6TSKLa6iEtbgDJgpCFzvyQAoAND1AP3SgGUkGv", 0x1::string::utf8(b"https://x.com/drpussx"), 0x1::string::utf8(b"https://linktr.ee/drpussx"), 0x1::string::utf8(b"https://t.me/drpussx"), arg1);
    }

    // decompiled from Move bytecode v6
}

