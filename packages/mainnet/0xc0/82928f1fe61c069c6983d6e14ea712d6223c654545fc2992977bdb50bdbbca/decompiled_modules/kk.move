module 0xc082928f1fe61c069c6983d6e14ea712d6223c654545fc2992977bdb50bdbbca::kk {
    struct KK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<KK>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<KK>(arg0, b"KK", b"KKLL", b"K", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdDCJuuggvp1fhiMzN1tp6Upv4btNgiWtBzTKRUgCbAmn")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00783ec5cef6bb8bb99b5acb4443955ddd214af6322095edc107ea2016aea4d9562c863261976163f2846c9127dc173188a66d4efcad41eeee9d1f0c2f51c52f04ed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1747073135"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

