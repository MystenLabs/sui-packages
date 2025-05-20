module 0xac0d4f123e6e9edd8fc0fa8df5fd6d616fcf636f9691765af5b51562f5b44440::svs {
    struct SVS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SVS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SVS>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SVS>(arg0, b"SVS", b"SUI VS SOL", x"57686f20776f756c642077696e3f200a0a245355492076732024534f4c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTGkVjXe4fGXF1xAFzqbC3MsesMmpXnhnmREteyzGmtzb")), b"WEBSITE", b"https://x.com/hiphopdotfun/status/1921899903057285197", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00c43274d9b9b36447cc04bdbee5722aad9e47abd709ae2fd1d3158142e42b41d898b72a811c6547f19c1d6810bb7e7d517c4e4f9bdb3d6645ec192f776a8f4709d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747757982"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

