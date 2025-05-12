module 0xc79c29093f09573eded0e8cf060229f9dde6de99e0cd2bdb8e12b3537696a4b0::ear3 {
    struct EAR3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: EAR3, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<EAR3>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<EAR3>(arg0, b"EAR3", b"Planet Earth 3", b"Earth is the third planet from the Sun and the only astronomical object known to harbor life. This is enabled by Earth being an ocean world, the only one in the Solar System sustaining liquid surface water.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmW2BhpQm1PUE8BxV69VhVCpdpNDXvEfCkYDE94K96uMZF")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"007586a19c0ad3a2bf55b08d0fb03718b7d0fc4bdbb906a11cb5a9f2edfe2b908e1c060a8f12849f109ef7d572ff02a5b3b44bdfd311bad1980c82988f7f9d3104ed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1747070790"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

