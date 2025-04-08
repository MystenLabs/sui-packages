module 0x9a07348bb338cc097de658aba68d29aec2b1f7a0b002a2365a9f6b6411f03f59::gtx {
    struct GTX has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTX, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<GTX>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<GTX>(arg0, b"GTX", b"GTXPR", b"GTXPR for loop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfEwEMZ2jAmAfNKc4ygGJt8Swh9sQyHhYENfecKXWUigR")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0002e629300cb987b16950a50735eafeb1d17a62ee2e051d837d68f5249992a5de9c102a25fef5ef11f978e4fa889341640678c078b7a25e8ac2b6f5223c7d1f06f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631744110476"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

