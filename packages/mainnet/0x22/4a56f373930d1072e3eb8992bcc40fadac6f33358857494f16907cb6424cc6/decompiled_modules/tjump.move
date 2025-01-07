module 0x224a56f373930d1072e3eb8992bcc40fadac6f33358857494f16907cb6424cc6::tjump {
    struct TJUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TJUMP, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<TJUMP>(arg0, 6140127521081034197, b"Trump Jump", b"TJUMP", b"Trump Jump is fun meme coin Play the game to make him win... share screenshot of high score and stand a chance to win $tjump coin", b"https://images.hop.ag/ipfs/QmZrQJGYeBjnrSMuvQCjqnVAn1hGwhMx1CQ3pn4oXAjopg", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"https://igcgamers.org/trumpjump/"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

