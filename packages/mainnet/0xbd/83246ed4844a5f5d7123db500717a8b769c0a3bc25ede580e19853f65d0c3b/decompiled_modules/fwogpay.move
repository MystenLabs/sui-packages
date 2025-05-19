module 0xbd83246ed4844a5f5d7123db500717a8b769c0a3bc25ede580e19853f65d0c3b::fwogpay {
    struct FWOGPAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWOGPAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/HFaqhKcMTPEgxRfFYXk2zYR3tVio7VDyGWjQbwfssREV.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FWOGPAY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FWOGPAY     ")))), trim_right(b"FwogPay                         "), trim_right(x"46776f6750617920697320612072657761726420746f6b656e20746861742070617973206f757420696e202446574f470a0a31302520546178206973207573656420746f2064697374726962757465207265776172647320746f20686f6c6465727320616e6420616c736f20746f206275726e20746f6b656e73207768696368206d616b6573206974206465666c6174696f6e6172792e0a0a496620796f752061726520686f6c64696e67202446776f6750617920796f7520617265206175746f6d61746963616c6c79206d616b696e672072657761726473206a7573742066726f6d20686f6c64696e672c206576657279626f64792077696e732e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWOGPAY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWOGPAY>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

