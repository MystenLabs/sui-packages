module 0xa831a7997c7710cbaa17547d0b6dc6c91c1939bd7c1bb998f7215703bc13de95::suic {
    struct SUIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIC, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUIC>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUIC>(arg0, b"Suic", b"Suicune", b"The legendary Suicune is here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYRWcfcNAV4hTaZF5SrN7fj35xSvk36kS4tovJtmj5LBV")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"004c28105b78b7d7df0f0763ff9569ae972513fefcf394b70bb1f505fd546c9b56ca0d9af3ebba41682e6e1e945d4262a2df87e17fa42fa978c626568b87b7180ad598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747757853"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

