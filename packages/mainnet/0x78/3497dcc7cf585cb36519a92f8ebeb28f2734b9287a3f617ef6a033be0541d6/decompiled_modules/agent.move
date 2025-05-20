module 0x783497dcc7cf585cb36519a92f8ebeb28f2734b9287a3f617ef6a033be0541d6::agent {
    struct AGENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGENT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<AGENT>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<AGENT>(arg0, b"AGENT", b"Matrix Oracle", b"Matrix Oracle: The 1st AI agent crafting evolving, user-shaped stories for a personalized, immersive experience built on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXotgXiVYBNpjH6S89ju9gTvqnYnpLu4ejgDk6tuAN7xH")), b"matrixoracle.xyz", b"https://x.com/MatrixOracleSui", b"DISCORD", b"t.me/Matrix_Oracle", 0x1::string::utf8(b"000d61a37bae6524f11f641fbb7b71087d56514b3d30c7f4f3c1ad20f928ea3631711be81362d01376dc63ef4d347856b1f1eb1d4343d09eb80a714f6c67149504d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747769012"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

