module 0xe6b79a93f4eb0848f323a3438d9147b7faca1ed6b5cb9032632dc87646408937::p0xdf5023c {
    struct P0XDF5023C has drop {
        dummy_field: bool,
    }

    fun init(arg0: P0XDF5023C, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<P0XDF5023C>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<P0XDF5023C>(arg0, b"P0xdf5023c", b"PBSW", b"Photograph by Stephen Webber", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmaqJ1CnNTpqT8fzfe3mCBewdVmn5MsGmV1P63sU1KgADh")), b"WEBSITE", b"https://x.com/s_webber", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"004ed9b5ab035f6239d557de42a59cf0daa28aced334f246162494ce04ee850ecbb43cdd2bff06471e2d1f0addf5e7562ed412a5838b1dec9bfd68df003d3dff04d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747780474"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

