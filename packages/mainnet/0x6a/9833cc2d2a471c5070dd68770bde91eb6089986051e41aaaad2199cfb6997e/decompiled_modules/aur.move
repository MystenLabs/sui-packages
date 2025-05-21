module 0x6a9833cc2d2a471c5070dd68770bde91eb6089986051e41aaaad2199cfb6997e::aur {
    struct AUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<AUR>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<AUR>(arg0, b"AUR", b"ARE U LOST", b"HY AM I LOST?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmer5b9cWjAKzMaNcKmZ4ZKZZGdoV37HhBQ9VLczudCRrK")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"003310c218ad7af24ca92b864cfcc0bc99138f08309678606b81e33f4daf63173b5f2117fd2ca2851d52c9b85afac7058e5e8ea4a1ce063ce906d280ea27066f08d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747808773"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

