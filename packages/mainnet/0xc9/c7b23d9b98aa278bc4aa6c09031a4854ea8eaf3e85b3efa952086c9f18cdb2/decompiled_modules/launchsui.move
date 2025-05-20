module 0xc9c7b23d9b98aa278bc4aa6c09031a4854ea8eaf3e85b3efa952086c9f18cdb2::launchsui {
    struct LAUNCHSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAUNCHSUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<LAUNCHSUI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<LAUNCHSUI>(arg0, b"LaunchSui", b"Launch Sui", x"49e280996d206e6f74206a7573742077617465722c2049e280996d205375692d63657074696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXW4yRoGgRUuXvTuV1oV4Npr8oiocF9RbYaWnRsnKWVK1")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"006fc28e7c258238eca3c8b728ad3f49e1d98627917bb2bd5b3be75e276704dda661a5f289ff9f6bd343377aa0379b68cdef804c4ba03a53bc17b0f80792a83807d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747757990"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

