module 0x4b3281b99f947ee21353db3307395a06fc843aa27a7cbab16bdf6408d3c9c5fc::ovo {
    struct OVO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OVO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<OVO>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<OVO>(arg0, b"OVO", b"OVON", b"We OVOV", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYPxj6vcbHP2FQqQUr5NgQjrKyfcZm6M59v2VeGMKBLu2")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"004412956a61c211266b18e6bff845aad658d5e42de14b4ac97843c71ff6c870d45ac3ec7b86dcd0666092910384d30dff7f2f864347e1699973086ffbe9dc170df5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631743076949"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

