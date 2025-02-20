module 0x5453097be5b5b8fbb5d87bee6a6e847d45bc6c0b0088781a48289423d99111f8::piz {
    struct PIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIZ, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<PIZ>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<PIZ>(arg0, b"PIZ", b"White Sun", b"White Sunw", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWqh7XXJ2dCQ2BQArHSEcC9jn5ADmzTRRSfmNxHyRKbAm")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"000bd54ad743051dd27858caf68d6f22725a4e043199f711660c4037e62cccd6309309e569ed943e4a91f01cefc16a0c0382dbaa4f8e8c41ab92094d183e8c7802f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631740059820"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

