module 0x89751c9926acfd4f4f1ec86e05f654af4164bed6be4768f057bd57b6a556b092::usd {
    struct USD has drop {
        dummy_field: bool,
    }

    fun init(arg0: USD, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<USD>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<USD>(arg0, b"USD", b"USA", b"USA USD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmW2BhpQm1PUE8BxV69VhVCpdpNDXvEfCkYDE94K96uMZF")), b"https://en.wikipedia.org/wiki/United_States_dollar", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"003bdc32a7e5e71366cf2b448dca3acef6be6ae6fb8b95aca35a0ba66ecec4239ed787ff598854f6791b5458495692a5757f248b222e15453d08566f9e76b3940df5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631745580405"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

