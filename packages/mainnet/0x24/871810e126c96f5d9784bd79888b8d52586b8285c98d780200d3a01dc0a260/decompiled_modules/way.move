module 0x24871810e126c96f5d9784bd79888b8d52586b8285c98d780200d3a01dc0a260::way {
    struct WAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<WAY>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<WAY>(arg0, b"WAY", b"Milky Way", b"Milky Way in space", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/e6b34666-f3a8-4651-9649-033dcb26884c")), b"https://science.nasa.gov/", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00c59fbbd7a45094e1c8ebc6d1e6587276b5ee6e452db5d212842a891c63e3c8f59f29da658db272dd584c117609bf108318069dccbb995a292774ed7a9ccf070cf5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631737548639"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

