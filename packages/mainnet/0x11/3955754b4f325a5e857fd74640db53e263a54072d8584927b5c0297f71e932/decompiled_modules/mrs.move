module 0x113955754b4f325a5e857fd74640db53e263a54072d8584927b5c0297f71e932::mrs {
    struct MRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<MRS>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<MRS>(arg0, b"MRS", b"megaredsss", b"beautiful flower", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQWW4bPxcw9e98E3Wsz2u3JZ51Uq6b6h34775Lb8B1pfD")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0064ced2bae6f2d378feffa5733149b0bca8f1cf5879ac3002b68448ddf0d06f3feceee54db65187448a61dd6478d9a293c51768c08f99baf4b0a42e34a614c30cd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748157307"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

