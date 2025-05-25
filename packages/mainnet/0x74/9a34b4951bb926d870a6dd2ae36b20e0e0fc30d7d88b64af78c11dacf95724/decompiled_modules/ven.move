module 0x749a34b4951bb926d870a6dd2ae36b20e0e0fc30d7d88b64af78c11dacf95724::ven {
    struct VEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: VEN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<VEN>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<VEN>(arg0, b"VEN", b"ventaakk", b"nothing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZ9MqU2atPbNxsw8sdc9wkpNqkuzZ9YguVNmXfetCL2p1")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00aba7a5af485feda1fb4017b27ece4f54e84569ff1118523a49608872b3b6b02b71609b982f02c27095d55e9a46670cf214952b72d4052b1a6160a6d8ba091201d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748195130"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

