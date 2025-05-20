module 0xe74356f1adad1fa30e03883cf1a8db716e786f7617b9c36c2baf66b8dc0e1998::iloveyou {
    struct ILOVEYOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ILOVEYOU, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<ILOVEYOU>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<ILOVEYOU>(arg0, b"Iloveyou", b"520", b"I hate the day May 20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmc9CBXkWXVKiz4t3cpjk2QCKevJGNveaGvBHDcdFS4s1B")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"005a49ac0707a22d27a4aa4ab44d1b8c05937bde6f31f1e267ea89f12efa20331deed0913200512f549e9fed06be36d1cb792bf4190e3d4d17c905d6745930670fd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747764316"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

