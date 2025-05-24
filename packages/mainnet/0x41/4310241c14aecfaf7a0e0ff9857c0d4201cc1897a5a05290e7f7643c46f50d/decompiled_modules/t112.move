module 0x414310241c14aecfaf7a0e0ff9857c0d4201cc1897a5a05290e7f7643c46f50d::t112 {
    struct T112 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T112, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<T112>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<T112>(arg0, b"T112", b"omega", b"ceo onus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTbzftyvVg7uFLciMeis8AvKoP8WEXWZmfHW7tecjAUWF")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00ed79f725b3cbed619a9f4972772cd7901e0c34e90cdc0da9e3228c4c3cd87be2493a62cf0d0771bca9219f15a4ffd22dcee2766fe88d966b1a889420dcdfd40fd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748074255"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

