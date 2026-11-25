module 0xad5547cee4fcb2c20de3ee39e300bd248ce5575f9875916ae0645e8d6ac1ebf6::gtgregoir {
    struct GTGREGOIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTGREGOIR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (false) {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_account(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895")
        } else {
            0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::creator_authority::new_address(0x2::address::from_bytes(x"39b5313c354ddb70648affc691a29db52fc8e22063c47dc83d41cabeb1f59895"))
        };
        let (v1, v2) = 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::new<GTGREGOIR>(arg0, 9, 0x1::string::utf8(b"GTGREGOIR"), 0x1::string::utf8(b"Gregoire"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://cdn4.telesco.pe/file/tKIYPAFsOemZ8Vpe9z2q0h03R3UFj5Ws0crrGTqQ90lVZ2-rCFWSrWdEZOsC-9uhXRQgkSH7RRQ0lfZjZ-qk6q3M_63MabbDU6z9ZQ9lb81ziBoJckXHwEf_m0ugVD4ULiOT0stk8fxbY8sW9kX-FUZV7B5h5xiOba32D-8Lss0oNMb0JgPXf0tvLAF6iQWrFisrwzFwLydu8-u3ghdqIqKyhn2Pyz3ubn-_BCnWnhzkYxDe1EU1KwojqnmICGuK5IF3-K2b0H5liI8WKZ-RJP6L6Qs_UZsjiK_yD_u_16B0OMBhzHhjv2_YAskN4o73BYV58SZi1rV2OmCo5O4vSQ.jpg"), v0, false, 0, arg1);
        0x2::transfer::public_transfer<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_ticket::LaunchTicket<GTGREGOIR>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<GTGREGOIR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

