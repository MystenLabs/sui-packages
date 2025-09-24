module 0x3055833d25321197c19876e87ac1db7e705ec0304e32472beeb35d8cd7b01613::tylenol {
    struct TYLENOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYLENOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve_v2<TYLENOL>(arg0, b"TYLENOL", b"tylenol on sui", b"PLEASE BE PATIENT I TAKE TYLENOL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQGthFfruYtFGWthy4BXag9qpTPybmZTYqFyznQN55Hr9")), b"WEBSITE", b"https://x.com/tier10k", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0053918e308ab25930321a3fe761ee94e6c551ad3c594eac36943047c175462f4773199436441b447706c3de677081ad5afc0dc98df826caa5d1e20dae587d050ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1758745621"), arg1);
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TYLENOL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

