module 0xb111ae46078aa89a4e3a8bbc74f6da659a45d04ef08899c413f482d1d4262965::doubao {
    struct DOUBAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOUBAO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<DOUBAO>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<DOUBAO>(arg0, b"DOUBAO", b"Wanted Capybara", x"22f09fa6a62057414e5445443a2043617079626172612027446f7562616f27202d20446f7562616f2074686520636170796261726120686173206265656e206f6e207468652072756e20666f722034302064617973206166746572206573636170696e67204a69616e6773752773205a6875797577616e205a6f6f2077697468206163636f6d706c6963657320286e6f77206361707475726564292e205265776172643a2046726565207a6f6f207469636b65747320666f72207469707321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPzAxwbpycJSUW8oS7prbBjKqCoaXWkegV9yx67cDCkVv")), b"https://x.com/shanghaidaily/status/1922102075204190614", b"https://x.com/shanghaidaily/status/1921421369402679519", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00f01e402ce7ed91b1f1b19827d4593bab3409b50f05f6fd086ef7bdce985825ad58f47f2f3b2d159891d2f46d8d855eb1436755f7f465d83a07cbb2be67902908d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747843286"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

