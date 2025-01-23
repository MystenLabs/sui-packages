module 0xa87250bc100573e1a429bd9fbcead9ae6c06502da96eda73431c769e078bf589::blb {
    struct BLB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLB, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<BLB>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<BLB>(arg0, b"BLB", b"Bulbasaur", b"pokemon bulbasaur", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/d37d2d2d-8f4f-4a82-b6de-6c5af2f5d796")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00c45bff0a2060a8fa9e76c39822a89cb8838ec3189889da8dbf2e1d3e9937665cc307bde7def282a54df36c5fd0c2ce252f4fccfad0a9ca28370ddc204b44ee04f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631737637299"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

