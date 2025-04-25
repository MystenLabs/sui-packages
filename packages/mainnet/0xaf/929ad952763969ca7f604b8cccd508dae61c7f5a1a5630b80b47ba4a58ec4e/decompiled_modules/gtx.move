module 0xaf929ad952763969ca7f604b8cccd508dae61c7f5a1a5630b80b47ba4a58ec4e::gtx {
    struct GTX has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTX, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<GTX>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<GTX>(arg0, b"GTX", b"SUI", b"GTX GTX GTXGTX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXQJPhL5xvx4rorYxxV7Daf21XJng4yzBoaAocyVPA8mK")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"009edca991e037be5ebfea16a780572b8d7787bdb76b568b0d1086a347ec1718c597c188a7298dcc87f5db0dd413c78632a1c9f57e66920158370d155c40bc1e0bf5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631745605913"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

