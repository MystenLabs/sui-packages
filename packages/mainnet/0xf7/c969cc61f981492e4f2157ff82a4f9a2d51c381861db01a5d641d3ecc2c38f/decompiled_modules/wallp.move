module 0xf7c969cc61f981492e4f2157ff82a4f9a2d51c381861db01a5d641d3ecc2c38f::wallp {
    struct WALLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALLP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<WALLP>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<WALLP>(arg0, b"Wallp", b"Wallpaper white", b"Wallpaper white one", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/118ddf2b-23c0-4f4b-b596-ae9eb6c78de2")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00b948dc45cff946df65c28dbf9c7dc2f251491f99bb663e7c2aca4795026ef469a2f482396deb8a704c080d78dccd56a76af89f3d7d2d96c911491fcf28236b04f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631738946603"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

