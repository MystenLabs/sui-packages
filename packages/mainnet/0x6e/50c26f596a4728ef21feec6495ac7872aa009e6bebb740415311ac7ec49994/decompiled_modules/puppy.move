module 0x6e50c26f596a4728ef21feec6495ac7872aa009e6bebb740415311ac7ec49994::puppy {
    struct PUPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPPY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<PUPPY>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<PUPPY>(arg0, b"PUPPY", b"PUPPY ON SUI", b"the dog of sui co-founder, evan cheng", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmeoNQzNGFwjjuJBfHpzS63tLJm3fpB3HdXePSvDK2DEZv")), b"WEBSITE", b"https://x.com/Puppy_Sui_", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00d57fd1b04ef44aa0a2926beec8412e4f634ad86eb1f68a6a566f6a1c3185cd3cddccfdb27b533a49c9f1182d349b20c9a92f1306d2871f70f35829b0ffd87606d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747761392"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

