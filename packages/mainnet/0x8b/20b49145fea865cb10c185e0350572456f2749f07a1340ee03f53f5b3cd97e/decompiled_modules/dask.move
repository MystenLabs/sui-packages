module 0x8b20b49145fea865cb10c185e0350572456f2749f07a1340ee03f53f5b3cd97e::dask {
    struct DASK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DASK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<DASK>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<DASK>(arg0, b"DASK", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXDPZaQ9kiLncSfiarJthyzeQXpVf83X24VZHBrdPzDEu")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0029c9729784f1d59ea21a8716735d60fe9fd4b8a5acbebc7fb3205e30cbd8fa3bd5f7e293e24540bc30a3e4685de696b660f2effc286dfcd6af10ed4391d28b05f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631745873455"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

