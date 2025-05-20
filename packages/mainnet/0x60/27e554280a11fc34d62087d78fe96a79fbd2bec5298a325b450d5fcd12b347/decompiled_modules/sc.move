module 0x6027e554280a11fc34d62087d78fe96a79fbd2bec5298a325b450d5fcd12b347::sc {
    struct SC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SC, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SC>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SC>(arg0, b"SC", b"Splash Cat", b"The fastest splash cat on sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPyZ8baeKhJqwvjoT23pFSa6K9yicjvMwVGZWaMh7G1sp")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00bcc30198f7f7b7ff9b56a1dd828d666d592c51f551867d1de451064a36e55a98721beefff11510da5b898fb4641c1df68a62ed7e19b42a836f2c1ee5e0efae05d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747763786"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

