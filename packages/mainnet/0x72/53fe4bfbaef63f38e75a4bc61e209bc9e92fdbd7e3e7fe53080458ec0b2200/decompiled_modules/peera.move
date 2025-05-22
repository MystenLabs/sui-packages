module 0x7253fe4bfbaef63f38e75a4bc61e209bc9e92fdbd7e3e7fe53080458ec0b2200::peera {
    struct PEERA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEERA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<PEERA>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<PEERA>(arg0, b"PEERA", b"Peera AI", b"The Efficient Way to Manage your Web3 Community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUTGAkC6a9gRuWEFKk2qp7QnwZ8V8fnxi8CRZwwebLv8v")), b"https://www.peera.ai/", b"https://x.com/peera_ai", b"https://discord.com/invite/rNzjvArqU2", b"TELEGRAM", 0x1::string::utf8(b"006db5d41c41fc1fbfc482fd1f12f91ee07d5352e8f1cbac9844db2a2035bf51c4e02f040d397d832d8db8483584ac442614bbef93af33c1c180e8de5daa0b070fd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747918352"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

