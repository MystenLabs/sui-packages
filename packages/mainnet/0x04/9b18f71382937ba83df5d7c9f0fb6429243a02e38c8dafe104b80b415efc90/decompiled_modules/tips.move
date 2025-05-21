module 0x49b18f71382937ba83df5d7c9f0fb6429243a02e38c8dafe104b80b415efc90::tips {
    struct TIPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIPS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<TIPS>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<TIPS>(arg0, b"TIPS", b"DevTips", x"5765206275696c742053706c6173682077697468206c6f76652e20537570706f727420746865206465767320627920686f6c64696e6720244465765469707320e2809420776520776f6ee28099742073656c6c20756e74696c20444558206c697374696e672e0a5469702075733a20307865623930363964346534623161653565376535313937383661333536383232306230333661373061643634613232613763656335613333376563626362643464", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRraHD8PhLpVRHWfnCLXUoGNevrDaF2q2LtVjPWFo31Gs")), b"WEBSITE", b"TWITTER", b"DISCORD", b"https://t.me/splash_DevTips", 0x1::string::utf8(b"002402394752ea5f34812c7f520c248bb3033095c6e67f50f9d5e70c7c775489ed8960ca67acf6597b795deb8d430dd7632a4101811b3ebe931fb1cb981262e10cd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747863124"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

