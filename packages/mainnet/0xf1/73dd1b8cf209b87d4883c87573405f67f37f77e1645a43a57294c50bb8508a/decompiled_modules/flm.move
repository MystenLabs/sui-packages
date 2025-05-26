module 0xf173dd1b8cf209b87d4883c87573405f67f37f77e1645a43a57294c50bb8508a::flm {
    struct FLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLM, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<FLM>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<FLM>(arg0, b"FLM", b"flam", b"flaming", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmdkcav1APGVCaiEh378mE2vEHGtgkYE2Eu8uPGUCxqrQc")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00e0b814d2ad2b9c0de727d3fb25758082a3d77268c44cbb8803c6aee8b13772c7018dd0cbc0fb5e08643ed4a6b89ad665f5625f96801c44549e6f03aa30594409d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748264946"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

